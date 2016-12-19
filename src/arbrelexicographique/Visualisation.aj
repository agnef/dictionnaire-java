package arbrelexicographique;

import java.awt.Container;
import java.util.Enumeration;

import javax.swing.JTree;
import javax.swing.tree.*;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Before;

public privileged aspect Visualisation {
	declare parents : ArbreLexicographique implements javax.swing.tree.TreeModel;
	declare parents : NoeudAbstrait implements javax.swing.tree.TreeNode;

	public DefaultTreeModel ArbreLexicographique.dtm;
	private DefaultMutableTreeNode NoeudAbstrait.dmtn;
	private JTree ArbreLexicographique.vue;

	public void ArbreLexicographique.setVue(javax.swing.JTree jt) {
		this.vue = jt;
	}

	// pointcuts et advices

	// ArbreLexicographique =>DefaultTreeModel
	pointcut creationArbre(ArbreLexicographique arbre) : target(arbre) && execution(ArbreLexicographique.new());

	after(ArbreLexicographique arbre): creationArbre(arbre){
		System.out.println("Pointcut crée arbre");
		arbre.dtm = new DefaultTreeModel(new DefaultMutableTreeNode("Noeud Parent"));
	}

	// ---------------------------------------------------------------------------------------------------------------------------------------------------------

	// pointcut ajoutMot(ArbreLexicographique arbre) : target(arbre) &&
	// execution(boolean ArbreLexicographique.ajout(String));
	//
	// after(ArbreLexicographique arbre): ajoutMot(arbre){
	// arbre.dtm.setRoot(arbre.entree.dmtn);
	// System.out.println("Pointcut ajout mot");
	//
	// }

	// ---------------------------------------------------------------------------------------------------------------------------------------------------------
	//
	// pointcut supprMot(ArbreLexicographique arbre) : target(arbre) &&
	// execution(boolean ArbreLexicographique.suppr(String));
	//
	// after(ArbreLexicographique arbre): supprMot(arbre){
	// System.out.println("Pointcut suppr mot");
	// arbre.dtm.setRoot(arbre.entree.dmtn);
	// // System.out.println(arbre.entree.toString());
	// }

	// Noeud =>TreeNode

	// CREATION------------------------------------------------------------------------------------------------------

	pointcut creationNoeudAbstrait(NoeudAbstrait noeudAbstrait) : target(noeudAbstrait) 
		&& execution(NoeudAbstrait.new(NoeudAbstrait));

	after(NoeudAbstrait noeudAbstrait): creationNoeudAbstrait(noeudAbstrait){
		System.out.println("creation noeudAbstrait ");
		noeudAbstrait.dmtn = new DefaultMutableTreeNode();

	}

	pointcut creationNoeud(Noeud noeud, NoeudAbstrait frere, NoeudAbstrait fils, char c) : target(noeud) 
		&& args(frere,fils,c) && execution(Noeud.new(NoeudAbstrait, NoeudAbstrait, char));

	after(Noeud noeud, NoeudAbstrait frere, NoeudAbstrait fils, char c): creationNoeud(noeud, frere, fils, c){
		System.out.println("creation nouveau noeud : " + c);
		noeud.dmtn = new DefaultMutableTreeNode(Character.toString(c));
		noeud.dmtn.add(fils.dmtn);
	}

	// AJOUT
	// ---------------------------------------------------------------------------------------------------------------------------------------------------------

	pointcut modifRacine(ArbreLexicographique arbre): this(arbre) && set(NoeudAbstrait ArbreLexicographique.entree);

	pointcut modifFrere(NoeudAbstrait noeud): target(noeud) && set(NoeudAbstrait NoeudAbstrait.frere);

	pointcut modifFils(Noeud noeud, NoeudAbstrait fils): this(noeud) && target(fils) && set(NoeudAbstrait Noeud.fils);

	// Chaque fois que la racine change lors de l'ajout :
	pointcut modifRacineAjout(ArbreLexicographique arbre) : target(arbre) && modifRacine(ArbreLexicographique)
		&& withincode(boolean ArbreLexicographique.ajout(String));

	after(ArbreLexicographique arbre) : modifRacineAjout(arbre){
		if (arbre.entree.dmtn != null) {
			System.out.println("modif racine ajout");
			((DefaultMutableTreeNode) arbre.dtm.getRoot()).insert(arbre.entree.dmtn, 0);
			((DefaultTreeModel) arbre.dtm).reload();
		}
	}

	// Chaque fois qu'un fils change lors de l'ajout
	pointcut modifFilsAjout(Noeud noeud) : target(noeud)
    	&& modifFils(Noeud,NoeudAbstrait) && withincode(NoeudAbstrait NoeudAbstrait.ajout(String));

	after(Noeud noeud) : modifFilsAjout(noeud){
		System.out.println("modif fils ajout : " + noeud.valeur);
		((MutableTreeNode) noeud.dmtn).insert(noeud.fils.dmtn, 0);
	}

	// Chaque fois qu'un frere change lors de l'ajout
	pointcut modifFrereAjout(NoeudAbstrait noeud) : target(noeud) && modifFrere(NoeudAbstrait) 
	&& withincode(NoeudAbstrait NoeudAbstrait.ajout(String));

	after(NoeudAbstrait noeud) : modifFrereAjout(noeud){
		System.out.println("modif frere ajout");
		if (noeud.getParent() != null) {
			((MutableTreeNode) noeud.dmtn.getParent()).insert(noeud.frere.dmtn, 0);
		}
	}

	// SUPPRESSION
	// ---------------------------------------------------------------------------------------------------------------------------------------------------------

	// Chaque fois que la racine change lors de la suppression
	pointcut modifRacineSuppr(ArbreLexicographique arbre) : this(arbre) && modifRacine(ArbreLexicographique) 
		&& withincode(boolean ArbreLexicographique.suppr(String));
	
	before(ArbreLexicographique arbre) : modifRacineSuppr(arbre){
		arbre.entree.dmtn.removeFromParent();
	}

	after(ArbreLexicographique arbre) : modifRacineSuppr(arbre){
		if (arbre.entree.dmtn != null) {
			System.out.println("modif racine suppr");
			((DefaultMutableTreeNode) arbre.dtm.getRoot()).insert(arbre.entree.dmtn, 0);
			((DefaultTreeModel) arbre.dtm).reload();
		}
	}

	// Chaque fois qu'un fils change lors de la suppression

	pointcut modifFilsSuppr(Noeud noeud) : this(noeud) &&  modifFils(Noeud,NoeudAbstrait) 
		&& withincode(NoeudAbstrait NoeudAbstrait.suppr(String));

	before(Noeud noeud) : modifFilsSuppr(noeud){
		System.out.println("modif fils suppr de ");
		if (noeud.fils != null) {
			noeud.dmtn.remove(noeud.fils.dmtn);
		}
	}

	after(Noeud noeud) : modifFilsSuppr(noeud){
		if (!(noeud.fils instanceof NoeudVide)) {
			noeud.dmtn.insert(noeud.fils.dmtn, 0);
		}
	}

	// Chaque fois qu'un frere change lors de la suppression
	pointcut modifFrereSuppr(NoeudAbstrait noeud) : target(noeud) && modifFrere(NoeudAbstrait) 
		&& withincode(NoeudAbstrait NoeudAbstrait.suppr(String));

	before(NoeudAbstrait noeud) : modifFrereSuppr(noeud){
		System.out.println("modif frere suppr de ");
		if (noeud.frere != null) {
			noeud.frere.dmtn.removeFromParent();
		}
	}

	after(NoeudAbstrait noeud) :  modifFrereSuppr(noeud){
		if (!(noeud.frere instanceof NoeudVide)) {
			((DefaultMutableTreeNode) noeud.getParent()).insert(noeud.frere.dmtn, 0);
		}
	}

	// TREE MODEL ------------------------------------------------------------

	public void ArbreLexicographique.

	addTreeModelListener(javax.swing.event.TreeModelListener l) {
		this.dtm.addTreeModelListener(l);
	}

	public Object ArbreLexicographique.

	getChild(Object parent, int index) {
		return this.dtm.getChild(parent, index);
	}

	public int ArbreLexicographique.

	getChildCount(Object parent) {
		return this.dtm.getChildCount(parent);
	}

	public int ArbreLexicographique.

	getIndexOfChild(Object parent, Object child) {
		return this.dtm.getIndexOfChild(parent, child);
	}

	public Object ArbreLexicographique.

	getRoot() {
		return this.dtm.getRoot();
	}

	public boolean ArbreLexicographique.

	isLeaf(Object node) {
		return this.dtm.isLeaf(node);
	}

	public void ArbreLexicographique.

	removeTreeModelListener(javax.swing.event.TreeModelListener l) {
		this.dtm.removeTreeModelListener(l);
	}

	public void ArbreLexicographique.

	valueForPathChanged(javax.swing.tree.TreePath path, Object newValue) {
		this.dtm.valueForPathChanged(path, newValue);
	}

	// TREE NODE ------------------------------------------------------------

	public Enumeration NoeudAbstrait.

	children() {
		return this.dmtn.children();
	}

	public boolean NoeudAbstrait.

	getAllowsChildren() {
		return this.dmtn.getAllowsChildren();
	}

	public TreeNode NoeudAbstrait.

	getChildAt(int childIndex) {
		return this.dmtn.getChildAt(childIndex);
	}

	public int NoeudAbstrait.

	getChildCount() {
		return this.dmtn.getChildCount();
	}

	public int NoeudAbstrait.

	getIndex(TreeNode node) {
		return this.dmtn.getIndex(node);
	}

	public TreeNode NoeudAbstrait.

	getParent() {
		return this.dmtn.getParent();
	}

	public boolean NoeudAbstrait.

	isLeaf() {
		return this.dmtn.isLeaf();
	}

	public void ArbreLexicographique.

	affiche(TreeNode entree) {
		System.out.println(entree.toString());

		for (int i = 0; i < entree.getChildCount(); i++) {
			affiche(entree.getChildAt(i));
		}
	}

	public static void main(String[] args) {
		ArbreLexicographique arbre = new ArbreLexicographique();
		// System.out.println(arbre.ajout("exemple"));
		arbre.ajout("aie");
		arbre.ajout("bla");
		// arbre.ajout("zou");
		// arbre.suppr("bla");
		// arbre.ajout("aie");
		// arbre.ajout("ai");
		// arbre.ajout("chat");
		// arbre.ajout("bla");

		if (arbre.entree.frere instanceof NoeudVide)
			System.out.println("l'entree n'a pas de frere");
		else if (arbre.entree.frere != null) {
			Noeud frere = ((Noeud) (Noeud) arbre.entree.frere);
			System.out.println("char du frere de l'entree : " + frere.valeur);
		}

		System.out.println("racine : " + arbre.dtm.getRoot());

		System.out.println("char entree : " + arbre.entree.dmtn.toString());

		arbre.affiche(arbre.entree.dmtn);

		// System.out.println(arbre.ajout("exemple"));
		// arbre.suppr("aie");
		System.out.println("-------------");
		// arbre.affiche(arbre.entree.dmtn);
		;

		// System.out.println(arbre);
		// System.out.println(arbre.suppr("absent"));
		// System.out.println(arbre.suppr("personne"));
		// System.out.println(arbre.suppr("personne"));
		// System.out.println(arbre);
		// System.out.println(arbre.contient("mot"));
		// System.out.println(arbre.contient("dernier"));
		// System.out.println(arbre.prefixe("der"));
		// System.out.println(arbre.prefixe("exa"));
		// System.out.println(arbre.nbMots());
	}
}
