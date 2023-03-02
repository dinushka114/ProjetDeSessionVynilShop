<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="../includes/admin-header.jsp" />
        <title>Admin</title>

        <style>
            .form-label{
                font-size:16px;
                font-weight: 400;
            }
        </style>

    </head>

    <sql:setDataSource var="myData" driver="com.mysql.cj.jdbc.Driver"
                       url="jdbc:mysql://localhost:3306/monshopvynilvault?zeroDateTimeBehavior=CONVERT_TO_NULL" user="root"
                       password="123" />



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
                        <h1 class="mt-4">Products</h1>
                        <ol class="breadcrumb mb-4">
                            <a href="NavigationController?to=adminAddNewProduct" class="btn btn-outline-success">Add new</a>
                        </ol>

                        <form action="AdminController" method="POST" enctype="multipart/form-data">
                            <h3>
                                <c:if test="${param.id != null}">
                                    Update Product

                                    <sql:query var="product" dataSource="${myData}">
                                        SELECT * FROM products where id=${param.id};
                                    </sql:query>

                                </c:if>
                                <c:if test="${param.id == null}">
                                    Add Product

                                    <div class="mb-3">
                                        <label for="exampleInputEmail1" class="form-label">Name</label>
                                        <input type="text" class="form-control" id="name" aria-describedby="emailHelp" name="name" >
                                    </div>

                                    <div class="mb-3">
                                        <label for="exampleInputEmail1" class="form-label">Artist</label>
                                        <input type="text" class="form-control" id="name" aria-describedby="emailHelp" name="artist">
                                    </div>

                                    <div class="mb-3">
                                        <label for="exampleInputEmail1" class="form-label">Price</label>
                                        <input type="text" class="form-control" id="name" aria-describedby="emailHelp" name="price" >
                                    </div>

                                    <div class="mb-3">
                                        <label for="exampleInputEmail1" class="form-label">Image</label>
                                        <input type="file" class="form-control" id="name" aria-describedby="emailHelp" name="image" >
                                    </div>

                                    <div class="mb-3">
                                        <label for="exampleInputEmail1" class="form-label">Genre</label>
                                        <input type="text" class="form-control" id="name" aria-describedby="emailHelp" name="genre" >
                                    </div>

                                    <div class="mb-3">
                                        <label for="exampleInputEmail1" class="form-label">Description</label>
                                        <!--                                <input type="text" class="form-control" id="name" aria-describedby="emailHelp" name="description">-->
                                        <textarea name="description" class="form-control"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="exampleInputEmail1" class="form-label">Year</label>
                                        <input type="text" class="form-control" id="name" aria-describedby="emailHelp" name="year">
                                    </div>

                                    <input type="submit" class="btn btn-primary" name="action" value="Add Product" />

                                </c:if>
                            </h3>

                            <c:if test="${emptyData != null}">
                                <div class="alert alert-danger mt-2 alert-dismissible" role="alert">
                                    <c:out value='${emptyData}' />
                                </div>
                            </c:if>


                            <c:if test="${productAddedError != null}">
                                <div class="alert alert-danger mt-2 alert-dismissible" role="alert">
                                    <c:out value='${productAddedError}' />
                                </div>
                            </c:if>
                            
                            <c:if test="${productUpdatedError != null}">
                                <div class="alert alert-danger mt-2 alert-dismissible" role="alert">
                                    <c:out value='${productUpdatedError}' />
                                </div>
                            </c:if>


                            <c:forEach var="val" items="${product.rows}">

                                <div class="mb-3">
                                    <label for="exampleInputEmail1" class="form-label">Name</label>
                                    <input type="hidden" name="id" value="<c:out value="${val.id}" />" />
                                    <input type="text" class="form-control" id="name" aria-describedby="emailHelp" name="name" value="<c:out value="${val.name}" />">
                                </div>

                                <div class="mb-3">
                                    <label for="exampleInputEmail1" class="form-label">Artist</label>
                                    <input type="text" class="form-control" id="name" aria-describedby="emailHelp" name="artist" value="<c:out value="${val.artist}" />">
                                </div>

                                <div class="mb-3">
                                    <label for="exampleInputEmail1" class="form-label">Price</label>
                                    <input type="text" class="form-control" id="name" aria-describedby="emailHelp" name="price" value="<c:out value="${val.price}" />">
                                </div>

                                <div class="mb-3">
                                    <label for="exampleInputEmail1" class="form-label">Image</label>
                                    <input type="file" required="" class="form-control" id="name" aria-describedby="emailHelp" name="image" value="<c:out value="${val.image}" />">
                                </div>

                                <div class="mb-3">
                                    <label for="exampleInputEmail1" class="form-label">Genre</label>
                                    <input type="text" class="form-control" id="name" aria-describedby="emailHelp" name="genre" value="<c:out value="${val.genre}" />">
                                </div>

                                <div class="mb-3">
                                    <label for="exampleInputEmail1" class="form-label">Description</label>
                                    <!--                                <input type="text" class="form-control" id="name" aria-describedby="emailHelp" name="description">-->
                                    <textarea name="description" class="form-control"><c:out value="${val.description}" /></textarea>
                                </div>

                                <div class="mb-3">
                                    <label for="exampleInputEmail1" class="form-label">Year</label>
                                    <input type="text" class="form-control" id="name" aria-describedby="emailHelp" name="year" value="<c:out value="${val.year}" />">
                                </div>

                                <input type="submit" class="btn btn-primary" name="action" value="Update Product" />
                            </c:forEach>
                        </form>
                    </div>
                </main>
                <footer class="py-4 bg-light mt-auto">

                </footer>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/static/js/script.js"></script>
    </body>

</html>
