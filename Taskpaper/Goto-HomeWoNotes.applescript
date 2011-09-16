tell application "TaskPaper"
	set the search field string of the front document to "(type = \"task\") and not @done and not @start"
end tell