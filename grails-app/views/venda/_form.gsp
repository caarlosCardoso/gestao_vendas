<div class="row">
    <div class="col-12">
        <label for="nome">
            <g:message code="cliente.label" default="nome" />
        </label>
        <g:select id="cliente" name="cliente.id" from="${gestao_vendas.Cliente.list()}" value="${venda.cliente?.id}" optionKey="id" optionValue="nome" />
    </div>
</div>
<br>
<hr>
<br>
<div class="row">
    <div class="col-12">
        <label for="nome">
            <g:message code="adicionar.produto.label" default="Adicionar Produto" />
        </label>
        <button type="button" class="btn btn-outline-primary" id="novaLinha" name="novaLinha" onclick="ajaxPost(this,'${createLink(controller:'venda', action:'inserirTabela')}','divTabela', true, 1)" class="btnAdicionar">+</button>
    </div>
</div>
<div class="row">
    <div class="col-12" id="divTabela">
         <g:render template="tabelaVenda"/>
    </div>
</div>
