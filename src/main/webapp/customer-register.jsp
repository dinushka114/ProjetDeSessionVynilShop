
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix= "fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setLocale value="${sessionScope.language}" />
<fmt:setBundle basename="ApplicationResource" />

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/header.jsp" />
        <title>Customer Register</title>

    </head>
    <body>
        <jsp:include page="includes/user-nav.jsp" />
        <div class="container">

            <div class="ol-xl-5 col-lg-6 col-md-8 col-sm-10 mx-auto mt-lg-5 content">
                <h1><fmt:message key="newAccount.createAccount" /></h1>

                <c:if test="${emptyData != null}">
                    <div class="alert alert-danger mt-2 alert-dismissible" role="alert">
                        <c:out value='${emptyData}' />

                    </div>
                </c:if>

                <c:if test="${emailError != null}">
                    <div class="alert alert-danger mt-2 alert-dismissible" role="alert">
                        <c:out value='${emailError}' />

                    </div>
                </c:if>


                <c:if test="${passwordError != null}">
                    <div class="alert alert-danger mt-2 alert-dismissible" role="alert">
                        <c:out value='${passwordError}' />

                    </div>
                </c:if>
                
                <c:if test="${registerDone != null}">
                    <div class="alert alert-success mt-2 alert-dismissible" role="alert">
                        <c:out value='${registerDone}' />

                    </div>
                </c:if>
                
                <c:if test="${registerFail != null}">
                    <div class="alert alert-danger mt-2 alert-dismissible" role="alert">
                        <c:out value='${registerFail}' />

                    </div>
                </c:if>



                <form action="CustomerController" method="POST">

                    <div class="mb-3">
                        <label for="name" class="form-label"><fmt:message key="newAccount.name" /></label> <input
                            type="text" class="form-control" id="nameInput" name='name'
                            />
                    </div>

                    <div class="mb-3">
                        <label for="name" class="form-label"><fmt:message key="newAccount.email" /></label> <input
                            type="email" class="form-control" id="nameInput" name='email'
                            />
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label"><fmt:message key="newAccount.psw" /></label> <input
                            type='password' class="form-control" id="passwordInput"
                            name='password' />
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label"><fmt:message key="newAccount.confirmPsw" /></label> <input
                            type='password' class="form-control" id="passwordInput"
                            name='cpassword' />
                    </div>

                    <div class='mb-3'>
                        <button type='submit' class='btn btn-primary w-100 mb-3' name='action'
                               value='Register'><fmt:message key="newAccount.createAccount" /></button>
                        <a href="customer-login.jsp"><fmt:message key="login.login" /></a>
                       
                    </div>
                </form>

            </div>
        </div>

    </div>


    <jsp:include page="includes/footer.jsp" />
</body>
</html>
