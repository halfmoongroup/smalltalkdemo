Class {
	#name : #Luz,
	#superclass : #SpApplication,
	#instVars : [
		'bookLibrary',
		'selectedItem'
	],
	#category : #'TGBookLibrary-App'
}

{ #category : #accessing }
Luz >> bookLibrary [
	^ bookLibrary
]

{ #category : #accessing }
Luz >> bookLibrary: anObject [
	bookLibrary := anObject
]

{ #category : #'as yet unclassified' }
Luz >> deleteBook [

	"implement this"
]

{ #category : #initialization }
Luz >> initializeWithUrl: aUrl [

	self bookLibrary: (BookLib new initializeWithUrl: aUrl).
	self bookLibrary fetchList
]

{ #category : #'as yet unclassified' }
Luz >> openBookEditor [

	"what do I do?"

]

{ #category : #'as yet unclassified' }
Luz >> saveBook [

	"which book do I save"
]

{ #category : #accessing }
Luz >> selectedItem [
	^ selectedItem
]

{ #category : #accessing }
Luz >> selectedItem: anObject [
	selectedItem := anObject
]
