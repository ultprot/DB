Insert INTO 차량(차량번호, 차종, 고유번호)
select 10000 ,'big' , 유저.고유번호
from 차량 join 사용자 on 차량.고유번호= 사용자.고유번호
join 유저 on 사용자.고유번호=유저.고유번호
where 유저.아이디='id2'