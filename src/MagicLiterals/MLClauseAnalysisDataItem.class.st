Class {
	#name : #MLClauseAnalysisDataItem,
	#superclass : #Object,
	#instVars : [
		'query',
		'queryType',
		'sourceFile',
		'clauseTypeToLiteralCount'
	],
	#category : #MagicLiterals
}

{ #category : #accessing }
MLClauseAnalysisDataItem >> clauseTypeToLiteralCount [
	^ clauseTypeToLiteralCount
]

{ #category : #accessing }
MLClauseAnalysisDataItem >> clauseTypeToLiteralCount: anObject [
	clauseTypeToLiteralCount := anObject
]

{ #category : #testing }
MLClauseAnalysisDataItem >> hasLiteral [
	^ (self clauseTypeToLiteralCount collect: #value) sum > 0
]

{ #category : #testing }
MLClauseAnalysisDataItem >> isNotParsable [
	^ self isParsable not
]

{ #category : #testing }
MLClauseAnalysisDataItem >> isParsable [
	^ self queryType ~= 'NOTPARSABLE'
]

{ #category : #accessing }
MLClauseAnalysisDataItem >> query [
	^ query
]

{ #category : #accessing }
MLClauseAnalysisDataItem >> query: anObject [
	query := anObject
]

{ #category : #accessing }
MLClauseAnalysisDataItem >> queryType [
	^ queryType
]

{ #category : #accessing }
MLClauseAnalysisDataItem >> queryType: anObject [
	queryType := anObject
]

{ #category : #accessing }
MLClauseAnalysisDataItem >> sourceFile [
	^ sourceFile
]

{ #category : #accessing }
MLClauseAnalysisDataItem >> sourceFile: anObject [
	sourceFile := anObject
]
