
<div class="m-4">
    <table id="table-itensVenda" class="table-itensVenda">
        <thead>
            <tr>
                <th>
                    <g:message code="produto.label" default="Produto" />
                </th>
                <th>
                    <g:message code="vendaItem.valorPadrao.label" default="Valor Padrão" />
                </th>
                <th>
                    <g:message code="vendaItem.quantidade.label" default="Quantidade" />
                </th>
                <th>
                    <g:message code="vendaItem.desconto.label" default="Desconto" />
                </th>
                <th>
                    <g:message code="vendaItem.valorTotalItem.label" default="Total Item" />
                </th>
                <th>
                    Remover Item
                </th>
            </tr>
        </thead>
        <tbody>
            <g:each status="i" var="item" in="${venda.itensVenda}">
                <g:hiddenField name="itensVenda[${i}].id" value="${venda?.itensVenda?.get(i).id}" />
               <tr>
                    <td><g:select name="itensVenda[${i}].produto.id" noSelection = "${['': 'Selecione Produto']}" from="${gestao_vendas.Produto.list()}" value="${item.produto?.id}" optionKey="id" optionValue="nome"  onchange="ajaxPost(this,'${createLink(controller:'venda', action:'atualizarValorPadrao', params: ['indice': i ])}','divValorPadrao${i}', true, 1), ajaxPost(this,'${createLink(controller:'venda', action:'zerarDesconto', params: ['indice': i ])}','divDesconto${i}', true, 1), ajaxPost(this,'${createLink(controller:'venda', action:'umQuantidade', params: ['indice': i ])}','divQuantidade${i}', true, 1), ajaxPost(this,'${createLink(controller:'venda', action:'iniciarValorTotalItem', params: ['indice': i ])}','divValorTotalItem${i}', true, 1)"  /></td>
                    <td>
                        <div id="divValorPadrao${i}">
                            <g:render template="valorPadrao" model= "[item: item, i: i]"/>
                        </div>
                    </td>
                    <td>
                        <div id="divQuantidade${i}">
                            <g:render template="quantidade" model= "[item: item, i: i]"/>
                        </div>
                    </td>
                    <td>
                        <div id="divDesconto${i}">
                            <g:render template="desconto" model= "[item: item, i: i]"/>
                        </div>
                    </td>
                    <td>
                        <div id="divValorTotalItem${i}">
                            <g:render template="valorTotalItem" model= "[item: item, i: i]"/>
                        </div>
                    </td>   
                    
                    <td style="text-align: center; vertical-align: middle;" ><button type="button" class="btn btn-outline-danger btnExcluir" name="excluirLinha" onclick="ajaxPost(this,'${createLink(controller:'venda', action:'removerTabela', params: ['indice': i ])}','divTabela', true, 1);" >Excluir</button></td> 
               </tr>
            </g:each>
        </tbody>
    </table>
</div>
<div>
    <div id="divValorTotal" >
		<g:render template="vendaTotal" model="[ativarTotal: ativarTotal]"/>
	</div>
</div>
<g:if test="${ativarTotal == 1}">
    <script>
        ajaxPost(document.getElementById('cliente'),'${createLink(controller:'venda', action:'calcularTotalVenda')}','divValorTotal', true, 1);
    </script>
</g:if>