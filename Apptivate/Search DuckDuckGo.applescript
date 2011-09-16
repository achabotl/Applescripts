-- Opens a dialog where you can enter the entry to search with DuckDuckGo. 
-- You can commen the search line and use Google instead.
-- Can be triggered with an app like Apptivate.
-- Made to copy search with triggers in Quicksilver.
tell me
	activate
	set search to text returned of (display dialog "Enter Search Query." with title "Google" default answer "" buttons {"Search", "Cancel"} default button 1)
	try
		--		open location "http://www.google.com//search?hl=en&source=hp&q=" & search
		open location "https://duckduckgo.com/?q=" & search
	end try
end tell