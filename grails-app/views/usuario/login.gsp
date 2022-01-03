<!doctype html>
<html>
<head>
    <meta name="layout" content="main" />
    <title>Login</title>
</head>
<body >
    <div id="content" role="main" >
        <br>
        <g:if test="${session.user==null}">
            <div class="container">
            <section class="row">
                <div class="col-sm-3"></div>
                <div class="col-sm-6">
                <g:form id="formLogin" class="formLogin border border-dark rounded  " method="POST">
                        <fieldset class="form">
                                <div class="row">
                                    <div class="col text-center">
                                        <h3>Acessar Sistema</h3>
                                        <br>
                                    </div>
                                </div>
                                <div  class="row">
                                    <div class="col">
                                        <label for="usuario">
                                            <g:message code="usuario.usuario.label" default="usuario" />
                                            <span class="required-indicator">*</span>
                                        </label>
                                        <g:field name="usuario" id="usuario" style="width: 100%;"/>
                                    </div>
                                </div>
                                <div  class="row">
                                    <div class="col">
                                        <label for="senha">
                                            <g:message code="usuario.senha.label" default="senha" />
                                            <span class="required-indicator">*</span>
                                        </label>
                                        <g:field name="senha" type="password" style="width: 100%;" />
                                        <br>
                                        <br>
                                    </div>
                                </div>               
                                <div  class="row">
                                    <div class="col">
                                        <g:actionSubmit style="width: 100%;" action="authLogin" value="${message(code: 'default.button.acessar.label', default: 'Acessar')}" class="btn btn-outline-primary btn-lg" />
                                    </div>
                                </div> 
                                <div  class="row">
                                    <g:if test="${flash.message}">
                                        <div class="message" role="alert">${flash.message}</div>
                                    </g:if>       
                                </div>            
                        </fieldset>
                </g:form>
                </div>
                <div class="col-sm-3"></div>  
            </section>
            </div>
        </g:if>
        <g:else>
            <div class="container ">
                <section>
                    <div class="row">
                        <div class="col-sm-4"></div>
                        <div class="col-sm-4">
                            <h1>usuário logado: ${session.user} </h1>
                        </div>
                        <div class="col-sm-4"></div>
                    </div>
                    <div class="row">
                        <div class="col-sm-4"></div>
                        <div class="col-sm-4">
                            <h1><a href="../venda/index" class="btn btn-outline-primary btn-lg" >Acessar Sistema </a></h1> 
                        </div>
                        <div class="col-sm-4"></div>
                    </div>
                </section>
            </div>
        </g:else>
    </div>
</body>
</html>
