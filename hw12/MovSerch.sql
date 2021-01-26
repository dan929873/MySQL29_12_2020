-- 1 Составить общее текстовое описание БД и решаемых ею задач;
-- КиноПоиск сайт с описанием фильмов и людей учавствующих в сьемках, 
-- а также возможностью оставлять рецензии об просмотринном и составлять список любимых фильмов. 

-- 2 минимальное количество таблиц - 10;

DROP DATABASE IF EXISTS CinemaSearch;
CREATE DATABASE CinemaSearch;
USE CinemaSearch;

-- 1 фильмы 
DROP TABLE IF EXISTS movies;
CREATE TABLE movies (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    movie_title VARCHAR(50) UNIQUE,
 	release_date DATE, 
    INDEX (movie_title)
) COMMENT 'фильмы';

-- 2 жанры 
DROP TABLE IF EXISTS style_movies;
CREATE TABLE style_movies (
	id SERIAL, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE 
    id_movie BIGINT UNSIGNED NOT NULL,
    style_mov ENUM('Action movie', 'Western film', 'Gangster movie',
					'Detective', 'Drama', 'Historical film',
					'Comedy', 'Melodrama'),	
    FOREIGN KEY (id_movie) REFERENCES movies(id)    
) COMMENT 'жанры';


-- 3 киноличности
DROP TABLE IF EXISTS movie_personality;
CREATE TABLE movie_personality (
	id SERIAL, 
	name VARCHAR(50),
	lastname VARCHAR(50),
	profession VARCHAR(50),
	email VARCHAR(120) UNIQUE
) COMMENT 'участники_кино';

-- 4 фильмография связь м*м между фильмами киноличностями
DROP TABLE IF EXISTS movie_personality_movies;
CREATE TABLE movie_personality_movies (
	movie_personality BIGINT UNSIGNED NOT NULL,
	movie BIGINT UNSIGNED NOT NULL,
	
	PRIMARY KEY(movie_personality, movie),
	FOREIGN KEY (movie_personality) REFERENCES movie_personality(id),
	FOREIGN KEY (movie) REFERENCES movies(id)
);

-- 5 трейлер (много бывает)
DROP TABLE IF EXISTS trailer;
CREATE TABLE trailer (
	id SERIAL,
	id_movies BIGINT UNSIGNED NOT NULL,
	release_date DATE, 
	trailer_title VARCHAR(100),
	FOREIGN KEY (id_movies) REFERENCES movies(id)
);

-- 6 пользователи
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL,
	name VARCHAR(50),
	password_hash VARCHAR(100), 
	email VARCHAR(120) UNIQUE,
	town VARCHAR(50),
	INDEX(name),
	INDEX(email)
);

-- 7 рейтинги м*м между польз и фильмами
DROP TABLE IF EXISTS users_movies;
CREATE TABLE users_movies (
	users BIGINT UNSIGNED NOT NULL,
	movies BIGINT UNSIGNED NOT NULL,
	rating ENUM('1', '2', '3', '4', '5', '6', '7', '8', '9', '10'),	
	PRIMARY KEY(users, movies),
	FOREIGN KEY (users) REFERENCES users(id),
	FOREIGN KEY (movies) REFERENCES movies(id)
);

-- 8 избранные фильмы
DROP TABLE IF EXISTS selected;
CREATE TABLE selected (
	id SERIAL,
	id_user BIGINT UNSIGNED NOT NULL,
	id_movie BIGINT UNSIGNED NOT NULL,	
	FOREIGN KEY (id_user) REFERENCES users(id),
	FOREIGN KEY (id_movie) REFERENCES movies(id),
	INDEX(id_user)
);

-- 9 рецензии 
DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews (
	id SERIAL,
	id_user BIGINT UNSIGNED NOT NULL,
	id_movies BIGINT UNSIGNED NOT NULL,
	body TEXT,
	create_at DATETIME DEFAULT NOW(),
	FOREIGN KEY (id_user) REFERENCES users(id),
	FOREIGN KEY (id_movies) REFERENCES movies(id),
	INDEX(id_movies),
	INDEX(id_user)
);

-- 10 кинотеатры
DROP TABLE IF EXISTS cinemas;
CREATE TABLE cinemas (
	id SERIAL,
	address VARCHAR(100),
	INDEX(adress)
);

-- 11 показы в кино
DROP TABLE IF EXISTS cinemas_movies;
CREATE TABLE cinemas_movies (
	id_movies BIGINT UNSIGNED NOT NULL,
	id_cinemas BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY(id_movies, id_cinemas),
	FOREIGN KEY (id_movies) REFERENCES movies(id),
	FOREIGN KEY (id_cinemas) REFERENCES cinemas(id)
);



-- --3 скрипты создания структуры БД (с первичными ключами, индексами, внешними ключами);
-- ключами индексами связями
-- ddl команды
-- 
-- --4 создать ERDiagram для БД;
-- скриншот, если не разобрать при уменьшении то надо разбить на части (сохранить как картинку)
-- 
-- --5 скрипты наполнения БД данными;
-- insert INTO (вставлять пакетами)
-- более 100 строк не надо в каждой таблице не надо



-- --6 скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы);
-- можно что то одно из скобок
-- 
-- --7 представления (минимум 2);
-- обьеденить с 6, views можно как пример из sacila посмотреть 
-- 
-- 1 кассовые сборы
-- 2 сегодня в кино (зависит от геолокаци)
-- 3 самые ожидаемые фильмы (рейтинги и выход в будущем)
-- 
-- --8 хранимые процедуры / триггеры;
-- 1 процедура, 1 тригер, 1 процедура
-- 
-- рекомендации 
-- топ 3 любимых жанра
-- топ 3 любимых актера и режисера
-- топ 3 по обсолютному рейтигу
