public with sharing class TaskSelector {
    public static List<Task__c> getTasksByTasksIds(List<Id> taskIds){
        return [SELECT Name, Status__c, Title__c, Developer__r.Name__c, Developer__r.Id, Points__c FROM Task__c WHERE Id IN :taskIds];
    }

    public static List<Task__c> getTaskByDeveloper(Id developerId){
        return [
            SELECT Name, Status__c, Title__c
            FROM Task__c
            WHERE Developer__c = :developerId
        ];
    }

    public static List<Task__c> getTasksFromSprintTasksAndIdDeveloper(List<Id> taskIds, Id developerId) {
        return [SELECT Id, Title__c, Developer__r.Name__c, Developer__r.Id, Points__c FROM Task__c WHERE Id IN :taskIds AND Developer__c = :developerId];
    }

    public static Task__c getTaskById(Id taskId){
        return [
            SELECT Name, Status__c, Title__c, Developer__c
            FROM Task__c
            WHERE Id = :taskId
            LIMIT 1
        ];
    }

}