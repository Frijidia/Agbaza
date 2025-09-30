# AGBAZA

## Présentation

AGBAZA est une application Flutter destinée à la gestion hospitalière et ministérielle. Elle propose des interfaces pour différents rôles (hôpital, ministre, etc.) et permet la gestion des produits, lits, sangs, et autres ressources médicales.

---

## Prérequis

- [Flutter](https://docs.flutter.dev/get-started/install) installé (version 3.x ou supérieure recommandée)
- [Dart](https://dart.dev/get-dart)
- Un éditeur de code (ex : VS Code)
- Android Studio ou Xcode pour les builds mobiles (optionnel)
- Google Chrome pour le web

---

## Installation

1. **Cloner le projet**
   ```sh
   git clone <url-du-repo>
   cd FRONTEND/Agbaza/frontend
   ```

2. **Installer les dépendances**
   ```sh
   flutter pub get
   ```

---

## Lancer le projet

### Version mobile (Android/iOS)
```sh
flutter run
```
Pour cibler Android :
```sh
flutter run -d android
```
Pour iOS :
```sh
flutter run -d ios
```

### Version web
```sh
flutter run -d chrome
```

---

## Générer le build web

```sh
flutter build web
```
Les fichiers générés sont dans `build/web/`.

Pour lancer localement le build web :
```sh
cd build/web
python3 -m http.server 8080
```
Accéder à : [http://localhost:8080](http://localhost:8080)

---

## Structure du projet

- **lib/** : Code source principal (Dart)
  - `main.dart` : Point d’entrée
  - `screens/` : Écrans de l’application
  - `routes/` : Gestion de la navigation
  - `widgets/` : Composants réutilisables
  - `theme/`, `utils/` : Styles et utilitaires
- **assets/** : Images, icônes, etc.
- **test/** : Tests unitaires et widgets
- **android/**, **ios/**, **web/**, **linux/**, **macos/**, **windows/** : Plateformes supportées

---

## Navigation et rôles

- Après connexion, l’utilisateur est redirigé vers le dashboard correspondant à son rôle :
  - Hôpital : `/hospital/dashboard`
  - Ministre : `/minister/dashboard`
- La navigation utilise le package [go_router](https://pub.dev/packages/go_router).

---

## Personnalisation

- Ajoutez vos images dans `assets/images/` et déclarez-les dans `pubspec.yaml`.
- Modifiez les écrans dans `lib/screens/`.
- Ajoutez des widgets réutilisables dans `lib/widgets/`.

---

## Tests

Pour lancer les tests :
```sh
flutter test
```

---

## Contribution

1. Forkez le projet
2. Créez une branche : `git checkout -b ma-feature`
3. Commitez vos modifications
4. Poussez la branche : `git push origin ma-feature`
5. Ouvrez une Pull Request

---

## Support

Pour toute question ou bug, ouvrez une issue sur le dépôt GitHub.

---