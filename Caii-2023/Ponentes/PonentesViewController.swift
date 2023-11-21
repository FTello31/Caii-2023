//
//  ViewController.swift
//  CollectionViewDynamicSizing
//
//  Created by Shankar on 03/03/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import UIKit

class PonentesViewController: UIViewController {
    
    var filters = ["Conferencista","Moderador","Panelista","Expositor"]
    
    var ponentes: [PonentesData] = []
    //    var ponentes: [String] = []
    
    
    @IBOutlet weak var collectionViewFilter: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavbar()
        loadPonentes()
        configureTableView()
        setFirstFilterSelected()
    }
    
    func loadPonentes(){
        ponentes =  fetchData()
    }
    
    func configureTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }
    
    
    func setFirstFilterSelected(){
        let indexPath = self.collectionViewFilter.indexPathsForSelectedItems?.last ?? IndexPath(item: 0, section: 0)
        collectionViewFilter.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
        filterPonentes(category: filters[0])
    }
    
    
    func filterPonentes( category: String){
        loadPonentes()
        
        ponentes = ponentes.filter { ponente in
            return ponente.category == category
        }
        
        self.tableView.reloadData()
        
    }
    
    func fetchData() -> [PonentesData] {
        let data1 = PonentesData(name: "Bruno Dantas", id: 1, category: "Conferencista", description: String(localized: "Doctor y Magíster en Derecho por la Pontificia Universidad Católica de São Paulo (PUC-SP), con Post-Doctorado en la Universidad del Estado de Río de Janeiro (UERJ). Ministro del Tribunal Federal de Cuentas (TCU) y profesor titular en UNINOVE (São Paulo), con amplia experiencia como Consultor General del Senado Federal y Consejero del CNJ y del CNMP."), eventName: "Los esfuerzos de la ciencia contra la corrupción", placeLabel: "Naciones 1 - Piso 8", timeLabel: "09:45 AM", dateLabel: "27/11/23", image: "Bruno Dantas")
        let data2 = PonentesData(name: "Robert Klitgaard", id: 2, category: "Conferencista", description: String(localized: "Profesor en Claremont Graduate University, exdecano de Pardee RAND Graduate School, con experiencia en Harvard y Yale. Autor de 14 libros, incluyendo \"Tropical Gangsters,\" nombrado uno de los \"Libros del Siglo\" por el New York Times. Sus obras recientes incluyen \"Bold and Humble: How to Lead Public-Private-Citizen Partnerships\" y \"Policy Analysis for Big Questions: Addressing Corruption, Elitism, Inequality, and Desperation."), eventName: "El valor de los modelos económicos en un mundo de cultura, política y gestión: El caso de la corrupción", placeLabel: "Naciones 1 - Piso 8", timeLabel: "10:30 AM", dateLabel: "27/11/23", image: "Robert Klitgaard")

        let data3 = PonentesData(name: "Eduardo Salcedo-Albarán", id: 3, category: "Conferencista", description: String(localized: "Filósofo y fundador de Fundación Vortex, reconocido por combatir el crimen. Investigador y autor prolífico, ha dirigido proyectos y publicado sobre redes de crimen transnacional en diversos continentes, destacando en la lucha contra la corrupción."), eventName: "La Corrupción: “Redes, sobornos y otros males”", placeLabel: "Naciones 1 - Piso 8", timeLabel: "14:30", dateLabel: "27/11/23", image: "Eduardo Salcedo-Albaran")

        let data4 = PonentesData(name: "Roberto de Michele", id: 4, category: "Conferencista", description: String(localized: "Excoordinador del clúster de transparencia e integridad del BID, es secretario del Fondo de Transparencia, liderando proyectos en integridad pública, gobierno abierto y prevención del lavado de activos. Además, dirige la Infoguia de Transparencia Financiera del BID, ofreciendo recursos técnicos de alto nivel. Abogado por la Universidad de Buenos Aires con un LL.M. de la Facultad de Derecho de Yale."), eventName: "Una visión regional de los avances en la agenda de transparencia y anticorrupción", placeLabel: "Naciones 1 - Piso 8", timeLabel: "09:00 AM", dateLabel: "28/11/23", image: "Roberto-de-Michele")

        let data5 = PonentesData(name: "Gene L. Dodaro", id: 5, category: "Conferencista", description: String(localized: "Asumió como octavo Contralor General de los Estados Unidos y jefe de la Oficina de Responsabilidad Gubernamental en diciembre de 2010, confirmado por el Senado tras ser nominado por el presidente Obama en septiembre de 2010. Anteriormente, había ejercido como Contralor General Interino desde marzo de 2008."), eventName: "Innovación en la auditoría para la supervisión del gasto y contratación pública", placeLabel: "Naciones 1 - Piso 8", timeLabel: "09:15", dateLabel: "28/11/23", image: "Gene Dodaro")

        let data7 = PonentesData(name: "Alberto Vanucci", id: 2, category: "Expositor", description: String(localized: "Catedrático de Ciencias Políticas en la Universidad de Pisa, es autor de más de 170 publicaciones y director del Programa de Maestría en “Análisis, prevención y lucha contra la corrupción y el crimen organizado”. Además, es miembro del consejo de dirección de la ONG “Libera” y asesor de Transparencia International-Italia, contribuyendo a investigaciones sobre la politización de la corrupción y estrategias anticorrupción."), eventName: "El orden oculto de la corrupción", placeLabel: "Naciones 1 - Piso 8", timeLabel: "16:30", dateLabel: "27/11/23", image: "Alberto Vannucci")

        let data8 = PonentesData(name: "Issa Luna Pla", id: 3, category: "Expositor", description: String(localized: "Coordinadora del Área en Derecho de la Información del IIJ, con maestría en derechos humanos de la London School of Economics. Especializada en medios de comunicación, democracia, libertad de expresión e información. Miembro del Sistema Nacional de Investigadores del CONACYT."), eventName: "De película de terror a las instituciones públicas de la región: El escándalo de los trabajadores y empresas fantasmas", placeLabel: "Huallamarca - Piso 4", timeLabel: "16:30", dateLabel: "27/11/23", image: "Issa Luna Pla")

        let data9 = PonentesData(name: "Gastón Pierri", id: 4, category: "Expositor", description: String(localized: "Economista Especialista en la Oficina de Efectividad para el Desarrollo y Planeamiento Estratégico del BID, con enfoque en Eficiencia Fiscal, Buena Gobernanza y su interacción con la Tecnología Digital. Doctor en Economía y Master en Administración Pública por la Universidad de Alcalá."), eventName: "Proyecto BID: Modelo de machine learning para predecir la probabilidad de corrupción en Denuncias", placeLabel: "Huallamarca - Piso 4", timeLabel: "16:30", dateLabel: "27/11/23", image: "Gaston Pierri")

        let data10 = PonentesData(name: "Samuel Rotta", id: 2, category: "Moderador", description: String(localized: "Director ejecutivo de Proética, capítulo peruano de Transparencia Internacional desde 2003. Bachiller en Ciencias Sociales por la PUCP, experto en anticorrupción. Consultor independiente y expositor frecuente en eventos sobre lucha anticorrupción en Perú y el extranjero. Autor de artículos sobre corrupción."), eventName: "A casi una década de su revelación, ¿estamos ante el final del Caso “Lava Jato” y sus redes en América Latina?", placeLabel: "Naciones 1 - Piso 8", timeLabel: "11:15", dateLabel: "27/11/23", image: "Samuel Rotta")

        let data11 = PonentesData(name: "Henry Ara", id: 3, category: "Moderador", description: String(localized: "Abogado con más de 15 años de experiencia en derecho administrativo, Contralor General del Estado Plurinacional de Bolivia (2016-2022). Lideró la reestructuración institucional y formuló planes estratégicos en la Contraloría General del Estado."), eventName: "“De tal palo, tal astilla”. Corrupción en los gobiernos subnacionales", placeLabel: "Naciones 3 - Piso 8", timeLabel: "11:15", dateLabel: "27/11/23", image: "Henry Ara Perez")

        let data12 = PonentesData(name: "Ramiro Mendoza", id: 4, category: "Moderador", description: String(localized: "Licenciado en Derecho de la Universidad de Chile, fue Contralor General de la República (2007-2015). Socio fundador de MOMAG Abogados, destacado en Derecho Administrativo. Presidente del Colegio de Abogados de Chile AG desde 2022."), eventName: "Control gubernamental y control político. El trabajo conjunto de las entidades Fiscalizadoras Superiores y los Parlamentos", placeLabel: "Puruchuco - Piso 4", timeLabel: "14:30", dateLabel: "27/11/23", image: "Ramiro Mendoza")

        let data13 = PonentesData(name: "Maria Isabel Torres", id: 5, category: "Moderador", description: String(localized: "Periodista de investigación con más de 15 años de experiencia trabajando en prensa escrita, televisión y medios digitales. Finalizó la maestría de Antropología Visual en la Pontificia Universidad Católica del Perú."), eventName: "Develando el delito ambiental: las raíces de la corrupción y redes criminales en la Amazonía", placeLabel: "Huallamarca - Piso 4", timeLabel: "14:30", dateLabel: "27/11/23", image: "Maria Isabel Torres")

        let data14 = PonentesData(name: "Abimael Cereda Junior", id: 6, category: "Moderador", description: String(localized: "Geógrafo con más de 23 años de experiencia, Máster y Doctor en Ingeniería Urbana, especializado en Análisis de Datos Geográficos, Sistemas de Información Geográfica y Planificación Territorial. Docente y conferencista en posgrados y mentor en Innovation hubs en Brasil, Paraguay y Perú."), eventName: "Herramientas tecnológicas para combatir la corrupción", placeLabel: "Naciones 1 - Piso 8", timeLabel: "09:30", dateLabel: "28/11/23", image: "Abimael Cereda")

        let data15 = PonentesData(name: "Carlos Felipe Córdoba", id: 7, category: "Moderador", description: String(localized: "Ex Contralor de la República de Colombia con doble titulación en Derecho. Amplia trayectoria, destacando su rol en el caso Hidroituango. Actual Asesor Jurídico y de Gestión Administrativa de Proffense."), eventName: "¿Se puede elegir al mejor postor? Avances y retos de las contrataciones públicas en el Perú", placeLabel: "Naciones 1 - Piso 8", timeLabel: "11:15", dateLabel: "28/11/23", image: "Carlos Felipe Cordova")

        let data16 = PonentesData(name: "Eduardo Cordero", id: 8, category: "Moderador", description: String(localized: "Profesor Titular de Derecho Administrativo, Pontificia Universidad Católica de Valparaíso. Doctor en Derecho, Universidad Carlos III, España. Magíster en Política Territorial y Urbanística, Universidad Carlos III, España"), eventName: "Los retos y el futuro de los regímenes administrativos sancionadores como primera línea de defensa contra la corrupción y la impunidad", placeLabel: "Naciones 3 - Piso 8", timeLabel: "11:15", dateLabel: "28/11/23", image: "Eduardo Cordero")

        let data17 = PonentesData(name: "Álvaro Ramírez Alujas", id: 9, category: "Moderador", description: String(localized: "Co-fundador y vicepresidente del Grupo de Investigación en Gobierno, Administración y Políticas Públicas (GIGAPP). Presidente de la Fundación Observatorio del Gasto Fiscal en Chile. Profesor y director académico en la Universidad de Chile. Especializado en gobierno abierto, innovación pública y reforma del Estado."), eventName: "Participación ciudadana: Desafiando barreras y cambiando paradigmas: La participación ciudadana en la prevención de la corrupción para fortalecer la gobernanza", placeLabel: "Puruchuco - Piso 4", timeLabel: "14:30", dateLabel: "28/11/23", image: "Álvaro Ramírez Alujas")

        let data18 = PonentesData(name: "Edwin Salazar", id: 10, category: "Moderador", description: String(localized: "Contador público y auditor con doctorado en Administración Pública. Ex-Contralor General de Cuentas de Guatemala y expresidente de la OCCEFS. Docente universitario y con experiencia en roles directivos y financieros en diversas organizaciones."), eventName: "“Elefantes blancos”, la corrupción en las obras de los gobiernos locales", placeLabel: "Naciones 1 - Piso 8", timeLabel: "16:20", dateLabel: "28/11/23", image: "Edwin Salazar")

        let data19 = PonentesData(name: "Néstor Aparicio", id: 2, category: "Panelista", description: String(localized: "Profesional en cumplimiento normativo internacional, abogado y Compliance Officer para una multinacional en varios países de América y Europa. Destacado docente y conferenciante, ha coordinado el manual Compliance Organizacional en México, una obra relevante en el ámbito del cumplimiento normativo."), eventName: "A casi una década de su revelación, ¿estamos ante el final del Caso “Lava Jato” y sus redes en América Latina?", placeLabel: "Naciones 1 - Piso 8", timeLabel: "11:15", dateLabel: "27/11/23", image: "Nestor Aparicio")

        let data20 = PonentesData(name: "Guilherme France", id: 3, category: "Panelista", description: String(localized: "Gerente del Centro de Conocimiento Anticorrupción de Transparencia Internacional Brasil y candidato a Doctor en Ciencias Políticas en la Universidad Estatal de Río de Janeiro. Investigador y consultor para organismos internacionales y ONGs. Coautor de \"Nuevas medidas contra la corrupción\"."), eventName: "A casi una década de su revelación, ¿estamos ante el final del Caso “Lava Jato” y sus redes en América Latina?", placeLabel: "Naciones 1 - Piso 8", timeLabel: "11:15", dateLabel: "27/11/23", image: "Guilherme France")

        let data21 = PonentesData(name: "Viviana Baraybar", id: 4, category: "Panelista", description: String(localized: "Candidata a doctora en Politics y Master en Philisophy por la Universidad de Oxford. Licenciada en Ciencia Política por la Pontificia Universidad Católica del Perú. Experta en corrupción a nivel individual e institucional, con publicaciones en revistas académicas y coautora del libro \"Prosecutors, Voters, and The Criminalization of Corruption in Latin America: The Case of Lava Jato\" de Cambridge University Press."), eventName: "A casi una década de su revelación, ¿estamos ante el final del Caso “Lava Jato” y sus redes en América Latina?", placeLabel: "Naciones 1 - Piso 8", timeLabel: "11:15", dateLabel: "27/11/23", image: "Viviana Baraybar")

        let data22 = PonentesData(name: "Joaquin Gil", id: 5, category: "Panelista", description: String(localized: "Periodista de la sección de Investigación. Licenciado en Periodismo por el CEU y máster de EL PAÍS por la Universidad Autónoma de Madrid. Tiene dos décadas de experiencia en prensa, radio y televisión. Escribe desde 2011 en EL PAÍS, donde pasó por la sección de España y ha participado en investigaciones internacionales."), eventName: "A casi una década de su revelación, ¿estamos ante el final del Caso “Lava Jato” y sus redes en América Latina?", placeLabel: "Naciones 1 - Piso 8", timeLabel: "11:15", dateLabel: "27/11/23", image: "Joaquin Gil")

        let data23 = PonentesData(name: "Katherine Bliss", id: 6, category: "Panelista", description: String(localized: "Experta en ciencias sociales y relaciones internacionales, analiza el respaldo del gobierno de EE. UU. a programas de salud en países de bajos y medianos ingresos. Historiadora de formación, ha enseñado y publicado sobre género y salud pública en México. Su experiencia incluye trabajo en el Departamento de Estado de EE. UU. en salud ambiental y políticas exteriores para la preparación ante pandemias. Bliss tiene un A.B. en historia y literatura de Harvard College y un Ph.D. en historia de la Universidad de Chicago, con una beca David E. Bell en Harvard."), eventName: "“De tal palo, tal astilla”. Corrupción en los gobiernos subnacionales", placeLabel: "Naciones 3 - Piso 8", timeLabel: "11:15", dateLabel: "27/11/23", image: "Katherine Bliss")

        let data24 = PonentesData(name: "Angela Córdoba", id: 7, category: "Panelista", description: String(localized: "Abogada de la Universidad del Rosario con más de 10 años de experiencia, especializada en derecho comercial y con un máster en Derecho, Gobierno y Gestión de la Justicia de la Universidad de los Andes. Funcionaria de la Fiscalía General de la Nación durante 6 años, liderando casos de relevancia nacional."), eventName: "“De tal palo, tal astilla”. Corrupción en los gobiernos subnacionales", placeLabel: "Naciones 3 - Piso 8", timeLabel: "11:15", dateLabel: "27/11/23", image: "Angela Cordoba")

        let data25 = PonentesData(name: "Juan Cruz Vieyra", id: 8, category: "Panelista", description: String(localized: "Especialista líder del Banco Interamericano de Desarrollo en gestión pública, transparencia, gobierno digital y seguridad ciudadana en la República Dominicana. Lidera la iniciativa MapaInversiones a nivel regional. Con experiencia en investigación y docencia."), eventName: "“De tal palo, tal astilla”. Corrupción en los gobiernos subnacionales", placeLabel: "Naciones 3 - Piso 8", timeLabel: "11:15", dateLabel: "27/11/23", image: "Juan Cruz Vieyra")

        let data26 = PonentesData(name: "Joel Segura", id: 9, category: "Panelista", description: String(localized: "Abogado especializado en Derecho Penal y Procesal Penal, con maestría en argumentación jurídica y estudios en Derecho Penal y gestión pública. Procurador Público Especializado en Delitos de Corrupción de Funcionarios, con experiencia en estrategias legales y extradición."), eventName: "“De tal palo, tal astilla”. Corrupción en los gobiernos subnacionales", placeLabel: "Naciones 3 - Piso 8", timeLabel: "11:15", dateLabel: "27/11/23", image: "Joel Segura")

        let data27 = PonentesData(name: "Bruno Dantas", id: 2, category: "Panelista", description: String(localized: "Doctor y Magíster en Derecho por la Pontificia Universidad Católica de São Paulo (PUC-SP), con Post-Doctorado en la Universidad del Estado de Río de Janeiro (UERJ). Ministro del Tribunal Federal de Cuentas (TCU) y profesor titular en UNINOVE (São Paulo), con amplia experiencia como Consultor General del Senado Federal y Consejero del CNJ y del CNMP."), eventName: "Control gubernamental y control político. El trabajo conjunto de las entidades Fiscalizadoras Superiores y los Parlamentos", placeLabel: "Puruchuco - Piso 4", timeLabel: "14:30", dateLabel: "27/11/23", image: "Bruno Dantas")

        let data28 = PonentesData(name: "Camilo Benítez", id: 3, category: "Panelista", description: String(localized: "Abogado y Notario Público con maestría en Argumentación Jurídica. Doctor en Derecho con Summa Cum Laude. Profesor Adjunto y expresidente del OLACEFS."), eventName: "Control gubernamental y control político. El trabajo conjunto de las entidades Fiscalizadoras Superiores y los Parlamentos", placeLabel: "Puruchuco - Piso 4", timeLabel: "14:30", dateLabel: "27/11/23", image: "Camilo Benítez")

        let data29 = PonentesData(name: "David Colmenares", id: 4, category: "Panelista", description: String(localized: "Economista y profesor por 30 años en la Universidad Nacional Autónoma de México. Presidió OLACEFS en 2016-2018 y lidera el Grupo de Trabajo sobre Valor y Beneficios de las EFS y IntoSAINT en INTOSAI."), eventName: "Control gubernamental y control político. El trabajo conjunto de las entidades Fiscalizadoras Superiores y los Parlamentos", placeLabel: "Puruchuco - Piso 4", timeLabel: "14:30", dateLabel: "27/11/23", image: "David Colmenares")

        let data30 = PonentesData(name: "Silvia Giscoppo", id: 5, category: "Panelista", description: String(localized: "Abogada y senadora argentina por Jujuy desde 2015. Actual Presidenta de PARLATINO y Co-Vicepresidenta de EUROLAT. Perteneciente a la Unión Cívica Radical."), eventName: "Control gubernamental y control político. El trabajo conjunto de las entidades Fiscalizadoras Superiores y los Parlamentos", placeLabel: "Puruchuco - Piso 4", timeLabel: "14:30", dateLabel: "27/11/23", image: "Silvia Giacoppo")

        let data31 = PonentesData(name: "María Fernanda Ramírez", id: 6, category: "Panelista", description: String(localized: "Egresada de la Universidad Externado de Colombia, cuenta con un máster en Estudios de Paz y Seguridad. Con ocho años de experiencia, se ha dedicado a investigar delitos ambientales y crimen organizado en la Cuenca Amazónica, liderando publicaciones sobre la deforestación y sus causas en diversos países como Colombia, Perú, Bolivia y otros."), eventName: "Develando el delito ambiental: las raíces de la corrupción y redes criminales en la Amazonía", placeLabel: "Huallamarca - Piso 4", timeLabel: "14:30", dateLabel: "27/11/23", image: "Maria Fernanda Ramirez")

        let data32 = PonentesData(name: "Diana Palacios", id: 7, category: "Panelista", description: String(localized: "Especialista Legal del Equipo Ambiental de UNODC"), eventName: "Develando el delito ambiental: las raíces de la corrupción y redes criminales en la Amazonía", placeLabel: "Huallamarca - Piso 4", timeLabel: "14:30", dateLabel: "27/11/23", image: "Diana Palacios")

        let data33 = PonentesData(name: "Julia Urrunaga", id: 8, category: "Panelista", description: String(localized: "Directora en Perú de Environmental Investigation Agency, especialista en tala ilegal y tráfico de madera. Periodista, investigadora y consultora con más de 15 años de experiencia en gobernabilidad, transparencia y desarrollo sostenible."), eventName: "Develando el delito ambiental: las raíces de la corrupción y redes criminales en la Amazonía", placeLabel: "Huallamarca - Piso 4", timeLabel: "14:30", dateLabel: "27/11/23", image: "Julia Urrunaga")

        let data34 = PonentesData(name: "Marcelo Cardoso", id: 2, category: "Panelista", description: String(localized: "Auditor federal de control externo en el Tribunal de Cuentas de la Unión desde 1999. Cuenta con maestrías en ciencia política y gestión ambiental."), eventName: "Develando el delito ambiental: las raíces de la corrupción y redes criminales en la Amazonía", placeLabel: "Huallamarca - Piso 4", timeLabel: "14:30", dateLabel: "27/11/23", image: "Marcelo Cardoso")

        let data35 = PonentesData(name: "Júlia Miralles", id: 3, category: "Panelista", description: String(localized: "Doctora en Ciencia Política por la Universidad Autónoma de Barcelona, especializada en integridad pública, anticorrupción, transparencia y prevención del blanqueo de capitales. Profesora asociada de políticas públicas en la UAB."), eventName: "Herramientas tecnológicas para combatir la corrupción", placeLabel: "Naciones 1 - Piso 8", timeLabel: "09:30", dateLabel: "28/11/23", image: "Julia Miralles")

        let data36 = PonentesData(name: "Álvaro Ramírez Alujas", id: 4, category: "Panelista", description: String(localized: "Co-fundador y vicepresidente del Grupo de Investigación en Gobierno, Administración y Políticas Públicas (GIGAPP). Presidente de la Fundación Observatorio del Gasto Fiscal en Chile. Profesor y director académico en la Universidad de Chile. Especializado en gobierno abierto, innovación pública y reforma del Estado."), eventName: "Herramientas tecnológicas para combatir la corrupción", placeLabel: "Naciones 1 - Piso 8", timeLabel: "09:30", dateLabel: "28/11/23", image: "Álvaro Ramírez Alujas")

        let data37 = PonentesData(name: "Mariana Costa Checa", id: 5, category: "Panelista", description: String(localized: "Cofundadora y CEO de Laboratoria, empresa social de tecnología en América Latina. Reconocida por el MIT y la BBC. Anteriormente en la Organización de Estados Americanos. Titulada por la London School of Economics y la Universidad de Columbia."), eventName: "Herramientas tecnológicas para combatir la corrupción", placeLabel: "Naciones 1 - Piso 8", timeLabel: "09:30", dateLabel: "28/11/23", image: "Mariana Costa")

        let data38 = PonentesData(name: "Alfonso Martel", id: 6, category: "Panelista", description: String(localized: "Compliance Officer - Head of Compliance & AML at Lemon. Ex funcionario de la justicia criminal. Abogado y Profesor de la Universidad de Buenos Aires - UBA."), eventName: "Herramientas tecnológicas para combatir la corrupción", placeLabel: "Naciones 1 - Piso 8", timeLabel: "09:30", dateLabel: "28/11/23", image: "Alfonso Martel")

        let data39 = PonentesData(name: "Nelson Shack", id: 7, category: "Panelista", description: String(localized: "Contralor General de la República del Perú, licenciado en economía por la Universidad del Pacífico y magíster en Gestión y Políticas Públicas por la Universidad de Chile, con sólida experiencia en roles directivos y consultorías internacionales. Su trayectoria en el Ministerio de Economía y Finanzas incluye destacados logros en Gestión Presupuestaria, Planificación Estratégica y Evaluación de Gasto Público. Es autor de publicaciones especializadas y docente en instituciones de postgrado."), eventName: "¿Se puede elegir al mejor postor? Avances y retos de las contrataciones públicas en el Perú", placeLabel: "Naciones 1 - Piso 8", timeLabel: "11:15", dateLabel: "28/11/23", image: "Nelson Shack")

        let data40 = PonentesData(name: "Laura Gutiérrez", id: 8, category: "Panelista", description: String(localized: "Abogada de la PUCP con especialización en Contratación Pública y Derecho Administrativo. Máster en Contratación Pública Orientada a Resultados por la Université Laval (Canadá) y estudios de Maestría en Ciencia Política y Políticas Públicas. Presidenta Ejecutiva del OSCE, con más de 15 años de experiencia en contrataciones públicas."), eventName: "¿Se puede elegir al mejor postor? Avances y retos de las contrataciones públicas en el Perú", placeLabel: "Naciones 1 - Piso 8", timeLabel: "11:15", dateLabel: "28/11/23", image: "Laura Gutierrez")

        let data41 = PonentesData(name: "Hania Pérez de Cuéllar", id: 9, category: "Panelista", description: String(localized: "Licenciada en Economía y Políticas Sociales, con una Maestría en Prácticas Sociales de Desarrollo. Experta en gerencia de proyectos de desarrollo sostenible, innovación y responsabilidad social. Presidenta ejecutiva del Indecopi, asesora de la Presidencia y el Ministerio de la Producción en Perú."), eventName: "¿Se puede elegir al mejor postor? Avances y retos de las contrataciones públicas en el Perú", placeLabel: "Naciones 1 - Piso 8", timeLabel: "11:15", dateLabel: "28/11/23", image: "Hania Perez de Cuellar")

        let data42 = PonentesData(name: "Raúl Pérez Reyes", id: 10, category: "Panelista", description: String(localized: "Economista y actual ministro de Transportes y Comunicaciones del Perú, con experiencia en diversos roles gubernamentales, incluyendo ministro de la Producción. Con una sólida formación académica, ha contribuido al desarrollo en sectores clave y ocupado roles cruciales en instituciones como Indecopi, Osinergmin y Osiptel."), eventName: "¿Se puede elegir al mejor postor? Avances y retos de las contrataciones públicas en el Perú", placeLabel: "Naciones 1 - Piso 8", timeLabel: "11:15", dateLabel: "28/11/23", image: "Raul Perez Reyes")

        let data43 = PonentesData(name: "Alex Contreras", id: 11, category: "Panelista", description: String(localized: "Ingeniero económico con Máster en Política Económica por la UNI y Williams College. Con más de 15 años de experiencia en gestión pública, destacando su rol en el Banco Central de Reserva del Perú. Experto en estadísticas monetarias, proyección macroeconómica y política monetaria."), eventName: "¿Se puede elegir al mejor postor? Avances y retos de las contrataciones públicas en el Perú", placeLabel: "Naciones 1 - Piso 8", timeLabel: "11:15", dateLabel: "28/11/23", image: "Alex Contreras")

        let data44 = PonentesData(name: "Jesús Salazar", id: 12, category: "Panelista", description: String(localized: "Ph.D. en Dirección Estratégica y Máster en Administración de Empresas, es Presidente Ejecutivo de Koplast Industrial. Destaca como líder en la Sociedad Nacional de Industrias, coordinador del Grupo de Trabajo de Economía Circular en la Alianza del Pacífico y reconocido como Líder Empresarial del Cambio 2023."), eventName: "¿Se puede elegir al mejor postor? Avances y retos de las contrataciones públicas en el Perú", placeLabel: "Naciones 1 - Piso 8", timeLabel: "11:15", dateLabel: "28/11/23", image: "Jesus Salazar Nishi")

        let data45 = PonentesData(name: "Iñigo Sanz", id: 13, category: "Panelista", description: String(localized: "Doctor y catedrático de Derecho Administrativo en la Universidad de Valladolid, con 35 años de experiencia docente, especializado en Derecho Administrativo Sancionador y autor de más de diez libros y cien artículos en revistas especializadas."), eventName: "Los retos y el futuro de los regímenes administrativos sancionadores como primera línea de defensa contra la corrupción y la impunidad", placeLabel: "Naciones 3 - Piso 8", timeLabel: "11:15", dateLabel: "28/11/23", image: "Iñigo Sanz")

        let data46 = PonentesData(name: "Miriam Ivanega", id: 14, category: "Panelista", description: String(localized: "Doctora en Derecho y Ciencias Sociales, magíster en Derecho Administrativo, es miembro fundador de importantes entidades jurídicas, directora de Comisión de Género, y cuenta con una amplia trayectoria como profesora y autora de libros y artículos en el ámbito del derecho administrativo."), eventName: "Los retos y el futuro de los regímenes administrativos sancionadores como primera línea de defensa contra la corrupción y la impunidad", placeLabel: "Naciones 3 - Piso 8", timeLabel: "11:15", dateLabel: "28/11/23", image: "Miriam Ivanega")

        let data47 = PonentesData(name: "Jaime Rodríguez - Arana", id: 15, category: "Panelista", description: String(localized: "Catedrático-Director del Grupo de Investigación de Derecho Público Global de la Universidad de A Coruña. Presidente Foro Iberoamericano de Derecho Administrativo. Director Doctorado Internacional en Derecho Administrativo Iberoamericano"), eventName: "Los retos y el futuro de los regímenes administrativos sancionadores como primera línea de defensa contra la corrupción y la impunidad", placeLabel: "Naciones 3 - Piso 8", timeLabel: "11:15", dateLabel: "28/11/23", image: "Jaime Rodriguez Arana")

        let data48 = PonentesData(name: "Miroslava Wedervoort", id: 16, category: "Panelista", description: String(localized: "Con más de 40 años en el sector financiero, ha ocupado roles destacados en banca, finanzas y consultoría. Ex Presidente de la Entidad Fiscalizadora Suprema de Curazao, actualmente preside la Autoridad de Competencia y es miembro del Consejo de Supervisión del Banco Central de Curazao y St. Maarten."), eventName: "Los retos y el futuro de los regímenes administrativos sancionadores como primera línea de defensa contra la corrupción y la impunidad", placeLabel: "Naciones 3 - Piso 8", timeLabel: "11:15", dateLabel: "28/11/23", image: "Miroslava Wedervoort")

        let data49 = PonentesData(name: "Cristina Zahar", id: 17, category: "Panelista", description: String(localized: "Experimentada periodista, lideró la Asociación Brasileña de Periodismo de Investigación. Supervisó proyectos de monitoreo de violencia de género contra periodistas y reportó sobre violencia en el Examen Periódico Universal de Brasil en la ONU. Con un DEA en Comunicación de la Universidad Michel de Montaigne y un MBA en Gestión Empresarial de la FIA-USP."), eventName: "La colaboración transnacional para investigar casos de corrupción", placeLabel: "Naciones 1 - Piso 8", timeLabel: "14:30", dateLabel: "28/11/23", image: "Cristina Zahar")

        let data50 = PonentesData(name: "Jorge Moreno", id: 2, category: "Panelista", description: String(localized: "Abogado con maestría en Estudios Políticos e Internacionales, especialista en Derecho Penal y Gestión Pública. Experto en políticas públicas y criminales, enfoque anticorrupción, prevención del delito y estrategias contra crimen organizado."), eventName: "La colaboración transnacional para investigar casos de corrupción", placeLabel: "Naciones 1 - Piso 8", timeLabel: "14:30", dateLabel: "28/11/23", image: "Jorge Moreno")

        let data51 = PonentesData(name: "Juan Luis Dammert", id: 3, category: "Panelista", description: String(localized: "Sociólogo con maestría y doctorado en Geografía. Director para América Latina del Natural Resource Governance Institute. Experiencia en Oxfam, SPDA y docencia en la PUCP. Investiga gobernanza de recursos y desarrollo en América Latina."), eventName: "Reforzando la democracia y su legitimidad: el papel de la integridad en los cargos de elección popular y los de libre designación", placeLabel: "Huallamarca - Piso 4", timeLabel: "14:30", dateLabel: "28/11/23", image: "Juan Luis Dammert")

        let data52 = PonentesData(name: "Carlos March", id: 4, category: "Panelista", description: String(localized: "Periodista. Director de Inteligencia Colaborativa de la Fundación Avina Latinoamérica. Ex director ejecutivo de la Fundación Poder Ciudadano. Integra 10 consejos directivos de organizaciones sociales argentinas. Autor de cuatro libros, entre ellos “Diginidad para todos” (2009) y “Democracia bipolar” (2021)."), eventName: "Reforzando la democracia y su legitimidad: el papel de la integridad en los cargos de elección popular y los de libre designación", placeLabel: "Huallamarca - Piso 4", timeLabel: "14:30", dateLabel: "28/11/23", image: "Carlos March")

        let data53 = PonentesData(name: "Jorge Pérez Artile", id: 5, category: "Panelista", description: String(localized: "Doctor socioeconomista, experto en desarrollo en España, África y América Latina. Director general de Participación Ciudadana en el Cabildo de Gran Canaria y coordinador de la Agenda Gran Canaria 2030 de Desarrollo Sostenible desde 2015."), eventName: "Participación ciudadana: Desafiando barreras y cambiando paradigmas: La participación ciudadana en la prevención de la corrupción para fortalecer la gobernanza", placeLabel: "Puruchuco - Piso 4", timeLabel: "14:30", dateLabel: "28/11/23", image: "Jorge Perez Artiles")

        let data54 = PonentesData(name: "Rita M. Grandinetti", id: 6, category: "Panelista", description: String(localized: "Profesora titular de Tecnologías de la Administración Pública y directora de PoliLab UNR. Doctora en Innovación y Desarrollo Territorial. Especialista en Innovación Pública. Integra la Comisión Directiva de la Asociación Argentina de Estudios en Administración Pública. Consultora en innovación en gobiernos y organismos regionales e internacionales."), eventName: "Participación ciudadana: Desafiando barreras y cambiando paradigmas: La participación ciudadana en la prevención de la corrupción para fortalecer la gobernanza", placeLabel: "Puruchuco - Piso 4", timeLabel: "14:30", dateLabel: "28/11/23", image: "Rita M. Grandinetti")

        let data55 = PonentesData(name: "Marcos Mendiburu", id: 7, category: "Panelista", description: String(localized: "Consultor en transparencia y rendición de cuentas con experiencia en organismos internacionales. Trabajó en el Banco Mundial durante 16 años. Co-coordinador de cursos de capacitación para la Organización Latinoamericana y del Caribe de Entidades Fiscalizadoras Superiores (OLACEFS). Autor del documento \"La participación ciudadana en las entidades fiscalizadoras superiores: ¿avance o impasse?\" (2020)."), eventName: "Participación ciudadana: Desafiando barreras y cambiando paradigmas: La participación ciudadana en la prevención de la corrupción para fortalecer la gobernanza", placeLabel: "Puruchuco - Piso 4", timeLabel: "14:30", dateLabel: "28/11/23", image: "Marcos Mendiburu")

        let data56 = PonentesData(name: "Roy Pineda", id: 8, category: "Panelista", description: String(localized: "Magistrado Coordinador de la Sala Laboral - Contencioso Administrativo. Experiencia como Magistrado del Tribunal Superior de Cuentas y en roles directivos en el Banco Central de Honduras. Práctica privada en derecho administrativo y mercantil, y certificación como árbitro y conciliador."), eventName: "Participación ciudadana: Desafiando barreras y cambiando paradigmas: La participación ciudadana en la prevención de la corrupción para fortalecer la gobernanza", placeLabel: "Puruchuco - Piso 4", timeLabel: "14:30", dateLabel: "28/11/23", image: "Roy Pineda")

        let data57 = PonentesData(name: "Marco Cancino", id: 9, category: "Panelista", description: String(localized: "Maestro en Economía Política por la Universidad Complutense de Madrid, especializado en análisis institucional. Director General de Inteligencia Pública, centrado en fortalecimiento institucional, evaluación del desempeño y transparencia presupuestaria para ciudadanizar información pública."), eventName: "“Elefantes blancos”, la corrupción en las obras de los gobiernos locales", placeLabel: "Naciones 1 - Piso 8", timeLabel: "16:20", dateLabel: "28/11/23", image: "Marco Cancino")

        let data58 = PonentesData(name: "Paola Barragán", id: 10, category: "Panelista", description: String(localized: "Asesora especializada en Gestión Pública, Posconflicto, Monitoreo y Evaluación, Fortalecimiento Institucional, Participación Pública y Desarrollo de Capacidades. Expertise en políticas públicas y gobernanza, con enfoque en resultados y participación ciudadana."), eventName: "“Elefantes blancos”, la corrupción en las obras de los gobiernos locales", placeLabel: "Naciones 1 - Piso 8", timeLabel: "16:20", dateLabel: "28/11/23", image: "Paola Barragan")

        let data59 = PonentesData(name: "Carlos Casas", id: 11, category: "Panelista", description: String(localized: "Economista con maestría de Georgetown University y licenciatura de la Universidad del Pacífico. Ex viceministro de Economía, combina investigación académica y formulación de políticas públicas, con experiencia en consultoría para empresas, organismos internacionales y gobiernos. Columnista en Gestión y América Economía."), eventName: "“Elefantes blancos”, la corrupción en las obras de los gobiernos locales", placeLabel: "Naciones 1 - Piso 8", timeLabel: "16:20", dateLabel: "28/11/23", image: "Carlos Casas")

        let data60 = PonentesData(name: "Dennys Cuba", id: 12, category: "Panelista", description: String(localized: "Ingeniero eléctrico y político peruano. Actualmente es presidente de la Asociación de Municipalidades del Perú para el periodo 2023 - 2026. Fue elegido como Alcalde provincial de Huancayo en las elecciones municipales del 2022. Además, fue alcalde de su natal distrito de Quilcas entre 2015 y 2018."), eventName: "“Elefantes blancos”, la corrupción en las obras de los gobiernos locales", placeLabel: "Naciones 1 - Piso 8", timeLabel: "16:20", dateLabel: "28/11/23", image: "Dennys Cuba")

        let data61 = PonentesData(name: "Alejandra Hinojosa", id: 13, category: "Panelista", description: String(localized: "Economista y Máster en Humanidades por UDEM, cuenta con más de 19 años de experiencia en programas educativos innovadores para niños y jóvenes. Co-creó 'Pequeños Ciudadanos' y lidera la organización Líderes Ciudadanos, fomentando la participación y propuestas juveniles contra la corrupción."), eventName: "Haz corto con la corrupción", placeLabel: "Naciones - Piso 3", timeLabel: "16:20", dateLabel: "28/11/23", image: "Alejandra Hinojosa")

        
        return [data1, data2 ,data3 ,data4 ,data5, data7 ,data8 ,data9,data10,data11,data12,data13,data14,data15,data16, data17,data18,data19,data20,data21,data22,data23,data24,data25,data26,data27,data28,data29,data30,data31,data32,data33, data34,data35,data36,data37,data38,data39,data40,data41,data42,data43,data44,data45,data46,data47,data48,data49,data50, data51,data52,data53,data54,data55,data56,data57,data58,data59,data60,data61]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.destination is PonenteDetailViewController {
            let vc = segue.destination as? PonenteDetailViewController
            let detailToSend = sender as? PonentesData
            vc?.detail = detailToSend
        }
        
    }
}

extension PonentesViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as? FilterViewCell
        //            else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(ofType: FilterViewCell.self, for: indexPath)
        cell.labelFilterName.text = filters[indexPath.item]
        if cell.isSelected {
            cell.labelFilterName.textColor = .white
            cell.viewFilter.backgroundColor = .black
        } else {
            cell.labelFilterName.textColor = .black
            cell.viewFilter.backgroundColor = .white
        }
        cell.tag = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FilterViewCell
        cell.isSelected = true
        cell.labelFilterName.textColor = .white
        cell.viewFilter.backgroundColor = .black
        
        filterPonentes(category: cell.labelFilterName.text!)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FilterViewCell else { return }
        cell.isSelected = false
        cell.labelFilterName.textColor = .black
        cell.viewFilter.backgroundColor = .white
        
    }
    
}



extension PonentesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ponente = ponentes[indexPath.row]
        print(ponente)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! TableViewCell
        cell.nameLabel.text = ponente.name
        cell.descriptionLabel.text = ponente.description
        cell.imageViewPhoto.image = UIImage(named: ponente.image)
        cell.imageViewPhoto.contentMode = .scaleAspectFill
        //        cell.imageViewPhoto.image = UIImage(named: "")
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ponentes.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "ponenteDetailSegue", sender: ponentes[indexPath.row])
    }
    
    
    
    
}
