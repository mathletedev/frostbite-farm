extends Node

const PLACE_OFFSET = 48

var holding: String = ""
var holding_price: int = 0
var can_sell: bool = true
var balance: int = 100
var dialogue: String = ""

signal update_balance
signal update_dialogue
