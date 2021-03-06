<!--#include virtual="./header.asp"-->
<%
  Set Dbcon=Server.CreateObject("ADODB.Connection")
  Dbcon.Open Application("dbConnect")
  
  Dim userID


  sql="select distinct 유저.아이디 ,총사용시간, "_
  & "case when 총사용시간 >= 40 then '우수회원' "_
  & "when 총사용시간 between 10 and 39 then '보통회원' "_
  & "when 총사용시간 between 5 and 9 then '소극적회원' else '유령회원' end as '회원등급' "_
  & "from 사용이력 join (select 사용이력.사용자_고유번호, "_
  & "sum(datediff(hour,사용이력.주차_시작시간,사용이력.주차종료시간)) as 총사용시간 "_
  & "from 사용이력 group by 사용이력.사용자_고유번호) as 합계 "_
  & "on 사용이력.사용자_고유번호=합계.사용자_고유번호 "_
  & "join 사용자 on 사용이력.사용자_고유번호=사용자.사용자_고유번호 "_
  & "join 유저 on 유저.고유번호=사용자.사용자_고유번호 "_
  & "where 사용이력.주차종료시간 is not null "_
  & "order by 총사용시간 DESC; "

  Set Rs=Dbcon.Execute(sql)
%>

<div id="content-wrapper">

    <div class="container-fluid">

      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          회원 등급
        </li>
      </ol>

      <div class="container">
        <h2>회원 등급 목록</h2>
        <table class="table table-bordered" id="dataTable">
          <thead>
            <tr>
              <th>아이디</th>
              <th>총사용시간</th>
              <th>회원등급</th>
            </tr>
          </thead>
          <tbody>
            <%
                            do while not(Rs.EOF)
                                response.write("<tr>")
                                response.write("<td>")
                                response.write(Rs("아이디"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("총사용시간"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("회원등급"))
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
