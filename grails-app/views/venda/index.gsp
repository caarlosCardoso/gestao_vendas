<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'venda.label', default: 'Venda')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>

        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css" type="text/css" />
    </head>
    <body>
        <a href="#list-venda" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="list-venda" class="content" role="main">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <div class="m-4">
                 <table id="table-venda">
                     <thead>
                          <tr>
                             <th>
                                 Editar Venda
                             </th>
                            <th>
                                <g:message code="cliente.label" default="nome" />
                            </th>
                            <th>
                                <g:message code="venda.quantidadeItens.label" default="id" />
                            </th>
                            <th>
                                <g:message code="venda.valorTotal.label" default="id" />
                            </th>
                      </tr>
                    </thead>
               </table>
            </div>
        </div>

        <content tag="jsEspecifico">
            <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
            <script>
                $('#table-venda').DataTable( {
                    "processing": true,
                    "serverSide": true,
                    "ajax": "${createLink(controller:"venda", action:"listVenda")}",
                    "columns": [
                        {
                            "orderable": false,
                            "data": null,
                            "className": "text-center",
                            "render": function (data, type, full, meta) { return '<a class="btn btn-outline-primary" href="${createLink(controller:'venda', action:'edit')}/'+ data.id +'" >Editar</a>'; }
                        },
                        {
                            "data": "nome",
                            "className": "text-center"                         
                        },
                        {   
                            "orderable": false,
                            "className": "text-center",
                            "data": "totalItens"
                        },
                        {
                            "data": "valorTotal",
                            "className": "text-center"
                        },
                    ],
                    "language": {
                        "url": "${assetPath(src: 'portuguese-brasil-datatable.json')}"
                    }
                } );
            </script>
	    </content>
    </body>
</html>