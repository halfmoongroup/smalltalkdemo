"
Smalltalk wrapper for a json object that represents a book. 
"
Class {
	#name : #Book,
	#superclass : #Object,
	#instVars : [
		'author',
		'bookId',
		'title',
		'originalPublicationYear',
		'imageUrl',
		'smallImageUrl',
		'languageCode'
	],
	#category : #'TGBookLibrary-Domain'
}

{ #category : #'instance creation' }
Book class >> fromJson: neoJSON [
	| book |
	book := self new. 
	book class allInstVarNames do: [ :namez | (neoJSON at: namez) ifNotNil: [ book instVarNamed: namez put: (neoJSON at: namez )] ].
	^book
]

{ #category : #'as yet unclassified' }
Book class >> randomize: randomStringBlock [
| book | 
	book := self new. 
	 ^ book author: (randomStringBlock value: 8),' ', (randomStringBlock value: 10);
	    title: (randomStringBlock value: 14);
		 bookId: (randomStringBlock value: 14);
		originalPublicationYear: (1950 to: 2020) atRandom.
]

{ #category : #accessing }
Book >> author [
	^ author
]

{ #category : #accessing }
Book >> author: anObject [
	author := anObject
]

{ #category : #accessing }
Book >> bookId [
	^ bookId
]

{ #category : #accessing }
Book >> bookId: anObject [
	bookId := anObject
]

{ #category : #accessing }
Book >> imageUrl [
	^ imageUrl
]

{ #category : #accessing }
Book >> imageUrl: anObject [
	imageUrl := anObject
]

{ #category : #accessing }
Book >> languageCode [
	^ languageCode
]

{ #category : #accessing }
Book >> languageCode: anObject [
	languageCode := anObject
]

{ #category : #accessing }
Book >> originalPublicationYear [
	^ originalPublicationYear
]

{ #category : #accessing }
Book >> originalPublicationYear: anObject [
	originalPublicationYear := anObject
]

{ #category : #accessing }
Book >> smallImageUrl [
	^ smallImageUrl
]

{ #category : #accessing }
Book >> smallImageUrl: anObject [
	smallImageUrl := anObject
]

{ #category : #accessing }
Book >> title [
	^ title
]

{ #category : #accessing }
Book >> title: anObject [
	title := anObject
]

{ #category : #'as yet unclassified' }
Book >> toDictionary [
	|returnValue| 
	returnValue := Dictionary new. 
	self class instVarNames do: [ :each |  returnValue at: each put: (self instVarNamed: each)].
	^returnValue
]

{ #category : #accessing }
Book >> toJson [
 ^String streamContents: [ :stream |
   (NeoJSONWriter on: stream)
      prettyPrint: true;
      mapInstVarsFor: self class;
      nextPut: self]
]
