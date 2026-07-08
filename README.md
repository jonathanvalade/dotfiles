# 💻 Dotfiles Hybrides (nix-darwin + GNU Stow)

Ce dépôt Git contient ma configuration système et utilisateur pour macOS. Il utilise une approche **hybride** moderne :
*   **[nix-darwin](https://github.com/LnL7/nix-darwin)** pour la configuration système déclarative, la gestion des paquets, les préférences macOS et Homebrew.
*   **[GNU Stow](https://www.gnu.org/software/stow/)** pour lier de manière modulaire mes fichiers de configuration utilisateur (`dotfiles`) de façon propre et isolée dans le dossier Home.

---

## 🚀 Guide de démarrage rapide (Bootstrapping)

### 1. Prérequis : Installer Nix (Determinate Systems)

Utilisez l'installateur officiel [Determinate Nix](https://github.com/DeterminateSystems/nix-installer#install-determinate-nix), plus robuste et mieux adapté à macOS.

Pour télécharger facilement l'installateur graphique macOS, utilisez aussi la page produits officielle :
[Determinate Systems Products](https://docs.determinate.systems/#products)


### 2. Vérifier Git

Avant de cloner le dépôt, vérifiez que Git est disponible :

```bash
git --version
```

Si macOS propose d'installer les **Command Line Tools**, acceptez l'installation, puis relancez la commande.

---

### 3. Cloner ce dépôt

Clonez ce dépôt directement dans votre dossier utilisateur sous le nom `dotfiles` :

```bash
git clone https://github.com/jonathanvalade/dotfiles.git ~/dotfiles
```

> [!IMPORTANT]
> Si vous clonez le dépôt dans un autre chemin que `~/dotfiles`, vous devrez ajuster les chemins sources dans `nix-darwin/modules/stow.nix` et dans les alias de votre `.zshrc`.

---

### 4. Ajuster le nom d'utilisateur

Ouvrez le fichier `nix-darwin/default.nix` et modifiez la variable `username` en haut du fichier pour correspondre à votre nom d'utilisateur macOS réel.

---

### 5. Premier déploiement de nix-darwin

> [!IMPORTANT]
> **nix-darwin n'est pas encore installé à cette étape.** C'est pourquoi on utilise `nix run` pour le bootstrapper — cette commande télécharge et exécute `nix-darwin` directement depuis le flake sans installation préalable.

Exécutez la commande suivante depuis n'importe quel répertoire :

```bash
nix run nix-darwin -- switch --flake ~/dotfiles/nix-darwin#jos-macbook-pro
```

> [!NOTE]
> *   **Conflits de fichiers** : Lors du premier lancement, `nix-darwin` détectera que certains fichiers système existants (comme `/etc/zshrc` ou `/etc/nix/nix.conf`) sont déjà présents et proposera de les sauvegarder automatiquement (ex: `zshrc.before-nix-darwin`). Répondez **`y` (yes)** à toutes les invites et saisissez votre mot de passe administrateur macOS si demandé.
> *   Cette commande installera automatiquement le binaire Homebrew (via le module `nix-homebrew`), puis installera vos casks/brews (comme AeroSpace et `gh`), et déploiera vos liens symboliques utilisateur avec Stow.
> *   La première exécution peut prendre **plusieurs minutes** selon votre connexion internet (téléchargement des dépendances Nix).

---

## 🛠️ Maintenance & Mises à jour

Après le premier déploiement, Zsh sera configuré avec des alias pratiques. Pour mettre à jour votre système après avoir modifié un fichier dans `~/dotfiles/nix-darwin/`, lancez simplement :

```bash
update-mac
```

Cette commande exécute sous le capot :
```bash
darwin-rebuild switch --flake ~/dotfiles/nix-darwin#jos-macbook-pro
```

> [!TIP]
> Contrairement au premier déploiement (qui utilise `nix run nix-darwin`), les mises à jour suivantes utilisent directement le binaire `darwin-rebuild` installé par nix-darwin lors du bootstrapping.

---

## 🧩 Détail du fonctionnement Stow

Le module `nix-darwin` intègre un script de post-activation qui exécute automatiquement `stow` à chaque reconstruction du système.

Il applique automatiquement tous les dossiers présents dans `~/dotfiles/stow/` :

```bash
cd ~/dotfiles/stow

for app in *; do
  if [ -d "$app" ]; then
    stow --no-folding -R -d ~/dotfiles/stow -t ~ "$app"
  fi
done
```

- `-R` : Recrée les liens symboliques (pratique pour appliquer les modifications).
- `-d` : Spécifie le répertoire source contenant les paquets dotfiles (`~/dotfiles/stow`).
- `-t` : Spécifie la cible pour les liens symboliques (votre dossier Home `~`).
- `--no-folding` : Force Stow à créer des dossiers réels comme `~/.config`, au lieu de les remplacer par un seul lien symbolique.
