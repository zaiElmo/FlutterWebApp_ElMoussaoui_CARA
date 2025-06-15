# CARA - eine Webanwendung zur Verwaltung von Rezepten
## Inhaltsverzeichnis
1. [Installation und Start](#installation-und-start)
2. [Benutzeranleitung](#benutzeranleitung)
3. [Einleitung](#einleitung)
4. [Über CARA](#über-cara)
   1. [Anforderungen](#anforderungen)
   2. [Technologien](#technologien)
5. [Projektstruktur der Anwendung](#projektstruktur-der-anwendung)
   1. [Allgemeiner Aufbau](#allgemeiner-aufbau)
   2. [Frontend](#frontend)
   3. [Backend](#backend)
6. [Fazit und Reflexion](#fazit-und-reflexion)
   1. [Persönlicher Lernzuwachs](#persönlicher-lernzuwachs)
   2. [Ausblick](#ausblick) 

## Installation und Start
Für den Start der Anwendungen sind bestimmte Systemvoraussetzungen zu erfüllen. Da der Server mithilfe der [.NET 9 SDK](https://dotnet.microsoft.com/en-us/download/dotnet/9.0) 
und die Benutzoberfläche mit [Flutter 3.32.0](https://docs.flutter.dev/get-started/install/windows/web#use-vs-code-to-install-flutter) realisiert wurde, ist es Vorrausetzung diese zuvor zur installieren. 
Nach dem Herunterladen des Projekts erfolgt die Ausführung des Servers durch den Befehl `dotnet run` in dem Ordner *cara.api*. Der Start des Clients erfolgt über den Befehl `flutter run` im Verzeichnis *cara*.

## Benutzeranleitung
Startet man die Applikation, wird zunächst die Listenansicht angezeigt. Beim erstmaligen Start ist diese Liste leer. In der oberen rechten Ecke befinden sich zwei Schaltflächen: ein Plus-Button sowie ein Würfel-Button.

![image](https://github.com/user-attachments/assets/1ff11c03-0589-4b2a-a028-ea34d357c654)


Durch das Klicken auf das Plus-Symbol gelangt man zur Eingabemaske für neue Rezepte. Dort müssen der Name, eine Beschreibung sowie die Zubereitungsdauer verpflichtend angegeben werden, um ein Rezept speichern zu können. Optional besteht die Möglichkeit, ein Bild hinzuzufügen. Nach Abschluss der Eingabe wird das Rezept durch Betätigen der Schaltfläche „Speichern“ gesichert. 

![image](https://github.com/user-attachments/assets/e02fabd6-7e23-40ab-a202-7a6fc667d870)

Anschließend erfolgt eine automatische Rückleitung zur Startseite, auf der das neu angelegte Rezept nun in der Liste erscheint.

![image](https://github.com/user-attachments/assets/0e77024f-4533-4110-be43-5e705ba4065b)

Zudem kann man durch Klicken auf ein vorhandenes Listenelement oder den Würfel-Button zur Detailansicht gelangen. Der Würfel-Button dient hierbei einer besonderen Funktion: Er wählt per Zufall ein Rezept aus der Datenbank aus und zeigt dieses direkt in der Detailansicht an. In der Detailansicht werden sämtliche Informationen eines Rezepts vollständig dargestellt. Dort kann man zu dem ein Rezept mithilfe des Mülleimer-Buttons löschen oder mittels des Stift-Buttons editieren.

![image](https://github.com/user-attachments/assets/1ec6db15-18c2-47f3-a9f9-c650fdffe551)


## Einleitung 
Im Rahmen der Vorlesung „Projekt: Webentwicklung“ wurde die Konzeption und Umsetzung einer Webanwendung mit einem serverseitigen und einem clientseitigen Bestandteil als Ziel vorgegeben. 
Als thematischer Ausgangspunkt wurde das alltägliche Problem identifiziert, dass Rezepte oft unstrukturiert und verstreut aufbewahrt werden. In vielen Fällen befinden sie sich auf Papier, in sozialen Netzwerken, in Messenger-Verläufen oder in einfachen Notiz-Apps. Diese Vielfalt an Ablageorten erschwert nicht nur das Wiederfinden einzelner Rezepte, sondern macht auch eine systematische Verwaltung und Kategorisierung nicht möglich. Zur Lösung dieses Problems wurde eine zentrale Plattform zur strukturierten Verwaltung und Archivierung von Rezepten entwickelt. In den vorangegangenen Kapiteln lag der Fokus auf einem schnellen Überblick zur Nutzung der Anwendung. Insbesondere für die, die sich zunächst einen unmittelbaren Eindruck verschaffen möchten. Die folgenden Abschnitte widmen sich nun den konzeptionellen und technischen Grundlagen der App im Detail. Zunächst werden die Zielgruppe und Funktionalitäten von sowie Anforderungen an CARA erläutert. Anschließend folgt eine strukturierte Analyse des Projektaufbaus und der technologischen Umsetzung. Den Abschluss bilden eine Reflexion des Entwicklungsprozesses sowie ein Ausblick auf potenzielle Erweiterungen und künftige Verbesserungen.

## Über CARA
Die Anwendung CARA dient der zentralisierten Speicherung, Pflege und Anzeige von Kochrezepten und findet ihren Mehrwert also in der Organisation von Rezepten. Die Zielgruppe richtet sich an Nutzerinnen und Nutzer, die ihre Rezepte dauerhaft speichern, digital verwalten möchten und visuell ansprechend darstellen möchten.
Die implementierten Funktionen lassen sich zusammenfassend wie folgt beschreiben: Die Anwendung ermöglicht das Anlegen, Bearbeiten und Löschen von Rezepten, die Ergänzung eines Bildes zu jedem Eintrag sowie die strukturierte Darstellung der Rezepte in Form einer Listen- und Detailansicht. Mithilfe der Vorschlagsfunktion können Nutzerinnen und Nutzern sich auf einfache Weise einen Rezeptvorschlag erzeugen.

### Anforderungen
Die Anwendung wurde unter Berücksichtigung sowohl funktionaler als auch technischer Anforderungen entwickelt. Diese lassen sich in zwei zentrale Bereiche gliedern: die clientseitige Umsetzung (Frontend) sowie die serverseitige Logik (Backend).

Bei den Anforderungen an das Frontend der Anwendung stand vor allem die Benutzerfreundlichkeit im Vordergrund. Die Oberfläche sollte intuitiv bedienbar, responsiv und visuell ansprechend gestaltet sein. Darüber hinaus sollten Nutzerinnen und Nutzer in der Lage sein, neue Rezepte anzulegen, bestehende Einträge zu bearbeiten oder zu löschen. Ein weiteres zentrales Element bildet das Hochladen eines Bildes zu jedem Rezept. Die Darstellung der Rezepte sollte sowohl in Form einer kompakten Listenansicht als auch in einer ausführlicheren Detailansicht erfolgen. Ergänzend soll eine Zufallsfunktion integriert werden, die ein zufällig ausgewähltes Rezept vorschlägt.

Bei der serverseitigen Komponente stand die sichere und zuverlässige Verwaltung der Anwendungsdaten im Fokus. Dazu gehört das Speichern der Rezepte und der dazugehörigen Bilder zur Datenhaltung. Zudem müssten zur Kommunikation mit dem Frontend API-Schnittstellen bereitgestellt werden. Diese umfassen die CRUD-Operationen (Create, Read, Update, Delete) sowie die Zufallsfunktion. Ein weiterer Bestandteil des Backends ist die Dateiverwaltung. Dabei sollen vom Client hochgeladene Bilder auf dem Server gespeichert und bereitgestellt werden.

### Technologien

Das Frontend basiert auf Flutter in der Version 3.32. Flutter ist ein Open-Source Framework von Google und eignet sich insbesondere für die Entwicklung von Benutzeroberflächen. 

Die serverseitige Logik wurde mit ASP.NET Core und .NET 9 unter Verwendung einer Minimal API realisiert. Dieser Ansatz ermöglicht eine kompakte und übersichtliche Strukturierung der Endpunkte und eignet sich insbesondere für Anwendungen mit einem moderaten Funktionsumfang. In diesem Projekt dient die Minimal API zur Bereitstellung sämtlicher REST-konformer Schnittstellen, über die grundlegende CRUD-Operationen (Create, Read, Update, Delete) auf Rezeptdaten sowie eine zufällige Auswahl von Rezepten umgesetzt werden.

Die Datenhaltung erfolgt über eine SQLite-Datenbank, die mithilfe von Entity Framework Core angebunden ist. Durch die gewählte Code-First-Vorgehensweise lassen sich C#-Modelle direkt in die zugrunde liegende Datenstruktur überführen, was die Weiterentwicklung und Pflege der Datenbank vereinfacht. SQLite wurde als Datenbanklösung aufgrund ihrer einfachen Handhabung, der Möglichkeit zur lokalen Speicherung sowie der nahtlosen Integration in das .NET-Ökosystem gewählt. Zudem erfordert der Einsatz von SQLite keinen separaten Datenbankserver, was den Betrieb insbesondere in kleineren Projekten erleichtert.

Zur Unterstützung der Entwicklung wurden verschiedene Werkzeuge eingesetzt: Die Arbeit am Frontend erfolgte in der Entwicklungsumgebung Visual Studio Code, während für das Backend JetBrains Rider verwendet wurde. Darüber hinaus kam das Tool Scalar, ein API-Dokumentationstool, zum Einsatz, um die Schnittstellen zu testen.

## Projektstruktur der Anwendung
### Allgemeiner Aufbau
Die Anwendung ist in zwei logische Hauptteile untergliedert: das Frontend im Verzeichnis cara/ und das Backend im Verzeichnis cara.api/. Die Kommunikation zwischen Client und Server wird anhand der folgenden Abbildung beschrieben. 

![Kommunikation zwischen Client und Server](https://github.com/user-attachments/assets/2686d763-e21a-4752-a8bc-6aae8fa701e7)*Abb. 1 Kommunikation zwischen Client und Server*

Bei der Ausführung einer der bereitgestellten Funktionen – etwa einer der CRUD-Operationen (Create, Read, Update, Delete) oder der zufallsbasierten Rezeptauswahl – initiiert der Client eine HTTP-Anfrage an die serverseitige API. Diese Minimal-API verarbeitet die eingehende Anfrage, führt die entsprechende Logik aus und greift dabei, sofern erforderlich, auf die von Entity-Framework angebundene SQLite-Datenbank zu. Die verarbeiteten Ergebnisse werden anschließend in strukturierter Form an den Client zurückgesendet, wo sie in der Benutzeroberfläche dargestellt werden.

### Frontend
```
cara/
└── lib/
    ├── pages/            
    ├── services/         
    ├── model/           
    ├── constants/        
    └── main.dart        
          
         
```
*Ein Ausschnitt der Projektstruktur vom Frontend*

Die zentralen UI-Komponenten der Anwendung befinden sich in den Verzeichnissen `pages`. Jede funktionale Ansicht der App – beispielsweise das Erstellen eines Rezepts oder die Detailansicht – ist im Ordner `pages` in Form einzelner, logisch gekapselter Dateien organisiert. API-Aufrufe sind im Verzeichnis `services` ausgelagert, um die Trennung von Logik und Darstellung zu wahren. Die zentrale main.dart-Datei initialisiert das Routing und startet die Anwendung. In `constants` befinden sich zentrale Designwerte wie Farben, um eine einheitliche Gestaltung zu gewährleisten.

Im Verzeichnis `pages` befinden sich – wie bereits zuvor erläutert – die zentralen Ansichten der Anwendung. Diese Seiten bilden die verschiedenen Benutzeroberflächen und steuern die Navigation innerhalb der App. Konkret umfasst das Verzeichnis die folgenden Dateien: `listed_recipe_page.dart`, `recipe_page.dart`, `create_recipe_page.dart` und `update_recipe_page.dart`.

Die Datei `listed_recipe_page.dart` stellt die Startseite der Anwendung dar und dient als zentrales Navigations-Element. Von hier aus gelangt man über das Antippen eines Listenelements oder durch Klicken des Würfel-Symbols zur Detailansicht eines Rezepts in der `recipe_page.dart`. Zusätzlich führt ein Klick auf das Plus-Symbol auf der Startseite zur `create_recipe_page.dart`, auf der neue Rezepte angelegt werden können. Innerhalb der Detailansicht (`recipe_page.dart`) besteht über das Stift-Symbol die Möglichkeit, ein bestehendes Rezept zu bearbeiten; in diesem Fall wird zur `update_recipe_page.dart` weitergeleitet.

### Backend
```
cara.api/
├── wwwroot/
|   └── images/
├── CaraDbContext.cs
├── IRecipeService.cs
├── Program.cs
├── Recipe.cs
├── RecipeListEntry.cs
├── RecipeService.cs
└── Migrations/
```
*Ein Ausschnitt der Projektstruktur vom Backend*

Der Einstiegspunkt der Anwendung ist die Datei `Program.cs`. Dort wird die Minimal API initialisiert, die benötigten Dienste registriert und die Middleware-Pipeline definiert. Durch die Verwendung der Minimal-API-Architektur wird auf komplexere Strukturen wie Controller verzichtet, um eine kompakte und leicht verständliche Serverkomponente zu realisieren.

Die gesamte Datenverwaltung erfolgt auf Basis von Entity Framework Core in Kombination mit einer SQLite-Datenbank. Der zentrale Datenbankkontext ist in `CaraDbContext.cs` definiert und bildet die Brücke zwischen den C#-Modellen und der zugrunde liegenden Datenbank. Zur Abbildung der Rezeptdaten steht das Modell `Recipe.cs` bereit, das alle relevanten Eigenschaften eines Rezepts kapselt. Für performantere Darstellungen in Listenansichten wird ergänzend das Modell `RecipeListEntry.cs` verwendet, welches nur eine reduzierte Teilmenge der Rezeptinformationen enthält.

Die Geschäftslogik zur Verarbeitung von Rezeptdaten ist in der Service-Klasse `RecipeService.cs` implementiert. Diese kapselt die eigentlichen CRUD-Operationen sowie die Funktion zur zufälligen Rezeptauswahl. 
Ein weiterer Bestandteil des Backends ist die Datei- und Bildverwaltung. Im Verzeichnis `wwwroot/images` werden alle vom Client hochgeladenen Rezeptbilder gespeichert. Die Bereitstellung erfolgt über statische Dateipfade, was eine direkte Einbindung in die Benutzeroberfläche erlaubt. 

Schließlich enthält das Projekt ein Unterverzeichnis `Migrations`, welches die automatisch generierten Migrationsdateien von Entity Framework Core aufnimmt. Diese dienen der Nachverfolgbarkeit und Reproduzierbarkeit von Änderungen am Datenbankschema und ermöglichen es, den Datenbankzustand konsistent mit dem Code zu halten. Die Mígrations werden automatisch zum Start von CARA ausgeführt.

## Fazit und Reflexion

Mit CARA wurde ein funktionsfähiger Prototyp für eine Webanwendung zur digitalen Verwaltung von Rezepten entwickelt. Die Nutzerinnen und Nutzer können über eine benutzerfreundliche Oberfläche neue Rezepte anlegen, bestehende bearbeiten oder löschen und diese mit optionalen Bildern anreichern. Dabei werden zentrale CRUD-Funktionalitäten abgedeckt. Das Frontend basiert auf dem UI-Toolkit Flutter, wodurch eine moderne, reaktive Benutzeroberfläche realisiert wurde, die sich sowohl für Desktop- als auch mobile Webanwendungen eignet. Auf Serverseite kommt ASP.NET Core in Verbindung mit einer SQLite-Datenbank zum Einsatz. Die Kommunikation zwischen Frontend und Backend erfolgt über eine REST-konforme API, die mithilfe des Minimal-API-Ansatzes implementiert wurde.

Die Projektumsetzung hat gezeigt, dass sich diese Technologien – insbesondere Flutter und .NET – effizient miteinander kombinieren lassen und eine kompakte, modulare Lösung ermöglichen. Durch die Verwendung von Entity Framework Core im Code-First-Modus konnte das Datenbankschema direkt aus den C#-Modellen generiert und bei Bedarf migrationsbasiert angepasst werden. Diese Arbeitsweise hat sich als besonders vorteilhaft für Prototyping und schnelle Iterationen erwiesen.

Ursprünglich war das Ziel des Projekts nicht die Erstellung einer produktionsreifen Anwendung, sondern die Umsetzung einer funktional vollständigen Web-App mit exemplarischem Charakter. Im Laufe der praktischen Arbeit und begleitender Recherchen wurde jedoch zunehmend deutlich, welche Anforderungen über die bloße Funktionalität hinaus notwendig wären, um CARA in Richtung Produktivbetrieb weiterzuentwickeln. Dazu zählen unter anderem: eine klar geschichtete und wartbare Backend-Architektur nach dem Prinzip der Clean Architecture, ein expliziter Service-Layer zur Trennung von Geschäftslogik und Schnittstellen, Mechanismen zur sicheren Dateiverwaltung, Paging- und Caching-Funktionalitäten zur Verbesserung der Performance sowie erweiterte Nutzerfunktionen wie eine Rezeptsuche, Tagging, Favoritenverwaltung oder ein Bewertungssystem. Auch Authentifizierung und Autorisierung fehlen bislang vollständig, was ein zentrales Kriterium für den produktiven Einsatz darstellt.

### Persönlicher Lernzuwachs

Im Zuge des Projekts wurden fundierte Kenntnisse in der Webentwicklung aufgebaut und vertieft. Die erstmalige Arbeit mit Flutter ermöglichte ein besseres Verständnis für deklaratives UI-Design, responsives Layouting und den Umgang mit State-Management-Strategien. Auf Backend-Seite standen die Konzeption und Umsetzung einer REST-API mit ASP.NET Core sowie die Modellierung von Datenstrukturen mit Entity Framework Core im Vordergrund. Insbesondere die Schnittstellenkoordination zwischen Frontend und Backend stellte einen zentralen Lernfaktor dar, ebenso wie die Integration von Bilddateien, das Fehlerhandling und das Arbeiten mit relationalen Datenbanken im Code-First-Paradigma.

### Ausblick

Zukünftige Projektphasen sollten mit einem geschärften Anforderungsprofil beginnen, das gezielt auf die Entwicklung einer wartbaren, skalierbaren und sicher betriebenen Webanwendung ausgerichtet ist. Dazu gehört nicht nur die Umsetzung technischer Standards, sondern auch die frühzeitige Berücksichtigung von Themen wie Barrierefreiheit, Sicherheit, Nutzerfreundlichkeit sowie Testbarkeit und Deployment-Strategien.

"# zaiElmo-FlutterWebApp_ElMoussaoui_CARA" 
