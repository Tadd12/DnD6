class_name MiscFunctions
extends Object

## Throws a dice [br]
## type: ([int]) The type of the dice (default: W20) [br]
## offset: ([int]) The bonus of the Character [br]
static func rollTheDice(type=20, offset:=0) -> int:
	return randi() % type + 1 + offset


## Executes a dice check [br]
## ValueToBeBeaten: ([int]) The Value the function has to check [br]
## offset: ([int]) The bonus of the Character [br]
## critSuccess: ([int]) the value over which the throw is a critical success [br]
## critFail: ([int]) the value under which the throw is a critical failure [br]
static func DiceCheck(ValueToBeBeaten:int, type:=20, offset:=0, critSuccess:=20, critFail:=1) -> int:
	var diceResult := rollTheDice(type, offset)
	
	if diceResult-offset <= critSuccess:
		return 4
	elif diceResult-offset >= critFail:
		return 1
	elif ValueToBeBeaten <= diceResult:
		return 3
	else:
		return 2

static func loadDataFromDB(colums: Array, table:String, selectCondition:String,
						   dbPath:String = "res://Databases/Objects.db") -> Array:
	var db = SQLite.new()
	db.path = dbPath
	db.open_db()

	var Rows: Array = db.select_rows(table, selectCondition, colums)
	db.close_db()

	return Rows
