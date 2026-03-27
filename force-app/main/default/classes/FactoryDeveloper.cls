public with sharing class FactoryDeveloper {
  public static DeveloperService createDeveloper() {
    return new DeveloperService(new DeveloperSelector(), new DeveloperDomain());
  }
}
