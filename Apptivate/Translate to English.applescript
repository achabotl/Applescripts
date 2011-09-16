-- Opens a dialog where you can input text. Then sends it to Google Translate.
-- Uses Google's auto-detect feature.
tell me
	activate
	set search to text returned of (display dialog "Translate to English" default answer "" buttons {"Search", "Cancel"} default button 1)
	try
		open location "http://translate.google.com/translate_t?text=" & search & "&langpair=auo%7Cen"
	end try
end tell