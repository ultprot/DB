select ������.�ּ�, ������.����, 
		������.�ð�����, ������.�ִ��̿�ð�,���ڸ���,�����ڸ���, ������.����ð�, ������.����ð�,
		 ( 6371 * acos( cos( radians(0) ) * cos( radians(������.x��ǥ ) )
          * cos( radians( ������.y��ǥ ) - radians(0) )
          + sin( radians(0) ) * sin( radians( ������.x��ǥ ) ) ) ) as distance, ����������

from ������ join (select ������.������_��ȣ,count(*) as ���ڸ���,
count(case when �ڸ�.����_��뿩�� = 0 then 1 end) as �����ڸ���,
AVG(convert(float,����.����)) as ����������
from ������ join ���� on ������.������_��ȣ=����.������_��ȣ
join �ڸ� on ������.������_��ȣ=�ڸ�.������_��ȣ
group by ������.������_��ȣ) as ������� on ������.������_��ȣ=�������.������_��ȣ
where ����������>0
ORDER BY distance;