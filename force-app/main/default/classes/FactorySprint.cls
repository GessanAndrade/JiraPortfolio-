public with sharing class FactorySprint {
  public static SprintService createSprintService() {
    return new SprintService(
      new SprintDomain(),
      new SprintSelector(),
      new SprintTaskSelector()
    );
  }
}
