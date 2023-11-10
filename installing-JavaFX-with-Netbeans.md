# Installing JavaFX 17, 21 with net
# INSTALLATION OF JAVAFX WITH NETBEANS UNDER LINUX (NOVEMBER 2023)

The manipulations which follow were carried out under a distribution `Kali linux purple` which is a distribution based on `debian`.
When these manipulations were carried out, **debian** was at **version 12**. At the same time, the version of Java that was installed by default on the aforementioned distributions was version 17 which can be checked by moving to the libraries folder of the operating system: `cd /usr/lib/jvm`.

**NB**: For the rest, please replace the term `UserName` with your username.

Make sure you have downloaded the JavaFX zipped files from the official sites.
For our part, the site [https://www.openjfx.io](https://www.openjfx.io) served as a channel for downloading javaFX files.
JavaFX version 21 was preferred because it was the last LTS in progress even if version 17 was also available.

## JavaFX 21 from Openjfx
- On the site [https://www.openjfx.io](https://www.openjfx.io), download the equivalents of the following files depending on your distribution or operating system:
- openjfx-21.0.1_linux-x64_bin-sdk.zip
- openjfx-21.0.1_linux-x64_bin-jmods.zip
- openjfx-21.0.1-javadoc.zip

- Unzip the files to the location you want except the javadoc location. We will have :
- /home/UserName/javafx-sdk-21.0.1
- /home/UserName/javafx-jmods-21.0.1

- To do things well, we create a `javafx21` folder in which we drop the extracted files:
- mkdir javafx21
- mv javafx-sdk-21.0.1 javafx21
- mv javafx-jmods-21.0.1 javafx21

- [OPTIONAL] Let's rename the `javafx21/javafx-sdk-21.0.1` folder as follows:
- cd javafx21
- mv javafx21/javafx-sdk-21.0.1 javafx21/sdk
- [OPTIONAL] Let's rename the `javafx21/javafx-jmods-21.0.1` folder as follows:
- being already inside the javafx21 folder, do
- mv javafx21/javafx-jmods-21.0.1 javafx21/jmods

```markdown
**WARNING**: you must delete the `src.zip` file from the `javafx21/sdk` folder after the manipulations. But, never delete any of the `.so` files from the `javafx21/sdk/lib` folder otherwise errors will arise and the code will never run!
```
- Create the `JAVA_HOME` environment variable and add it to the PATH.

```bash
# JAVA HOME or Java Platform ---> java is always located at the "/usr/lib/jvm" path
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH
```

## Step of configurations to be carried out in NETBEANS 19

This step is very crucial for things to work properly. Paying particular attention to it is therefore highly recommended.

This step is essentially based on the configuration for *non-modular projects* of the site [https://openjfx.io/openjfx-docs/](https://openjfx.io/openjfx-docs/) with some modifications made to that it works for us.

Suppose that for certain reasons of facilitation in following the instructions of the helpers the NetBeans interface is in English. This is the case with us anyway.

- Open `NetBeans 19` then create a `new global Library` under `Tools -> Libraries -> New Librar`y. Name it
`JavaFX21` and add the jars from the `javafx21/sdk/lib` folder.

```
NB: We hope that the src.zip file has been deleted otherwise an exception error will appear during project execution.

```

1. Create a JavaFX project with NetBeans 19

**Attention:** Do not try to create a JavaFX project but rather create a normal `Java with Ant -> Java Application` project.

Once the project is created, right-click on it and in the window that appears, click on `Properties` to make the necessary configurations to allow the integration of JavaFX into the project files so that everything works perfectly.

2. Check the JDK used in Netbeans

Ensure that Netbeans is indeed using the JDK installed by default on the system.
To do this :
- Go to `Properties -> Libraries -> Java Platform` and make the necessary settings.

3. Add the javaFX jars as library in the Classpath

- Go to `Properties -> Libraries -> Compile -> Classpath -> click on the + sign -> Add Library` and add them
jars from JavaFX21 like library.

- Go to `Properties -> Build -> Compile` and deselect the `Compile on Save option.` **This step is very crucial for the proper functioning of the project with the JavaFX library.**

- Still in `Properties -> Build -> Compile`, deselect the `Run compilation in External VM.` box. **This step is very crucial for the proper functioning of the project with the JavaFX library.**

- Click `OK` to confirm the changes made for this project. This needs to be done for every project that should use JavaFX for everything to work well.

- Go to `Properties -> Run -> VM Options` then Add the JavaFX21 library by adding the following line to the VM.
**This step is also very crucial for the proper functioning of the project with the JavaFX library.**

VM Options:
```
--module-path /home/UserName/JavafxPath/JavaFX21/sdk/lib --add-modules javafx.controls,javafx.fxml,javafx.base,javafx.graphics,javafx.media,javafx.swing,javafx.web

```


# DON'T DO BECAUSE IT DOES NOT WORK

```markdown
# Add this to your .zshrc file
export JAVA_HOME=/path/to/your/java/home
export PATH=$JAVA_HOME/bin:$PATH
export JAVAFX21_PATH=/home/UserName/JavafxPath/JavaFX21

# Add these lines to fix the permission issues
chmod -R +rx ~/JavafxPath/JavaFX21

**VM Options:**

--module-path ${JAVAFX21_PATH}/sdk/lib --add-modules javafx.controls,javafx.fxml,javafx.base,javafx.graphics,javafx.media,javafx.swing,javafx.web

```

**NB**: For `VM Options`, you must always specify the full path without going through the environment variables created.
