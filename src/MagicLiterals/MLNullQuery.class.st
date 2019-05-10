"
I am the implementation of the null object design pattern for a query node of the AST.
"
Class {
	#name : #MLNullQuery,
	#superclass : #Object,
	#category : #MagicLiterals
}

{ #category : #'as yet unclassified' }
MLNullQuery >> literalNodes [
	^ #()
]

{ #category : #'as yet unclassified' }
MLNullQuery >> queryType [
	^ 'NOTPARSABLE'
]
