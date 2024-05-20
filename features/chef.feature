# language: fr

@fr @jimbodragon @install_chef
Fonctionnalité: Action sur le workstation Chef

  @admin
  Scénario: Installer chef workstation
  Lorsque chef workstation est absent
  Alors installer le workstation Chef

  @admin
  Scénario: Installer chef client
  Lorsque chef client est absent
  Alors préparer le répertoire global de Chef

  @admin
  Scénario: Accepter les licences Chef
  Lorsque les licenses sont absent
  Alors accepter les licenses Chef

  @admin
  Scénario: vérifier la connection avec chef
  Lorsque le client chef est déconnecter
  Alors connecté le client
