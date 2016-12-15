package arbrelexicographique;

import java.awt.EventQueue;

import javax.swing.JFrame;
import java.awt.Color;
import javax.swing.JPanel;
import java.awt.BorderLayout;
import javax.swing.JToolBar;
import javax.swing.JButton;
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
import javax.swing.JMenuBar;

public class InterfaceGraphique {

	private JFrame frmTpArbreLexicographique;
	private JTextField textNbMots;
	private JTextField textFieldQuoi;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
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
		txtpnQuoi.setEditable(false);
		txtpnQuoi.setText("Quoi ?");
		methodes.add(txtpnQuoi);
		
		textFieldQuoi = new JTextField();
		methodes.add(textFieldQuoi);
		textFieldQuoi.setColumns(10);
		
		JPanel panel = new JPanel();
		fonctionnalites.add(panel, BorderLayout.CENTER);
		panel.setLayout(new BorderLayout(0, 0));
		
		JTabbedPane tabbedPane = new JTabbedPane(JTabbedPane.TOP);
		panel.add(tabbedPane, BorderLayout.CENTER);
		
		JTree tree = new JTree();
		tabbedPane.addTab("Arbre", null, tree, null);
		
		JList list = new JList();
		tabbedPane.addTab("Liste", null, list, null);
		
		JPanel panelNbMots = new JPanel();
		FlowLayout flowLayout = (FlowLayout) panelNbMots.getLayout();
		flowLayout.setAlignment(FlowLayout.LEFT);
		frmTpArbreLexicographique.getContentPane().add(panelNbMots, BorderLayout.SOUTH);
		
		textNbMots = new JTextField();
		panelNbMots.add(textNbMots);
		textNbMots.setColumns(10);
		frmTpArbreLexicographique.setTitle("TP Arbre Lexicographique");
		frmTpArbreLexicographique.setBounds(100, 100, 450, 300);
		frmTpArbreLexicographique.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}

}
