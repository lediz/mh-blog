//----------------------------------------------------------------------------//

CLASS EntryModel 

	DATA cAlias

	METHOD New()             		CONSTRUCTOR
	METHOD Rows( nId, nRows )
	
ENDCLASS

//----------------------------------------------------------------------------//

METHOD New() CLASS EntryModel
	
	USE ( AppPathData() + 'entry.dbf' ) SHARED NEW VIA 'DBFCDX'
	SET INDEX TO 'entry.cdx'
	
	::cAlias := Alias()		

RETU SELF

METHOD Rows( nId, nRows ) CLASS EntryModel

	LOCAL hData 	:= {=>}
	LOCAL hRows 	:= {}
	LOCAL nCount 	:= 0
	LOCAL nRecno

	DEFAULT nId 		 TO 0
	DEFAULT nRows		 TO 5
	
	IF nId == 0
		(::cAlias)->( DbGoTop() )
	ELSE
		(::cAlias)->( DbGoto( nId ) )
		(::cAlias)->( DbSkip() )
	ENDIF
	
		WHILE nCount < nRows .AND. (::cAlias)->( !Eof() )
		
			nRecno := (::cAlias)->( Recno() )
		
			Aadd( hRows, { '_recno'	=> nRecno,;
							'id' 		=> (::cAlias)->id,;
							'fecha'		=> (::cAlias)->fecha,;
							'titulo'	=> (::cAlias)->titulo,;
							'texto' 	=> (::cAlias)->texto ;
						})						
		
			nCount++						
		
			(::cAlias)->( DbSkip(1) )
		END	
		
	hData[ 'recno' ] := nRecno
	hData[ 'rows'  ] := hRows

RETU hData
