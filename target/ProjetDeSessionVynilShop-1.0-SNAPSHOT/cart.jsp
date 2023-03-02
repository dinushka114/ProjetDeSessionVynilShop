
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

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
        <title>Vynil Shop - cart</title>
    </head>
    <body>
        <jsp:include page="includes/user-nav.jsp" />
        <div class="container">


            <h2 class="mt-4 mb-4">Shopping Cart</h2>

            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Item Id</th>
                        <th>Image</th>
                        <th>Item Name</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Remove</th>

                    </tr>
                </thead>

                <tbody id='tbody'>

                </tbody>




            </table>

            <c:choose>
                <c:when test="${sessionScope.userId != null}">
                    <form action="CustomerController" method="POST" id="buyNowForm">
                        <input class="btn btn-outline-success" type="submit" value="Buy now" name="action" />
                    </form>
                </c:when>
                <c:when test="${sessionScope.userId == null}">
                    <form action="CustomerController" method="POST">
                        <input disabled class="btn btn-outline-success" type="submit" value="Buy now" name="action" />
                    </form>
                    <p>You need to <a href="customer-login.jsp">login</a> to the system to buy product</p>
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
                        <td>
                                <img class='img-fluid' width='150px' src=data:image/jpeg;base64,\${cartData[item].image} />
                        </td>
                        <td>\${cartData[item].title}</td>
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
