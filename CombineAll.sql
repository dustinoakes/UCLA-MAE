CREATE TABLE all_hotels
	SELECT * FROM hotels_boston UNION SELECT  * FROM tripadvisor_boston
	UNION SELECT * FROM hotels_las_vegas UNION SELECT * FROM tripadvisor_las_vegas
	UNION SELECT * FROM hotels_los_angeles UNION SELECT * FROM tripadvisor_los_angeles
	UNION SELECT * FROM hotels_miami UNION SELECT * FROM tripadvisor_miami
	UNION SELECT * FROM hotels_new_orleans UNION SELECT * FROM tripadvisor_new_orleans
	UNION SELECT * FROM hotels_new_york UNION SELECT * FROM tripadvisor_new_york
	UNION SELECT * FROM hotels_philadelphia UNION SELECT * FROM tripadvisor_philadelphia
	UNION SELECT * FROM hotels_san_diego UNION SELECT * FROM tripadvisor_san_diego
	UNION SELECT * FROM hotels_seattle UNION SELECT * FROM tripadvisor_seattle
	UNION SELECT * FROM hotels_washington_dc UNION SELECT * FROM tripadvisor_washington_dc;

SELECT hotel, 
CAST(ratings as DECIMAL(3,1)) as ratings,
city,
price,
site,
CAST(ratings as DECIMAL(3,1))/CAST(REPLACE(price, '$', '') AS DECIMAL(4,0)) as value
FROM all_hotels
WHERE ratings >= 0
ORDER BY value DESC