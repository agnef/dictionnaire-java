package arbrelexicographique;

import java.awt.EventQueue;

import javax.swing.JFrame;
import java.awt.Color;
import javax.swing.JPanel;
import java.awt.BorderLayout;
import javax.swing.JToolBar;
import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JTextField;
import java.awt.FlowLayout;
import javax.swing.JTextPane;
import javax.swing.JSlider;
import javax.swing.JTree;
import javax.swing.JList;
import javax.swing.JMenu;
import javax.swing.JMenuItem;
import javax.swing.JTabbedPane;
import javax.swing.border.BevelBorder;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import javax.swing.JMenuBar;

import arbrelexicographique.ArbreLexicographique;
import javax.swing.JScrollPane;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.GridLayout;
import java.awt.SystemColor;

public class InterfaceGraphique {

	private JFrame frmTpArbreLexicographique;
	private JTextField textNbMots;
	private JTextField textFieldQuoi;
	static private ArbreLexicographique arbre;
	private JTextField reponse;
	

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {

		arbre = new ArbreLexicographique();

		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					InterfaceGraphique window = new InterfaceGraphique();
					window.frmTpArbreLexicographique.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the application.
	 */
	public InterfaceGraphique() {
		initialize();
	}
	
	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize() {
		frmTpArbreLexicographique = new JFrame();
		frmTpArbreLexicographique.getContentPane().setBackground(Color.PINK);

		JMenuBar menuBar = new JMenuBar();
		frmTpArbreLexicographique.getContentPane().add(menuBar, BorderLayout.NORTH);

		JMenu mnFichier = new JMenu("Fichier");
		menuBar.add(mnFichier);

		JMenuItem menuCharger = new JMenuItem("Charger un arbre");
		mnFichier.add(menuCharger);

		JMenuItem menuSauvegarder = new JMenuItem("Sauvegarder un arbre");
		mnFichier.add(menuSauvegarder);

		JMenuItem menuQuitter = new JMenuItem("Quitter");		
		mnFichier.add(menuQuitter);

		JMenu mnAide = new JMenu("Aide");
		menuBar.add(mnAide);

		JPanel fonctionnalites = new JPanel();
		frmTpArbreLexicographique.getContentPane().add(fonctionnalites, BorderLayout.CENTER);
		fonctionnalites.setLayout(new BorderLayout(0, 0));

		JToolBar methodes = new JToolBar();
		fonctionnalites.add(methodes, BorderLayout.NORTH);

		JButton btnAjouter = new JButton("Ajouter");
		methodes.add(btnAjouter);

		JButton btnSupprimer = new JButton("Supprimer");
		methodes.add(btnSupprimer);

		JButton btnChercher = new JButton("Chercher");
		methodes.add(btnChercher);

		JButton btnPrefixe = new JButton("Prefixe");
		btnPrefixe.setToolTipText("");
		methodes.add(btnPrefixe);

		JTextPane txtpnQuoi = new JTextPane();
		txtpnQuoi.setBackground(SystemColor.menu);
		txtpnQuoi.setEditable(false);
		txtpnQuoi.setText("Quoi ?");
		methodes.add(txtpnQuoi);

		textFieldQuoi = new JTextField();
		methodes.add(textFieldQuoi);
		textFieldQuoi.setColumns(10);

		JPanel panel = new JPanel();
		fonctionnalites.add(panel, BorderLayout.CENTER);
		panel.setLayout(new BorderLayout(0, 0));

		// ------------------------------------ARBRE ET LIST----------------------------------------
		JTabbedPane tabbedPane = new JTabbedPane(JTabbedPane.TOP);
		panel.add(tabbedPane, BorderLayout.CENTER);

		// ARBRE
		JTree tree = new JTree(arbre.dtm);
		arbre.setVue(tree);
		JScrollPane scrollPane = new JScrollPane(tree);
		tabbedPane.addTab("Arbre", null, scrollPane, null);

		// LIST
		final JTextPane list = new JTextPane();
		list.setEditable(false);
		JScrollPane scrollPane_1 = new JScrollPane(list);
		tabbedPane.addTab("List", null, scrollPane_1, null);

		tabbedPane.addChangeListener(new ChangeListener() {
			public void stateChanged(ChangeEvent e) {
				list.setText(arbre.toString());
			}
		});

		// -------------------------------------------------------------------------------------------------

		JPanel panelNbMots = new JPanel();
		frmTpArbreLexicographique.getContentPane().add(panelNbMots, BorderLayout.SOUTH);
		panelNbMots.setLayout(new GridLayout(0, 2, 0, 0));

		textNbMots = new JTextField();
		textNbMots.setBackground(new Color(240, 240, 240));
		panelNbMots.add(textNbMots);
		textNbMots.setColumns(10);
		textNbMots.setText("Nombre mots :" + arbre.nbMots());
		
		reponse = new JTextField();
		reponse.setBackground(SystemColor.menu);
		panelNbMots.add(reponse);
		reponse.setColumns(10);

		frmTpArbreLexicographique.setTitle("TP Arbre Lexicographique");
		frmTpArbreLexicographique.setBounds(100, 100, 450, 300);
		frmTpArbreLexicographique.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

		// --------------------------------------ACTIONS---------------------------------------------------------
		// Sauvegarder un arbre
		menuSauvegarder.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				System.out.println("sauvegarder");
				JFileChooser chooser = new JFileChooser();
			    int returnVal = chooser.showOpenDialog(frmTpArbreLexicographique);
			    if(returnVal == JFileChooser.APPROVE_OPTION) {
			    	 String path = chooser.getSelectedFile().getAbsolutePath();
			    	 try {
						arbre.sauve(path);
					} catch (Exception e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
			    }
			}
		});

		// Charger un arbre
		menuCharger.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				System.out.println("charger");
				JFileChooser chooser = new JFileChooser();
				int returnVal = chooser.showOpenDialog(frmTpArbreLexicographique);
				if(returnVal == JFileChooser.APPROVE_OPTION){
					String path = chooser.getSelectedFile().getAbsolutePath();
					try {
						arbre.charge(path);
					} catch (Exception e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
				}
			}
		});
		
		//Quitter
		menuQuitter.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				System.out.println("quitter");								
				frmTpArbreLexicographique.setVisible(false);	
				frmTpArbreLexicographique.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
			}
		});

		// Ajouter un mot
		btnAjouter.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if( arbre.ajout(textFieldQuoi.getText())){
					reponse.setText("Ajout réussi");
					list.setText(arbre.toString());
					textNbMots.setText("Nombre mots :" + arbre.nbMots());
				}
				else{
					reponse.setText("Ajout impossible");
				}
			}
		});

		// Supprimer un mot
		btnSupprimer.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if( arbre.suppr(textFieldQuoi.getText())){
					reponse.setText("Suppression réussie");
					list.setText(arbre.toString());
					textNbMots.setText("Nombre mots :" + arbre.nbMots());
				}
				else{
					reponse.setText("Suppression impossible");
				}
			}
		});
		
		
		// Chercher un mot
		btnChercher.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if( arbre.contient(textFieldQuoi.getText())){
					reponse.setText("Le mot "+textFieldQuoi.getText()+" est dans l'arbre");
				}
				else{
					reponse.setText("Le mot "+textFieldQuoi.getText()+" n'est pas dans l'arbre");
				}
			}
		});
		
		// Prefixe d'un mot
		btnPrefixe.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if( arbre.prefixe(textFieldQuoi.getText())){
					reponse.setText("Le mot "+textFieldQuoi.getText()+" est un prefixe");
				}
				else{
					reponse.setText("Le mot "+textFieldQuoi.getText()+" n'est pas un prefixe");
				}
			}
		});

		// ---------------------------------------------------------------------------------------------------

	}

	

}
