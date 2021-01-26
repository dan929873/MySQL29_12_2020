--    1 Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).

use vk;
select from_user_id, COUNT(from_user_id) as частота, to_user_id from vk.messages where to_user_id = 1 GROUP BY from_user_id ORDER BY частота desc


--    2 Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

-- получаем пользователей младше 10 лет

select user_id from likes where user_id 
	IN(select id from users where id 
		IN(select user_id as 'id_user_likes' from profiles 
			where TIMESTAMPDIFF(year, birthday, now()) < 10));

--    3 Определить кто больше поставил лайков (всего): мужчины или женщины.
 
select count(gender) as men, (
	select count(gender) as fem from profiles 
		where user_id in(select id from users 
		where id in(select user_id from likes)) and gender = 'f')as fem 
from profiles 
	where user_id in(select id from users 
	where id in(select user_id from likes)) and gender = 'm';
	
