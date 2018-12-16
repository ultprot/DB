select *
from 관리기록 join 구청 on 관리기록.구청_고유번호 = 구청.구청_고유번호
join 주차장 on 관리기록.주차장번호 = 주차장.주차장번호
where 구청.구_명칭='gpxfh'