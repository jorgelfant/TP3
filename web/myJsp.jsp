<%--
  Created by IntelliJ IDEA.
  User: jorge.carrillo
  Date: 1/27/2020
  Time: 11:14 AM
  To change this template use File | Settings | File Templates.
--%>
<%--
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" %>
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%--
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                        JSTL xml : exercice d'application
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

La bibliothèque xml n'a maintenant plus de secrets pour vous. Mais si vous souhaitez vous familiariser avec toutes ces
nouvelles balises et être à l'aise lors du développement de pages JSP, vous devez vous entraîner !

Je vous propose ici un petit exercice d'application qui met en jeu des concepts réalisables à l'aide des balises que
vous venez de découvrir. Suivez le guide... ;)

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                           Les bases de l'exercise
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
On prend les mêmes et on recommence...

Pour mener à bien ce petit exercice, commencez par créer un nouveau projet nommé jstl_exo2. Configurez bien entendu
ce projet en y intégrant la JSTL, afin de pouvoir utiliser nos chères balises dans les pages JSP !

Une fois que c'est fait, créez pour commencer un document XML à la racine de votre projet, sous le répertoire WebContent.
Je vous en donne ici le contenu complet :

                                        On crée un fichier xml   myXml.xml

------------------------------------------------------------------------------------------------------------------------

Ne prêtez pas grande attention aux données modélisées par ce document. Nous avons simplement besoin d'une base simple,
contenant de quoi nous amuser un peu avec les balises que nous venons de découvrir !

Note : toute ressemblance avec des personnages existants ou ayant existé serait fortuite et indépendante de la volonté
de l'auteur... :-°

Votre mission maintenant, c'est d'écrire la page rapportInventaire.jsp se chargeant d'analyser ce document XML et de
générer un rapport qui :

       * listera chacun des livres présents ;

       * affichera un message d'alerte pour chaque livre dont le stock est en dessous de la quantité minimum spécifiée ;

       * listera enfin chacun des livres présents, regroupés par stocks triés du plus grand au plus faible.

Cette page devra également être placée à la racine du projet, sous le répertoire WebContent, et sera donc accessible
via l'URL http://localhost:8080/jstl_exo2/rapportInventaire.jsp.

Il y a plusieurs manières de réaliser ces tâches basiques, choisissez celle qui vous semble la plus simple et logique.
Prenez le temps de chercher et de réfléchir, et on se retrouve ensuite pour la correction !

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                 Correction
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Ne vous jetez pas sur la correction sans chercher par vous-mêmes : cet exercice n'aurait alors plus aucun intérêt.
Je ne vous donne ici pas d'aide supplémentaire. Si vous avez suivi le cours jusqu'ici vous devez être capables de
comprendre comment faire, les balises nécessaires pour cet exercice ressemblant fortement à celles utilisées dans celui
concernant la bibliothèque Core !

Voici donc une correction possible :
--%>


<%-- Récupération du document XML. --%>
<c:import url="myXml.xml" var="myXml"/>
<%-- Analyse du document XML récupéré. --%>
<x:parse var="doc" doc="${myXml}"/>

<p><b>Liste de tous les livres :</b></p>
<div>
    <ul>
        <%-- Parcours du document parsé pour y récupérer chaque nœud "livre". --%>
        <x:forEach var="livre" select="$doc/inventaire/livre">
            <%-- Affichage du titre du livre récupéré. --%>
            <li><x:out select="$livre/titre"/></li>
        </x:forEach>
    </ul>
</div>

<p><b>Liste des livres qu'il faut réapprovisionner :</b></p>
<div>
    <ul>
        <%-- Parcours du document parsé pour y récupérer chaque nœud "livre"
            dont le contenu du nœud "stock" est inférieur au contenu du nœud
            "minimum". --%>
        <x:forEach var="livre" select="$doc/inventaire/livre[stock < minimum]">
            <%-- Affichage des titres, stocks et minimaux du livre récupéré. --%>
            <li><x:out select="$livre/titre"/> : <x:out select="$livre/stock"/> livres en stock (limite avant alerte :
                <x:out select="$livre/minimum"/>)
            </li>
        </x:forEach>
    </ul>
</div>

<p><b>Liste des livres classés par stock :</b></p>
<%-- Il faut réfléchir... un peu ! --%>
<pre>
Le tri d'une liste, d'un tableau, d'une collection... bref de manière générale le tri de données,
ne doit pas se faire depuis votre page JSP ! Que ce soit en utilisant les API relatives aux collections,
ou via un bean de votre couche métier, ou que sais-je encore, il est toujours préférable que votre tri
soit effectué avant d'arriver à votre JSP. La JSP ne doit en principe que récupérer cette collection déjà triée,
formater les données pour une mise en page particulière si nécessaire, et seulement les afficher.

C'était un simple piège ici, j'espère que vous avez réfléchi avant de tenter d'implémenter un tri avec
la JSTL, et que vous comprenez pourquoi cela ne doit pas intervenir à ce niveau ;)
</pre>

<%--
Je n'ai fait intervenir ici que des traitements faciles, n'utilisant que des boucles et des expressions XPath.
J'aurais pu vous imposer l'utilisation de tests conditionnels, ou encore de variables de scope, mais l'objectif
est ici uniquement de vous permettre d'être à l'aise avec l'analyse d'un document XML. Si vous n'êtes pas parvenus
à réaliser ce simple traitement de document, vous devez identifier les points qui vous ont posé problème et revoir
le cours plus attentivement !

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                           Inclure automatiquement la JSTL Core à toutes vos JSP
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Vous le savez, pour pouvoir utiliser les balises de la bibliothèque Core dans vos pages JSP, il est nécessaire de
faire intervenir la directive include en tête de page :

                  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

Admettons-le : dans une application, rares seront les vues qui ne nécessiteront pas l'utilisation de balises issues de
la JSTL. Afin d'éviter d'avoir à dupliquer cette ligne dans l'intégralité de vos vues, il existe un moyen de rendre
cette inclusion automatique ! C'est dans le fichier web.xml que vous avez la possibilité de spécifier une telle
section :

                            <?xml version="1.0" encoding="UTF-8"?>
                            <web-app>
                            	<jsp-config>
                            		<jsp-property-group>
                            			<url-pattern>*.jsp</url-pattern>
                            			<include-prelude>/WEB-INF/taglibs.jsp</include-prelude>
                            		</jsp-property-group>
                            	</jsp-config>

                            	...

Le fonctionnement est très simple, la balise <jsp-property-group> ne contenant dans notre cas que deux balises :

  <url-pattern>,    qui permet comme vous vous en doutez de spécifier à quels fichiers appliquer l'inclusion automatique.
                    Ici, j'ai choisi de l'appliquer à tous les fichiers JSP de l'application !

  <include-prelude>, qui permet de préciser l'emplacement du fichier à inclure en tête de chacune des pages couvertes
                     par le pattern précédemment défini. Ici, j'ai nommé ce fichier taglibs.jsp .

  Il ne nous reste donc plus qu'à créer un fichier taglibs.jsp sous le répertoire /WEB-INF de notre application, et à
  y placer la directive taglib que nous souhaitons voir apparaître sur chacune de nos pages JSP :

  Redémarrez Tomcat pour que les modifications apportées au fichier web.xml soient prises en compte, et vous n'aurez
  dorénavant plus besoin de préciser la directive en haut de vos pages JSP : ce sera fait de manière transparente ! :)

------------------------------------------------------------------------------------------------------------------------
  Sachez par ailleurs que ce système est équivalent à une inclusion statique, en d'autres termes une directive
  include <%@ include file="/WEB-INF/taglibs.jsp" %> placée en tête de chaque JSP.
------------------------------------------------------------------------------------------------------------------------

  Nous n'en avons pas l'utilité ici, mais sachez qu'il est possible, avec ce même système, d'inclure automatiquement
  un fichier en fin de page : il faut pour cela préciser le fichier à inclure au sein d'une balise <include-coda>, et
  non plus <include-prelude> comme nous l'avons fait dans notre exemple. Le principe de fonctionnement reste identique,
  seul le nom de la balise diffère.

--%>
</body>
</html>
