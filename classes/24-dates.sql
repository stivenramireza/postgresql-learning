SELECT 
	NOW(),
	CURRENT_DATE,
	CURRENT_TIME,
	DATE_PART('hours', NOW()) AS hours,
	DATE_PART('minutes', NOW()) AS minutes,
	DATE_PART('seconds', NOW()) AS seconds,
	DATE_PART('days', NOW()) AS days,
	DATE_PART('months', NOW()) AS months,
	DATE_PART('years', NOW()) AS years;
