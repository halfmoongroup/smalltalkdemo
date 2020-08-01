Class {
	#name : #BookTestClient,
	#superclass : #Object,
	#instVars : [
		'bookRepo'
	],
	#category : #'TGBookLibrary-Tests'
}

{ #category : #'as yet unclassified' }
BookTestClient class >> randomBook [

	^ Book randomize:  [ :size | self randomStringOfSize: size ] .
]

{ #category : #'as yet unclassified' }
BookTestClient class >> randomStringOfSize: anInteger [

	^ String streamContents: [ :s | 
    	anInteger timesRepeat: 
      		[ s nextPut: (Character codePoint: (97 to: 122) atRandom) ] ]
]

{ #category : #accessing }
BookTestClient >> bookRepo [
	^ bookRepo
]

{ #category : #accessing }
BookTestClient >> bookRepo: anObject [
	bookRepo := anObject
]

{ #category : #'as yet unclassified' }
BookTestClient >> fetchRawBookList [

	| returnValue | 
	
	returnValue := Dictionary new. 
	returnValue at: #count put: self bookRepo size.
	returnValue at: #books put: (OrderedCollection newFrom: self bookRepo). 
	^NeoJSONObject fromString: (NeoJSONWriter toString: returnValue).
]

{ #category : #'accessing - data' }
BookTestClient >> fetchRawBookWithId: anId [
	^nil
]

{ #category : #'as yet unclassified' }
BookTestClient >> getFirstBookId [

	^(bookRepo at: 1) at: #bookId
]

{ #category : #initialization }
BookTestClient >> initialize [
	| books |
	books := OrderedCollection new. 
	1 to: 10 do: [ :index | books add: (self class randomBook) ].
	bookRepo := books collect: [ :item | item toDictionary  ].
	
	
]
