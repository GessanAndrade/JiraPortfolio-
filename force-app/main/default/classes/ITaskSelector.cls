public interface ITaskSelector {
  List<Task__c> getTasksByTasksIds(List<Id> taskIds);

  List<Task__c> getTaskByDeveloper(Id developerId);

  List<Task__c> getTasksFromSprintTasksAndIdDeveloper(
    List<Id> taskIds,
    Id developerId
  );

  Task__c getTaskById(Id taskId);
}
