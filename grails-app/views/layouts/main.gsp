<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
        <g:layoutTitle default="Grails"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>

    <asset:stylesheet src="bootstrap.css"/>
    <asset:stylesheet src="grails.css"/>
    <asset:stylesheet src="main.css"/>
    <asset:stylesheet src="mobile.css"/>

    <asset:stylesheet src="application.css"/>

    <style>
        .bloqueio-div{
            background-color: gray;
            opacity: 0.1;
        }
    </style>

    <g:layoutHead/>
</head>

<body>
    <nav class="navbar navbar-expand-lg navbar-dark navbar-static-top" role="navigation">
            <a class="navbar-brand" href="/#"><asset:image src="grails.svg" alt="Grails Logo"/></a>
            <h1 style="color: white;">Mercadinho do Carlão</h1>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarContent" aria-controls="navbarContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <g:if test="${session.user!=null}">
            <div id="divNav" class="collapse navbar-collapse" aria-expanded="false" style="height: 0.8px;" id="navbarContent">
                <ul class="nav navbar-nav ml-auto">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle btn-outline-primary" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Gerenciar Mercado <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <g:each var="c" in="${grailsApplication.controllerClasses.sort { it.fullName } }">
                                <li class="dropdown-item">
                                    <g:link controller="${c.logicalPropertyName}"><g:message code="menu.label" default="opcao menu" args="[message(code:(c.name.uncapitalize()+".label"), default:'domain')]" /></g:link>
                                </li>
                            </g:each>
                        </ul>
                    </li>
                </ul>
                <a  class="nav navbar-nav" role="button"  ><g:link onclick="return confirm('${message(code: 'default.button.sair.confirm.message', default: 'Are you sure?')}');" controller="usuario" action="authLogout">Sair<span class="caret"></span></g:link></a>
            </div>
            </g:if>

        </nav>

<g:layoutBody/>

<div class="footer " role="contentinfo">
    
</div>




<div id="spinner" class="spinner" style="display:none;">
    <g:message code="spinner.alt" default="Loading&hellip;"/>
</div>

<asset:javascript src="jquery-3.3.1.min.js"/>
<asset:javascript src="bootstrap.js"/>
<asset:javascript src="popper.min"/>

<asset:javascript src="application.js"/>
<asset:javascript src="ajaxPost.js"/>
<asset:javascript src="formatacao.js"/>
 <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
<g:ifPageProperty name="page.jsEspecifico">
        <g:pageProperty name="page.jsEspecifico"/>
</g:ifPageProperty>

</body>
</html>
