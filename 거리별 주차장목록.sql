select 주차장.주소, 주차장.종류, 주차장.총_자리_수, 주차장.현재_자리_수,
		주차장.시간당_요금, 주차장.최대이용시간, 주차장.개장시간, 주차장.폐장시간,
		 ( 6371 * acos( cos( radians(0) ) * cos( radians(주차장.x좌표 ) )
          * cos( radians( 주차장.y좌표 ) - radians(0) )
          + sin( radians(0) ) * sin( radians( 주차장.x좌표 ) ) ) ) as distance		  
from 주차장
order by distance;