select 备没.备_疙莫,max(包府扁废.包府老磊) as  弥辟包府老磊,林瞒厘.林瞒厘_锅龋,林瞒厘.备没_包府林扁,
DATEADD(day,林瞒厘.备没_包府林扁,max(包府扁废.包府老磊)) as 促澜包府老磊
from 备没 join 包府扁废 on 备没.备没_绊蜡锅龋=包府扁废.备没_绊蜡锅龋
join 林瞒厘 on 包府扁废.林瞒厘_锅龋=林瞒厘.林瞒厘_锅龋
group by 备没.备_疙莫,林瞒厘.林瞒厘_锅龋,林瞒厘.备没_包府林扁
order by 备没.备_疙莫