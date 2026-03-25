public with sharing class ErrorHandler {
  public static AuraHandledException handled(String message) {
    return new AuraHandledException(message);
  }
}
