-- Opens a dialog where you can enter the entry search for an Artist on allmusic.com
-- Can be triggered with an app like Apptivate.
-- Made to copy search with triggers in Quicksilver.
tell me
	activate
	set search to text returned of (display dialog "Enter Search Query." with title "All Music Guide" default answer "" buttons {"Search", "Cancel"} default button 1)
	try
		open location "http://allmusic.com/search/artist/" & search
	end try
end tell