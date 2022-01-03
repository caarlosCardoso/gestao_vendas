package gestao_vendas


class LoginInterceptor {

    public LoginInterceptor(){
        matchAll().excludes(controller: 'usuario', action:'login').excludes(controller:'usuario', action:'authLogin')
    }
    boolean before() { 
        if(session.user == null){
            redirect(controller:'usuario', action:'login')
            return false
        }/*else{
            println "interceptor Validado"
            println params
        }*/
        true 
    }

    boolean after() { true }

    void afterView() {
        // no-op
    }
}
