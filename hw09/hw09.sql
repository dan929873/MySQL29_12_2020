-- Практическое задание по теме “Транзакции, переменные, представления”

-- 1 В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 
-- из таблицы shop.users в таблицу sample.users. Используйте транзакции.

use sample; 
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Èìÿ ïîêóïàòåëÿ',
  birthday_at date DEFAULT NULL COMMENT 'Äàòà ðîæäåíèÿ',
  created_at datetime DEFAULT current_timestamp(),
  updated_at datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
)

START TRANSACTION;
INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;
COMMIT;


-- 2 Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название 
-- каталога name из таблицы catalogs.
use shop;
select products.name, catalogs.name from products 
	inner join catalogs on products.catalog_id = catalogs.id;

-- 3 (по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные записи 
-- за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. Составьте запрос, который выводит полный список дат 
-- за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.
use shop;
DROP TABLE IF EXISTS datetbl2;
CREATE TABLE datetbl2 (
	created_at DATE
);

INSERT INTO datetbl2 VALUES
	('2018-08-01'), ('2018-08-02'), ('2018-08-03'), ('2018-08-04'), ('2018-08-05'), ('2018-08-06'), ('2018-08-07'),
	('2018-08-08'), ('2018-08-09'), ('2018-08-10'), ('2018-08-11'), ('2018-08-12'), ('2018-08-13'), ('2018-08-14'),
	('2018-08-15'), ('2018-08-16'), ('2018-08-17'), ('2018-08-18'), ('2018-08-19'), ('2018-08-20'), ('2018-08-21'),
	('2018-08-22'), ('2018-08-23'), ('2018-08-24'), ('2018-08-25'), ('2018-08-26'), ('2018-08-27'), ('2018-08-28'),
	('2018-08-29'), ('2018-08-30'), ('2018-08-31');

DROP TABLE IF EXISTS datetbl;
CREATE TABLE datetbl (
	created_at DATE
);

INSERT INTO datetbl VALUES
	('2018-08-01'),
	('2018-08-04'),
	('2018-08-16'),
	('2018-08-17');


SELECT datetbl2.created_at, datetbl.created_at from datetbl2
left join datetbl on datetbl2.created_at = datetbl.created_at 


-- Практическое задание по теме “Администрирование MySQL” (эта тема изучается по вашему желанию)

-- 1 Создайте двух пользователей которые имеют доступ к базе данных shop. Первому пользователю shop_read 
-- должны быть доступны только запросы на чтение данных, второму пользователю shop — любые операции в пределах 
-- базы данных shop.

CREATE USER shop_read;
GRANT SELECT ON shop.* TO shop_read;

CREATE USER shop;
GRANT ALL ON shop.* TO 'shop'@'localhost' IDENTFIED WICH sha256_password BY '123'; 
-- только не очень понимаю что такое sha256_password, ведь ключевое слово для создания пароля это IDENTFIED WICH
 

-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"

-- 1 Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу 
-- "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

 
DROP FUNCTION IF EXISTS hello_people;

CREATE FUNCTION hello_people(d VARCHAR(255))
RETURNS VARCHAR(255) DETERMINISTIC 
BEGIN
	
	DECLARE my_text VARCHAR(255);
	DECLARE my_h INT;
	SET my_h = HOUR(CONVERT(d, TIME));

	IF my_h = 0 
		THEN SET my_h = 24;
	END IF;

	IF 6 < my_h AND my_h < 12
		THEN SET my_text = 'Доброе утро';
	ELSEIF 12 < my_h AND my_h < 18
		THEN SET my_text = 'Добрый день';
	ELSEIF 18 < my_h AND my_h < 24
		THEN SET my_text = 'Добрый вечер';
	ELSEIF 0 < my_h AND my_h < 6
		THEN SET my_text = 'Доброй ночи';	
	ELSE 
		SET my_text = d;
	END IF;	
	RETURN my_text;
END ;

SELECT hello_people('11:30');
SELECT hello_people('14:00');
SELECT hello_people('19:00');
SELECT hello_people('4:30');

-- 2 В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение 
-- NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.

USE shop;


CREATE TRIGGER ubdate_products BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF NEW.name IS NULL AND NEW.desription IS NULL THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Значение name и description не могут быть NULL одновременно';
	END IF;
END;

INSERT INTO products (name, desription, price, catalog_id)
	VALUES (NULL,NULL, 5060.00,	2);

