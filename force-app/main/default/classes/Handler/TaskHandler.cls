public with sharing class TaskHandler {
  public static void updateDeveloperTaskOn(Id developerId) {
    if (developerId == null)
      return;
    updateDeveloperTaskOn(new Set<Id>{ developerId });
  }

  public static void updateDeveloperTaskOn(Set<Id> developerIds) {
    if (developerIds == null || developerIds.isEmpty())
      return;

    Map<Id, Integer> openTasksByDev = new Map<Id, Integer>();

    for (AggregateResult ar : [
      SELECT Developer__c devId, COUNT(Id) total
      FROM Task__c
      WHERE
        Developer__c IN :developerIds
        AND Status__c NOT IN ('Done', 'Rejected')
      GROUP BY Developer__c
    ]) {
      openTasksByDev.put((Id) ar.get('devId'), (Integer) ar.get('total'));
    }

    List<Developer__c> devsToUpdate = [
      SELECT Id, Task_On__c
      FROM Developer__c
      WHERE Id IN :developerIds
    ];

    for (Developer__c dev : devsToUpdate) {
      dev.Task_On__c = openTasksByDev.containsKey(dev.Id)
        ? openTasksByDev.get(dev.Id)
        : 0;
    }

    if (!devsToUpdate.isEmpty()) {
      update devsToUpdate;
    }
  }
}
