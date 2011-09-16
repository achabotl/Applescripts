-- Opens a dialog where you can enter the entry to search Artists on Pitchfork
-- Can be triggered with an app like Apptivate.
-- Made to copy search with triggers in Quicksilver.
tell me
	activate
	set search to text returned of (display dialog "Enter Search Query." with title "Pitchfork Artist Search" default answer "" buttons {"Search", "Cancel"} default button 1)
	try
		open location "http://pitchfork.com/search/?query=" & search & "&filters=albums&search_type=advanced"
	end try
end tell