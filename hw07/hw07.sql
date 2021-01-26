-- 1 Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

use shop;
SELECT id, name from users where id IN(select user_id from orders group by user_id); 

-- 2 Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT * FROM products WHERE catalog_id IN (SELECT id FROM catalogs)


-- DELIMITER //
CREATE PROCEDURE NOW3()
BEGIN 
	DECLARE i INT DEFAULT 3;
	WHILE i > 0 DO	
END
