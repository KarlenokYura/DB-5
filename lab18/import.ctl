LOAD DATA
	INFILE 'D:\Database\lab18\import.txt'
	INTO TABLE load_data
	FIELDS TERMINATED BY "," 
	(
	t_number "ROUND(:t_number, 2)",
	t_str "UPPER(:t_str)",
	t_date DATE 'DD.MM.YYYY'
	)
