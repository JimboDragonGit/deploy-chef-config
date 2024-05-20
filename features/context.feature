# language: fr

@fr @jimbodragon @install_context
Fonctionnalité: Action sur le contexte

  @context
  Scénario: Exporter le contexte
  Étant donné le context est absent dans Chef
  Alors on crée le data bag de contextes
  Et on export le contexte dans Chef

  @context
  Scénario: Importer le contexte
  Étant donné le context est installé dans Chef
  Alors importer le context
