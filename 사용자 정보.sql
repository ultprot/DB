select 사용자.고유번호, 유저.아이디, 유저.비밀번호, 유저.생년월일, 유저.전화번호
from 유저 left outer join 사용자 on 유저.고유번호=사용자.고유번호 
where 사용자.고유번호 is not null and 유저.아이디='kprngproxvf'