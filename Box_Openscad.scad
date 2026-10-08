// Parametri principali del box
panel_width = 90;   // Sostituisci con la larghezza del tuo pannello
panel_length = 50;   // Sostituisci con la lunghezza del tuo pannello
box_height = 40;     // Altezza fissa richiesta[cite: 1]
wall_thickness = 3;  // Spessore delle pareti
lip = 2;             // Tolleranza per l'alloggiamento del pannello
corner_pillar_radius = 7; // Raggio delle colonnine per le viti
screw_hole_radius = 1.6;  // Raggio per viti M3 (3mm di diametro)

module corner_pillars() {
    // Posizionamento delle 4 colonnine agli angoli interni
    translate([wall_thickness + corner_pillar_radius, wall_thickness + corner_pillar_radius, 0])
        pillar();
    translate([wall_thickness + panel_width - corner_pillar_radius, wall_thickness + corner_pillar_radius, 0])
        pillar();
    translate([wall_thickness + corner_pillar_radius, wall_thickness + panel_length - corner_pillar_radius, 0])
        pillar();
    translate([wall_thickness + panel_width - corner_pillar_radius, wall_thickness + panel_length - corner_pillar_radius, 0])
        pillar();
}

module pillar() {
    difference() {
        cylinder(h = box_height - wall_thickness, r = corner_pillar_radius, $fn=50);
        // Foro per la vite
        translate([0, 0, -1])
            cylinder(h = box_height + 2, r = screw_hole_radius, $fn=30);
    }
}

module enclosure() {
    outer_w = panel_width + (wall_thickness * 2);
    outer_l = panel_length + (wall_thickness * 2);
    
    difference() {
        // Scatola esterna piena
        cube([outer_w, outer_l, box_height]);
        
        // Svuotamento interno della scatola
        translate([wall_thickness, wall_thickness, wall_thickness])
            cube([panel_width, panel_length, box_height]);
            
        // Scasso superiore per incassare il pannello a filo
        translate([wall_thickness - 0.5, wall_thickness - 0.5, box_height - 3])
            cube([panel_width + 1, panel_length + 1, 4]);
    }
    
    // Aggiunta delle colonnine angolari interne
    corner_pillars();
}

enclosure();