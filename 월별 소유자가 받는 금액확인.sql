Select 유저.아이디,DATEPART(mm, 사용이력.주차종료시간) as 월,
sum(사용이력.납부한_요금) as 월별총합납부요금
From 유저 join 소유자 on 유저.고유번호=소유자.소유자_고유번호
join 주차장 on 소유자.소유자_고유번호= 주차장.소유자_고유번호
join 사용이력 on 주차장.주차장_번호=사용이력.주차장_번호
group by 유저.아이디,DATEPART(mm, 사용이력.주차종료시간)
having DATEPART(mm, 사용이력.주차종료시간) is not null and 유저.아이디 like 'a%'
order by DATEPART(mm, 사용이력.주차종료시간)
