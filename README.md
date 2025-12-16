#  Weather App - Application Météo Flutter


Une application météo moderne et élégante développée avec Flutter, utilisant le pattern Provider pour la gestion d'état et l'API OpenWeatherMap pour les données en temps réel.

##  Fonctionnalités

### Fonctionnalités Principales

- ✅ **Recherche de ville** - Recherchez la météo pour n'importe quelle ville dans le monde
- ✅ **Météo actuelle** - Température, ressenti, description, icône dynamique
- ✅ **Prévisions 4 jours** - Températures min/max, humidité, conditions météo
- ✅ **Détails complets** - Humidité, précipitations, vitesse du vent, pression atmosphérique
- ✅ **Dates en français** - Formatage localisé avec le package `intl`
- ✅ **Gestion d'état avancée** - Pattern Provider avec ChangeNotifier
- ✅ **Pull-to-refresh** - Actualisation des données par glissement

### Fonctionnalités Techniques

-  **Design moderne** - Interface Material Design avec gradients adaptatifs
- **Animations fluides** - Transitions et apparitions progressives
- **Appels API optimisés** - Requêtes parallèles avec `Future.wait()`
- **4 états gérés** - Initial, Loading, Success, Error
- **Architecture propre** - Organisation en couches (Data, Business Logic, Presentation)
- **Icônes dynamiques** - Icônes météo depuis l'API OpenWeatherMap
- **Gestion d'erreur robuste** - Messages contextuels pour chaque type d'erreur

---

## Objectifs Pédagogiques

Cette application a été développée dans le cadre du **TP2 - Gestion d'État Avancée avec Flutter** et vise à :

1. **Maîtriser Provider** - Remplacer `setState()` par une gestion d'état professionnelle
2. **Architecture Clean** - Séparer les responsabilités en packages distincts
3. **Intégration API REST** - Appels HTTP asynchrones avec gestion d'erreurs
4. **Programmation réactive** - Utilisation de Futures, Streams et async/await
5. **Modèles de données** - Parsing JSON automatique avec factory constructors
6. **Thème personnalisé** - Création d'un design system cohérent
7. **Internationalisation** - Formatage des dates en français

---

## Architecture

L'application suit une architecture en **3 couches** basée sur le principe de séparation des responsabilités :

```
┌─────────────────────────────────────────┐
│         PRESENTATION LAYER              │
│   (Pages, Widgets, Theme, Animations)   │
└──────────────┬──────────────────────────┘
               │ uses
               ▼
┌─────────────────────────────────────────┐
│           DATA LAYER                    │
│   (Models, Repositories, Data Sources)  │
└─────────────────────────────────────────┘
```

### Patterns Utilisés

| Pattern | Description |
|---------|-------------|
| **Provider Pattern** | Gestion d'état réactive avec `ChangeNotifier` |
| **Repository Pattern** | Encapsulation de la logique d'accès aux données |
| **Factory Pattern** | Méthodes `fromJson()` pour créer les modèles |
| **Singleton Pattern** | Instance unique du Provider partagée globalement |

---

## Installation

### Prérequis

- Flutter SDK `>= 3.0.0`
- Dart SDK `>= 3.0.0`
- Android Studio / VS Code avec extensions Flutter
- Clé API OpenWeatherMap (gratuite)

### Étapes d'Installation

**1. Cloner le repository**
```bash
git clone https://github.com/bensalahRyma/tp-flutter-appM-teo.git
cd tp-flutter-appM-teo
```

**2. Installer les dépendances**
```bash
flutter pub get
```

**3. Configurer la clé API** (voir section Configuration ci-dessous)

**4. Lancer l'application**
```bash
# Sur émulateur/appareil connecté
flutter run

# Sur Chrome (web)
flutter run -d chrome

# Build de production
flutter build apk     # Android
flutter build ios     # iOS
flutter build web     # Web
```

---

## ⚙Configuration

### 1. Obtenir une Clé API OpenWeatherMap

1. Créez un compte gratuit sur [OpenWeatherMap](https://openweathermap.org/api)
2. Générez une clé API dans votre dashboard
3. Copiez la clé (format : `abc123def456...`)

### 2. Configurer la Clé dans l'Application

Ouvrez le fichier `lib/data/repositories/weather_repository.dart` :

```dart
class WeatherRepository {
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String _apiKey = 'VOTRE_CLE_API_ICI'; // ⬅️ Remplacez ici
  
  // ...
}
```

** Important** : Pour un projet en production, utilisez des variables d'environnement ou `flutter_dotenv` pour sécuriser votre clé API.

### 3. Configuration Optionnelle

**Changer la locale (langue)** dans `lib/main.dart` :
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null); // Français
  runApp(const MyApp());
}
```

**Personnaliser les couleurs** dans `lib/presentation/theme/app_theme.dart` :
```dart
class AppTheme {
  static const Color primaryBlue = Color(0xFF4A90E2);
  static const Color lightBlue = Color(0xFF5DADE2);
  // Modifiez selon vos préférences
}
```

---

## Utilisation

### Rechercher une Ville

1. Lancez l'application
2. Saisissez le nom d'une ville dans la barre de recherche
3. Appuyez sur le bouton de recherche  ou sur Entrée
4. La météo actuelle et les prévisions s'affichent avec animations

### Actualiser les Données

- **Méthode 1** : Glissez vers le bas (pull-to-refresh)
- **Méthode 2** : Effectuez une nouvelle recherche

### États de l'Application

| État | Description |
|------|-------------|
| **Initial** | Écran d'accueil avec message d'invitation |
| **Loading** | Spinner de chargement pendant les appels API |
| **Success** | Affichage des données avec animations |
| **Error** | Message d'erreur contextuel |

---

##  Technologies

### Packages Principaux

| Package | Version | Utilisation |
|---------|---------|-------------|
| **provider** | ^6.1.1 | Gestion d'état avec ChangeNotifier |
| **http** | ^1.1.0 | Appels HTTP vers l'API |
| **intl** | ^0.18.1 | Formatage des dates en français |
| **font_awesome_flutter** | ^10.6.0 | Bibliothèque d'icônes |
| **google_fonts** | ^6.1.0 | Police Poppins personnalisée |
| **flutter_animate** | ^4.3.0 | Animations déclaratives |
| **shimmer** | ^3.0.0 | Effets de brillance |

### Dépendances Complètes

Voir le fichier [`pubspec.yaml`](pubspec.yaml) pour la liste complète des dépendances.

---

## Diagrammes UML

### Diagramme de Classes

Le diagramme de classes montre l'architecture complète de l'application :

- **Couche Data** : `WeatherModel`, `ForecastModel`, `WeatherRepository`, `WeatherProvider`
- **Couche Presentation** : `WeatherPage`, widgets personnalisés, `AppTheme`
- **Relations** : Héritage, composition, dépendances



### Diagramme de Séquence

Le diagramme de séquence illustre le flux complet d'une recherche météo :

1. Interaction utilisateur → UI
2. UI → Provider (ChangeNotifier)
3. Provider → Repository
4. Repository → API OpenWeatherMap
5. Retour des données avec `notifyListeners()`
6. Mise à jour réactive de l'interface


** Pour générer les diagrammes** : Consultez [`DIAGRAMS_GUIDE.md`](DIAGRAMS_GUIDE.md)

---

## Structure du Projet

```
weather_app/
│
├── lib/
│   ├── main.dart                          # Point d'entrée
│   │
│   ├── data/                              # Couche Data
│   │   ├── models/
│   │   │   ├── weather_model.dart         # Modèle météo actuelle
│   │   │   └── forecast_model.dart        # Modèle prévisions
│   │   ├── repositories/
│   │   │   └── weather_repository.dart    # Appels API
│   │   └── providers/
│   │       └── weather_provider.dart      # Provider
│   │
│   │
│   └── presentation/                      # Couche Presentation
│       ├── pages/
│       │   └── weather_page.dart          # Page principale
│       ├── widgets/
│       │   ├── search_bar_widget.dart     # Barre de recherche
│       │   ├── current_weather_widget.dart # Météo actuelle
│       │   └── forecast_widget.dart       # Prévisions
│       ├── theme/
│       │   └── app_theme.dart             # Thème
│       └── animations/
│
├── assets/                                # Ressources
│   ├── images/
│   └── icons/
│
├── pubspec.yaml                           # Dépendances
├── README.md                              # Ce fichier
├──
```

---

## Design System

### Palette de Couleurs

```
Primary Blue:   #4A90E2  ████  Couleur principale
Light Blue:     #5DADE2  ████  Accents
Dark Blue:      #2C3E50  ████  Textes importants
Accent Orange:  #F39C12  ████  Boutons, highlights
Success Green:  #27AE60  ████  Succès
Error Red:      #E74C3C  ████  Erreurs
```

### Gradients Adaptatifs

Les gradients changent automatiquement selon les conditions météo :

| Météo | Gradient |
|-------|----------|
| ☀️ **Ensoleillé** | Orange → Jaune |
| ☁️ **Nuageux** | Gris → Bleu |
| 🌧️ **Pluvieux** | Bleu foncé → Bleu |
| ❄️ **Neigeux** | Blanc → Bleu clair |

### Typographie

- **Police principale** : Poppins (Google Fonts)
- **Titres** : 24-32px, Bold
- **Corps de texte** : 14-18px, Regular
- **Petits textes** : 12px, Light

### Espacements Cohérents

- **Petits** : 8px
- **Standard** : 16px
- **Grands** : 24px
- **Extra-grands** : 32px

---

## Gestion des États

L'application utilise le pattern **Provider** avec 4 états distincts :

### 1. État Initial
```dart
WeatherStatus.initial
```
- Écran d'accueil
- Message d'invitation
- Icône animée avec effet shimmer

### 2. État Loading
```dart
WeatherStatus.loading
```
- Spinner de chargement
- Désactivation de la recherche
- Requêtes API en cours

### 3. État Success
```dart
WeatherStatus.success
```
- Affichage de la météo
- Prévisions sur 4 jours
- Animations progressives

### 4. État Error
```dart
WeatherStatus.error
```
- Message d'erreur contextuel
- Icône d'erreur
- Suggestion de solution

### Flux de Données

```
User Action
    ↓
Provider.searchWeather()
    ↓
_setLoading() → notifyListeners()
    ↓
UI shows Loading
    ↓
Repository.getCurrentWeather()
Repository.getForecast()
    ↓
_setSuccess() → notifyListeners()
    ↓
UI updates with data
```


---


## Liens Utiles

- [Documentation Flutter](https://flutter.dev/docs)
- [Provider Package](https://pub.dev/packages/provider)
- [OpenWeatherMap API](https://openweathermap.org/api)
- [Material Design](https://material.io/design)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)

---

