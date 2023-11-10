# INSTALLATION DE JAVAFX AVEC NETBEANS SOUS LINUX (NOVEMBRE 2023)

Les manipulations qui vont suivre ont été pratiquées sous une distribution `Kali linux purple` qui est une distribution basée sur `debian`.
Lorsque ces manipulations étaient pratiquées, **debian** était à la **version 12**. Pendant ce même moment, la version de java qui était installée par défaut sur les distributions susmentionnées était la version 17 vérifiable en se déplaçant dans le dossier des librairies du système d'exploitation: `cd /usr/lib/jvm`.

**NB** : Pour la suite, veuillez remplacer le terme `UserName` par votre nom d'utilisateur.

Assurez-vous d'avoir téléchargé les fichiers zippés de JavaFX sur les sites officiels.
Pour notre part, le site [https://www.openjfx.io](https://www.openjfx.io) a servi de canal de téléchargement des fichiers de javaFX.
La version 21 de JavaFX a été préférée car étant la dernière LTS en cours même si la version 17 était aussi disponible.

## JavaFX 21 de Openjfx 
- Sur le site [https://www.openjfx.io](https://www.openjfx.io), téléchargez selon votre distribution ou système d'exploitation les équivalents des fichiers suivants : 
	- openjfx-21.0.1_linux-x64_bin-sdk.zip
	- openjfx-21.0.1_linux-x64_bin-jmods.zip
	- openjfx-21.0.1-javadoc.zip

- Décrompressez les fichiers à l'endroit que vous désirez sauf celui de la javadoc. On aura : 
	- /home/UserName/javafx-sdk-21.0.1
	- /home/UserName/javafx-jmods-21.0.1

- Pour bien faire les choses, nous créeons un dossier `javafx21` dans lequel nous déposons les fichiers extraits:
	- mkdir javafx21
	- mv javafx-sdk-21.0.1 javafx21
	- mv javafx-jmods-21.0.1 javafx21

- [OPTIONNEL] Rénommons le dossier `javafx21/javafx-sdk-21.0.1` comme suit :
	- cd javafx21
	- mv javafx21/javafx-sdk-21.0.1 javafx21/sdk
- [OPTIONNEL] Rénommons le dossier `javafx21/javafx-jmods-21.0.1` comme suit :
	- étant déjà à l'intérieur du dossier javafx21, faire
	- mv javafx21/javafx-jmods-21.0.1 javafx21/jmods

```markdown
**ATTENTION** : il faut supprimer le fichier `src.zip` du dossier `javafx21/sdk` après les manipulations. Mais, ne jamais supprimer aucun des fichiers `.so` du dossier `javafx21/sdk/lib` sinon des erreurs surgiront et le code ne s'exécutera jamais !
```
- Créez la variable d'environnement `JAVA_HOME` et l'ajouter au PATH.

```bash
# JAVA HOME or Java Platform ---> java is always located at the "/usr/lib/jvm" path
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH
```

## Étape des configurations à opérer dans NETBEANS 19

Cette étape est très cruciale pour le bon fonctionnement des choses. Y accorder une attention particulière est donc très récommandée.

Cette étape est ssentiellement basée sur la configuration pour *projets non-modulaires* du site [https://openjfx.io/openjfx-docs/](https://openjfx.io/openjfx-docs/) avec quelques modifications apportées pour que cela fonctionne chez nous.

Supposons que pour certaines raisons de facilitation dans le suivi des instructions des aides l'interface de NetBeans est en Anglais. C'est le cas chez nous en tous cas.

- Ouvrez `NetBeans 19` puis créez un `new global Library` sous `Tools -> Libraries -> New Librar`y . Nommez-le
`JavaFX21` et ajouter les jars du dossier `javafx21/sdk/lib`.

```
NB: On espère que le fichier src.zip a été supprimé sinon une erreur exception apparaîtra pendant l'exécution du projet.

```

1. Créer un projet JavaFX avec NetBeans 19

**Attention :** N'essayez surtout pas de créer un projet JavaFX mais plutôt créez un projet normal `Java with Ant -> Java Application`.

Une fois le projet créé, faites un clic droit sur lui et dans la fenêtre qui apparaît, cliquez sur `Properties` pour faire les configurations nécessaires pour permettre l'intégration de JavaFX dans les fichiers du projet pour que tout fonctionne parfaitement.

2. Vérifiez la JDK utilisée dans Netbeans

S'assurer que Netbeans utilise bel et bien la JDK installée par défaut sur le système. 
Pour ce faire :
	- Allez dans `Properties -> Libraries -> Java Platform ` et faites les réglages nécessaires.

3. Ajoutez les jars de javaFX comme library dans le Classpath

- Allez dans `Properties -> Libraries -> Compile -> Classpath -> cliquez sur le signe + -> Add Library` et ajoutez les 
jars de JavaFX21 comme library.

- Allez dans `Properties -> Build -> Compile`  et dé-sélectionnez la case `Compile on Save option.` **Cette étape est très cruciale pour le bon fonctionnement du projet avec la librairy JavaFX.**

- Toujours dans `Properties -> Build -> Compile`, dé-sélectionnez la case `Run compilation in External VM.` **Cette étape est très cruciale pour le bon fonctionnement du projet avec la librairy JavaFX.**

- Cliquez sur `OK` pour confirmer les changements effectués pour ce projet. Cela doit être fait pour chaque projet qui devrait utiliser JavaFX pour que tout marche bien.

-  Allez dans `Properties -> Run -> VM Options` puis Ajoutez la library JavaFX21 en ajoutant la ligne suivante à la VM. 
**Cette étape est également très cruciale pour le bon fonctionnement du projet avec la librairy JavaFX.**

VM Options : 
```
--module-path /home/UserName/JavafxPath/JavaFX21/sdk/lib --add-modules javafx.controls,javafx.fxml,javafx.base,javafx.graphics,javafx.media,javafx.swing,javafx.web

```


# À NE SUTOUT PAS FAIRE CAR CELA NE FONCTIONNE PAS

```markdown
# Add this to your .zshrc file
export JAVA_HOME=/path/to/your/java/home
export PATH=$JAVA_HOME/bin:$PATH
export JAVAFX21_PATH=/home/UserName/JavafxPath/JavaFX21

# Add these lines to fix the permission issues
chmod -R +rx ~/JavafxPath/JavaFX21

**VM Options :**

--module-path ${JAVAFX21_PATH}/sdk/lib --add-modules javafx.controls,javafx.fxml,javafx.base,javafx.graphics,javafx.media,javafx.swing,javafx.web

```

**NB** : Pour les `VM Options`, il faut toujours spécifier le chemin complet sans passer par les variables d'environnement créées.
