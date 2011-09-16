-- Opens a dialog where you can enter the entry to send to Wolfram Alpha
-- Can be triggered with an app like Apptivate.
-- Made to copy search with triggers in Quicksilver.
tell me
	activate
	set search to text returned of (display dialog "Enter Search Query." with title "Wolfram Alpha" default answer "" buttons {"Search", "Cancel"} default button 1)
	try
		open location "http://www.wolframalpha.com/input/?i=" & search
	end try
end tell