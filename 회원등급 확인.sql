select distinct 유저.아이디 ,총사용시간,
	case when 총사용시간 >= 40 then '우수회원'
	when 총사용시간 between 10 and 39 then '보통회원'
	when 총사용시간 between 5 and 9 then '소극적회원' else '유령회원' end as '회원등급'
from 사용이력 join (select 사용이력.사용자_고유번호,
sum(datediff(hour,사용이력.주차_시작시간,사용이력.주차종료시간)) as 총사용시간
from 사용이력 group by 사용이력.사용자_고유번호) as 합계 
on 사용이력.사용자_고유번호=합계.사용자_고유번호
join 사용자 on 사용이력.사용자_고유번호=사용자.사용자_고유번호
join 유저 on 유저.고유번호=사용자.사용자_고유번호
where 사용이력.주차종료시간 is not null
order by 총사용시간 DESC;


