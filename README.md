# MU-TH-UR 6000 — Terminal « M.A.M.A.N » du Nostromo

Terminal de bord du vaisseau d'*Alien, le 8ème passager* (1979), recréé dans le navigateur. On lui parle au micro ou au clavier, elle répond à voix haute grâce à l'API **Google Gemini**.

![Capture d'écran du terminal](chemin/vers/image.png)

## Fonctionnalités

- **Interface CRT** verte rétro : état du vaisseau, biorythmes de l'équipage, spectre audio du micro.
- **Conversation vocale** en français : reconnaissance de la parole et voix féminine calme. « Tais-toi » ou « Stop » coupent la voix.
- **Reconnaissance du locuteur** : une voix inconnue doit s'identifier avant que M.A.M.A.N lui réponde. Plusieurs officiers peuvent parler dans la même session.
- **Registre classifié** : 33 informations et commandes protégées par un code d'accès (Ordre spécial 937, pilotage manuel, autodestruction avec compte à rebours…).
- **Mode écoute** : M.A.M.A.N se tait et prend des notes.

## Lancement

1. Placez tous les fichiers dans un même dossier.
2. Démarrez un serveur local, sinon le navigateur redemandera l'accès au micro après chaque réponse :
   - **Windows** : double-cliquez sur `lancer-maman.bat`.
   - **Autres systèmes** : lancez `python -m http.server 8000`, puis ouvrez `http://localhost:8000/maman-nostromo.html`.
   - **En ligne** : activez GitHub Pages sur le dépôt (*Settings → Pages*).
3. Utilisez **Chrome** ou **Edge**.

## Clé API Gemini

Créez une clé gratuite sur [Google AI Studio](https://aistudio.google.com/) (« Get API key »), puis collez-la sur l'écran de démarrage. Elle reste uniquement dans votre navigateur.

> Ne publiez jamais votre clé dans le code ou sur GitHub.

## Utilisation

À chaque lancement, l'écran de démarrage demande :

- la **clé API** (mémorisée d'une fois sur l'autre) ;
- un **matricule** au choix (lettres, chiffres, tirets, avec au moins un chiffre) ;
- un **nom d'appel** ;
- un **code d'accès**, saisi deux fois.

Rien d'autre n'est conservé. M.A.M.A.N enregistre ensuite votre **empreinte vocale** dès votre première phrase.

Si une autre personne prend le micro, elle énonce son matricule et son nom, puis le code d'accès est tapé au clavier pour l'autoriser.

| Vous dites… | Effet |
|---|---|
| « Affiche la liste des informations classifiées » | Montre le registre (titres uniquement) |
| « Quel est l'ordre spécial 937 ? » ou « SEC-07 » | Demande le code, puis révèle l'information |
| « Active l'autodestruction » | Code, délai en minutes, confirmation |
| « Appelle-moi Commandant » | Change votre nom d'appel |
| « Passe en mode écoute » / « Repasse en mode vocal » | Change de mode |

## Personnaliser

- **Registre classifié** : modifiez `registre-classifie.json`.
- **Modèle Gemini** : modifiez la constante `MODEL` en haut du script de `maman-nostromo.html`.

## Avertissement

Projet de fan non officiel. *Alien*, le Nostromo et Weyland-Yutani appartiennent à 20th Century Studios. Le code d'accès et la reconnaissance vocale sont une simulation, pas une vraie sécurité.
