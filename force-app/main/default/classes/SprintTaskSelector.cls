public with sharing class SprintTaskSelector {
  public static List<Sprint_Task__c> getListTasksBySprint(Id sprintId) {
    List<Sprint_Task__c> sprintTasks = [
      SELECT Task__c, Id, Sprint_FKN__c
      FROM Sprint_Task__c
      WHERE Sprint_FKN__c = :sprintId
    ];

    SObjectAccessDecision decision = Security.stripInaccessible(
      AccessType.READABLE,
      sprintTasks
    );

    return (List<Sprint_Task__c>) decision.getRecords();
  }

  public static Sprint_Task__c getSprintTaskById(Id taskId) {
    Sprint_Task__c sprintTask = [
      SELECT Id, Sprint_FKN__c, Task__c
      FROM Sprint_Task__c
      WHERE Id = :taskId
      LIMIT 1
    ];

    SObjectAccessDecision decision = Security.stripInaccessible(
      AccessType.READABLE,
      new List<Sprint_Task__c>{ sprintTask }
    );

    return (Sprint_Task__c) decision.getRecords()[0];
  }
}
