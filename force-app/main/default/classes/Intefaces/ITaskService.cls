public interface ITaskService {
  List<Task__c> getTasksFromSprintTasksAndIdDeveloper(
    List<Id> taskIds,
    Id developerId
  );
}
