select  유저.아이디, *
from 주차장 join 소유자 on 주차장.고유번호=소유자.고유번호
join 유저 on 유저.고유번호 = 소유자.고유번호
where 유저.아이디='almlpa'