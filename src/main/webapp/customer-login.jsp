
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix= "fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setLocale value="${sessionScope.language}" />
<fmt:setBundle basename="ApplicationResource" />

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/header.jsp" />
        <title><fmt:message key="login.title" /><</title>
    </head>
    <body>
        <jsp:include page="includes/user-nav.jsp" />
        <div class="container">

            <div class="ol-xl-5 col-lg-6 col-md-8 col-sm-10 mx-auto mt-lg-5">
                <h1><fmt:message key="login.userLogin" /></h1>

                <c:if test="${emptyData != null}">
                    <div class="alert alert-danger mt-2 alert-dismissible" role="alert">
                        <c:out value='${emptyData}' />

                    </div>
                </c:if>

                <c:if test="${loginError != null}">
                    <div class="alert alert-danger mt-2 alert-dismissible" role="alert">
                        <c:out value='${loginError}' />

                    </div>
                </c:if>

                <form action="CustomerController" method="POST">

                    <div class="mb-3">
                        <label for="name" class="form-label"><fmt:message key="login.emailAddress" /></label> <input
                            type="text" class="form-control" id="nameInput" name='email'
                            required />
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label"><fmt:message key="login.password" /></label> <input
                            type='password' class="form-control" id="passwordInput"
                            name='password' required />
                    </div>

                    <div class='mb-3'>
                   
                        
                        <button type="submit" name="action" class='btn btn-primary w-100 mb-3' value="Login"><fmt:message key="login.login" /></button>

                        <a href="customer-register.jsp"><fmt:message key="login.createAnAccount" /></a>

                    </div>
                </form>

            </div>
        </div>

    </div>



    <jsp:include page="includes/footer.jsp" />
</body>
</html>
