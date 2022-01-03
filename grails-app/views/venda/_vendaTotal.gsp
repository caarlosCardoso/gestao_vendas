<label for="valorTotal">
 	<g:message code="venda.valorTotal.label" default="Total:" />
</label>
<g:field id= "valorTotal" name="valorTotal" value= "${formatNumber(number: venda.valorTotal, format: '###,###,##0.00')}" readonly="true"  />