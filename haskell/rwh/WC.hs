--- file: ch1/WC.hs
--- comment here

main = interact wordCount
	where wordCount input = show (length (words inpu:t)) ++ "\n"
