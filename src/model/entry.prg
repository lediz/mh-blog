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

	DEFAULT nId 		 TO 1
	DEFAULT nRows		 TO 5
	
	(::cAlias)->( DbGoto( nId ) )
	
		WHILE nCount < nRows .AND. (::cAlias)->( !Eof() )
		
			Aadd( hRows, { 'id' 		=> (::cAlias)->id,;
							'fecha'		=> (::cAlias)->fecha,;
							'titulo'	=> (::cAlias)->titulo,;
							'texto' 	=> (::cAlias)->texto ;
						})						
		
			nCount++
		
			(::cAlias)->( DbSkip(1) )
		END	
	
	hData[ 'recno' ] := (::cAlias)->( Recno() )
	hData[ 'rows'  ] := hRows

RETU hData
