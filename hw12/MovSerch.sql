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
	INDEX(address)
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

INSERT INTO `cinemas` VALUES 
('4', '05379 Anya Mountains\nWest Kennethmouth, MT 01234'),
('1', '0994 Viola Radial Suite 000\nAlejandrinstad, MA 89116'),
('3', '1402 Jonatan Terrace\nSelenatown, HI 14027-3036'),
('5', '180 Judy Dam\nEast Ulices, IN 20159'),
('9', '2126 Tess Motorway\nNorth Harryton, IA 73434'),
('10', '47428 Feeney Inlet Apt. 235\nPercyborough, MN 99407'),
('8', '5478 Walter Springs\nDedricchester, NC 58311'),
('6', '580 Alisha Brook\nJaylinland, WY 43614-0503'),
('7', '6919 Gillian Meadow Apt. 939\nSincereville, CT 36894'),
('2', '884 Morris Springs\nSipesfurt, NE 67943-0359');

INSERT INTO `movie_personality` VALUES ('1', 'odio', 'Ortiz', 'Aut animi iure consectetur cumque voluptatem non. ', 'lurline.muller@example.org'),
('2', 'labore', 'Larkin', 'Autem error et quam corrupti veniam. Adipisci dolo', 'riley59@example.com'),
('3', 'pariatur', 'Grimes', 'Repellat dolores hic nihil odit aut quas ut. Eveni', 'casper.monserrate@example.org'),
('4', 'laudantium', 'Kirlin', 'Molestiae provident possimus corrupti eos et. Et i', 'edietrich@example.org'),
('5', 'et', 'Maggio', 'Placeat in voluptas rerum amet. Ipsa sit quod volu', 'ottilie.funk@example.com'),
('6', 'laboriosam', 'Abernathy', 'Fuga quaerat quasi eum quos. Voluptatem facere dol', 'hyatt.lukas@example.net'),
('7', 'quisquam', 'Cummerata', 'Aut non consequatur id necessitatibus suscipit ut.', 'htreutel@example.com'),
('8', 'sunt', 'West', 'Recusandae sunt temporibus magnam minus illo quasi', 'lavinia86@example.net'),
('9', 'nihil', 'Eichmann', 'Quis provident ipsa veniam in. Debitis nam aut nih', 'jaquan76@example.org'),
('10', 'amet', 'Yundt', 'Praesentium ratione voluptatem natus saepe qui vol', 'kiehn.jayme@example.org');


INSERT INTO `movies` VALUES ('1', 'Illo hic quas dolorum.', '2009-06-03'),
('2', 'Velit nemo quia non est laboriosam.', '1971-03-26'),
('3', 'Ipsa commodi sit nulla atque fugit.', '2007-12-27'),
('4', 'Voluptates ratione quis quia.', '2020-12-06'),
('5', 'Saepe ut porro mollitia veritatis.', '2018-05-18'),
('6', 'Voluptate qui architecto molestiae quia voluptate ', '1986-11-06'),
('7', 'Enim qui sit rerum minus sit a.', '2005-09-14'),
('8', 'Dolorem vel sint velit quod ut.', '1982-02-13'),
('9', 'Officiis ut qui earum consequuntur ex mollitia et.', '2008-02-23'),
('10', 'Aut quis dolor quo.', '1970-07-03');


INSERT INTO `movie_personality_movies` VALUES ('1', '1'),
('2', '2'),
('3', '3'),
('4', '4'),
('5', '5'),
('6', '6'),
('7', '7'),
('8', '8'),
('9', '9'),
('10', '10'),
('1', '2'),
('2', '3'),
('3', '4'),
('4', '5'),
('5', '6'),
('6', '7'),
('7', '8'),
('8', '9'),
('9', '10'),
('10', '1');

INSERT INTO `cinemas_movies` VALUES ('1', '1'),
('2', '2'),
('3', '3'),
('4', '4'),
('5', '5'),
('6', '6'),
('7', '7'),
('8', '8'),
('9', '9'),
('10', '10');

INSERT INTO `style_movies` VALUES ('1', '1', 'Drama'),
('2', '2', 'Action movie'),
('3', '3', 'Gangster movie'),
('4', '4', 'Drama'),
('5', '5', 'Melodrama'),
('6', '6', 'Western film'),
('7', '7', 'Western film'),
('8', '8', 'Western film'),
('9', '9', 'Detective'),
('10', '10', 'Detective');

INSERT INTO `trailer` VALUES ('1', '1', '2010-05-23', 'Ducimus odit cumque ab ea.'),
('2', '2', '1981-03-20', 'Quaerat incidunt harum mollitia laboriosam aliquam.'),
('3', '3', '1984-07-08', 'Consequatur eveniet eius delectus iste nihil.'),
('4', '4', '1993-12-08', 'Assumenda quia officiis culpa tempore.'),
('5', '5', '1995-12-03', 'Molestiae possimus amet ipsam mollitia.'),
('6', '6', '2011-04-02', 'Quia modi in ratione sequi a ea excepturi consequatur.'),
('7', '7', '1996-05-25', 'Vitae est voluptatem iusto perspiciatis ullam beatae.'),
('8', '8', '2002-03-26', 'Quis doloremque omnis excepturi exercitationem.'),
('9', '9', '1992-04-26', 'Fugiat autem eligendi accusamus fugiat quis velit aut dolore.'),
('10', '10', '1999-03-26', 'Adipisci praesentium fugiat magni est et quo debitis.');


INSERT INTO `users` VALUES ('1', 'nulla', 'b0f8d0ba960f61561291acb7a318245ca6022de1', 'reagan13@example.org', '8566 Huel Manors\nEast Zane, IA 35054-0141'),
('2', 'vitae', '8f7c7b12ddc68cca04acc7c13afe058cadfdb5ba', 'lweissnat@example.net', '153 Lucius Bypass Apt. 765\nHahnburgh, CA 94237-281'),
('3', 'voluptatem', '7ee059150f586e3678ab28f3e3b80070359c722a', 'zlockman@example.org', '1462 Alfonso Road Apt. 474\nRoobborough, FL 34189-8'),
('4', 'ut', 'a7bc74a332303f6f7d1cca8da0786b7f56b91461', 'trey.maggio@example.com', '3137 Garrison Street Apt. 112\nLake Shayneport, AL '),
('5', 'voluptatibus', '84a9522d7e324d0e45313f36d3f996ba07da05a0', 'awuckert@example.net', '8814 Napoleon Camp Suite 602\nJoelleberg, AL 56489-'),
('6', 'repellendus', '9b93b21320c1911dfc8d86bc6ea35b94c628ede9', 'imarks@example.com', '8358 Boris Forges Suite 664\nGideonview, VA 32185-5'),
('7', 'veritatis', 'a435da9e538a9e1ad9e80b85509e780e1f962526', 'madyson09@example.org', '0307 Lakin Mall Suite 655\nWest Marcchester, GA 953'),
('8', 'deleniti', '2541d223ca3efb14cae0080fb55a59a5b2131884', 'zchamplin@example.net', '876 Schamberger Villages\nFayport, SD 68088-0178'),
('9', 'sed', '37827298a7b9d34a28c86ac857b9117fbe8a40d3', 'njohns@example.com', '28899 Josiah Row\nWavamouth, NY 82752-9527'),
('10', 'aspernatur', 'c74a0d313de74ceaaf695bad1db62e72b817a4f2', 'hwuckert@example.com', '1884 Bartell Park Suite 853\nNorth Torrance, RI 053');

INSERT INTO `users_movies` VALUES ('1', '1', '6'),
('2', '2', '5'),
('3', '3', '3'),
('4', '4', '8'),
('5', '5', '1'),
('6', '6', '3'),
('7', '7', '1'),
('8', '8', '6'),
('9', '9', '3'),
('10', '10', '9');

INSERT INTO `selected` VALUES ('1', '1', '1'),
('2', '2', '2'),
('3', '3', '3'),
('4', '4', '4'),
('5', '5', '5'),
('6', '6', '6'),
('7', '7', '7'),
('8', '8', '8'),
('9', '9', '9'),
('10', '10', '10');

INSERT INTO `reviews` VALUES 
('1', '1', '1', 'Optio non et architecto ratione cumque. Sapiente accusantium dolores qui tempora. Corporis placeat sit repellendus velit. Deleniti nisi asperiores quisquam eos explicabo molestiae.', '2009-02-27 04:13:04'),
('2', '2', '2', 'Consequatur voluptate a inventore voluptatem. Eos necessitatibus quod fugit natus eos ut. Suscipit et iste saepe ex.', '2008-10-06 04:59:16'),
('3', '3', '3', 'Temporibus magnam id rerum iste eius odit. Esse voluptas id beatae et omnis eius vero aperiam. Aperiam ipsum corrupti ab quis molestiae.', '1971-07-20 23:08:19'),
('4', '4', '4', 'Quisquam blanditiis doloribus vero veniam et labore numquam voluptas. Esse nihil consequuntur ipsa voluptas nam. Quisquam nulla eos ea hic iste.', '1975-01-13 03:18:29'),
('5', '5', '5', 'Ad aut error in qui qui et et. Voluptate dicta consectetur quia laborum reiciendis. Beatae expedita totam deserunt sunt ad eum distinctio exercitationem.', '1981-08-30 16:54:49'),
('6', '6', '6', 'Soluta ipsam omnis voluptatibus aperiam est voluptatem qui. Iusto iusto quam qui illo. Facere architecto in repellendus quam sit quae est. Sunt tempora molestias omnis perferendis eum excepturi.', '1995-07-14 09:11:23'),
('7', '7', '7', 'Autem dolor molestiae sed ea quisquam praesentium voluptatibus necessitatibus. Tenetur iste occaecati qui quas. Dolore optio quidem est consectetur modi. Iure illum ab cupiditate consequuntur exercitationem reprehenderit. Asperiores cumque fugit rerum earum voluptatum impedit reiciendis earum.', '1977-10-08 06:49:25'),
('8', '8', '8', 'Reiciendis aliquid asperiores modi. Sed autem ut et inventore illo porro ea. Dolorem modi odio rerum laudantium tempora autem voluptatem.', '2020-08-21 11:57:00'),
('9', '9', '9', 'Consequatur repudiandae est enim quis suscipit dolorem. Earum necessitatibus voluptas illo odit. Ipsam fugiat mollitia nihil dolor officia.', '1992-07-12 17:24:47'),
('10', '10', '10', 'Totam id dolor necessitatibus sed. Nihil similique qui in. Minus est praesentium aut sint quae impedit nihil.', '2012-10-10 05:52:32');



-- --6 скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы);
-- можно что то одно из скобок
 
SELECT name FROM users ORDER BY name asc; 

select id, movie_title FROM movies WHERE (release_date < '2000.01.01');

-- запрос имен пользователей которые оставили рецензии
select id, name from users where id in (select id_user from reviews) order by id; 

-- вывести  id и название фильма, имя киноличностей, id и пользователи которые поставили оценки, рейтинг выше 5
select mpm.movie as 'id фильма', m.movie_title as 'название фильма', mp.name  as 'участники фильма', 
um.users as 'id пользователя', u2.name as 'имя пользователя', um.rating as 'рейтинг > 5' 
from movie_personality_movies mpm 
join movies m on mpm.movie = m.id 
join movie_personality mp on mpm.movie_personality = mp.id
join users_movies um on m.id = um.movies 
join users u2 on u2.id = um.users 
where um.rating > 5
order by m.id 


-- --7 представления (минимум 2);
-- обьеденить с 6, views можно как пример из sacila посмотреть 
 
-- 1 лучшие 3 фильма по мнению пользователей 
create or replace view best_films3 as
	select m.movie_title from users_movies um
	join movies m on um.movies = m.id 
	order by um.rating DESC
	limit 3;

select * from best_films3

-- 2 фильмы вестерн
create or replace view western as
	select m.movie_title from style_movies sm 
	join movies m on m.id = sm.id_movie 
	where sm.style_mov = 'Western film';

select * from western

-- --8 хранимые процедуры / триггеры;
-- рекомендации 
-- топ 3 любимых жанра
-- топ 3 любимых актера и режисера
-- топ 3 по обсолютному рейтигу

drop procedure if exists ratingbest_movies_person_style;

create procedure ratingbest_movie_person_style()
begin
-- рейтинг фильмов 
-- актера и режисера
-- жанр
	select m.movie_title as 'название фильма', mp.name as 'киноличности', sm.style_mov as 'жанры' from users_movies um
	join movies m on um.movies = m.id 
	join movie_personality_movies mpm on mpm.movie = um.movies 
	join movie_personality mp on mp.id = mpm.movie_personality 
	join style_movies sm on sm.id_movie = m.id 
	order by um.rating desc;

end;

call ratingbest_movie_person_style();


