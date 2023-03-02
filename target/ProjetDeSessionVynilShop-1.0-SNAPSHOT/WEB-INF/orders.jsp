<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>


<!DOCTYPE html>
<html>
    <head>   
        <jsp:include page="../includes/admin-header.jsp" />
        <title>Admin</title>


    </head>

    <sql:setDataSource var="myData" driver="com.mysql.cj.jdbc.Driver"
                       url="jdbc:mysql://localhost:3306/monshopvynilvault" user="root"
                       password="123" />

    <sql:query var="orders" dataSource="${myData}">
        select o.id , o.order_id , p.name , p.price, o.quantity , u.email , o.date   from orders o , products p  , users u where p.id = o.product_id and o.user_id = u.id
    </sql:query>

    <c:if test="${sessionScope.isAdminLoggedIn == null}">
        <c:redirect url="admin-login.jsp" />
    </c:if>

    <body class="sb-nav-fixed">
        
        <jsp:include page="../includes/admin-nav.jsp" />
        

        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <jsp:include page="../includes/admin-sidebar.jsp" />
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Orders</h1>
                      
                        
                        <c:if test="${customerDelete != null}">
                            <div class="alert alert-success mt-2 alert-dismissible" role="alert">
                                <c:out value='${customerDelete}' />
                            </div>
                        </c:if>
                        
                        <c:if test="${customerDeleteError != null}">
                            <div class="alert alert-danger mt-2 alert-dismissible" role="alert">
                                <c:out value='${customerDeleteError}' />
                            </div>
                        </c:if>

                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th> Order ID </th>
                                    <th>Product Name</th>
                                    <th>Quantity</th>
                                    <th>Customer Email</th>
                                    <th>Total Price</th>
                                    <th>Date</th>
                      
                                </tr>
                            </thead>
                            <tbody id="myTable">

                                <c:forEach var="order" items="${orders.rows}">
                                    <tr id='<c:out value="${order.id}" />'>
                                        <td><c:out value="${order.id}" /></td>
                                        <td><c:out value="${order.order_id}" /></td>
                                        <td><c:out value="${order.name}" /></td>
                                        <td><c:out value="${order.quantity}" /></td>
                                        <td><c:out value="${order.email}" /></td>
                                        <td><c:out value="${order.quantity * order.price}" /></td>
                                        <td>${fn:substring(order.date, 0, 10)}</td>
                                    </tr>
                                </c:forEach>

                            </tbody>
                        </table>

                    </div>
                </main>
                <footer class="py-4 bg-light mt-auto">

                </footer>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/static/js/admin.js"></script>
      
    </body>

</html>
