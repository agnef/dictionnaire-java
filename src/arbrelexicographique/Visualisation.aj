package arbrelexicographique;

import java.util.Enumeration;

import javax.swing.tree.TreeNode;


public aspect Visualisation {
	declare parents : ArbreLexicographique implements javax.swing.tree.TreeModel;
	declare parents : NoeudAbstrait implements javax.swing.tree.TreeNode;

	private javax.swing.tree.DefaultTreeModel ArbreLexicographique.dtm;
	private javax.swing.tree.DefaultMutableTreeNode NoeudAbstrait.dmtn;
	private javax.swing.JTree ArbreLexicographique.vue;
	
	public void ArbreLexicographique.setVue(javax.swing.JTree jt){
		this.vue = jt;
	}
	
// TREE MODEL
	
	public void ArbreLexicographique.addTreeModelListener(javax.swing.event.TreeModelListener l){
		this.dtm.addTreeModelListener(l);
	}
	
	public Object ArbreLexicographique.getChild(Object parent, int index){
		return this.dtm.getChild(parent,index);		
	}
	
	public int ArbreLexicographique.getChildCount(Object parent){
		return this.dtm.getChildCount(parent);
	}
	
	public int ArbreLexicographique.getIndexOfChild(Object parent, Object child){
		return this.dtm.getIndexOfChild(parent,child);
	}
	
	public Object ArbreLexicographique.getRoot(){
		return this.dtm.getRoot();
	}
	
	public boolean ArbreLexicographique.isLeaf(Object node){
		return this.dtm.isLeaf(node);
	}
	
	public void ArbreLexicographique.removeTreeModelListener(javax.swing.event.TreeModelListener l){
		this.dtm.removeTreeModelListener(l);
	}
	
	public void ArbreLexicographique.valueForPathChanged(javax.swing.tree.TreePath path, Object newValue){
		this.dtm.valueForPathChanged(path,newValue);
	}
	
//TREE NODE
	
	public Enumeration NoeudAbstrait.children(){
		return this.dmtn.children();		
	}
	
	public boolean NoeudAbstrait.getAllowsChildren(){
		return this.dmtn.getAllowsChildren();
	}
	
	public TreeNode NoeudAbstrait.getChildAt(int childIndex){
		return this.dmtn.getChildAt(childIndex);
	}
	
	public int NoeudAbstrait.getChildCount(){
		return this.dmtn.getChildCount();
	}
	
	public int NoeudAbstrait.getIndex(TreeNode node){
		return this.dmtn.getIndex(node);
	}
	
	public TreeNode NoeudAbstrait.getParent(){
		return this.dmtn.getParent();
	}

	public boolean NoeudAbstrait.isLeaf(){
		return this.dmtn.isLeaf();
	}
	
	
	public static void main(String[] args) {
		System.out.println("prout");

	}

}
