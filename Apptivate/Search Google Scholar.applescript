-- Opens a dialog where you can enter the entry to search with Google Scholar
-- Can be triggered with an app like Apptivate.
-- Made to copy search with triggers in Quicksilver.
tell me
	activate
	set search to text returned of (display dialog "Enter Search Query." with title "Google Scholar" default answer "" buttons {"Search", "Cancel"} default button 1)
	try
		open location "http://scholar.google.com/scholar?q=" & search & "&hl=en&btnG=Search&as_sdt=1%2C5&as_sdtp=on"
	end try
end tell