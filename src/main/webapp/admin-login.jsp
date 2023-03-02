
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix= "fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setLocale value="${sessionScope.language}" />
<fmt:setBundle basename="ApplicationResource" />

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/header.jsp" />
        <title>Admin Login</title>
    </head>
    <body>
        <jsp:include page="includes/user-nav.jsp" />
        <div class="container">

            <div class="ol-xl-5 col-lg-6 col-md-8 col-sm-10 mx-auto mt-lg-5">
                <h1>Admin login</h1>

                <c:if test="${emptyData != null}">
                    <div class="alert alert-danger mt-2 alert-dismissible" role="alert">
                        <c:out value='${emptyData}' />
                        <button type="button" class="btn-close" data-bs-dismiss="alert"
                                aria-label="Close"></button>
                    </div>
                </c:if>

                <c:if test="${loginError != null}">
                    <div class="alert alert-danger mt-2 alert-dismissible" role="alert">
                        <c:out value='${loginError}' />
                        <button type="button" class="btn-close" data-bs-dismiss="alert"
                                aria-label="Close"></button>
                    </div>
                </c:if>

                <form action="AdminController" method="POST">

                    <div class="mb-3">
                        <label for="name" class="form-label">Username</label> <input
                            type="text" class="form-control" id="nameInput" name='username'
                            required />
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label> <input
                            type='password' class="form-control" id="passwordInput"
                            name='password' required />
                    </div>

                    <div class='mb-3'>
                        <input type='submit' class='btn btn-primary w-100' name='action'
                               value='Login'>
                    </div>
                </form>

            </div>
        </div>

    </div>

    <jsp:include page="includes/footer.jsp" />
</body>
</html>
