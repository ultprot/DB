select 주차장.주소, 주차장.종류, 
		주차장.시간당요금, 주차장.최대이용시간,총자리수,현재자리수, 주차장.개장시간, 주차장.폐장시간,
		 ( 6371 * acos( cos( radians(0) ) * cos( radians(주차장.x좌표 ) )
          * cos( radians( 주차장.y좌표 ) - radians(0) )
          + sin( radians(0) ) * sin( radians( 주차장.x좌표 ) ) ) ) as distance, 주차장평점

from 주차장 join (select 주차장.주차장_번호,count(*) as 총자리수,
count(case when 자리.현재_사용여부 = 0 then 1 end) as 현재자리수,
AVG(convert(float,리뷰.평점)) as 주차장평점
from 주차장 join 리뷰 on 주차장.주차장_번호=리뷰.주차장_번호
join 자리 on 주차장.주차장_번호=자리.주차장_번호
group by 주차장.주차장_번호) as 평균평점 on 주차장.주차장_번호=평균평점.주차장_번호
where 주차장평점>0
ORDER BY distance;