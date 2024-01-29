WORKS FINE WITH LIGHtWEIGHT DATABASES

private static final String JDBC_URL = "jdbc:sqlite:/home/your-username/Templates/db/sqlitedb.db";


# JDBC templates for databases

The JDBC URL syntax varies across different database systems, and there isn't a single global syntax that fits all databases. Each database system has its own conventions and features, and the JDBC URL is designed to accommodate these specifics.

However, there are some common patterns that you might find across different JDBC URLs:

```java

jdbc:<subprotocol>:<subname>
```
- `jdbc`: Indicates that JDBC is being used.
- `<subprotocol>`: The database-specific subprotocol, which defines how the JDBC driver connects to the database.
- `<subname>`: Database-specific information that is required by the JDBC driver to connect to the database, such as the host, port, database name, and additional parameters.

```
YOUR-DATABASE-ENGINE-NAME-HERE Database Engine Standalone : jdbc:«database-engine-name-here?»:file:«database/path?»
YOUR-DATABASE-ENGINE-NAME-HERE Database Engine In-Memory : jdbc:«database-engine-name-here?»:mem:«database/path?»
YOUR-DATABASE-ENGINE-NAME-HERE Database Engine Server : jdbc:«database-engine-name-here?»:«database-engine-name-here?»://localhost/«database/path?»
YOUR-DATABASE-ENGINE-NAME-HERE Database Engine WebServer : jdbc:«database-engine-name-here?»:http://«hostname/databasename?»
```

### For HSQLDB

```java
HSQLDB Database Engine Standalone : jdbc:hsqldb:file:«database/path?»
HSQLDB Database Engine In-Memory : jdbc:hsqldb:mem:«database/path?»
HSQLDB Database Engine Server : jdbc:hsqldb:hsql://localhost/«database/path?»
HSQLDB Database Engine WebServer : jdbc:hsqldb:http://«hostname/databasename?»
```


### For H2:

#### Standalone (File):
```java
// H2 Database Engine Standalone
String h2FileStandaloneURL = "jdbc:h2:file:/path/to/your/database";

// H2 Database Engine In-Memory
String h2MemURL = "jdbc:h2:mem:yourdatabase";

// H2 Database Engine Server
String h2ServerURL = "jdbc:h2:tcp://localhost/~/yourdatabase";

// H2 Database Engine WebServer
String h2WebServerURL = "jdbc:h2:http://localhost/yourdatabase";
```

### For SQLite:

#### Standalone (File):
```java
// SQLite Database Engine Standalone
String sqliteFileStandaloneURL = "jdbc:sqlite:/path/to/your/database";

// SQLite Database Engine In-Memory (SQLite does not support in-memory databases in the same way as H2)
String sqliteMemURL = "jdbc:sqlite::memory:";

// SQLite Database Engine Server (SQLite does not have a dedicated server mode like H2)
// Example: Use a shared file/database accessible by multiple clients
String sqliteServerURL = "jdbc:sqlite:/path/to/shared/database";

// SQLite Database Engine WebServer (SQLite does not have a dedicated web server mode)
// Example: Connect to a remote SQLite database using a server
String sqliteWebServerURL = "jdbc:sqlite:http://hostname/yourdatabase";
```

Note:
- SQLite has some differences compared to H2. It doesn't have a dedicated server mode or web server mode like H2.
- SQLite's "in-memory" database is a different concept compared to other databases. The `::memory:` URL creates an in-memory database, but it is not shared between different connections or processes.

Adjust these URLs based on your specific requirements and configurations. Ensure that you replace placeholders like `/path/to/your/database`, `yourdatabase`, `localhost`, etc., with your actual database details.

# Create a database file

filepath : jdbc:THE-DATABASE-ENGINE-USED:file:«database/path?»
Our database files are preferentially located at `/home/YOUR-USERNAME/Templates/db/`. You can adapt to your convenience.

- H2 : `jdbc:h2:file:/home/YOUR-USERNAME/Templates/db/h2testdb`
- HSQLDB : `jdbc:hsql:file:/home/YOUR-USERNAME/Templates/db/h2testdb`
- SQLite : `jdbc:sqlite:/home/YOUR-USERNAME/Templates/db/h2testdb`

```shell
# create the repersotry
mkdir /home/YOUR-USERNAME/Templates/db/ && cd /home/YOUR-USERNAME/Templates/db/
# create the database file named "mydatabase" or with extension suchas ".db", ".sqlite", etc.
touch mydatabase.db
# IMPORTANT STEP : give "read and write rights" to the created file of the database
chmod 775 mydatabase.db
```

## using sqlite3

```shell
# create the repersotry
mkdir /home/YOUR-USERNAME/Templates/db/ && cd /home/YOUR-USERNAME/Templates/db/
# create the database file named "mydatabase" or with extension suchas ".db", ".sqlite", etc.
touch mydatabase.db
# IMPORTANT STEP : give "read and write rights" to the created file of the database
chmod 775 mydatabase.db

# Open the database in console
sqlite3 mydatabase.db
```
The sqlite3 shell will be promted.

```
sqlite > 
```
You can type any sql code you want.

```sqlite3

sqlite> .help

sqlite > CREATE TABLE personne(id PRIMARY KEY AUTOINCREMENT, login VARCHAR(255), email VARCHAR(255));
sqlite > INSERT INTO personne(id, login, email) VALUES (1,'john doe','john-doe@example.com');

```

# Dtabase management using java

## Simple management stuffs

```java
package af.africa.me.main;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class Main {

    // JDBC URL, username, and password of HSQLDB server
    private static final String JDBC_URL = "jdbc:sqlite:/home/your-username/Templates/db/sqlitedb.db";
    private static final String USERNAME = "SA";
    private static final String PASSWORD = "";


    public static void main(String[] args) {
        try (Connection connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD)) {
            // Create the PERSON table if it doesn't exist
            createPersonTable(connection);

            // Insert data into PERSON table
            insertPersonData(connection, 3, "hnes", "hnes@example.com");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void createPersonTable(Connection connection) throws SQLException {
        String createTableSQL = "CREATE TABLE IF NOT EXISTS PERSON ("
                + "ID INT PRIMARY KEY,"
                + "LOGIN VARCHAR(50),"
                + "EMAIL VARCHAR(100)"
                + ")";

        try (Statement statement = connection.createStatement()) {
            statement.executeUpdate(createTableSQL);
        }
    }

    private static void insertPersonData(Connection connection, int id, String login, String email) throws SQLException {
        String insertSQL = "INSERT INTO PERSON (ID, LOGIN, EMAIL) VALUES (?, ?, ?)";

        try (PreparedStatement preparedStatement = connection.prepareStatement(insertSQL)) {
            preparedStatement.setInt(1, id);
            preparedStatement.setString(2, login);
            preparedStatement.setString(3, email);

            int rowsAffected = preparedStatement.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
        }
    }
}
```

## EclipseLink

**Create persistence.xml:**
   Create a `persistence.xml` file in the `META-INF` directory of your project. This file contains the configuration for the JPA persistence unit, including the database connection details.

### For MySQL Database:

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <persistence xmlns="http://xmlns.jcp.org/xml/ns/persistence"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/persistence http://xmlns.jcp.org/xml/ns/persistence/persistence_3_0.xsd"
                version="3.0">
       <persistence-unit name="yourPersistenceUnitName" transaction-type="RESOURCE_LOCAL">
           <class>your.package.YourEntityClass</class>
           <!-- Other entity classes go here -->
           <properties>
               <property name="jakarta.persistence.jdbc.url" value="jdbc:mysql://localhost:3306/yourdatabase"/>
               <property name="jakarta.persistence.jdbc.user" value="yourusername"/>
               <property name="jakarta.persistence.jdbc.password" value="yourpassword"/>
               <property name="jakarta.persistence.jdbc.driver" value="com.mysql.cj.jdbc.Driver"/>
               <property name="eclipselink.logging.level" value="INFO"/>
           </properties>
       </persistence-unit>
   </persistence>
   ```
Certainly! Below are modified examples for H2, HSQLDB, and SQLite databases. Please note that the JDBC URL, user, password, and driver class names are adjusted for each database.

### For H2 Database:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<persistence xmlns="http://xmlns.jcp.org/xml/ns/persistence"
             xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
             xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/persistence http://xmlns.jcp.org/xml/ns/persistence/persistence_3_0.xsd"
             version="3.0">
    <persistence-unit name="h2PersistenceUnit" transaction-type="RESOURCE_LOCAL">
        <class>your.package.YourEntityClass</class>
        <!-- Other entity classes go here -->
        <properties>
            <property name="jakarta.persistence.jdbc.url" value="jdbc:h2:mem:test"/>
            <property name="jakarta.persistence.jdbc.user" value="yourusername"/>
            <property name="jakarta.persistence.jdbc.password" value="yourpassword"/>
            <property name="jakarta.persistence.jdbc.driver" value="org.h2.Driver"/>
            <property name="eclipselink.logging.level" value="INFO"/>
        </properties>
    </persistence-unit>
</persistence>
```

### For HSQLDB Database:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<persistence xmlns="http://xmlns.jcp.org/xml/ns/persistence"
             xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
             xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/persistence http://xmlns.jcp.org/xml/ns/persistence/persistence_3_0.xsd"
             version="3.0">
    <persistence-unit name="hsqldbPersistenceUnit" transaction-type="RESOURCE_LOCAL">
        <class>your.package.YourEntityClass</class>
        <!-- Other entity classes go here -->
        <properties>
            <property name="jakarta.persistence.jdbc.url" value="jdbc:hsqldb:mem:test"/>
            <property name="jakarta.persistence.jdbc.user" value="yourusername"/>
            <property name="jakarta.persistence.jdbc.password" value="yourpassword"/>
            <property name="jakarta.persistence.jdbc.driver" value="org.hsqldb.jdbcDriver"/>
            <property name="eclipselink.logging.level" value="INFO"/>
        </properties>
    </persistence-unit>
</persistence>
```

### For SQLite Database:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<persistence xmlns="http://xmlns.jcp.org/xml/ns/persistence"
             xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
             xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/persistence http://xmlns.jcp.org/xml/ns/persistence/persistence_3_0.xsd"
             version="3.0">
    <persistence-unit name="sqlitePersistenceUnit" transaction-type="RESOURCE_LOCAL">
        <class>your.package.YourEntityClass</class>
        <!-- Other entity classes go here -->
        <properties>
            <property name="jakarta.persistence.jdbc.url" value="jdbc:sqlite:/path/to/your/database.db"/>
            <property name="jakarta.persistence.jdbc.driver" value="org.sqlite.JDBC"/>
            <property name="eclipselink.logging.level" value="INFO"/>
        </properties>
    </persistence-unit>
</persistence>
```

Remember to replace `your.package.YourEntityClass` with the actual package and entity class name you are using, and adjust the database connection details (URL, user, password) accordingly.
Adjust the `jakarta.persistence.jdbc.url`, `jakarta.persistence.jdbc.user`, `jakarta.persistence.jdbc.password`, and `jakarta.persistence.jdbc.driver` properties according to your database setup.

3. **Use EntityManager:**
   In your Java code, use `EntityManager` to interact with the database. Below is a simple example:

   ```java
   import jakarta.persistence.EntityManager;
   import jakarta.persistence.EntityManagerFactory;
   import jakarta.persistence.Persistence;

   public class Main {
       public static void main(String[] args) {
           EntityManagerFactory emf = Persistence.createEntityManagerFactory("yourPersistenceUnitName");
           EntityManager em = emf.createEntityManager();

           // Perform database operations using EntityManager

           em.close();
           emf.close();
       }
   }
   ```

   Replace `"yourPersistenceUnitName"` with the name you specified in your `persistence.xml`.

Remember to replace placeholders like `yourdatabase`, `yourusername`, `yourpassword`, `your.package.YourEntityClass` with your actual database details and entity class information.

Adjust the configuration based on your specific database (e.g., MySQL, PostgreSQL, etc.) and JPA provider requirements.

### Eclipse IDE and the database file

In Eclipse IDE, the location to put the `database.db` file depends on your project structure and how you want to manage your project resources. Here are a few common approaches:

1. **Project Root Directory:**
   Place the `database.db` file in the root directory of your Eclipse project. This is a simple and straightforward approach, especially if the database file is considered a project-level resource.

2. **src Directory:**
   Place the `database.db` file inside the `src` directory of your Eclipse project. This is suitable if the database file is closely related to your source code and resources.

3. **Resources or Data Directory:**
   Create a separate directory (e.g., `resources` or `data`) in your project, and place the `database.db` file there. This is a common practice to keep project resources organized.

4. **External Location:**
   If you want more control over the location and don't want the database file to be inside your project, you can place it in an external directory on your file system. Then, use an absolute path in the JDBC URL to reference the file.

For example, assuming you choose the "Resources or Data Directory" approach, your project structure might look like this:

```
YourProject/
|-- src/
|   |-- your/
|       |-- package/
|           |-- YourEntityClass.java
|-- resources/
|   |-- database.db
|-- META-INF/
|   |-- persistence.xml
```

or 

```
YourProject/
|-- src/
|   |-- main/
|       |-- java/
|       |   |-- your/
|       |       |-- package/
|       |           |-- YourEntityClass.java
|       |-- resources/
|           |-- database.db
|-- META-INF/
|   |-- persistence.xml
```

In your `persistence.xml`, you would set the JDBC URL accordingly:

```xml
<property name="jakarta.persistence.jdbc.url" value="jdbc:sqlite:./resources/database.db"/>
OR
<property name="jakarta.persistence.jdbc.url" value="jdbc:sqlite:./src/main/resources/database.db"/>

<property name="jakarta.persistence.jdbc.url" value="jdbc:h2:file:./resources/database.db"/>
OR
<property name="jakarta.persistence.jdbc.url" value="jdbc:h2:file:./src/main/resources/database.db"/>

<property name="jakarta.persistence.jdbc.url" value="jdbc:hsqldb:file:./resources/database.db"/>
OR
<property name="jakarta.persistence.jdbc.url" value="jdbc:hsqldb:file:./src/main/resources/database.db"/>
```

If you use an absolute path, it would look like:

```xml
<property name="jakarta.persistence.jdbc.url" value="jdbc:sqlite:/absolute/path/to/your/project/resources/database.db"/>
OR
<property name="jakarta.persistence.jdbc.url" value="jdbc:sqlite:/absolute/path/to/your/project/src/main/resources/database.db"/>
```

Ensure that the Eclipse IDE recognizes the folder structure. If you're using Maven or another build tool, the resources folder may be automatically recognized. If not, you may need to configure the build path or resource settings in Eclipse to include the appropriate folders.

Choose the approach that best fits your project structure and organization preferences.

```java
package af.africa.me.main;

import java.util.List;

import af.africa.me.entities.Person;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.Query;

public class Main {

	public static void main(String[] args) {
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("MyPU");
        EntityManager em = emf.createEntityManager();

        // Perform database operations using EntityManager
        try {
            // Create a new Person instance
            Person newPerson = new Person();
            newPerson.setLogin("asdia");
            newPerson.setEmail("asdia@example.com");

            // Begin a transaction
            em.getTransaction().begin();

            // Persist the new Person
            em.persist(newPerson);

            // Commit the transaction
            em.getTransaction().commit();
        } finally {
            // Close the EntityManager and EntityManagerFactory
            em.close();
//            emf.close();
        }

        // Now, perform the SELECT query
        EntityManager emSelect = emf.createEntityManager();
        try {
            emSelect.getTransaction().begin();

            // Perform SELECT * FROM Person
            Query query = emSelect.createQuery("SELECT p FROM Person p");
            List<Person> resultList = query.getResultList();

            // Display the results
            System.out.println("List of Persons:");
            for (Person person : resultList) {
                System.out.println("ID: " + person.getId() + ", Login: " + person.getLogin() + ", Email: " + person.getEmail());
            }

            // Commit the transaction
            emSelect.getTransaction().commit();
        } finally {
            // Close the EntityManager used for the SELECT query
            emSelect.close();
        }
        emf.close();
	}

}

```

# Server Mode of h2, hsqldb and sqlite3

In HSQLDB, when using the server mode (`jdbc:hsqldb:hsql://localhost/«database/path?»` or `jdbc:hsqldb:http://«hostname/databasename?»`), the database files are typically stored on the server side, not within your application's project structure.

Here's how you can set up the HSQLDB server and where to place the database files:

1. **HSQLDB Server Mode (`jdbc:hsqldb:hsql://localhost/«database/path?»`):**
   - When using the HSQLDB server mode, the database files are typically managed by the HSQLDB server itself.
   - You need to start an HSQLDB server, and it will handle the creation and management of the database files.
   - The server will create and manage the database files at the specified path or in-memory if a path is not specified.

2. **HSQLDB WebServer Mode (`jdbc:hsqldb:http://«hostname/databasename?»`):**
   - In the WebServer mode, the HSQLDB server is accessed via HTTP, and the database files are still managed on the server side.
   - The server will create and manage the database files at the specified path or in-memory if a path is not specified.

### Steps:

- **Start HSQLDB Server:**
  - If you are using the HSQLDB Server mode, you need to start the server separately.
  - You can use the HSQLDB Server jar and run it with the appropriate command. For example:
    ```bash
    java -cp hsqldb.jar org.hsqldb.server.Server --database.0 file:mydatabase --dbname.0 mydatabase
    ```
    Replace `hsqldb.jar` with the actual path to your HSQLDB Server jar, and adjust the `mydatabase` to your desired database name.

- **Configure Your JDBC URL:**
  - Use the appropriate JDBC URL in your `persistence.xml` or Java code.
  - If using HSQLDB Server mode:
    ```xml
    <property name="jakarta.persistence.jdbc.url" value="jdbc:hsqldb:hsql://localhost/«database/path?»"/>
    ```
  - If using HSQLDB WebServer mode:
    ```xml
    <property name="jakarta.persistence.jdbc.url" value="jdbc:hsqldb:http://«hostname/databasename?»"/>
    ```
  - The actual database files will be managed by the server.

- **Accessing the Database:**
  - Connect to the database using your application code or a database tool.
  - You don't need to manually place a `database.db` file in your project directory for HSQLDB Server or WebServer modes.

Make sure to consult the HSQLDB documentation for more details on server setup and configuration: [HSQLDB Server Setup](http://hsqldb.org/doc/2.0/guide/listeners-chapt.html).

For H2 and SQLite, the approach is a bit different than HSQLDB. Let's go through the specifics for each database:

### For H2 Database:

1. **H2 Embedded Database:**
   - When using H2 in embedded mode, you can specify the path to the database file, and it is typically placed within your project's structure.
   - You can choose a location based on your preference, such as the `src/main/resources` directory.

2. **H2 Server Mode:**
   - When using H2 in server mode, the database files are managed by the H2 Server. You don't need to manually place the database file in your project.

### Example for H2 (Embedded Mode):

Suppose you are using H2 in embedded mode, and you want to place the database file in the `src/main/resources` directory:

```java
// H2 Embedded Database URL
String h2Url = "jdbc:h2:./src/main/resources/mydatabase";

// Example JDBC properties
Properties h2Properties = new Properties();
h2Properties.setProperty("user", "yourusername");
h2Properties.setProperty("password", "yourpassword");

// Creating a connection
Connection h2Connection = DriverManager.getConnection(h2Url, h2Properties);
```

### For SQLite Database:

1. **SQLite Embedded Database:**
   - When using SQLite in embedded mode, you specify the path to the SQLite database file.
   - You can choose a location based on your preference, such as the `src/main/resources` directory.

2. **SQLite File Database:**
   - For SQLite, if you're working with a standalone database file, you specify the path to the SQLite database file.
   - You can choose a location based on your preference, such as the `src/main/resources` directory.


### Example for SQLite (Embedded Mode):

Suppose you are using SQLite in embedded mode, and you want to place the SQLite database file in the `src/main/resources` directory:

```java
// SQLite Embedded Database URL
String sqliteUrl = "jdbc:sqlite:./src/main/resources/mydatabase.db";

// Creating a connection
Connection sqliteConnection = DriverManager.getConnection(sqliteUrl);
```

For SQLite, you can use the `jdbc:sqlite:` prefix to specify the SQLite database file path.

Remember to replace `yourusername`, `yourpassword`, and `mydatabase` with your actual values. Adjust the paths based on your project structure and preferences.

For SQLite and H2 Server modes, the database files are typically managed by the server, and you don't need to manually place them in your project.
















