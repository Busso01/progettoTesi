# Sviluppo di un'applicazione di supporto all'apprendimento della scrittura

Nella nostra società la scuola e lo studio sono fondamentali, gli insegnanti so‑
no per gli studenti un punto di riferimento e tutto questo aiuta i ragazzi a co‑
struirsi un futuro brillante. Tuttavia talvolta possono presentarsi degli ostacoli
che possono sembrare insormontabili, in particolare per coloro che soffrono di
Disturbi Speciici dell’Apprendimento (DSA). Per DSA si intendono i disturbi spe‑
ciici nelle capacità di apprendimento ovvero: dislessia, disortograia, disgraia,
discalculia. La tesi riguarda lo sviluppo di un applicativo che supporti le per‑
sone che soffrono di disgraia, ovvero un disturbo speciico nell’apprendimento
della scrittura, tramite un riscontro immediato sulla qualità ed il modo in cui
le lettere sono state scritte a mano nei diversi formati (e.g., lettere maiuscole e
minuscole). L’applicazione è stata creata utilizzando il framework Flutter basa‑
to su linguaggio Dart. Nell’architettura dell’applicazione è stato anche integrato
Isar, un Data Base sviluppato appositamente per Flutter per consentire la per‑
sistenza dei dati. L’applicazione consiste nel richiedere all’utente di disegnare
la lettera su cui vuole esercitarsi scegliendo anche lo stile (stampatello e corsi‑
vo sia minuscolo che maiuscolo) e, alla conferma, valutare l’accuratezza con la
quale è stata scritta la lettera. La valutazione avviene effettuando un confronto
pixel per pixel tra la lettera scritta a mano dall’utente e quella mostrata come
riferimento dall’applicazione, analizzando il modo in cui la lettera è stata scritta
e assicurandosi che rispetti le regole deinite. L’applicazione, dopo la valutazio‑
ne, mostrerà all’utente il risultato, indicando se e dove è necessario migliorare.
Per quanto riguarda la valutazione del metodo di scrittura delle lettere è stato
deciso di utilizzare l’algoritmo Dynamic Time Warping per deinire quando le tra‑
iettorie dei tratti che compongono una lettera sono simili rispetto allo standard
deinito.
