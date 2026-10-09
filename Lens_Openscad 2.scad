// --- PARAMETRI CONFIGURABILI ---

// Dimensioni della piastrina
lunghezza = 14.3;            // Dimensione asse X in mm
larghezza = 14.3;            // Dimensione asse Y in mm
spessore_totale = 3.0;       // Spessore totale asse Z in mm
raggio_arrotondamento = 1.5; // Raggio di curvatura degli angoli in mm

// Fessura di separazione centrale (paraluce tra le due camere)
fessura_spessore = 1.5;      // Spessore della scanalatura (asse Y) in mm
fessura_altezza  = 2.5;      // Altezza dello scavo dal basso (asse Z) in mm
// Di default attraversa tutto il pezzo in X (+2 mm per garantire un taglio pulito)
fessura_lunghezza = lunghezza + 2; 

// Testi da incidere
testo_superiore = "FAULT";   // Riga in alto (+Y)
testo_inferiore = "OPEN";    // Riga in basso (-Y)
dimensione_font = 2.8;       // Dimensione del font in mm

// --- CALCOLO PROFONDITÀ E POSIZIONAMENTO ---
// Il testo sale dal basso fino al 90% dello spessore (2.7 mm, lascia 0.3 mm sul top)
percentuale_scavo_testo = 0.90; 
altezza_scavo_testo = spessore_totale * percentuale_scavo_testo; 

// Centratura delle scritte nelle rispettive metà (sopra e sotto la fessura)
distanza_y = larghezza / 4; 

$fn = 60; // Risoluzione delle curvature

// --- GENERAZIONE MODELLO ---
difference() {
    // 1. Corpo principale con angoli arrotondati
    linear_extrude(height = spessore_totale)
        offset(r = raggio_arrotondamento)
        square([lunghezza - 2 * raggio_arrotondamento, larghezza - 2 * raggio_arrotondamento], center = true);

    // 2. Fessura di separazione centrale (a Y = 0)
    // Parte da Z = -0.05 per aprire bene il fondo e sale fino a Z = 2.5 mm
    translate([-fessura_lunghezza / 2, -fessura_spessore / 2, -0.05])
        cube([fessura_lunghezza, fessura_spessore, fessura_altezza + 0.05]);

    // 3. Scavo dei testi dal piano di appoggio (Z=0) fino a 2.7 mm
    translate([0, 0, -0.05])
        linear_extrude(height = altezza_scavo_testo + 0.05) {
            
            // Riga superiore (FAULT)
            translate([0, distanza_y, 0])
                text(testo_superiore, 
                     size = dimensione_font, 
                     halign = "center", 
                     valign = "center", 
                     font = "Liberation Sans:style=Bold");
            
            // Riga inferiore (OPEN)
            translate([0, -distanza_y, 0])
                text(testo_inferiore, 
                     size = dimensione_font, 
                     halign = "center", 
                     valign = "center", 
                     font = "Liberation Sans:style=Bold");
        }
}