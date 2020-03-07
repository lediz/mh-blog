//----------------------------------------------------------------------------//

CLASS RootController

    METHOD New( oController )

    METHOD Next( oController )  

    METHOD Default( oController )  

ENDCLASS    

//----------------------------------------------------------------------------//

METHOD New( oController ) CLASS RootController

    local cAction := oController:oRequest:Post( 'action' )

	? 'Action => ', cAction
	
    do case
       case cAction == "Next"   	; ::Next( oController )

       otherwise
          ::Default( oController ) 
		  
    endcase

return Self    

//----------------------------------------------------------------------------//

METHOD Default( oController ) CLASS RootController

   local oModelEntry 	:= EntryModel():New()   
   local hData 		:= oModelEntry:Rows( nil, 5 )   

   oController:View( "root.view", hData )

RETU nil 

METHOD Next( oController ) CLASS RootController  

	local oModelEntry := EntryModel():New() 
	local nRecno 		:= oController:oRequest:Post( 'recno', 0, 'N' )
	local hData 		:= oModelEntry:Rows( nRecno, 5 )

	oController:View( "root.view", hData )
	
RETU NIL


{% zinclude( "/src/model/entry.prg" ) %}
