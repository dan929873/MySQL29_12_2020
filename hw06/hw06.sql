--    1 ����� ����� ��������� ������������. �� ���� ������������� ���. ���� ������� ��������, ������� ������ ���� ������� � ��������� ������������� (������� ��� ���������).

use vk;
select from_user_id, COUNT(from_user_id) as �������, to_user_id from vk.messages where to_user_id = 1 GROUP BY from_user_id ORDER BY ������� desc


--    2 ���������� ����� ���������� ������, ������� �������� ������������ ������ 10 ���..

-- �������� ������������� ������ 10 ���

select user_id from likes where user_id 
	IN(select id from users where id 
		IN(select user_id as 'id_user_likes' from profiles 
			where TIMESTAMPDIFF(year, birthday, now()) < 10));

--    3 ���������� ��� ������ �������� ������ (�����): ������� ��� �������.
 
select count(gender) as men, (
	select count(gender) as fem from profiles 
		where user_id in(select id from users 
		where id in(select user_id from likes)) and gender = 'f')as fem 
from profiles 
	where user_id in(select id from users 
	where id in(select user_id from likes)) and gender = 'm';
	
