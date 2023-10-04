# language: fr
@fr @deploycontext
Fonctionnalité: Testons la recherche de variables et de leurs valeurs

  Plan du Scénario: Affiché la valeur par défault
  Étant donné que la variable <variable_name> est absent des données <item> du sac <data_bag>
  Alors affiché la valeur défini par Chef pour <variable_name>

  Exemples:
    | variable_name  |    data_bag   | item |
    | context_config | configuration | test |

  Plan du Scénario: Affiché une valeur présente
  Étant donné que la variable <variable_name> est présent dans les données <item> du sac <data_bag>
  Alors affiché la valeur enregistré dans le data bag <data_bag> pour <variable_name>

  Exemples:
    | variable_name | data_bag |
    | context_config | configuration | test |
