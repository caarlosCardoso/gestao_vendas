package gestao_vendas

import grails.testing.web.interceptor.InterceptorUnitTest
import spock.lang.Specification

class ControlarInterceptorSpec extends Specification implements InterceptorUnitTest<ControlarInterceptor> {

    def setup() {
    }

    def cleanup() {

    }

    void "Test controlar interceptor matching"() {
        when:"A request matches the interceptor"
            withRequest(controller:"controlar")

        then:"The interceptor does match"
            interceptor.doesMatch()
    }
}
