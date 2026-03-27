public with sharing class SprintTaskSelector implements ISprintTaskSelector {
  public List<Sprint_Task__c> getListTasksBySprint() {
    List<Sprint_Task__c> sprintTasks = [
      SELECT Task__c, Id, Sprint_FKN__c
      FROM Sprint_Task__c
      WHERE
        Sprint_FKN__c IN (SELECT Id FROM Sprint__c WHERE Status__c = 'Active')
    ];

    SObjectAccessDecision decision = Security.stripInaccessible(
      AccessType.READABLE,
      sprintTasks
    );

    return (List<Sprint_Task__c>) decision.getRecords();
  }

  public Sprint_Task__c getSprintTaskById(Id taskId) {
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
