package gestao_vendas

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON
import org.springframework.transaction.annotation.Transactional;

class VendaController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [vendaList: Venda.list(params), vendaTotal: Venda.count()]
    }

    def listVenda(int length, int start){
        params.max = length;
        params.offset = start;
        int iCol=0;
        String search = params.getAt("search[value]")?.toString()?.trim(), 
               orderColumn = params.getAt("order[0][column]");
        
        List dados = Venda.createCriteria().list(params) {
            if (search && !search.equals("")){
                or {
                    //INSERIR RESTRIÇÕES DE FILTRO NAS COLUNAS   
                    cliente{
                        ilike("nome", "%"+search+"%")
                    }

                    sqlRestriction("to_char(this_.valor_total, 'FM999G999G990D00') like ?", [search+"%"])
                }
            }
            
            if (orderColumn && params.getAt("columns["+orderColumn+"][data]")?.toString()!=""){
                if(orderColumn == '1'){
                    cliente{
                        order("nome",params.getAt("order[0][dir]"))
                    }
                }else{
                    order(params.getAt("columns["+orderColumn+"][data]"),params.getAt("order[0][dir]"))
                }
                
            }else{ 
                order("id","desc")
            }
        }
        
        def recordsTotal = Venda.count();
        def recordsFiltered = dados.totalCount;
        
        //CODIGO ABAIXO PERMITE A PESONALIZAÇÃO DO RETORNO
        dados = dados.collect {it -> return [
            id: it.id,  
            clienteId : it.cliente?.id,
            nome: it.cliente?.nome,
            totalItens: it.itensVenda?.size(),
            valorTotal :  formatNumber(number:it.valorTotal, format:"###,###,##0.00")
        ]}
        
        render contentType: "text/json", text: ["draw":params.draw,"recordsTotal":recordsTotal,"recordsFiltered":recordsFiltered,"data": dados ] as JSON;
    }

    def create() {
        def venda = new Venda(params)
        venda.itensVenda=[]
        venda.valorTotal = 0
        
        [venda: venda]
    }

    def save() {
        def venda = new Venda(params)
        if (!venda.save(flush: true)) {
            render(view: "create", model: [venda: venda])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'venda.label', default: 'Venda'), venda.id])
        redirect(action: "index", id: venda.id)
    }

    def edit(Long id) {
        def venda = Venda.get(id)
        if (!venda) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'venda.label', default: 'Venda'), id])
            redirect(action: "index")
            return
        }

        [venda: venda]
    }

    @Transactional(readOnly = false)
    def update(Long id, Long version) {
        def venda = Venda.get(id)
        if (!venda) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'venda.label', default: 'Venda'), id])
            redirect(action: "index")
            return
        }

        if (version != null) {
            if (venda.version > version) {
                venda.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'venda.label', default: 'Venda')] as Object[],
                          "Another user has updated this Venda while you were editing")
                render(view: "edit", model: [venda: venda])
                return
            }
        }

        venda.itensVenda.clear()
        venda.properties = params

        if (!venda.save(flush: true)) {
            render(view: "edit", model: [venda: venda])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'venda.label', default: 'Venda'), venda.id])
        redirect(action: "index", id: venda.id)
    }

    def delete(Long id) {
        def venda = Venda.get(id)
        if (!venda) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'venda.label', default: 'Venda'), id])
            redirect(action: "index")
            return
        }

        try {
            venda.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'venda.label', default: 'Venda'), id])
            redirect(action: "index")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'venda.label', default: 'Venda'), id])
            redirect(action: "edit", id: id)
        }
    }

    def inserirTabela(){
        //insere um novo produto na tabela. esse produto vem carregado com valores padrões de um item "vazio"
        def venda = new Venda(params)
        def item = new VendaItem()
        item.desconto =0
        item.quantidade =1
        item.valorUnitario = 0
        item.valorTotalItem = 0
       
        if(venda.itensVenda == null){
            venda.itensVenda = []
            venda.itensVenda.add(item)
        }else{
            venda.itensVenda.add(item)
        }

        render(template: "/venda/tabelaVenda", model: [venda: venda, ativarTotal: 1])
    }

        //Remove o item selecionado da tabela
    def removerTabela(){
        def venda = new Venda(params)
        int indice = params.indice as int
        venda.itensVenda.remove(indice)
        render(template: "/venda/tabelaVenda", model: [venda: venda, ativarTotal: 1])
    }

    def atualizarValorPadrao(){
        def venda = new Venda(params)
        int indice = params.indice as int
        
        if (venda.itensVenda[indice].produto?.id != null){
            venda.itensVenda[indice].valorUnitario = venda.itensVenda[indice].produto.valorPadrao
        }else{
            venda.itensVenda[indice].valorUnitario = 0
        }
        render(template: "/venda/valorPadrao", model: [item: venda.itensVenda[indice], i:indice, ativarTotal: 1])
    }

    def zerarDesconto(){
        def venda = new Venda(params)
        int indice = params.indice as int
        venda.itensVenda[indice].desconto = 0
        render(template: "/venda/desconto", model: [item: venda.itensVenda[indice], i:indice])
    }
    def umQuantidade(){
        def venda = new Venda(params)
        int indice = params.indice as int
        venda.itensVenda[indice].quantidade = 1
        render(template: "/venda/quantidade", model: [item: venda.itensVenda[indice], i:indice])
    }

    def iniciarValorTotalItem(){
        def venda = new Venda(params)
        int indice = params.indice as int
        if (venda.itensVenda[indice].produto?.id != null){
            venda.itensVenda[indice].valorTotalItem = venda.itensVenda[indice].produto.valorPadrao
        }else{
            venda.itensVenda[indice].valorTotalItem = 0
        }
        
        render(template: "/venda/valorTotalItem", model: [item: venda.itensVenda[indice], i:indice, ativarTotal: 1])
    }

    def atualizarValorTotalItem(){
        def venda = new Venda(params)
        int indice = params.indice as int

        if( venda.itensVenda[indice].quantidade < 0){
            venda.itensVenda[indice].quantidade = 0
        }

        if (venda.itensVenda[indice].produto?.id != null){
            venda.itensVenda[indice].valorTotalItem = (venda.itensVenda[indice].valorUnitario * venda.itensVenda[indice].quantidade) - venda.itensVenda[indice].desconto
        }else{
            venda.itensVenda[indice].valorTotalItem = 0
        }

        if(venda.itensVenda[indice].valorTotalItem < 0){
            venda.itensVenda[indice].valorTotalItem = 0
        } 
        
        render(template: "/venda/valorTotalItem", model: [item: venda.itensVenda[indice], i:indice, ativarTotal: 1])
    }

    def calcularTotalVenda(){
        def venda = new Venda(params)
        
        if(venda?.itensVenda?.size() > 0){
            venda.valorTotal = venda.itensVenda.valorTotalItem.sum();
        }else{
            venda.valorTotal = 0;
        }
            
        render(template: "/venda/vendaTotal", model: [venda:venda])
    }

    

      
}
