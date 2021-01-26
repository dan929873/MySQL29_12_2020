-- 1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
-- catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы,
-- идентификатор первичного ключа и содержимое поля name.

-- !!! Archive - не поддерживает индексы, поэтому при определении
-- таблицы первичный ключ не указывается. !!!

DROP TABLE IF EXIST logs;
CREATE TABLE logs (
	create_at DATETIME NOT NULL,
	table_name VARCHAR(50) NOT NULL,
	id_bint BIGINT, NOT NULL,
	name_v VARCHAR(50) NOT NULL
) ENGINE = ARCHIVE;

-- триггер для users
DROP TRIGGER IF EXIST log_users;
delimiter //
CREATE TRIGGER log_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs(create_at, table_name, id_bint, name_v)
	VALUES(NOW(), 'users', NEW.id, NEW.name);
END//
delimiter ;
-- триггер для catalogs
DROP TRIGGER IF EXIST log_catalogs;
delimiter //
CREATE TRIGGER log_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs(create_at, table_name, id_bint, name_v)
	VALUES(NOW(), 'catalogs', NEW.id, NEW.name);
END//
delimiter ;

-- триггер для products
DROP TRIGGER IF EXIST products;
delimiter //
CREATE TRIGGER products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs(create_at, table_name, id_bint, name_v)
	VALUES(NOW(), 'catalogs', NEW.id, NEW.name);
END//
delimiter ;

-- 2 (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

DROP PROCEDURE IF EXISTS insert_into_users ;
delimiter //
CREATE PROCEDURE insert_into_users ()
BEGIN
	DECLARE i INT DEFAULT 0; 
	DECLARE j INT DEFAULT 1000000; -- количество запичей
	WHILE i < j DO
		INSERT INTO users(name, birthday_at) 
			VALUES (CONCAT('user_', i), NOW());
		SET i = i + 1;
	END WHILE;
END //
delimiter ;


