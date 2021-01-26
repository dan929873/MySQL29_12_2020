--  1 Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf, задав в нем логин и пароль, который указывался при установке. 
--  Нужно добавлять в папку C:\Program Files\MySQL\MySQL Server 8.0 , файл my.cnf с содержимым 

-- [mysql] 
-- user=root 
-- password=******* 
-- 
--  2 Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name. 

DROP DATABASE IF EXISTS exemple; 

CREATE DATABASE exemple; 

USE exemple; 

DROP TABLE IF EXISTS users; 

CREATE TABLE users( 

id INT(100),  

name VARCHAR(100)); 

--  3 Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample. 
--    Предварительно изменив root на client 

mysqldump exemple > sample.sql 



