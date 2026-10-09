// --- PARAMETRI CONFIGURABILI ---

// Dimensioni del corpo principale
lunghezza = 14.3;            // Lunghezza in mm (asse X)
larghezza = 14.3;            // Larghezza in mm (asse Y)
spessore_totale = 3.0;       // Spessore totale in mm (asse Z)
raggio_arrotondamento = 1.5; // Raggio di curvatura degli angoli in mm

// Impostazioni del testo
testo_1 = "OPEN";
testo_2 = "FAULT";
dimensione_font = 3.0;  

// --- CALCOLO PROFONDITÀ ---
// Imposta automaticamente la profondità della scritta all'80% dello spessore (2.4 mm)
profondita_scritta = spessore_totale * 0.90;

// Calcola lo scostamento sull'asse Y per distribuire le scritte
distanza_y = larghezza / 4; 

// --- GENERAZIONE MODELLO ---
// Imposta la risoluzione delle curve (più alto = più liscio)
$fn = 50; 

difference() {
    // 1. Corpo principale con angoli arrotondati
    // Viene estruso un quadrato 2D a cui vengono smussati i bordi tramite offset()
    linear_extrude(height = spessore_totale)
        offset(r = raggio_arrotondamento)
        square([lunghezza - 2 * raggio_arrotondamento, larghezza - 2 * raggio_arrotondamento], center = true);

    // 2. Scritte da sottrarre (Incisione)
    translate([0, 0, spessore_totale - profondita_scritta])
        // Aggiungiamo +1 all'altezza per garantire un taglio pulito della faccia superiore
        linear_extrude(height = profondita_scritta + 1) {
            
            // Prima riga (in alto)
            translate([0, distanza_y, 0])
                text(testo_1, 
                     size = dimensione_font, 
                     halign = "center", 
                     valign = "center", 
                     font = "Liberation Sans:style=Bold");
            
            // Seconda riga (in basso)
            translate([0, -distanza_y, 0])
                text(testo_2, 
                     size = dimensione_font, 
                     halign = "center", 
                     valign = "center", 
                     font = "Liberation Sans:style=Bold");
        }
}