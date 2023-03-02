
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>


<%@ taglib prefix= "fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setLocale value="${sessionScope.language}" />
<fmt:setBundle basename="ApplicationResource" />

<sql:setDataSource var="myData" driver="com.mysql.cj.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/monshopvynilvault" user="root"
                   password="123" />

<sql:query var="orders" dataSource="${myData}">
    select o.id, o.order_id, p.name , p.image , o.quantity , p.price , o.`date`  from orders o , products p where user_id = ${sessionScope.userIdNo} and  o.product_id = p.id ;
</sql:query>

<!DOCTYPE html>
<html>
    <head>

        <jsp:include page="../includes/header.jsp" />
        <title><fmt:message key="orders.allOrders" /></title>
    </head>
    <body>
        <jsp:include page="../includes/user-nav.jsp" />
        <div class="container">

            <h3 class="mt-4 mb-4"><fmt:message key="orders.allOrders" /></h3>

            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th><fmt:message key="orders.orderId" /> </th>
                        <th><fmt:message key="orders.name" /> </th>
                        <th><fmt:message key="orders.quantity" /></th>
                        <th><fmt:message key="orders.price" /></th>
                        <th><fmt:message key="orders.date" /></th>
                        
                    </tr>
                </thead>
                <tbody id="myTable">
                    <c:forEach var="order" items="${orders.rows}">
                        <tr id='<c:out value="${order.id}" />'>
                            <td><c:out value="${order.order_id}" /></td>
                            <td><c:out value="${order.name}" />
                            <img class='img-fluid' width='150px' src="data:image/jpeg;base64,${order.image}" alt="alt"/>
                            
                            </td>
                         
                            <td><c:out value="${order.quantity}" /></td>
                            <td><c:out value="${order.price}" /></td>
                            <td>${fn:substring(order.date, 0, 10)}</td>


                        </tr>
                    </c:forEach>

                </tbody>
            </table>

        </div>

    </div>

    <jsp:include page="../includes/footer.jsp" />
</body>
</html>
