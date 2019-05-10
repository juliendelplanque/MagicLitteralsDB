"
I analyse a collection of datasets and provide statistics about them.
"
Class {
	#name : #MLDatasetsAnalyser,
	#superclass : #Object,
	#instVars : [
		'loaders'
	],
	#category : #MagicLiterals
}

{ #category : #analyzing }
MLDatasetsAnalyser >> analyze [
	^ self loaders collect: [ :loader |
		self analyzeDataset: loader load ]
]

{ #category : #analyzing }
MLDatasetsAnalyser >> analyzeDataset: aMLDataset [
	^ aMLDataset items collect: [ :aMLDatasetItem |
		|ast literals|
		ast := aMLDatasetItem ast.
		literals := ast literalNodes.
		{
			aMLDatasetItem queryString. 
			ast queryType.
			
		} ]
]

{ #category : #accessing }
MLDatasetsAnalyser >> loaders [
	^ loaders
]

{ #category : #accessing }
MLDatasetsAnalyser >> loaders: anObject [
	loaders := anObject
]
