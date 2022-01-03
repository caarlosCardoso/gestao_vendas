package gestao_vendas

class Cliente {
    String nome
    String cpfCnpj
    String email
    
    
    static constraints = {
        nome(nullable:false, maxSize: 255)
        cpfCnpj(nullable:false,  matches: "([0-9]*)",validator:{value ->
            if((value.size()==11) || (value.size()==14)){
                return true;
            }else{
                return false;
            }
        })
        email(nullable: true, email:true)
    }

    public void setNome(String nome) {
        this.nome = nome?.trim()?.toUpperCase();
    }

    // ------- MAPPING -------
    static mapping = {
        id generator:'sequence', params:[sequence:'sequence_cliente']
    }
    // ------- FIM MAPPING -------

}