select distinct ����.���̵� ,�ѻ��ð�,
	case when �ѻ��ð� >= 40 then '���ȸ��'
	when �ѻ��ð� between 10 and 39 then '����ȸ��'
	when �ѻ��ð� between 5 and 9 then '�ұ���ȸ��' else '����ȸ��' end as 'ȸ�����'
from ����̷� join (select ����̷�.�����_������ȣ,
sum(datediff(hour,����̷�.����_���۽ð�,����̷�.��������ð�)) as �ѻ��ð�
from ����̷� group by ����̷�.�����_������ȣ) as �հ� 
on ����̷�.�����_������ȣ=�հ�.�����_������ȣ
join ����� on ����̷�.�����_������ȣ=�����.�����_������ȣ
join ���� on ����.������ȣ=�����.�����_������ȣ
where ����̷�.��������ð� is not null
order by �ѻ��ð� DESC;


