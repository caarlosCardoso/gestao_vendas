
<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'nome', 'error')}">
    <label for="nome">
        <g:message code="cliente.nome.label" default="nome" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="nome" value="${clienteInstance.nome}" />
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'cpfCnpj', 'error')}">
    <label for="cpfCnpj">
        <g:message code="cliente.cpfCnpj.label" default="cpfCnpj" />
         <span class="required-indicator">*</span>
    </label>
    <g:field name="cpfCnpj" value="${ clienteInstance.cpfCnpj}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clienteInstance, field: 'email', 'error')}">
    <label for="email">
        <g:message code="cliente.email.label" default="email" />
    </label>
    <g:field name="email" value="${ clienteInstance.email}"/>
</div>