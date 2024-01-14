extends Node

const PLACE_OFFSET = 48

var holding: String = ""

var playerCoins = 500
var balance: int = 100
var dialogue: String = ""

signal update_balance
signal update_dialogue
