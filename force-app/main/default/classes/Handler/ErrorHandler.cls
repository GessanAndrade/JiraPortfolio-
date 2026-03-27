public with sharing class ErrorHandler {
  // Método para erros de UI (LWC/Aura)
  public static AuraHandledException handUIError(Exception e) {
    // 1. Faz o Log interno (importante para o desenvolvedor)
    logInternalError(e);

    // 2. Retorna uma mensagem amigável (importante para o usuário)
    String userFriendlyMessage = 'Ocorreu um erro inesperado. Por favor, tente novamente mais tarde.';

    AuraHandledException auraEx = new AuraHandledException(userFriendlyMessage);
    auraEx.setMessage(userFriendlyMessage); // Necessário para o LWC ler a mensagem corretamente
    return auraEx;
  }

  public static AuraHandledException handUnableError(
    Exception e,
    String message
  ) {
    // 1. Faz o Log interno (importante para o desenvolvedor)
    logInternalError(e);

    // 2. Retorna uma mensagem amigável (importante para o usuário)
    String userFriendlyMessage = 'Desabilitado para carregar:' + message;

    AuraHandledException auraEx = new AuraHandledException(userFriendlyMessage);
    auraEx.setMessage(userFriendlyMessage); // Necessário para o LWC ler a mensagem corretamente
    return auraEx;
  }

  public static AuraHandledException handNotFoundError(String message) {
    String userFriendlyMessage = 'Não encontrou:' + message;

    AuraHandledException auraEx = new AuraHandledException(userFriendlyMessage);
    auraEx.setMessage(userFriendlyMessage); // Necessário para o LWC ler a mensagem corretamente
    return auraEx;
  }

  public static AuraHandledException handNotNullError(String message) {
    String userFriendlyMessage = 'Não pode ser nulo:' + message;

    AuraHandledException auraEx = new AuraHandledException(userFriendlyMessage);
    auraEx.setMessage(userFriendlyMessage); // Necessário para o LWC ler a mensagem corretamente
    return auraEx;
  }

  public static AuraHandledException handRequiredError(String message) {
    String userFriendlyMessage = 'Campo obrigatório:' + message;

    AuraHandledException auraEx = new AuraHandledException(userFriendlyMessage);
    auraEx.setMessage(userFriendlyMessage); // Necessário para o LWC ler a mensagem corretamente
    return auraEx;
  }

  // Método para salvar o erro no banco de dados (Log)
  private static void logInternalError(Exception e) {
    Log__c log = new Log__c();
    log.Error__c = e.getMessage();
    log.message__c = e.getStackTraceString();

    System.debug('ERRO: ' + log.Error__c + ' em ' + log.message__c);

    try {
      insert log;
    } catch (Exception ex) {
      System.debug('Erro ao salvar log: ' + ex.getMessage());
    }
  }
}
