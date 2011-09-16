-- Opens a dialog where you can enter the entry to map with Google Maps.
-- Can be triggered with an app like Apptivate.
-- Made to copy search with triggers in Quicksilver.
tell me
	activate
	set search to text returned of (display dialog "Enter Search Query." with title "Google Maps" default answer "" buttons {"Search", "Cancel"} default button 1)
	try
		open location "http://maps.google.com/maps?oi=map&q=" & search
	end try
end tell