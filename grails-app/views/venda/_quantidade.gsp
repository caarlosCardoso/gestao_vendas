 <g:field name="itensVenda[${i}].quantidade" value="${formatNumber(number: item.quantidade, format: '###,###,##0.00')}" onkeyup="mascaraNumero(this);" onchange="ajaxPost(this,'${createLink(controller:'venda', action:'atualizarValorTotalItem', params: ['indice': i ])}','divValorTotalItem${i}', true, 1)"  />



