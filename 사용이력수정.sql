update dbo.사용이력
set 주차_종료시간=GETDATE(),납부요금=1001,총_요금=2001
where 주차장번호=500