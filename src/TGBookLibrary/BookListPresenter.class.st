Class {
	#name : #BookListPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'bookList',
		'menu'
	],
	#category : #'TGBookLibrary-App'
}

{ #category : #initialization }
BookListPresenter class >> defaultLayout [

	^SpBoxLayout newVertical
	    add: #bookList;
	    yourself
]

{ #category : #'as yet unclassified' }
BookListPresenter class >> defaultSpec [
	^self defaultLayout
]

{ #category : #modifying }
BookListPresenter >> addBook [

	"does nothing"
]

{ #category : #'private building' }
BookListPresenter >> buildFileMenu [

	^ self newMenu 
			addItem: [ :item | item name: 'Edit Book..'; action:[ self application openBookEditor]];
			addItem: [ :item | item name: 'Add Book..'; action:[ self application saveBook]];
			addItem: [ :item | item name: 'Delete Book..'; action:[ self application deleteBook]];
			yourself
			
]

{ #category : #'private building' }
BookListPresenter >> buildMenuBar [ 


	^self newMenuBar 
		addGroup: [ :group | group 
				addItem: [ :item | item name: 'File'; subMenu: self buildFileMenu ]  ]
]

{ #category : #modifying }
BookListPresenter >> deleteBook [
]

{ #category : #initialization }
BookListPresenter >> initializePresenters [
	
	bookList :=  self newTable
		addColumn: (SpStringTableColumn title: 'Title' evaluated: #title);
		addColumn: (SpStringTableColumn title: 'Author' evaluated: #author);
		addColumn: (SpStringTableColumn title: 'Year' evaluated: #originalPublicationYear );
		yourself.
	bookList whenSelectionChangedDo:[ :selectedItemMode | 
		selectedItemMode isEmpty ifFalse:[self application selectedItem: 
				(selectedItemMode selectedItem)]].
		self updatePresenter
]

{ #category : #initialization }
BookListPresenter >> initializeWindow: aWindowPresenter [


	aWindowPresenter
			title: 'Mini Book Editor'; 
			initialExtent: 600@400; 
			menu: ( menu := self buildMenuBar);
			toolBar: (self newToolBar
						addItem: (SpToolBarButton new 
											icon: (self application iconNamed: #smallAdd);
											help: 'Add Book';	
                          action: [ self addBook  ];
                          yourself);
						addItem: (SpToolBarButton new 
											icon: (self application iconNamed: #smallDeleteIcon );
											help: 'Add Book';	
                          action: [ self deleteBook  ];
                          yourself);
                       yourself)
]

{ #category : #initialization }
BookListPresenter >> updatePresenter [

	
	bookList items: (self application bookLibrary books). 
	"bookList items: (OrderedCollection new). "
]
