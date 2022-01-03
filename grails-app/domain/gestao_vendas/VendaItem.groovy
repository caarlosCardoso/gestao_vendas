package gestao_vendas

class VendaItem {
    Produto produto
    BigDecimal valorUnitario
    BigDecimal quantidade
    BigDecimal desconto
    BigDecimal valorTotalItem

    static belongsTo = [venda: Venda]
    
    static constraints = {
        produto(nullable:false)
        valorUnitario(nullable:false)
        quantidade(nullable:false, min: 1.00)
        desconto(nullable:true)
        valorTotalItem(nullable:false, min: 0.01)
    }

    // ------- MAPPING -------
    static mapping = {
        id generator:'sequence', params:[sequence:'sequence_vendaItem']
    }
    // ------- FIM MAPPING -------
}