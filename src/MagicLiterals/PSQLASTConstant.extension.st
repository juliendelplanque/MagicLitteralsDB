Extension { #name : #PSQLASTConstant }

{ #category : #'*MagicLiterals' }
PSQLASTConstant >> nameOfClauseInWhichItIs [
	^ (self allParents detect: #isClause ifNone: [ self allParents detect: #isSelectQuery ]) clauseType
]
