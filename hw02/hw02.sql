--  1 ���������� ���� MySQL. �������� � �������� ���������� ���� .my.cnf, ����� � ��� ����� � ������, ������� ���������� ��� ���������. 
--  ����� ��������� � ����� C:\Program Files\MySQL\MySQL Server 8.0 , ���� my.cnf � ���������� 

-- [mysql] 
-- user=root 
-- password=******* 
-- 
--  2 �������� ���� ������ example, ���������� � ��� ������� users, ��������� �� ���� ��������, ��������� id � ���������� name. 

DROP DATABASE IF EXISTS exemple; 

CREATE DATABASE exemple; 

USE exemple; 

DROP TABLE IF EXISTS users; 

CREATE TABLE users( 

id INT(100),  

name VARCHAR(100)); 

--  3 �������� ���� ���� ������ example �� ����������� �������, ���������� ���������� ����� � ����� ���� ������ sample. 
--    �������������� ������� root �� client 

mysqldump exemple > sample.sql 



