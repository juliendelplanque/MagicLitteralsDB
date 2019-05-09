Class {
	#name : #MLBasicQueryExtractor,
	#superclass : #Object,
	#instVars : [
		'sourceFile',
		'targetFile'
	],
	#category : #MagicLiterals
}

{ #category : #csv }
MLBasicQueryExtractor class >> csvReaderOn: aStream [
	^ self subclassResponsibility
]

{ #category : #extraction }
MLBasicQueryExtractor >> extractToTargetFile [
	self subclassResponsibility
]

{ #category : #accessing }
MLBasicQueryExtractor >> sourceFile [
	^ sourceFile
]

{ #category : #accessing }
MLBasicQueryExtractor >> sourceFile: anObject [
	sourceFile := anObject
]

{ #category : #accessing }
MLBasicQueryExtractor >> targetFile [
	^ targetFile
]

{ #category : #accessing }
MLBasicQueryExtractor >> targetFile: anObject [
	targetFile := anObject
]
