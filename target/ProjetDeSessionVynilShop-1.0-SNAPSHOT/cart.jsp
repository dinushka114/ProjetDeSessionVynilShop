
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%@ taglib prefix= "fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setLocale value="${sessionScope.language}" />
<fmt:setBundle basename="ApplicationResource" />

<sql:setDataSource var="myData" driver="com.mysql.cj.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/monshopvynilvault" user="root"
                   password="123" />

<sql:query var="products" dataSource="${myData}">
    SELECT * FROM products;
</sql:query>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/header.jsp" />
        <title><fmt:message key="detailProduct.add" /> </title>
    </head>
    <body>
        <jsp:include page="includes/user-nav.jsp" />
        <div class="container">

            <table class="table table-striped mt-5">
                <thead>
                    <tr>
                        <th>#</th>
                        <th><fmt:message key="orders.name" /> </th>
                        <th><fmt:message key="orders.quantity" /> </th>
                        <th><fmt:message key="cart.price" /> </th>
                        <th><fmt:message key="cart.delete" /></th>

                    </tr>
                </thead>

                <tbody id='tbody'>

                </tbody>




            </table>

            <c:choose>
                <c:when test="${sessionScope.userId != null}">
                    <form action="CustomerController" method="POST" id="buyNowForm">
                        <button class="btn btn-outline-success" type="submit" value="Buy now" name="action"><fmt:message key="cart.buy" /></button>
                    </form>
                </c:when>
                <c:when test="${sessionScope.userId == null}">
                    <form action="CustomerController" method="POST">
                        <input disabled class="btn btn-outline-success" type="submit" value="<fmt:message key="cart.buy" />" name="action" />
                    </form>
                    <a href="customer-login.jsp"><fmt:message key="login.login" /></a>
                </c:when>
            </c:choose>



        </div>

    </div>

    <jsp:include page="includes/footer.jsp" />

    <script>


        function showCart() {
            var cart = localStorage.getItem("cart");


            var html = "";
            var cartData = JSON.parse(cart);


            for (var item in cartData) {

                html += `
                        <tr>
                        <td>\${item}</td>
                    
                        <td>\${cartData[item].title} <img class='img-fluid' width='150px' src=data:image/jpeg;base64,\${cartData[item].image} /> </td>
                        <td> <button class="btn btn-outline-primary" onclick="removeFromCart('\${item}','\${cartData[item].price}','\${cartData[item].title}','\${cartData[item].image}');showCart()" >-</button> <span style="padding:5px">\${cartData[item].qty}</span> <button onclick="addToCart('\${item}','\${cartData[item].price}','\${cartData[item].title}','\${cartData[item].image}');showCart()" class="btn btn-outline-primary">+</button> </td>
                        <td>\${cartData[item].price * cartData[item].qty}</td>
                        <td> <button onclick="remove('\${item}','\${cartData[item].price * cartData[item].qty}' , '\${cartData[item].qty}');showCart();updateCart();" class="btn btn-danger"><i class="fas fa-trash"></i></button> </td>
                </tr>
                `
            }
            document.getElementById('tbody').innerHTML = html;
            
        }



        window.addEventListener("load", (event) => {
            showCart();

        });


        $("#buyNowForm").submit(function (e) {
            e.preventDefault();
            let ids = "";
            let qtys = "";
            const cartData = JSON.parse(localStorage.getItem("cart"));
            if(cartData===null || Object.keys(cartData).length===0){
                alert("Your cart is empty!!");
                return;
                
            }
            
            for (const key in cartData) {
                console.log(cartData[key].title);
                ids+=key+",";
                qtys+=cartData[key].qty+",";
            }
            
            $.ajax({
                url: 'CustomerController?action=Buy now',
                type: 'post',
                data: {
                    ids:ids,
                    qtys:qtys
                },
                success: function (data) {
                    if(data.status==='true'){
                        localStorage.removeItem("cart");
                        localStorage.removeItem("count");
                        localStorage.removeItem("sum");
                        
                        alert("Order placed!!You will be redirected to the home page");
                        
                        window.location.href="index.jsp";
                    }else{
                        alert(data.msg)
                    }
                }
            });
        })



    </script>
</body>
</html>
