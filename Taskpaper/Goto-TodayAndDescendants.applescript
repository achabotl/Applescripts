tell application "TaskPaper"
	set the search field string of the front document to "(@today or @overdue) +d"
end tell