Class {
	#name : #QueryBook,
	#superclass : #Object,
	#instVars : [
		'title',
		'author'
	],
	#category : #'TGBookLibrary-Domain'
}

{ #category : #accessing }
QueryBook >> author [
	^ author
]

{ #category : #accessing }
QueryBook >> author: anObject [
	author := anObject
]

{ #category : #accessing }
QueryBook >> title [
	^ title
]

{ #category : #accessing }
QueryBook >> title: anObject [
	title := anObject
]
