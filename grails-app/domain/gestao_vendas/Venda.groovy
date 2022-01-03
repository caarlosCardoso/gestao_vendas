package gestao_vendas

class Venda {
    List itensVenda;
    Cliente cliente
    BigDecimal valorTotal

    static hasMany = [itensVenda: VendaItem]

    static constraints = {
        itensVenda(nullable:false, minSize: 1)
        cliente(nullable:false)
        valorTotal(nullable:false, min: 0.01)
    }

    // ------- MAPPING -------
    static mapping = {
        id generator:'sequence', params:[sequence:'sequence_venda']
        itensVenda cascade:"all-delete-orphan"
    }
    // ------- FIM MAPPING -------
}
