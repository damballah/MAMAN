# MU-TH-UR 6000 — Terminal « M.A.M.A.N » du Nostromo

> *« INTERFACE 2037 READY FOR INQUIRY. »*

Une application web autonome qui recrée le terminal de bord **MU-TH-UR 6000**, surnommé « M.A.M.A.N » en version française, de l'USCSS Nostromo dans *Alien, le 8ème passager* (1979).

Vous lui parlez au micro ou au clavier, elle vous répond à voix haute. Elle reconnaît qui parle et protège les secrets de la Compagnie derrière un code d'accès. Les réponses sont générées par l'API **Google Gemini**.

Tout tient dans **un seul fichier HTML** : pas de framework à installer, pas de compilation, pas de serveur distant.

---

## Sommaire

- [Fonctionnalités](#fonctionnalités)
- [Contenu du dépôt](#contenu-du-dépôt)
- [Prérequis](#prérequis)
- [Obtenir une clé API Gemini](#obtenir-une-clé-api-gemini)
- [Lancer l'application](#lancer-lapplication)
- [Utilisation](#utilisation)
- [Le registre classifié](#le-registre-classifié)
- [Personnalisation](#personnalisation)
- [Fonctionnement technique](#fonctionnement-technique)
- [Dépannage](#dépannage)
- [Limites et sécurité](#limites-et-sécurité)
- [Crédits](#crédits)

---

## Fonctionnalités

### Interface CRT rétro-futuriste
- Écran monochrome vert phosphore avec lignes de balayage, vignettage, scintillement et bande de rafraîchissement.
- Police `Share Tech Mono` / `VT323` et texte qui s'affiche caractère par caractère.
- Panneau d'état du vaisseau : pression, oxygène, intégrité de la coque, cargaison, mode de pilotage et alertes actives.
- Moniteur de biorythmes de l'équipage en stase (Dallas, Ripley, Ash, Kane, Lambert), avec électrocardiogrammes animés.
- Analyseur de spectre qui réagit en temps réel à votre micro, avec une onde ambre quand M.A.M.A.N parle.

### Voix et son
- **Reconnaissance vocale** continue en français (Web Speech API).
- **Synthèse vocale** féminine, calme et posée, qui choisit en priorité les voix françaises de qualité (Hortense, Amélie, Denise, voix Google ou « Natural »).
- **Interruption vocale** : « tais-toi », « silence », « stop » ou « arrête de parler » coupent immédiatement la voix. Les bruits ambiants ne l'interrompent jamais.
- **Bruit de fond** du vaisseau, activable : ronronnement des réacteurs à 45 Hz et ventilation.
- Bips de terminal synthétisés à l'envoi et à la réception des messages.

### Intelligence artificielle
- Réponses générées par **Gemini** (`gemini-3-flash-preview` par défaut).
- Personnalité froide, analytique et formelle, fidèle au film.
- Répond à **toutes** les questions (calcul, culture générale, code…), toujours dans son rôle d'ordinateur de bord.
- Réponses courtes et complètes : 1 à 3 phrases, jamais tronquées, sans balises ni texte de « réflexion » interne.

### Identification et multi-utilisateurs
- **Écran de configuration** au lancement : clé API, matricule, nom d'appel et code d'accès saisi deux fois.
- **Contrôle strict des matricules** : seuls les matricules du registre sont acceptés, et le terminal se verrouille après 3 échecs.
- **Reconnaissance du locuteur** (simple) par la hauteur et le timbre de la voix. Si une voix inconnue prend le micro, M.A.M.A.N refuse de lui répondre tant qu'elle ne s'est pas identifiée.
- **Plusieurs officiers** dans la même conversation, chacun avec sa carte de biorythme. M.A.M.A.N s'adresse à chacun par son nom.
- **Changement de nom** à la volée (« appelle-moi Commandant »), avec confirmation quand le nom est dicté.

### Registre classifié
- **33 informations et commandes sensibles** consultables uniquement avec le code d'accès.
- Commandes simulées : pilotage manuel, purge atmosphérique, ouverture des sas, réveil d'urgence de l'équipage, balise de détresse…
- **Séquence d'autodestruction** avec délai au choix, compte à rebours, sirène, annonces vocales et possibilité d'interruption.

### Modes de fonctionnement
- **Mode vocal** (par défaut) : chaque échange est affiché et lu à voix haute.
- **Mode écoute** : M.A.M.A.N se tait et prend des notes `[NOTE LOG M.A.M.A.N]` horodatées, avec le nom du locuteur et des mesures (nombre de mots, niveau sonore).

---

## Contenu du dépôt

| Fichier | Rôle |
|---|---|
| `maman-nostromo.html` | L'application complète (HTML, Tailwind CSS, JavaScript ES6). |
| `registre-classifie.json` | La liste des informations et commandes protégées. Modifiable. |
| `lancer-maman.bat` | Lanceur Windows : démarre un petit serveur local et ouvre la page. |
| `README.md` | Ce document. |

---

## Prérequis

- **Google Chrome** ou **Microsoft Edge** sur ordinateur. Firefox et Safari ne gèrent pas correctement la reconnaissance vocale ; la saisie au clavier y reste disponible.
- Un **microphone**.
- Une **connexion Internet**, pour l'API Gemini, la reconnaissance vocale du navigateur et le chargement de Tailwind et des polices.
- Une **clé API Gemini** (gratuite pour un usage modéré, voir ci-dessous).

---

## Obtenir une clé API Gemini

1. Rendez-vous sur **[Google AI Studio](https://aistudio.google.com/)** et connectez-vous avec un compte Google.
2. Cliquez sur **« Get API key »**, puis **« Create API key »**.
3. Copiez la clé (elle commence par `AIza…`).
4. Collez-la dans le champ prévu sur l'écran de configuration de l'application.

La clé est enregistrée **uniquement dans votre navigateur** (`localStorage`). Elle n'est envoyée qu'aux serveurs de Google, pour générer les réponses.

> ⚠️ **Ne mettez jamais votre clé API dans le code ni dans un commit.** L'application est conçue pour que chaque utilisateur saisisse sa propre clé.

Les quotas gratuits et les noms de modèles disponibles peuvent évoluer : consultez la [documentation officielle de l'API Gemini](https://ai.google.dev/gemini-api/docs).

---

## Lancer l'application

Le micro doit être autorisé sur une adresse `http://localhost` ou `https://`. Si vous ouvrez simplement le fichier par double-clic (adresse en `file://`), le navigateur **redemandera l'accès au micro après chaque réponse**.

### Option 1 — Windows, le plus simple
Double-cliquez sur **`lancer-maman.bat`**. Il démarre un serveur local avec PowerShell, déjà présent sur Windows, et ouvre automatiquement `http://localhost:8765/maman-nostromo.html`.

Laissez la fenêtre noire ouverte pendant l'utilisation, et fermez-la pour arrêter le serveur. Au premier lancement, Windows peut afficher un avertissement de sécurité : choisissez « Informations complémentaires » puis « Exécuter quand même ».

### Option 2 — Python (Windows, macOS, Linux)
```bash
cd chemin/vers/le/dossier
python -m http.server 8000
```
Puis ouvrez `http://localhost:8000/maman-nostromo.html`.

### Option 3 — GitHub Pages
Le dépôt peut être publié tel quel avec GitHub Pages : dans **Settings → Pages**, choisissez la branche `main` et le dossier racine. La page sera servie en `https://`, ce qui permet au micro et à la reconnaissance vocale de fonctionner normalement. Chaque visiteur devra saisir sa propre clé API.

---

## Utilisation

### 1. Configuration de session
Au lancement, remplissez l'écran d'initialisation :

| Champ | Description |
|---|---|
| Clé API Gemini | Votre clé `AIza…` |
| Matricule d'officier | Un matricule présent dans le registre (voir [Personnalisation](#personnalisation)) |
| Nom ou titre d'appel | Le nom par lequel M.A.M.A.N vous appellera (3 mots maximum) |
| Code d'accès + confirmation | Protège le registre classifié. Il n'est **jamais enregistré** et est redemandé à chaque session. |

Matricules disponibles par défaut : `A-227-100-JP` et `A-100-227-ANGEL`.

M.A.M.A.N vous demande ensuite de prononcer une phrase pour enregistrer votre empreinte vocale.

### 2. Ajouter un autre officier
Quand une voix inconnue parle, M.A.M.A.N répond : *« VOIX NON RECONNUE. ACCÈS REFUSÉ. VEUILLEZ ÉNONCER VOTRE MATRICULE D'OFFICIER. »* La personne donne son matricule, puis son nom d'appel, et une nouvelle carte de biorythme apparaît.

### 3. Commandes vocales utiles

| Vous dites… | Effet |
|---|---|
| « Tais-toi », « Silence », « Stop » | Coupe immédiatement la voix de M.A.M.A.N |
| « Passe en mode écoute » | Désactive la voix et active la prise de notes |
| « Repasse en mode vocal » | Réactive la voix |
| « Appelle-moi Commandant » / « Change mon nom » | Modifie votre nom d'appel |
| « Affiche la liste des informations classifiées » | Affiche le registre (titres uniquement) |
| « SEC-07 » / « Quel est l'ordre spécial 937 ? » | Demande une entrée classifiée (code requis) |
| « Annule l'autodestruction » | Interrompt le compte à rebours (code requis) |
| « Repasse en pilotage automatique » | Rend le contrôle à MU-TH-UR |

Toutes les commandes fonctionnent aussi au clavier.

### 4. Boutons de contrôle

| Bouton | Fonction |
|---|---|
| **MICROPHONE** | Active ou coupe le micro |
| **MODE VOCAL / ÉCOUTE** | Bascule entre les deux modes |
| **BRUIT AMBIANT** | Active le ronronnement du vaisseau |
| **REBOOT SESSION** | Retour à l'écran de configuration |
| **CLÉ API GEMINI** | Modifier ou effacer la clé |
| **REGISTRE CLASSIFIÉ** | Afficher la liste des entrées protégées |

### 5. Réglage de la reconnaissance vocale
Le panneau **IDENTIFICATION VOCALE** affiche en direct la fréquence et le timbre mesurés, ainsi que le locuteur reconnu. Son curseur de tolérance se règle ainsi :

- vers **SOUPLE** si M.A.M.A.N ne vous reconnaît plus d'une phrase à l'autre ;
- vers **STRICTE** si elle confond deux personnes.

---

## Le registre classifié

Le fichier `registre-classifie.json` contient 33 entrées réparties en six catégories :

| Catégorie | Exemples |
|---|---|
| Dossiers de l'équipage | Dossiers médicaux, indices de loyauté, véritable nature d'Ash |
| Compagnie Weyland-Yutani | Ordre spécial 937, analyse du signal de LV-426, division Armes Biologiques |
| Sécurité du système | Niveaux d'habilitation, journal d'accès, codes de priorité |
| Navigation et pilotage | Pilotage manuel, coordonnées de LV-426, séparation de la raffinerie |
| Systèmes de bord | Purge atmosphérique, sas, navette Narcissus, réveil d'urgence |
| Protocoles d'urgence | Autodestruction, balise de détresse, abandon du vaisseau |

**Déroulement d'une demande :**
1. La liste peut être affichée librement, mais elle ne montre que les titres.
2. Toute demande portant sur une entrée déclenche l'exigence du **code d'accès**, à taper au clavier dans un champ masqué.
3. Les **informations** déverrouillées restent accessibles pendant toute la session.
4. Les **commandes** redemandent le code à chaque fois, puis une confirmation par oui ou non.
5. Après 3 codes erronés, le registre se verrouille 60 secondes.

**Autodestruction :** le délai se choisit entre 1 et 60 minutes. Un bandeau rouge affiche le compte à rebours, accompagné d'une sirène et d'annonces vocales. L'interruption est possible jusqu'à T-moins 30 secondes.

---

## Personnalisation

### Ajouter des matricules
En haut du script de `maman-nostromo.html`, complétez la liste `REGISTRY` :

```js
const REGISTRY = [
  { id:'A-227-100-JP',    forms:['A227100JP'],    short:['227'] },
  { id:'A-100-227-ANGEL', forms:['A100227ANGEL'], short:[] },
  { id:'B-042-314-RX',    forms:['B042314RX'],    short:[] },   // nouveau
];
```
- `forms` : écriture compacte du matricule, sans tirets ni espaces, comparée à l'identique.
- `short` : forme abrégée acceptée uniquement si elle est dite seule (facultatif).

### Modifier le registre classifié
Éditez `registre-classifie.json`. Chaque entrée contient :

| Champ | Description |
|---|---|
| `code` | Identifiant, par exemple `SEC-07` |
| `categorie`, `titre`, `niveau` | Affichés dans la liste |
| `type` | `info` (révélée après le code) ou `commande` (exécutée après code et confirmation) |
| `mots_cles` | Expressions qui déclenchent la demande de code, **sans accents ni apostrophes** |
| `resume` | Phrase lue à voix haute (pour les `info`) |
| `contenu` | Texte complet affiché dans la console |
| `action`, `confirmation`, `execution`, `etat` | Pour les commandes |

Actions reconnues : `alarms_off`, `manual_on`, `course`, `separate`, `overdrive`, `purge`, `airlock`, `shuttle`, `wake`, `beacon`, `selfdestruct`, `selfdestruct_cancel`.

L'application relit ce fichier à chaque lancement quand elle est servie en `http(s)://`. Sinon, elle utilise la copie intégrée au fichier HTML. Pensez à mettre à jour les deux si vous distribuez la page seule.

### Changer de modèle Gemini
Modifiez la constante en haut du script :
```js
const MODEL = 'gemini-3-flash-preview';
```

---

## Fonctionnement technique

| Fonction | Technologie |
|---|---|
| Interface | HTML5, Tailwind CSS (CDN), Canvas 2D |
| Reconnaissance vocale | `SpeechRecognition` / `webkitSpeechRecognition` |
| Synthèse vocale | `speechSynthesis` (Web Speech API) |
| Spectre, sons, bruit de fond | Web Audio API (`AnalyserNode`, oscillateurs, bruit brun filtré) |
| Identification du locuteur | Fréquence fondamentale par autocorrélation + centroïde spectral, comparés aux empreintes enregistrées |
| IA | SDK `@google/genai` chargé depuis jsDelivr, avec repli automatique sur l'API REST Gemini |
| Stockage | `localStorage` pour la clé API, le matricule et le nom ; le code d'accès reste en mémoire uniquement |

Le contenu des dossiers verrouillés **n'est jamais envoyé à Gemini**. Le modèle reçoit seulement la liste des titres et la consigne de répondre par un marqueur d'accès restreint. L'application intercepte ce marqueur et exige alors le code.

---

## Dépannage

**Le navigateur redemande l'accès au micro après chaque réponse**
La page est ouverte en `file://`. Utilisez `lancer-maman.bat`, `python -m http.server` ou GitHub Pages.

**« Permission denied » alors que le micro est autorisé**
La page tourne probablement dans un cadre intégré (aperçu d'un autre site). Ouvrez-la directement dans un onglet.

**Pas de voix, ou une voix robotique**
Les voix disponibles dépendent du système. Sous Windows, installez des voix françaises dans *Paramètres → Heure et langue → Voix*. Edge propose des voix « Natural » de bonne qualité.

**« Défaillance de liaison avec le module cognitif »**
Vérifiez la clé API, votre connexion, vos quotas Gemini, et que le nom du modèle est toujours valide.

**M.A.M.A.N ne me reconnaît pas ou confond deux personnes**
Ajustez le curseur de tolérance. Les phrases très courtes (« oui », « ok ») sont attribuées à la dernière personne qui a parlé.

---

## Limites et sécurité

Ce projet est une **simulation ludique**, pas un système de sécurité :

- Le code d'accès et le registre sont vérifiés dans le navigateur. Toute personne qui lit le code source ou le fichier JSON peut en voir le contenu.
- La reconnaissance du locuteur est volontairement simple. Elle distingue bien des voix différentes (par exemple homme et femme), mais pas deux timbres proches, et une imitation peut la tromper.
- La clé API reste dans le `localStorage` du navigateur. Utilisez un navigateur personnel et révoquez la clé sur Google AI Studio en cas de doute.

---

## Crédits

- Projet de fan, non officiel et sans but commercial.
- *Alien*, le Nostromo, MU-TH-UR 6000 et Weyland-Yutani sont des marques et créations de **20th Century Studios**. Ce projet n'est ni affilié ni approuvé par leurs ayants droit.
- Polices [Share Tech Mono](https://fonts.google.com/specimen/Share+Tech+Mono) et [VT323](https://fonts.google.com/specimen/VT323) (Google Fonts, licence OFL).
- Réponses générées par l'API [Google Gemini](https://ai.google.dev/).

> *« MOTHER, I'VE TURNED THE COOLING UNIT BACK ON. »*
