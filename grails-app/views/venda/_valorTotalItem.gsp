<g:field name="itensVenda[${i}].valorTotalItem"  value="${formatNumber(number: item.valorTotalItem, format: '###,###,##0.00')}" readonly="true" />


<g:if test="${ativarTotal == 1}">
    <script>
        ajaxPost(document.getElementById('cliente'),'${createLink(controller:'venda', action:'calcularTotalVenda')}','divValorTotal', true, 1);
    </script>
</g:if>

