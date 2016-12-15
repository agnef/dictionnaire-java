package arbrelexicographique;

import java.io.*;
import java.nio.*;
import java.nio.file.Files;
import java.nio.file.Paths;

public aspect Serialisation {
	declare parents : ArbreLexicographique implements java.io.Serializable;

	void ArbreLexicographique.sauve(String nomFichier) throws IOException {
		String arbre = this.toString();
		FileWriter fw = new FileWriter(new File("/home/dcissm2/doreln/Bureau/ProjetJavaS3/" + nomFichier));
		for (int i = 0; i < arbre.length() - 1; i++) {
			if (arbre.charAt(i) == ' ') {
				fw.write("\n");
			}
			fw.write(arbre.charAt(i));
		}
		fw.close();
	}

	void ArbreLexicographique.charge(String nomFichier) throws IOException {
		String mot = "";
		int i;
		FileReader fr = new FileReader(new File("/home/dcissm2/doreln/Bureau/ProjetJavaS3/"+nomFichier              ));
		while ((i = fr.read()) != -1) {
			if ((char) i == '\n') {
				this.ajout(mot);
				mot = "";
			} else {
				mot = mot + (char) i;
			}
		}
		this.ajout(mot);
		fr.close();

	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ArbreLexicographique arbre = new ArbreLexicographique();
		ArbreLexicographique arbre1 = new ArbreLexicographique();
		arbre.ajout("personne");
		arbre.ajout("exo");
		arbre.ajout("ciao");
		 try {
		 arbre.sauve("mon petit arbre.txt");
		 } catch (Exception e) {
		 // TODO Auto-generated catch block
		 e.printStackTrace();
		 }
		try {
			arbre1.charge("mon petit arbre.txt");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(arbre1);
	}

}
