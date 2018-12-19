<!--#include virtual="./header.asp"-->
<%
  Set Dbcon=Server.CreateObject("ADODB.Connection")
  Dbcon.Open Application("dbConnect")
  
  Dim userID

  userID=session.contents("userID")
  Dim userX
  Dim userY
  Dim userCarType
  Dim rateLimit
  Dim parkType

  Dim carType

  Dim sql

  userX=request.querystring("xpos")
  userY=request.querystring("ypos")
  userCarNumber=request.querystring("carNumber")
  rateLimit=request.querystring("rateLimit")
  parkType=request.querystring("parkType")

  if parkType="공영" then
    parkType=0
  elseif parkType="사설" then
    parkType=1
  end if

  if not isempty(userCarNumber) then
    sqlCartype="select * from 차량 where 차량번호="_
    & userCarNumber & ";"
    Set Rs=Dbcon.Execute(sqlCartype)
  end if

  sqlSmall="select 주차장.주차장_번호, 주차장.주소, 주차장.종류, "_
  & "주차장.시간당요금, 주차장.최대이용시간,총자리수,현재자리수, 주차장.개장시간, 주차장.폐장시간, "_
  & "( (" & xpos & "-주차장.x좌표)*(" & xpos & "-주차장.x좌표)+(" & ypos & "-주차장.y좌표)*(" & ypos _
  & "-주차장.y좌표)) as distance, 주차장평점 "_
  & "from 주차장 join (select 주차장.주차장_번호,count(*) as 총자리수, "_
  & "count(case when 자리.현재_사용여부 = 0 then 1 end) as 현재자리수, "_
  & "AVG(convert(float,리뷰.평점)) as 주차장평점 ,"_
  & "count(case when 자리.현재_사용여부 = 0 and 자리.수용차종=0 then 1 end) as 소형빈자리수 "_
  & "from 주차장 join 리뷰 on 주차장.주차장_번호=리뷰.주차장_번호 "_
  & "join 자리 on 주차장.주차장_번호=자리.주차장_번호 "_
  & "group by 주차장.주차장_번호) as 평균평점 on 주차장.주차장_번호=평균평점.주차장_번호 "_
  & "where 주차장평점>="& rateLimit & " and 현재자리수>0 and 소형빈자리수>0 and 주차장.종류=" & parkType _
  & "ORDER BY distance;"

  sqlMideum="select 주차장.주차장_번호, 주차장.주소, 주차장.종류, "_
  & "주차장.시간당요금, 주차장.최대이용시간,총자리수,현재자리수, 주차장.개장시간, 주차장.폐장시간, "_
  & "( (" & xpos & "-주차장.x좌표)*(" & xpos & "-주차장.x좌표)+(" & ypos & "-주차장.y좌표)*(" & ypos _
  & "-주차장.y좌표)) as distance, 주차장평점 "_
  & "from 주차장 join (select 주차장.주차장_번호,count(*) as 총자리수, "_
  & "count(case when 자리.현재_사용여부 = 0 then 1 end) as 현재자리수, "_
  & "AVG(convert(float,리뷰.평점)) as 주차장평점 ,"_
  & "count(case when 자리.현재_사용여부 = 0 and 자리.수용차종=1 then 1 end) 중형빈자리수 "_
  & "from 주차장 join 리뷰 on 주차장.주차장_번호=리뷰.주차장_번호 "_
  & "join 자리 on 주차장.주차장_번호=자리.주차장_번호 "_
  & "group by 주차장.주차장_번호) as 평균평점 on 주차장.주차장_번호=평균평점.주차장_번호 "_
  & "where 주차장평점>="& rateLimit & " and 현재자리수>0 and 중형빈자리수>0 and 주차장.종류=" & parkType _
  & " ORDER BY distance;"

  sqlLarge="select 주차장.주차장_번호, 주차장.주소, 주차장.종류, "_
  & "주차장.시간당요금, 주차장.최대이용시간,총자리수,현재자리수, 주차장.개장시간, 주차장.폐장시간, "_
  & "( (" & xpos & "-주차장.x좌표)*(" & xpos & "-주차장.x좌표)+(" & ypos & "-주차장.y좌표)*(" & ypos _
  & "-주차장.y좌표)) as distance, 주차장평점 "_
  & "from 주차장 join (select 주차장.주차장_번호,count(*) as 총자리수, "_
  & "count(case when 자리.현재_사용여부 = 0 then 1 end) as 현재자리수, "_
  & "AVG(convert(float,리뷰.평점)) as 주차장평점 ,"_
  & "count(case when 자리.현재_사용여부 = 0 and 자리.수용차종=2 then 1 end) as 대형빈자리수 "_
  & "from 주차장 join 리뷰 on 주차장.주차장_번호=리뷰.주차장_번호 "_
  & "join 자리 on 주차장.주차장_번호=자리.주차장_번호 "_
  & "group by 주차장.주차장_번호) as 평균평점 on 주차장.주차장_번호=평균평점.주차장_번호 "_
  & "where 주차장평점>="& rateLimit & " and 현재자리수>0 and 대형빈자리수>0 and 주차장.종류=" & parkType _
  & " ORDER BY distance;"

  sqlNone="select 주차장.주차장_번호, 주차장.주소, 주차장.종류, "_
  & "주차장.시간당요금, 주차장.최대이용시간,총자리수,현재자리수, 주차장.개장시간, 주차장.폐장시간, "_
  & "( (" & xpos & "-주차장.x좌표)*(" & xpos & "-주차장.x좌표)+(" & ypos & "-주차장.y좌표)*(" & ypos & "-주차장.y좌표)) as distance, 주차장평점 "_
  & "from 주차장 join (select 주차장.주차장_번호,count(*) as 총자리수, "_
  & "count(case when 자리.현재_사용여부 = 0 then 1 end) as 현재자리수, "_
  & "AVG(convert(float,리뷰.평점)) as 주차장평점 "_
  & "from 주차장 join 리뷰 on 주차장.주차장_번호=리뷰.주차장_번호 "_
  & "join 자리 on 주차장.주차장_번호=자리.주차장_번호 "_
  & "group by 주차장.주차장_번호) as 평균평점 on 주차장.주차장_번호=평균평점.주차장_번호 "_
  & "where 주차장평점>="& rateLimit & "and 주차장.종류=" & parkType _
  & "ORDER BY distance; "

  if not isempty(userCarNumber) then
    if Rs("차종")=0 then 
        sql=sqlSmall
    elseif Rs("차종")=1 then
        sql=sqlMideum
    elseif Rs("차종")=2 then
        sql=sqlLarge
    end if
  else
    sql=sqlNone
  end if
  
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
        <div class="card mb-3">
            <div class="card-header">
                <i class="fas fa-table"></i>
                검색된 주차장
            </div>
            <div class="card-body">
                <div class="table-responsive"> 
                    <table class="table table-bordered" id="dataTable">
                        <thead>
                            <tr>
                                <th>주차장 번호</th>
                                <th>거리</th>
                                <th>주소</th>
                                <th>종류</th>
                                <th>최대 이용 시간</th>
                                <th>총 자리수</th>
                                <th>현재 자리 수</th>
                                <th>개장시간</th>
                                <th>폐장시간</th>
                                <th>리뷰</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            do while not(Rs.EOF)
                                response.write("<tr>")
                                response.write("<td>")
                                response.write(Rs("주차장_번호"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("distance"))
                                response.write("미터")
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("주소"))
                                response.write("</td>")
                                response.write("<td>")
                                if Rs("종류")=0 then
                                    response.write("공영")
                                elseif Rs("종류")=1 then
                                    response.write("사설")
                                end if
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("최대이용시간"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("총자리수"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("현재자리수"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("개장시간"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("폐장시간"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write("<a href=""parkReview.asp?parkNumber=")
                                response.write(Rs("주차장_번호"))
                                response.write(""" class=""btn btn-secondary"">리뷰</a>")
                                response.write("</td>")
                                response.write("</tr>")
                                Rs.movenext
                            Loop
                            %>
                        </tbody>
                    </table>
                </div>
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
