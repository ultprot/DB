select 리뷰.리뷰_번호 as 리뷰번호, 리뷰.평점, 리뷰.내용
from 리뷰 join 주차장 on 리뷰.주차장_번호 = 주차장.주차장_번호
where 주차장.주차장_번호=21