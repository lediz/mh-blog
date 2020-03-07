// {% LoadHrb( "/lib/core_lib.hrb" ) %}
// {% LoadHrb( "/lib/mercury.hrb" ) %}

function Main()

	local oApp := App()
   
		oApp:oRoute:Map( "GET,POST"			, "root"			, "/"			, "@rootcontroller.prg" )

	oApp:Init()

return nil

function AppPathData() ; RETU AP_GetEnv( "DOCUMENT_ROOT" ) + AP_GetEnv( "PATH_DATA" )