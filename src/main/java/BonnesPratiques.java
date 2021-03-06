import org.joda.time.DateTime;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class BonnesPratiques extends HttpServlet {
    /*
    Eh bien comme je vous l'ai annoncé, une bonne pratique est de remplacer ces initialisations directes par des
    constantes, regroupées en tête de classe. Voici donc le code de notre servlet après modification :
    */

    public static final String ATT_MESSAGE = "test";
    public static final String ATT_BEAN = "coyote";
    public static final String ATT_LISTE = "liste";
    public static final String ATT_JOUR = "jour";
    public static final String VUE = "/WEB-INF/test.jsp";

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ServletException, IOException {

        /** Création et initialisation du message. */
        String message = "Message transmis de la servlet à la JSP.";

        /** Création du bean et initialisation de ses propriétés */
        CoyoteBean premierBean = new CoyoteBean();
        premierBean.setNom("Coyote");
        premierBean.setPrenom("Wile E.");

        /** Création de la liste et insertion de quatre éléments */
        List<Integer> premiereListe = new ArrayList<Integer>();
        premiereListe.add(27);
        premiereListe.add(12);
        premiereListe.add(138);
        premiereListe.add(6);

        /** On utilise ici la libraire Joda pour manipuler les dates, pour deux raisons :
         *    - c'est tellement plus simple et limpide que de travailler avec les objets Date ou Calendar !
         *    - c'est (probablement) un futur standard de l'API Java.
         */
        DateTime dt = new DateTime();
        Integer jourDuMois = dt.getDayOfMonth();

        /** Stockage du message, du bean et de la liste dans l'objet request */
        request.setAttribute(ATT_MESSAGE, message);
        request.setAttribute(ATT_BEAN, premierBean);
        request.setAttribute(ATT_LISTE, premiereListe);
        request.setAttribute(ATT_JOUR, jourDuMois);

        /** Transmission de la paire d'objets request/response à notre JSP */
        this.getServletContext().getRequestDispatcher(VUE).forward(request, response);
    }
}
/*

Vous visualisez bien ici l'intérêt d'une telle pratique : en début de code sont accessibles en un coup d’œil toutes
les données utilisées en dur au sein de la classe. Si vous nommez intelligemment vos constantes, vous pouvez alors,
sans avoir à parcourir le code, savoir quelle constante correspond à quelle donnée. Ici par exemple, j'ai préfixé les
noms des attributs de requête par "ATT_" et nommé "VUE" la constante contenant le chemin vers notre page JSP. Ainsi,
si vous procédez plus tard à une modification sur une de ces données, il vous suffira de modifier la valeur de la
constante correspondante et vous n'aurez pas besoin de parcourir votre code. C'est d'autant plus utile que votre
classe est volumineuse : plus long est votre code, plus pénible il sera d'y chercher les données initialisées en dur.


*/
