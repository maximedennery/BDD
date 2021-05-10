using System;
using MySql.Data.MySqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EssaisMaxime
{
    class Program
    {
        static void Main(string[] args)
        {
            #region Initialization
            MySqlConnection maConnexion = null;
            try
            {
                string connectionString = "SERVER=localhost;PORT=3306;DATABASE=VeloMax;UID=root;PASSWORD=root";
                maConnexion = new MySqlConnection(connectionString);
                maConnexion.Open();
            }
            catch (MySqlException e)
            {
                Console.WriteLine("Erreur de connexion : " + e.ToString());
                Console.ReadKey();
                return;
            }
            Console.WriteLine("Connecté !");
            #endregion

            //CreationByciclette(maConnexion, "VTT8", 130, 2080, 1);
            //CreationByciclette(maConnexion, "VTT8", 1340, 200, 1);
            //CreationByciclette(maConnexion, "VTT8", 130, 2500, 1);
            CreationByciclette(maConnexion, 2,"VTTew8", 130, 200, 2);
            //SupressionByciclette(maConnexion,1);
            //EditionByciclette(maConnexion, 8);
            Console.ReadKey();
        }
        /*
         RequeteSQL(maConnexion, "select * from location");

         string c = "UPDATE adresse " +
             "natural join personne " +
             "SET villeAdresse = \"Paris\" " +
             "WHERE idPersonne = 1";

         CommandeSQL(maConnexion, c);
         */
        static void RequeteSQL(MySqlConnection connexion, string requete)
        {
            MySqlCommand maCommande = new MySqlCommand(requete, connexion);
            MySqlDataReader lecteur = maCommande.ExecuteReader();

            while (lecteur.Read())
            {
                for (int i = 0; i < lecteur.FieldCount; i++)
                {
                    string data = "";
                    if (!lecteur.IsDBNull(i)) data = lecteur.GetString(i);
                    else data = "null";
                    Console.Write(data);
                    if (i != lecteur.FieldCount - 1) Console.Write(" ; ");
                    else Console.WriteLine();
                }
            }
            Console.WriteLine(lecteur.ToString());
        }
        #region Requete
        #endregion


        static void CommandeSQL(MySqlConnection cnn, string action)
        {
            var cmd = new MySqlCommand(action, cnn);
            cmd.ExecuteNonQuery();
            cmd.Dispose();
        }

        #region Commande
        static void CreationByciclette(MySqlConnection maConnexion, int id_byciclette, string nomByciclette, int grandeur, int prix_unitaire, int id_modèle)
        {
            string c = $"Insert into Byciclette (id_byciclette, nomByciclette, grandeur, prix_unitaire, id_modele) values (\"{id_byciclette}\"{nomByciclette}\", {grandeur}, {prix_unitaire}, {id_modèle})";
            CommandeSQL(maConnexion, c);
        }
        static void SupressionByciclette(MySqlConnection maConnexion, int id_byciclette)
        {
            string c = $"delete from Byciclette where id_byciclette={id_byciclette}";
            CommandeSQL(maConnexion, c);
        }
        static void EditionByciclette(MySqlConnection maConnexion, int id_byciclette)
        {
            Dictionary<int, string> dict = new Dictionary<int, string>
            {
            {1,"nomByciclette"},
            {2,"grandeur"},
            {3,"prix_unitaire"},
            {4,"id_modele" }
            };
            Console.WriteLine("Choisissez l'attribut à éditer : \n1 : nomByciclette\n2 : grandeur\n3 : prix_unitaire\n4 : id_modele");
            int choix = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("Entrer la nouvelle valeur");
            string modifications = Console.ReadLine();
            string c = $"UPDATE Byciclette SET {dict[choix]} = \"{modifications}\" WHERE id_byciclette = {id_byciclette}";
            CommandeSQL(maConnexion, c);
        }
        #endregion
    }
}
