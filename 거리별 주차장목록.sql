select ������.�ּ�, ������.����, ������.��_�ڸ�_��, ������.����_�ڸ�_��,
		������.�ð���_���, ������.�ִ��̿�ð�, ������.����ð�, ������.����ð�,
		 ( 6371 * acos( cos( radians(0) ) * cos( radians(������.x��ǥ ) )
          * cos( radians( ������.y��ǥ ) - radians(0) )
          + sin( radians(0) ) * sin( radians( ������.x��ǥ ) ) ) ) as distance		  
from ������
order by distance;