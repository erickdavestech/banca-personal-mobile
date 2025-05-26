enum Apis { apiUrlDev, apiUrlQA, hostDev, hostQA }

class EnvConfig {
  static Map<Apis, String> configs = {
    Apis.apiUrlDev: "https://10.1.10.3/api/v1/",
    Apis.hostDev: "bancaenlinea.ca-zeta.pma",
    Apis.apiUrlQA: "https://10.1.10.53/api/v1/",
    Apis.hostQA: "bancaenlinea.qa-ca-zeta.pma",
  };
}
