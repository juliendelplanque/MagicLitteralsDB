Class {
	#name : #MLDatasetLoader,
	#superclass : #Object,
	#instVars : [
		'csvFileToLoad',
		'extractor'
	],
	#category : #MagicLiterals
}

{ #category : #accessing }
MLDatasetLoader >> csvFileToLoad [
	^ csvFileToLoad
]

{ #category : #accessing }
MLDatasetLoader >> csvFileToLoad: anObject [
	csvFileToLoad := anObject
]

{ #category : #accessing }
MLDatasetLoader >> extractorClass [
	^ extractor
]

{ #category : #accessing }
MLDatasetLoader >> extractorClass: anObject [
	extractor := anObject
]

{ #category : #actions }
MLDatasetLoader >> load [
	^ MLDataset loadFrom: self csvFileToLoad extractor: self extractorClass
]

{ #category : #actions }
MLDatasetLoader >> load: aFileReference [
	self csvFileToLoad: aFileReference.
	^ self load
]
