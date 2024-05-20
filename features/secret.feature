# language: fr

@fr @jimbodragon @install_secret
Fonctionnalité: Action sur les secrets

  @secret
  Scénario: Générer le fichier de secret
  Étant donné le fichier secret manquant
  Alors on crée le fichier secret pour Chef

  @secret
  Scénario: Cheger le fichier de secret
  Étant donné le fichier secret présent
  Alors on charge le secret
