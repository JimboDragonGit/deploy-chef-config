# language: fr

@fr @jimbodragon @install_context
Fonctionnalité: Action que doit faire un administrateur

  @admin
  Scénario: vérifier la clé ssh
  Lorsque la clé ssh est absente
  Alors créer la clé ssh
  Et connecté ssh au bundle

  @admin
  Scénario: vérifier la connection avec rubygem
  Lorsque la signature rubygem est absente
  Alors signé le gem à rubygem

  @admin
  Plan du Scénario: build rubygem
  Lorsque la signature rubygem est présent
  Étant donné que <repository> est présent

  Exemples:
    |repository|
    |jimbodragon_rubygems|
