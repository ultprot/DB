<!--#include virtual="./header.asp"-->
<%
  Set Dbcon=Server.CreateObject("ADODB.Connection")
  Dbcon.Open Application("dbConnect")
  
  Dim userID


  sql="select distinct 유저.아이디 ,총사용시간, "_
  & "case when 총사용시간 >= 40 then '우수회원' "_
  & " "_
  & " "_
  & " "_
  & " "_
  & " "_
  & " "_
  & " "_
  & " "_
  & " "_
  & " "_

  
	
	when 총사용시간 between 10 and 39 then '보통회원'
	when 총사용시간 between 5 and 9 then '소극적회원' else '유령회원' end as '회원등급'
from 사용이력 join (select 사용이력.사용자_고유번호,
sum(datediff(hour,사용이력.주차_시작시간,사용이력.주차종료시간)) as 총사용시간
from 사용이력 group by 사용이력.사용자_고유번호) as 합계 
on 사용이력.사용자_고유번호=합계.사용자_고유번호
join 사용자 on 사용이력.사용자_고유번호=사용자.사용자_고유번호
join 유저 on 유저.고유번호=사용자.사용자_고유번호
where 사용이력.주차종료시간 is not null
order by 총사용시간 DESC;
  Set Rs=Dbcon.Execute(sql)
%>

<div id="content-wrapper">

    <div class="container-fluid">

      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          장기방치자
        </li>
      </ol>

      <div class="container">
        <h2>장기방치자 목록</h2>
        <table class="table table-bordered">
          <thead>
            <tr>
              <th>사용자 고유번호</th>
              <th>아이디</th>
              <th>주차 시작시간</th>
              <th>총 주차기간</th>
			  <th>장기방치여부</th>
            </tr>
          </thead>
          <tbody>
            <%
                            do while not(Rs.EOF)
                                response.write("<tr>")
                                response.write("<td>")
                                response.write(Rs("사용자_고유번호"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("아이디"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("주차_시작시간"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("총주차기간"))
                                response.write("</td>")
								response.write("<td>")
                                response.write(Rs("장기방치여부"))
                                response.write("</td>")
                                response.write("</tr>")
                                Rs.movenext
                            Loop
                            %>
          </tbody>
        </table>
        
        
      </div>
    <div class="d-flex justify-content-around">
    

    </div>
    </div>
    <!-- /.container-fluid -->
    <!-- The Modal -->
    
</div>
<%
  Dbcon.Close()
  Set Dbcon=Nothing
  Set Rs=Nothing
%>
<!-- /.content-wrapper -->
<!--#include virtual="./footer.asp"-->
