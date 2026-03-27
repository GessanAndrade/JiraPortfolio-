public with sharing class FactoryTask {
  public static TaskService createTaskService() {
    return new TaskService(
      new TaskDomain(),
      new TaskSelector(),
      new DeveloperSelector()
    );
  }
}
