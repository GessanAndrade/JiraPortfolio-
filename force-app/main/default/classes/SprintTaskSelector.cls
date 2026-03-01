public with sharing class SprintTaskSelector {
    public static List<Sprint_Task__c> getListTasksBySprint(Id sprintId){
        return [SELECT Task__c, Id, Sprint_FKN__c FROM Sprint_Task__c WHERE Sprint_FKN__c = :sprintId];
    }

    public static Sprint_Task__c getSprintTaskById(Id taskId){
        return [SELECT Id, Sprint_FKN__c, Task__c FROM Sprint_Task__c WHERE Id = :taskId LIMIT 1];
    }

}