extends Node
#Switch puzzle
signal checkSwitch

#player manager
signal addGold
signal addExp
signal addCollectable

signal addHealth

#loading world
signal writeWorldLocations
signal loadLocations
signal saveWorld
signal loadObjects
signal changeState

signal tutorial

#CUTSCENE
signal startCutscene
signal cutsceneFinished

signal startBubble

#Player
signal enablePlayer
signal disablePlayer
signal placeWorld

#tutorial sequence
signal enableDialogueObject
signal tutorialFinished

#Quests
signal advanceQuest
signal completeQuest
signal completeObj
signal emitQueue
signal queueQuest
signal completeTimer
signal emitCurrentQuestSignal
signal removeFromQueue

signal blackFade


#pipe puzzle
signal checkPipes