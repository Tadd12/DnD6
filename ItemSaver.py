import sqlite3
import re
import os

os.chdir(os.path.dirname(__file__))
print(os.getcwd())
con = sqlite3.connect("DND6/Databases/Objects.db")

# USER input
ItemSID = input("""ItemSID (Type in a internal StringIdentifier. ITEM_ will be added by this script)
(e.g. FIRE_SWORD or POSION_APPLE): """).strip()
if ItemSID == '':
    raise ValueError("ItemSID must be given")

ItemSID = ItemSID.upper()
ItemSID = ItemSID.replace(" ", "_")

ItemNameEnglish = input("English Name: ").strip()
if ItemNameEnglish == '':
    raise ValueError("English Name must be given")

ItemNameGerman = input("German Name (optional): ").strip()
ItemNameFrench = input("French Name (optional): ").strip()

ItemDescEnglish = input("""English Description (optional,
but if you want give a description in german or french this is mandatory): """).strip()
if ItemDescEnglish != '':
    ItemDescGerman = input("German Description (optional): ").strip()
    ItemDescFrench = input("French Description (optional): ").strip()

ItemWeight = float(input("Item Weight as float in kg: ").strip())

ItemType = input("""ItemType (Type a letter representing the type of the Item)
(C -> Consumable, A -> Armor, S -> Shield, W -> Weapon): """).strip()
if ItemType == '':
    raise ValueError("ItemType must be given")
if ItemType not in ["C", "A", "S", "W"]:
    raise ValueError("Must be C, A, S or W")

match ItemType:
    case 'C':
        itemTarget = input("""ItemTarget (The Target the Item can be used on) 
(C -> only used on Character (e.g. Health Potion), I -> only used on Item (e.g. ), A -> used on All (e.g. Posion)): """).strip()
        if itemTarget not in ["C", "I", "A"]:
            raise ValueError(" \"ItemTarget\" must be C, I or A")

        itemInFight = input("""Useable in Fight (Should the item be able to be used in) (T or F): """).strip()
        if itemInFight not in ["T", "F", "0", "1"]:
            raise ValueError(" \"Useable in Fight\" must be T or F")
        itemInFight = 0 if itemInFight in ["F", "0"] else 1
    case 'A':
        ArmorBonus = int(input("ArmorBonus (The bonus for the armor class of the character wearing the armor) int: "))
        ArmorType = input("""ArmorType (the Type of armor)
(C -> Cloth, L -> Light armor, M -> middle armor, H -> Heavy Armor): """).strip()
        if ArmorType not in ["C", "L", "M", "H"]:
            raise ValueError(" \"ItemTarget\" must be C, L, M or H")

        ArmorPart = input("""ArmorPart (The body part the Armor should be able to be worn) 
(S -> Shoes, L -> Legs, T -> Torso, G -> Gloves, N -> Neckless, H -> Helmet): """).strip()
        if ArmorType not in ["S", "L", "T", "G", "N", "H"]:
            raise ValueError(" \"ItemTarget\" must be S, L, T, G, N or H")
    case 'S':
        ArmorBonus = int(input("ArmorBonus (The bonus for the armor class of the character wearing the armor) int: ").strip())
    case 'W':
        AttackBonus = int(input("AttackBonus (The bonus for each attack of the character wielding a Weapon) int: ").strip())
        StandardDamage = input("""StandardDamage (The Standard Damage of the Weapon without bonus)
(nWm where n is the number of dice and m the number of sides): """).strip()
        if not re.match(r"\d{0,2}W\d{1,2}", StandardDamage):
            raise ValueError("StandardDamage must be of shape nWm (where n is the number of dice and m the number of sides)")

        WeaponRange = int(input("WeaponRange (the Range of the Weapon) int: ").strip())
        WeaponClass = input("WeaponClass (the class/type of Weapon (e.g. Sword, Javelin, etc.)): ").strip()


# Saving in DB

# open DB

cur = con.cursor()

NameSID = f"ITEMNAME_{ItemSID}"
DescSID = f"ITEMDESC_{ItemSID}" if not ItemDescEnglish == '' else "DESC_EMPTY"

sqlStatementName = f"""INSERT INTO Names (NameSID, English, German, French)
VALUES ("{NameSID}", "{ItemNameEnglish}", "{ItemNameGerman}", "{ItemNameFrench}");"""

cur.execute(sqlStatementName)

if DescSID != 'DESC_EMPTY':
    sqlStatementDescription = f"""INSERT INTO Descriptions (DescSID, English, German, French)
    VALUES ("{DescSID}", "{ItemDescEnglish}", "{ItemDescGerman}", "{ItemDescFrench}");"""

    cur.execute(sqlStatementDescription)

sqlStatementItemBase = f"""INSERT INTO Item (SID, NameSID, DescSID, Weight, Type)
VALUES ("ITEM_{ItemSID}", "{NameSID}", "{DescSID}", {ItemWeight}, "{ItemType}");"""

cur.execute(sqlStatementItemBase)

match ItemType:
    case 'C':
        sqlStatementItemChild = f"""INSERT INTO ItemConsumable (ItemSID, UseTarget, UseableInFight)
        VALUES ("ITEM_{ItemSID}", "{itemTarget}", "{itemInFight}");"""
    case 'A':
        sqlStatementItemChild = f"""INSERT INTO ItemArmor (ItemSID, ArmorBonus, ArmorType, ArmorPart)
        VALUES ("ITEM_{ItemSID}", {ArmorBonus}, "{ArmorType}", "{ArmorPart}");"""
    case 'S':
        sqlStatementItemChild = f"""INSERT INTO ItemShield (ItemSID, ArmorBonus)
        VALUES ("ITEM_{ItemSID}", {ArmorBonus});"""
    case 'W':
        sqlStatementItemChild = f"""INSERT INTO ItemWeapon (ItemSID, AttackBonus, StandardDamage, Range, Class)
        VALUES ("ITEM_{ItemSID}", {AttackBonus}, "{StandardDamage}", {WeaponRange}, "{WeaponClass}");"""

cur.execute(sqlStatementItemChild)

# close DB
con.commit()
con.close()
print("Item written to DB")

input("Press any ENTER to exit")
