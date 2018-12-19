<!--#include virtual="./header.asp"-->
<%
  Set Dbcon=Server.CreateObject("ADODB.Connection")
  Dbcon.Open Application("dbConnect")
  
  Dim userID


  sql="select 사용자.사용자_고유번호,유저.아이디,사용이력.주차_시작시간,총주차기간, "_
  & "case when 총주차기간 >= 5 then '장기방치자'  end as 장기방치여부 "_
  & "from 사용이력 join (select 사용이력.사용자_고유번호, 사용이력.주차_시작시간, "_
  & "datediff(day,사용이력.주차_시작시간,GETDATE()) as 총주차기간 "_
  & "from 사용이력 "_
  & "where 사용이력.주차종료시간 is null "_
  & "group by 사용이력.사용자_고유번호,사용이력.주차_시작시간) as 합계 "_
  & "on 사용이력.사용자_고유번호=합계.사용자_고유번호 and 사용이력.주차_시작시간=합계.주차_시작시간 "_
  & "join 사용자 on 사용이력.사용자_고유번호=사용자.사용자_고유번호 "_
  & "join 유저 on 사용자.사용자_고유번호=유저.고유번호"

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
