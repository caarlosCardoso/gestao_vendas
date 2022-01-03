package gestao_vendas

class Usuario {
    String nome
    String usuario    
    String senha

    static constraints ={
        nome(nullable:false, maxSize: 255)
        usuario(nullable:false, maxSize: 50, unique: true)
        senha(nullable:false, maxSize: 50, password:true, matches: "([A-Za-z0-9]{2,})")
    }

    // ------- SETTERS E GETTERS -------
    public void setNome(String nome) {
        this.nome = nome?.trim()?.toUpperCase();
    }
    // ------- FIM SETTERS E GETTERS -------

    // ------- MAPPING -------
    static mapping = {
        id generator:'sequence', params:[sequence:'sequence_usuario']
    }
    // ------- FIM MAPPING -------
}
