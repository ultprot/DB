<!--#include virtual="./header.asp"-->
<%
  Set Dbcon=Server.CreateObject("ADODB.Connection")
  Dbcon.Open Application("dbConnect")

  sql="select 차량.* "_
  & "from 차량 join 차량소유 on 차량.차량번호=차량소유.차량번호 " _
  & "join 사용자 on 차량소유.사용자_고유번호=사용자.사용자_고유번호 " _
  & "join 유저 on 사용자.사용자_고유번호=유저.고유번호 "_
  & "where 유저.아이디='" & session("userID") & "';"
  Set Rs=Dbcon.Execute(sql)

%>
<div id="content-wrapper">

    <div class="container-fluid">

      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          주차장 검색
        </li>
      </ol>

      <div class="container">
        <div class="card mx-auto mt-10">
          <div class="card-header">검색 조건 입력</div>
          <div class="card-body">
            <form action="searchResult.asp" type="post">
              <div class="form-group">
                <div class="form-row">
                  <div class="col-md-6">
                    <div class="form-label-group">
                      <input type="text" name="xpos" id="xpos" class="form-control" placeholder="X 좌표" required="required" autofocus="autofocus">
                      <label for="xpos">X 좌표</label>
                    </div>
                  </div>
                  <div class="col-md-6">
                    <div class="form-label-group">
                      <input type="text" name="ypos" id="ypos" class="form-control" placeholder="Y 좌표" required="required">
                      <label for="ypos">Y 좌표</label>
                    </div>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label for="rateLimit">평점 하한선</label>
                  <select name="rateLimit" class="form-control" id="rateLimit">
                    <option>0</option>
                    <option>1</option>
                    <option>2</option>
                    <option>3</option>
                    <option>4</option>
                  </select>
              </div>
              <div class="form-group">
                <div class="form-row">
                  <div class="col-md-6">
                    <label for="parkType">주차장 종류</label>
                    <select name="parkType" class="form-control" id="parkType">
                      <option>공영</option>
                      <option>사설</option>
                    </select>
                  </div>
                  <%
                  if not Rs.BOF then
                    response.write("<div class=""col-md-6""><label for=""carNumber"">주차할 차량</label><select name=""carNumber"" class=""form-control"" id=""carNumber"">")
                    do while not(Rs.EOF)
                      response.write("<option>")
                      response.write(Rs("차량번호"))
                      response.write("</option>")
                      Rs.movenext
                    Loop
                    response.write("</select></div>")
                  end if
                  %>
                </div>
              </div>
              <button type="submit" class="btn btn-secondary btn-block">검색</button>
            </form>
          </div>
        </div>
      </div>

    </div>
</div>
<!-- /.container-fluid -->
</div>
<%
  Dbcon.Close()
  Set Dbcon=Nothing
  Set Rs=Nothing
%>
<!-- /.content-wrapper -->
<!--#include virtual="./footer.asp"-->





<%
'if Rs.BOF then
'        Dbcon.Close()
'        Set Dbcon=Nothing
'        Set Rs=Nothing
'        dir="register.asp?inputID=" & inputID
'        response.redirect(dir)
'    else
'        Dbcon.Close()
'        Set Dbcon=Nothing
'        Set Rs=Nothing
'        response.write("이미 존재 하는 아이디입니다.")
'    end if
    %>