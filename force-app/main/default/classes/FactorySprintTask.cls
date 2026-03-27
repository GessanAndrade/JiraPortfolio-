public with sharing class FactorySprintTask {
  public static SprintTaskService createSprintTaskService() {
    return new SprintTaskService(
      new SprintTaskDomain(),
      new SprintTaskSelector(),
      new TaskService(
        new TaskDomain(),
        new TaskSelector(),
        new DeveloperSelector()
      )
    );
  }
}
