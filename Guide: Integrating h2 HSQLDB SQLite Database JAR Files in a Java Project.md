# Guide: Working with Java and Different Database Types
----------------------------------------------------------------------

**Guide: How to integrate h2, HSQLDB or SQLite Database JAR Files in a Java Project ?**

### Introduction

Java provides great flexibility when it comes to working with relational databases. This guide explains how to download and install the necessary drivers to work with different databases such as H2, HSQLDB, SQLite, or SQLite3.

#### Prerequisites

Make sure you have the following installed before proceeding:

* A Java development environment (IDE) such as Eclipse, IntelliJ IDEA, or NetBeans.
* Basic understanding of the Java language and its ecosystem.

### Step 1: Download Required Binaries

There are two main ways to download the necessary JAR files:

#### Option 1: Official Website

Official websites usually offer compressed archives containing the required JAR files. These files may have extensions like .zip, .tar.gz, or .rar.

Here's where to find download links for each targeted database:

| Database | Official Website | File Extension |
|---|---|---|
| H2 | <https://www.h2database.com/> | .jar |
| HSQLDB | <http://hsqldb.org/download.html> | .jar |
| SQLite/SQLite3 | <https://github.com/xerial/sqlite-jdbc/releases> | .jar |

Once you've downloaded the corresponding archive, extract it to obtain the desired JAR file.

#### Option 2: Dependency Managers (Maven / Gradle)

If you're already using a dependency manager like Maven or Gradle, you can easily include the necessary drivers directly in your project without manually searching for them.

For example, if using Maven, add the following dependencies to your pom.xml file:

| Database | Maven Dependency | Version |
|---|---|---|
| H2 | `<dependency><groupId>com.h2database</groupId><artifactId>h2</artifactId><version>2.2.224</version></dependency>` | 2.2.224 |
| HSQLDB | `<dependency><groupId>org.hsqldb</groupId><artifactId>hsqldb</artifactId><version>2.7.2</version></dependency>` | 2.7.2 |
| SQLite/SQLite3 | `<dependency><groupId>org.xerial</groupId><artifactId>sqlite-jdbc</artifactId><version>3.36.0.3</version></dependency>` | 3.36.0.3 |

Similarly, if using Gradle, add the following dependencies to your build.gradle file:

| Database | Gradle Dependency | Version |
|---|---|---|
| H2 | `implementation 'com.h2database:h2:2.2.224'` | 2.2.224 |
| HSQLDB | `implementation 'org.hsqldb:hsqldb:2.7.2'` | 2.7.2 |
| SQLite/SQLite3 | `implementation 'org.xerial:sqlite-jdbc:3.36.0.3'` | 3.36.0.3 |

After syncing your project, the JAR files will be automatically downloaded to the appropriate directory.

### Step 2: Install Binaries

Once you have the JAR files downloaded, you need to install them on your local machine. The procedure slightly differs based on the operating system.

#### UNIX Systems (Linux / macOS)

In common Linux distributions, JAR files downloaded via Maven are placed under the following path:

~/.m2/repository/\[group\]/\[artifact\]/[...]/

For example, for H2, the JAR file is located at:

~/.m2/repository/com/h2database/h2/2.2.224/h2-2.2.224.jar

Simply copy the JAR files to a directory of your choice, e.g., ~/jars/:

mkdir -p ~/jars && cp \
~/.m2/repository/com/h2database/h2/2.2.224/h2-2.2.224.jar \
~/jars/

Then, rename the JAR files to make them easier to use later. For example, let's rename the H2 JAR file to "h2.jar":

mv ~/jars/h2-2.2.224.jar ~/jars/h2.jar

#### Windows

The procedure is similar to UNIX systems. Copy and paste the JAR files to a directory of your choice, e.g., "%USERPROFILE%\jars\":

copy \
"%HOMEPATH%.m2\repository\com\h2database\h2\2.2.224\h2-2.2.224.jar" \
"%USERPROFILE%\jars\h2.jar"

Then, rename the JAR files to make them easier to use later. For example, let's rename the H2 JAR file to "h2.jar":

ren "%USERPROFILE%\jars\h2-2.2.224.jar" "%USERPROFILE%\jars\h2.jar"

### Step 3: Use Binaries in Your Java Project

Now that the JAR files have been downloaded and locally installed, you can use them in your Java project. Simply add the JAR files as external libraries in your preferred Java IDE.

For example, in Eclipse, follow these steps:

1. Select your Java project in the Package Explorer.
2. Go to the context menu and click on Properties.
3. Navigate to Java Build Path > Libraries > Add External JARs.
4. Browse to the directory containing the JAR files and select them.

Once done, your Java project is ready to use H2, HSQLDB, or SQLite databases. Refer to the respective documentation of each database to learn how to interact with it using Java.
