# Guide: Integrating Database JAR Files in a Java Project

## Introduction

This guide provides step-by-step instructions for downloading and integrating JAR files for HSQLDB, H2, and SQLite databases into a Java project. Following these steps will help you manage external libraries effectively.

## Downloading JAR Files

### HSQLDB

- Locate the JAR file at `/home/YOUR-USERNAME/.m2/repository/org/hsqldb/hsqldb/VERSION/`.
  - For version "2.7.2", you will find: `hsqldb-2.7.2.jar` and `hsqldb-2.7.2-sources.jar`.

### H2

- Find the JAR file at `/home/YOUR-USERNAME/.m2/repository/com/h2database/h2/VERSION/`.
  - For version "2.2.224", you will find: `h2-2.2.224.jar` and `h2-2.2.224-sources.jar`.

### SQLite or SQLite3

- Access the JAR file at `/home/YOUR-USERNAME/.m2/repository/org/xerial/sqlite-jdbc/VERSION/`.
  - For version "3.36.0.3", you will find: `sqlite-3.36.0.3.jar` and `sqlite-3.36.0.3-sources.jar`.

## Renaming JAR Files

Before integrating the JAR files into your project, follow these steps:

1. **Copy or Move Files:**
   - Copy or move the JAR files to a designated directory, for example: `/home/YOUR-USERNAME/jars`.

2. **Rename JAR Files:**
   - Rename the JAR files by removing the version number:
     - `hsqldb-2.7.2.jar` and `hsqldb-2.7.2-sources.jar` → `hsqldb.jar` and `hsqldbsources.jar`
     - `h2-2.2.224.jar` and `h2-2.2.224-sources.jar` → `h2.jar` and `h2sources.jar`
     - `sqlite-3.36.0.3.jar` and `sqlite-3.36.0.3-sources.jar` → `sqlite.jar` and `sqlitesources.jar`

## Integrating JAR Files in Your Project

1. **Open Your Code Editor:**
   - Launch your preferred code editor.

2. **Add JARs as External Libraries:**
   - Include the renamed JAR files (`hsqldb.jar`, `h2.jar`, `sqlite.jar`, etc.) as external libraries in your Java project.

## Conclusion

By following these steps, you have successfully downloaded, renamed, and integrated the necessary database JAR files into your Java project. This ensures smooth integration of HSQLDB, H2, and SQLite databases, enhancing your project's functionality.


[Get more details step-by-step clicking here](https://github.com/rootoor-dev/Debian-12-stuffs/blob/main/Guide:%20Integrating%20h2%20HSQLDB%20SQLite%20Database%20JAR%20Files%20in%20a%20Java%20Project.md)

