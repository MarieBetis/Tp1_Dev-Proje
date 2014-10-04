<%@page import="com.gcf.modele.Membre"%>
<%@page import="com.gcf.modele.Catalogue"%>
<%@page import="com.gcf.modele.Operation"%>
<%@page import="com.gcf.util.Connexion"%>
<%@page import="com.gcf.DAO.implement.PermissionDAO"%>
<%@page import="com.gcf.modele.Permission"%>
<%@page import="com.gcf.modele.Dossier"%>
<%@page import="com.gcf.modele.PointDiscussion"%>
<%@page import="java.util.List"%>
<%@page import="com.gcf.modele.Reunion"%>
<div>
    <h1>Information de la R�union</h1>
    <% 
    Reunion r=((Reunion)(request.getAttribute("reunion")));
    out.println("<table class=\"nostyle\"><tr><td>Titre de la r�union:</td><td>"+r.getTitre() +"</td></tr><tr><td>Date:</td><td>"+r.getDate() +"</td></tr><tr><td>Etat:</td><td>"+r.getEtat() +"</td></tr></table>");
    out.println("<hr />");
  
    %>
    <h1>Ordre du jour</h1>
    <%
    List<PointDiscussion> listePD=(List<PointDiscussion>)(request.getAttribute("listeOrdreDuJour"));
    if(listePD.isEmpty()){
      out.println("<p class=\"msg info\">Vous n'avez pas de point de discussion associ� � cet ordre du jour<p>");
    }
    else
    {
        out.println("<form method=\"POST\" action=\"ctrl.do\" >");
        out.println("<input type=\"hidden\" name=\"action\" value=\"consulterInfoReunion\" >");     
        out.println("<input type=\"hidden\" name=\"idReunion\" value="+r.getIdReunion()+" >");       
        out.println("<input type=\"hidden\" name=\"modifierODJ\" value=\"lol\" >");
        
        out.println("</form>");
        out.println("<table id=\"ordreDujour\" >");
        for(int i=0;i<listePD.size();i++)
        out.println("<tr class=\"t-center\"><td>Sujet:</td><td>"+listePD.get(i).getNom() +"</td><td>Type:</td><td>"+listePD.get(i).getType() +"</td><td>Dossier:</td><td>"+listePD.get(i).getIdDossier() +"</td></tr>");
        out.println("<input type=\"submit\" value=\"G�rer\">");
        out.println("</table>");
        
        
        }
    
    %>
   
   <form method="POST" action="ctrl.do">
   <input type="hidden" name="action" value="consulterInfoReunion" />
   <input type="hidden" name="ajoutPD" value="Mierda" />
   <input type="hidden" name="idReunion" value="<%=((Reunion)request.getAttribute("reunion")).getIdReunion() %>" />
   <% if(request.getAttribute("message")!=null){
       out.println("<p class=\""+(String)(request.getAttribute("typeMessage"))+"\">"+(String)(request.getAttribute("message"))+"</p>");
    }
   String idCatalogue=(((Catalogue)(request.getSession().getAttribute("catalogueCourant"))).getNumeroCat());
   String idCreateur=(((Membre)(request.getSession().getAttribute("connecte"))).getNumero());
   Permission perm = (new PermissionDAO(Connexion.getInstance())).read(idCatalogue, idCreateur);
       
   if (((perm.getValeurPermission()&Operation.creerPointDiscussion)==Operation.creerPointDiscussion)&&(!r.getEtat().equals("Ferme"))){
 %>
 
   <fieldset> 
   <legend>Ajouter un point de discussion:</legend>
   <table class="nostyle">
        <tr>
            <td style="width:150px;">Nom du point de discussion:</td>
            <td><input type="text" size="40" name="nomPD" class="input-text" /></td>
        </tr>
        <tr>
            <td style="width:150px;">Type:</td>
            <td><input type="text" size="40" name="typePD" class="input-text" /></td>
        </tr>
        <tr>
            <td style="width:150px;">Nom du dossier:</td>
            <td><select name="idDossier">
                <option value="-">-</option>
                    <% List<Dossier> listeDossier= (List<Dossier>)(request.getAttribute("listeDossier"));
                       for(int i=0;i<listeDossier.size();i++){
                       out.println("<option value="+listeDossier.get(i).getIdDossier() +" >"+listeDossier.get(i).getNom()+"</option>");
                       }   
                      %>   
                </select></td>
        </tr>
        <tr>
           
            <td><input type="submit" class="input-submit" value="Ajouter"/></td>
        </tr>
   </table>
    </fieldset> 
   </form>
 
   <%}%>
</div>
