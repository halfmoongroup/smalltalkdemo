Class {
	#name : #BookPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'title',
		'author',
		'lang',
		'year'
	],
	#category : #'TGBookLibrary-App'
}

{ #category : #initialization }
BookPresenter class >> defaultLayout [

		^ SpGridLayout new
					add: 'Title' at: 1@1; add: #title at: 2@1;
					add: 'Author' at: 1@2; add: #author at: 2@2; 
					add: 'Lang' at: 1@3; add: #lang at: 2@3; 
					add: 'Year' at: 1@4; add: #year at: 2@4; yourself
]

{ #category : #specs }
BookPresenter class >> defaultSpec [
	^self defaultLayout
]

{ #category : #initialization }
BookPresenter >> initializePresenters [

	title  := self newTextInput. 
	author  := self newTextInput. 
	lang := self newTextInput.
	year  := self newNumberInput
              rangeMinimum: 1800
              maximum:  Year current year

]
