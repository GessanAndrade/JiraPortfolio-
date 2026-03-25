public with sharing class SprintDomain {
  public static void validateSprintFields(Sprint__c sprint) {
    if (sprint.Date_Begin__c == null) {
      throw new AuraHandledException('StartDate is required.');
    }
    if (sprint.Date_End__c == null) {
      throw new AuraHandledException('EndDate is required.');
    }
  }
  public static void validateSprintAcessibility() {
    if (!Schema.sObjectType.Sprint__c.isAccessible()) {
      throw new AuraHandledException(
        'You do not have permission to access Sprint.'
      );
    }
  }
  public static void validateSprintCreateability() {
    if (!Schema.sObjectType.Sprint__c.isCreateable()) {
      throw new AuraHandledException(
        'You do not have permission to create Sprint.'
      );
    }
  }
  public static void validateSprintUpdateability() {
    if (!Schema.sObjectType.Sprint__c.isUpdateable()) {
      throw new AuraHandledException(
        'You do not have permission to update Sprint.'
      );
    }
  }
  public static void validateSprintDeletability() {
    if (!Schema.sObjectType.Sprint__c.isDeletable()) {
      throw new AuraHandledException(
        'You do not have permission to delete Sprint.'
      );
    }
  }
}
