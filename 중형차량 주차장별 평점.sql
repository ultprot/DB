select 주차장.주소, 주차장.종류, 
		주차장.시간당요금, 주차장.최대이용시간,총자리수,현재자리수, 주차장.개장시간, 주차장.폐장시간,
		( (0-주차장.x좌표)*(0-주차장.x좌표)+(0-주차장.y좌표)*(0-주차장.y좌표)) as distance, 주차장평점
		  
from 주차장 join (select 주차장.주차장_번호,count(*) as 총자리수,
count(case when 자리.현재_사용여부 = 0 then 1 end) as 현재자리수,
AVG(convert(float,리뷰.평점)) as 주차장평점,
count(case when 자리.현재_사용여부 = 0 and 자리.수용차종=1 then 1 end) 중형빈자리수
from 주차장 join 리뷰 on 주차장.주차장_번호=리뷰.주차장_번호
join 자리 on 주차장.주차장_번호=자리.주차장_번호
group by 주차장.주차장_번호) as 평균평점 on 주차장.주차장_번호=평균평점.주차장_번호

where 주차장평점>=0 and 현재자리수>0 and 중형빈자리수>0 and 주차장.종류=1
ORDER BY distance;