import processing.sound.*;

PImage beach, jawaImage;
SoundFile mySound;
int scene = 1;
int xspacing = 16;   
int w;              
float theta = 0.0;  
float amplitude = 20.0;  
float period = 500.0;  
float dx;  
float[] yvalues;  
int arrowSpacing = 320; 
int arrowHeight = 100; 
float arrowSpeed = 2; 
float centerY;
float sideY;
int arrowDirection = 1;
float characterX, characterY;
float velocityX, velocityY;
float angle = 0;
boolean isSunny = true;
float thunderTimer = 0;
float scaleFactor = 1.0;
float targetScale = 2.0; 
float scaleSpeed = 0.002; 
int startTime;

void setup() {
  size(1280, 720);
  w = width + 16;
  dx = (TWO_PI / period) * xspacing;
  yvalues = new float[w / xspacing];
  
  beach = loadImage("D:/[A] Semester 4/Grafika dan Multimedia/scene expo/final project/gambarpantai.jpg"); 
  beach.resize(width, height); 
  centerY = height / 2 + 100;
  sideY = height / 2 - 100;
  
  characterX = width / 2;
  characterY = height / 2;
  velocityX = random(-2, 2);
  velocityY = random(-2, 2);
  
  mySound = new SoundFile(this, "semuasuara.mp3"); // Suara yang akan digunakan untuk semua scene

  jawaImage = loadImage("D:/[A] Semester 4/Grafika dan Multimedia/scene expo/final project/jawir.png");
  imageMode(CENTER);

  startTime = millis();
}

void draw() {
  int elapsedTime = millis() - startTime;
  
  if (!mySound.isPlaying()) {
    mySound.play(); // Memastikan suara diputar jika belum diputar
  }
  
  if (elapsedTime < 23000) {
    scene1();
  } else if (elapsedTime < 23000 + 14000) {
    scene2();
  } else if (elapsedTime < 23000 + 14000 + 22000) {
    scene3();
  } else if (elapsedTime < 23000 + 14000 + 22000 + 20000) {
    scene4();
  } else if (elapsedTime < 23000 + 14000 + 22000 + 20000 + 32000) {
    scene5();
  }
}

void scene1() {
  background(50);  
  drawClouds();
  calcWave();
  renderWave();
  drawPirateShip();
}

void drawClouds() {
  fill(40);  
  noStroke();
  ellipse(150, 100, 300, 80);
  ellipse(400, 70, 400, 100);
  ellipse(550, 120, 350, 90);
}

void calcWave() {
  theta += 0.02;
  float x = theta;
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = sin(x) * amplitude;
    x += dx;
  }
}

void renderWave() {
  fill(0, 0, 50);  
  noStroke();
  beginShape();
  vertex(0, height);  
  for (int x = 0; x < yvalues.length; x++) {
    vertex(x * xspacing, height / 2 + yvalues[x]);
  }
  vertex(width, height);  
  endShape(CLOSE);

  noFill();
  stroke(0, 150, 255);  
  beginShape();
  for (int x = 0; x < yvalues.length; x++) {
    vertex(x * xspacing, height / 2 + yvalues[x]);
  }
  endShape();
}

void drawPirateShip() {
  int shipX = width / 2;
  int shipY = (int)(height / 2 + yvalues[shipX / xspacing]);

  fill(50);  
  stroke(0);
  strokeWeight(2);
  
  beginShape();
  vertex(shipX - 100, shipY + 20);
  vertex(shipX + 100, shipY + 20);
  vertex(shipX + 60, shipY + 50);
  vertex(shipX - 60, shipY + 50);
  endShape(CLOSE);

  line(shipX - 60, shipY + 20, shipX - 60, shipY - 100);
  line(shipX - 20, shipY + 20, shipX - 20, shipY - 120);
  line(shipX + 20, shipY + 20, shipX + 20, shipY - 100);
  line(shipX + 60, shipY + 20, shipX + 60, shipY - 80);

  fill(100);
  beginShape();
  vertex(shipX - 60, shipY - 100);
  vertex(shipX - 30, shipY - 70);
  vertex(shipX - 60, shipY - 70);
  endShape(CLOSE);

  beginShape();
  vertex(shipX - 20, shipY - 120);
  vertex(shipX + 10, shipY - 80);
  vertex(shipX - 20, shipY - 80);
  endShape(CLOSE);

  beginShape();
  vertex(shipX + 20, shipY - 100);
  vertex(shipX + 50, shipY - 70);
  vertex(shipX + 20, shipY - 70);
  endShape(CLOSE);

  beginShape();
  vertex(shipX + 60, shipY - 80);
  vertex(shipX + 90, shipY - 50);
  vertex(shipX + 60, shipY - 50);
  endShape(CLOSE);
}

void scene2() {
  background(beach);
  drawRipCurrentArrows();
}

void drawRipCurrentArrows() {
  strokeWeight(4);

  stroke(0, 255, 0); 
  fill(0, 255, 0);
  line(width / 2, centerY, width / 2, centerY - arrowHeight);
  line(width / 2, centerY, width / 2 - 20, centerY - 20);
  line(width / 2, centerY, width / 2 + 20, centerY - 20);
  centerY -= arrowSpeed * arrowDirection;
  if (centerY < height / 2 - 100 || centerY > height / 2 + 100) {
    arrowDirection *= -1;
  }

  stroke(255, 0, 0);  
  fill(255, 0, 0);

  line(width / 2 - arrowSpacing, sideY, width / 2 - arrowSpacing, sideY + arrowHeight);
  line(width / 2 - arrowSpacing, sideY, width / 2 - arrowSpacing - 20, sideY + 20);
  line(width / 2 - arrowSpacing, sideY, width / 2 - arrowSpacing + 20, sideY + 20);

  line(width / 2 + arrowSpacing, sideY, width / 2 + arrowSpacing, sideY + arrowHeight);
  line(width / 2 + arrowSpacing, sideY, width / 2 + arrowSpacing - 20, sideY + 20);
  line(width / 2 + arrowSpacing, sideY, width / 2 + arrowSpacing + 20, sideY + 20);

  sideY += arrowSpeed * arrowDirection;
  if (sideY > height / 2 + 100 || sideY < height / 2 - 100) {
    arrowDirection *= -1;
  }
}

void scene3() {
  background(255);

  noStroke();
  fill(87, 122, 162);
  rect(1, 0, 1278, 719);

  fill(0, 79, 135);
  beginShape();
  // Add the vertices for the first coral reef here (from scene 3)
  vertex(1278.84, 718.937);
vertex(1278.84, 473.969);
vertex(1263.71, 474.812);
vertex(1244.16, 472.719);
vertex(1250.94, 432.802);
vertex(1256.38, 405.542);
vertex(1253.88, 340.755);
vertex(1237.22, 329.687);
vertex(1236.31, 405.745);
vertex(1224, 468.391);
vertex(1223.03, 473.062);
vertex(1218.98, 474.203);
vertex(1227.36, 410.984);
vertex(1222.02, 308.589);
vertex(1220.64, 259.464);
vertex(1217.75, 258.807);
vertex(1205.82, 300.057);
vertex(1207.39, 369.203);
vertex(1210.37, 401.839);
vertex(1197.65, 369.812);
vertex(1197.28, 326.844);
vertex(1183.61, 290.38);
vertex(1167.53, 283.771);
vertex(1179.61, 334.474);
vertex(1179.74, 353.979);
vertex(1188.71, 401.026);
vertex(1198.1, 426.594);
vertex(1201.93, 456.245);
vertex(1199.29, 456.589);
vertex(1186.3, 429.365);
vertex(1172.11, 377.641);
vertex(1141.35, 306.979);
vertex(1134.24, 297.333);
vertex(1132.18, 298.667);
vertex(1132.64, 302.245);
vertex(1134.95, 333.052);
vertex(1143.18, 371.016);
vertex(1158.72, 396.26);
vertex(1169.54, 422.969);
vertex(1167.87, 430.724);
vertex(1160.84, 427.771);
vertex(1153.44, 415.953);
vertex(1142.64, 389.193);
vertex(1132.46, 373.766);
vertex(1129.78, 375.172);
vertex(1133.03, 390.115);
vertex(1139.23, 419.828);
vertex(1163.91, 452.214);
vertex(1187.79, 475.203);
vertex(1194.28, 493.479);
vertex(1191.4, 498.651);
vertex(1145.45, 525.302);
vertex(1066.87, 518.75);
vertex(1070.92, 516.125);
vertex(1072.56, 503.807);
vertex(1062.89, 498.057);
vertex(1050.93, 504.745);
vertex(1048.54, 509.906);
vertex(1046.04, 495.682);
vertex(1072.9, 467.016);
vertex(1075.44, 455.682);
vertex(1059.43, 445.589);
vertex(1050.67, 446.807);
vertex(1047.44, 460.5);
vertex(1044.72, 463.422);
vertex(1042.94, 450.573);
vertex(1046.19, 443.24);
vertex(1040.22, 430.38);
vertex(1012.55, 439.068);
vertex(1011.09, 446.432);
vertex(1017.69, 458.448);
vertex(1025.8, 473.125);
vertex(1023.03, 486.208);
vertex(1017.5, 484.818);
vertex(1015.86, 477.349);
vertex(1007.37, 471.203);
vertex(992.776, 481.63);
vertex(997.776, 494.401);
vertex(1006.62, 500.76);
vertex(1007.31, 506.573);
vertex(1002.85, 503.932);
vertex(997.557, 497.917);
vertex(991.198, 493.901);
vertex(984.292, 495.167);
vertex(975.568, 508.875);
vertex(993.401, 524.552);
vertex(1021.59, 537.943);
vertex(1020.16, 540.083);
vertex(968.443, 622.833);
vertex(932.495, 644.526);
vertex(849.057, 693.839);
vertex(849.057, 718.875);
vertex(1278.84, 718.937);
endShape(CLOSE);
  endShape(CLOSE);

  fill(0, 79, 135);
  beginShape();
  // Add the vertices for the second coral reef here (from scene 3)
  vertex(469.219, 666.427);
vertex(439.651, 664.229);
vertex(428.865, 663.427);
vertex(419.094, 657.531);
vertex(413.37, 648.359);
vertex(375.552, 587.839);
vertex(368.813, 577.047);
vertex(356.609, 570.932);
vertex(343.932, 571.995);
vertex(283.917, 577);
vertex(269.745, 578.182);
vertex(256.339, 570.406);
vertex(250.318, 557.51);
vertex(244.182, 544.354);
vertex(230.365, 536.557);
vertex(215.932, 538.099);
vertex(197.464, 540.078);
vertex(177.063, 542.26);
vertex(159.411, 526.005);
vertex(159.901, 505.495);
vertex(161.125, 454.208);
vertex(161.547, 436.375);
vertex(148.109, 421.24);
vertex(130.349, 419.583);
vertex(88.349, 415.635);
vertex(76.4792, 414.526);
vertex(66.0677, 407.271);
vertex(60.901, 396.51);
vertex(42.2188, 357.573);
vertex(37.3594, 347.469);
vertex(27.8385, 340.401);
vertex(16.7656, 338.698);
vertex(1.75, 336.391);
vertex(1.75, 718.625);
vertex(500.667, 718.625);
vertex(500.667, 700.307);
vertex(500.667, 682.521);
vertex(486.953, 667.75);
vertex(469.219, 666.438);
endShape(CLOSE);

// Detail Terumbu karang kedua
beginShape();
vertex(250.24, 508.031);
vertex(249.286, 503.76);
vertex(246.786, 500.615);
vertex(242.391, 499.422);
vertex(237.917, 498.208);
vertex(235.583, 499.422);
vertex(233.391, 503.552);
vertex(232.422, 505.375);
vertex(231.042, 506.984);
vertex(229.849, 508.693);
vertex(229.417, 508.526);
vertex(228.979, 508.365);
vertex(228.547, 508.203);
vertex(228.641, 507.047);
vertex(228.5, 505.802);
vertex(228.88, 504.755);
vertex(230.641, 499.87);
vertex(233.823, 496.24);
vertex(238.359, 493.609);
vertex(240.995, 492.078);
vertex(243.531, 490.182);
vertex(245.635, 487.995);
vertex(248.125, 485.401);
vertex(248.047, 482.026);
vertex(246.255, 479.073);
vertex(243.979, 475.318);
vertex(240.646, 472.677);
vertex(235.995, 472.958);
vertex(232.453, 473.167);
vertex(231.63, 476.354);
vertex(230.672, 479.057);
vertex(229.974, 481.021);
vertex(229.766, 483.167);
vertex(229.052, 485.12);
vertex(228.771, 485.875);
vertex(227.708, 486.339);
vertex(227.005, 486.938);
vertex(226.484, 486.188);
vertex(225.51, 485.432);
vertex(225.516, 484.688);
vertex(225.547, 482.219);
vertex(225.562, 479.641);
vertex(226.276, 477.318);
vertex(227.24, 474.198);
vertex(228.891, 471.287);
vertex(230.177, 468.26);
vertex(232.401, 463.052);
vertex(230.917, 459.323);
vertex(225.734, 457.094);
vertex(221.448, 455.255);
vertex(217.198, 455.396);
vertex(213.021, 457.516);
vertex(210.635, 458.724);
vertex(209.271, 460.682);
vertex(209.672, 463.323);
vertex(210.083, 466.063);
vertex(210.99, 468.719);
vertex(211.635, 471.427);
vertex(212.271, 474.13);
vertex(213.156, 476.823);
vertex(213.349, 479.563);
vertex(213.521, 481.953);
vertex(211.76, 482.984);
vertex(209.536, 482.057);
vertex(208.099, 481.448);
vertex(206.734, 480.516);
vertex(205.568, 479.469);
vertex(203.479, 477.604);
vertex(201.62, 475.505);
vertex(199.583, 473.594);
vertex(197.062, 471.234);
vertex(194.047, 470.969);
vertex(191.469, 473.167);
vertex(187.422, 476.615);
vertex(185.281, 481.172);
vertex(184.703, 486.432);
vertex(184.427, 488.901);
vertex(185.646, 490.448);
vertex(188.047, 490.984);
vertex(190.089, 491.443);
vertex(192.135, 491.938);
vertex(194.203, 492.208);
vertex(203.839, 493.474);
vertex(210.385, 498.453);
vertex(213.333, 507.891);
vertex(214.542, 511.75);
vertex(214.339, 515.219);
vertex(212.448, 515.948);
vertex(209.333, 517.135);
vertex(207.302, 514.833);
vertex(205.568, 512.891);
vertex(203.187, 510.229);
vertex(201.161, 507.229);
vertex(199.057, 504.328);
vertex(196.922, 501.385);
vertex(193.885, 500.266);
vertex(191.714, 502.537);
vertex(188.531, 505.859);
vertex(185.516, 509.578);
vertex(183.37, 513.62);
vertex(181.359, 517.401);
vertex(182.802, 520.5);
vertex(186.562, 522.745);
vertex(189.724, 524.63);
vertex(192.995, 526.375);
vertex(196.344, 527.906);
vertex(204.115, 531.448);
vertex(209.318, 537.401);
vertex(212.672, 545.063);
vertex(213.828, 547.693);
vertex(214.516, 550.542);
vertex(215.37, 553.297);
vertex(216.255, 556.156);
vertex(218.036, 557.469);
vertex(220.755, 556.365);
vertex(222.375, 555.714);
vertex(224.161, 554.078);
vertex(224.724, 552.474);
vertex(226.547, 547.313);
vertex(228.099, 542.021);
vertex(229.266, 536.662);
vertex(230.911, 529.177);
vertex(235.026, 523.62);
vertex(241.266, 519.453);
vertex(242.76, 518.458);
vertex(244.318, 517.547);
vertex(245.771, 516.5);
vertex(248.635, 514.427);
vertex(251.089, 511.953);
vertex(250.219, 508.047);
endShape(CLOSE);

// Detail Terumbu karang kedua - bagian bawah
beginShape();
vertex(205.099, 421.896);
vertex(204.125, 419.552);
vertex(202.401, 419.359);
vertex(200.766, 419.839);
vertex(198.135, 420.609);
vertex(195.599, 421.708);
vertex(193.031, 422.698);
vertex(191.042, 423.464);
vertex(189.104, 424.365);
vertex(187.078, 425.026);
vertex(185.547, 425.531);
vertex(183.547, 425.917);
vertex(182.901, 424.078);
vertex(182.599, 423.219);
vertex(183.724, 421.469);
vertex(184.661, 420.63);
vertex(186.094, 419.349);
vertex(187.979, 418.583);
vertex(189.578, 417.464);
vertex(191.198, 416.328);
vertex(192.698, 415.042);
vertex(194.25, 413.823);
vertex(193.88, 412.714);
vertex(192.698, 412.745);
vertex(191.406, 412.474);
vertex(190.359, 412.87);
vertex(188.458, 413.589);
vertex(186.729, 414.74);
vertex(184.901, 415.656);
vertex(181.656, 417.292);
vertex(178.479, 419.151);
vertex(175.088, 420.411);
vertex(173.115, 421.151);
vertex(170.781, 420.932);
vertex(168.609, 421.151);
vertex(168.562, 420.839);
vertex(168.51, 420.536);
vertex(168.463, 420.229);
vertex(173.656, 415.187);
vertex(178.99, 410.37);
vertex(186.901, 410.406);
vertex(189.917, 410.422);
vertex(192.312, 409.234);
vertex(194.786, 407.651);
vertex(196.724, 406.411);
vertex(199.12, 405.875);
vertex(201.297, 405.005);
vertex(202.01, 404.719);
vertex(202.906, 404.531);
vertex(203.349, 403.995);
vertex(206.286, 400.464);
vertex(210.099, 399.687);
vertex(214.417, 400.115);
vertex(218.75, 400.542);
vertex(223.385, 397.844);
vertex(225.516, 393.656);
vertex(224.802, 393.745);
vertex(224.213, 393.807);
vertex(223.635, 393.917);
vertex(221.365, 394.339);
vertex(219.099, 394.849);
vertex(216.812, 395.151);
vertex(216.146, 395.24);
vertex(215.083, 394.958);
vertex(214.781, 394.479);
vertex(214.479, 393.995);
vertex(214.766, 393.01);
vertex(215.021, 392.333);
vertex(215.302, 391.599);
vertex(215.911, 391);
vertex(216.24, 390.271);
vertex(216.99, 388.594);
vertex(216.198, 387.557);
vertex(214.557, 387.568);
vertex(213.62, 387.568);
vertex(212.51, 388.141);
vertex(211.792, 388.802);
vertex(210.146, 390.292);
vertex(208.75, 392.052);
vertex(207.156, 393.609);
vertex(202.948, 397.724);
vertex(198.203, 401);
vertex(192.427, 402.682);
vertex(194.198, 400.708);
vertex(195.984, 398.698);
vertex(198.187, 397.359);
vertex(208.922, 390.812);
vertex(215.562, 380.448);
vertex(223.068, 370.901);
vertex(226.229, 366.88);
vertex(227.719, 362.214);
vertex(227.708, 356.562);
vertex(225.625, 357.568);
vertex(223.828, 358.448);
vertex(221.495, 359.573);
vertex(222.588, 357.708);
vertex(223.625, 356.5);
vertex(224.005, 355.109);
vertex(224.286, 354.109);
vertex(224.073, 352.385);
vertex(223.401, 351.854);
vertex(222.687, 351.297);
vertex(220.719, 351.312);
vertex(220.088, 351.911);
vertex(218.812, 353.135);
vertex(217.745, 354.823);
vertex(217.182, 356.505);
vertex(216.588, 358.323);
vertex(216.625, 360.365);
vertex(216.463, 362.312);
vertex(215.776, 370.276);
vertex(211.588, 376.573);
vertex(207.062, 382.932);
vertex(204.87, 381.047);
vertex(204.396, 378.865);
vertex(205.099, 376.661);
vertex(205.844, 374.318);
vertex(207.141, 372.151);
vertex(208.094, 369.865);
vertex(208.354, 369.24);
vertex(208.49, 367.917);
vertex(208.302, 367.839);
vertex(206.807, 367.219);
vertex(205.156, 366.318);
vertex(203.682, 366.516);
vertex(202.505, 366.667);
vertex(201.078, 368.042);
vertex(200.542, 369.229);
vertex(199.979, 370.495);
vertex(200.01, 372.26);
vertex(200.359, 373.661);
vertex(201.979, 380.292);
vertex(199.995, 385.99);
vertex(195.49, 390.62);
vertex(190.344, 395.896);
vertex(184.687, 400.672);
vertex(179.213, 405.615);
vertex(178.844, 405.953);
vertex(177.979, 406.208);
vertex(177.646, 406.005);
vertex(177.276, 405.781);
vertex(176.979, 404.896);
vertex(177.13, 404.453);
vertex(178.463, 400.312);
vertex(179.797, 396.177);
vertex(181.354, 392.115);
vertex(182.156, 390.01);
vertex(183.943, 388.964);
vertex(186.213, 388.365);
vertex(187.729, 387.969);
vertex(189.375, 386.969);
vertex(190.359, 385.75);
vertex(193.073, 382.396);
vertex(193.74, 378.359);
vertex(193.109, 374.146);
vertex(192.823, 372.229);
vertex(191.755, 370.766);
vertex(189.682, 370.589);
vertex(187.641, 370.411);
vertex(187.026, 372.057);
vertex(186.505, 373.609);
vertex(185.76, 375.823);
vertex(185.078, 378.057);
vertex(184.187, 380.859);
vertex(182.115, 378.583);
vertex(180.463, 376.776);
vertex(178.812, 374.969);
vertex(176.646, 376.349);
vertex(175.958, 378.135);
vertex(177.375, 380.255);
vertex(178.812, 382.391);
vertex(178.5, 384.219);
vertex(177.422, 386.208);
vertex(175.818, 389.182);
vertex(174.088, 392.099);
vertex(172.641, 395.151);
vertex(171.849, 396.807);
vertex(171.115, 398.667);
vertex(171.057, 400.453);
vertex(170.891, 406.792);
vertex(165.818, 414.172);
vertex(159.927, 416.182);
vertex(156.625, 417.318);
vertex(154.698, 416.323);
vertex(154.24, 412.839);
vertex(154.078, 411.589);
vertex(154.615, 409.948);
vertex(155.396, 408.932);
vertex(158.656, 404.719);
vertex(162.161, 400.687);
vertex(165.526, 396.547);
vertex(167.484, 394.135);
vertex(169.437, 391.714);
vertex(171.213, 389.167);
vertex(172.167, 387.807);
vertex(172.557, 386.115);
vertex(171.026, 384.802);
vertex(169.391, 383.396);
vertex(167.687, 384.115);
vertex(166.495, 385.38);
vertex(164.687, 387.297);
vertex(163.193, 389.495);
vertex(161.542, 391.589);
vertex(158.333, 389.464);
vertex(157.099, 390.042);
vertex(156.583, 394.12);
vertex(156.495, 394.797);
vertex(156.094, 395.437);
vertex(155.766, 396.062);
vertex(153.25, 400.865);
vertex(150.713, 405.661);
vertex(148.187, 410.464);
vertex(147.776, 411.245);
vertex(147.344, 412.021);
vertex(146.917, 412.797);
vertex(147, 409.854);
vertex(147.146, 407.068);
vertex(147.937, 404.474);
vertex(150.745, 395.286);
vertex(153.734, 386.146);
vertex(156.766, 377.026);
vertex(157.187, 375.766);
vertex(158.307, 374.766);
vertex(158.891, 373.547);
vertex(159.385, 372.505);
vertex(160.021, 371.187);
vertex(159.76, 370.224);
vertex(159.495, 369.255);
vertex(158.286, 368.437);
vertex(157.323, 367.792);
vertex(156.766, 367.422);
vertex(155.901, 367.505);
vertex(155.068, 367.365);
vertex(155.479, 366.271);
vertex(155.901, 365.38);
vertex(156.146, 364.443);
vertex(157.052, 361.062);
vertex(157.885, 357.641);
vertex(156.349, 354.24);
vertex(155.005, 351.266);
vertex(151.823, 351);
vertex(150.057, 353.729);
vertex(149.443, 354.672);
vertex(148.969, 355.818);
vertex(148.797, 356.927);
vertex(148.24, 360.536);
vertex(147.792, 364.161);
vertex(147.422, 367.792);
vertex(146.76, 374.177);
vertex(146.25, 380.562);
vertex(145.552, 386.937);
vertex(145.365, 388.599);
vertex(144.854, 390.26);
vertex(144.25, 391.828);
vertex(142.953, 395.193);
vertex(139.755, 395.484);
vertex(136.901, 395.573);
vertex(136.016, 395.604);
vertex(134.807, 393.547);
vertex(134.182, 392.24);
vertex(130.505, 384.578);
vertex(132.641, 377.141);
vertex(135.333, 369.781);
vertex(135.625, 369.005);
vertex(136.5, 368.469);
vertex(137.026, 367.76);
vertex(138.63, 365.604);
vertex(140.682, 363.62);
vertex(141.682, 361.193);
vertex(143.474, 356.849);
vertex(144.635, 352.245);
vertex(146.026, 347.734);
vertex(147.016, 344.495);
vertex(148.521, 342.099);
vertex(152.365, 341.453);
vertex(155.463, 340.943);
vertex(156.609, 338.021);
vertex(155.588, 335.349);
vertex(152.234, 335.422);
vertex(148.963, 335.484);
vertex(145.125, 335.562);
vertex(147.156, 331.755);
vertex(148.979, 328.792);
vertex(150.312, 325.615);
vertex(150.838, 324.365);
vertex(150.838, 322.135);
vertex(150.062, 321.297);
vertex(149.141, 320.297);
vertex(147.062, 319.849);
vertex(145.599, 320.036);
vertex(144.151, 320.219);
vertex(142.536, 321.229);
vertex(141.536, 322.365);
vertex(139.5, 324.677);
vertex(137.536, 327.161);
vertex(136.088, 329.865);
vertex(133.979, 333.792);
vertex(134.073, 337.786);
vertex(136.562, 341.786);
vertex(137.443, 343.208);
vertex(137.818, 345.406);
vertex(137.484, 347.052);
vertex(136.141, 353.604);
vertex(132.995, 359.396);
vertex(129.026, 364.729);
vertex(128.677, 365.193);
vertex(127.656, 365.698);
vertex(127.338, 365.51);
vertex(126.797, 365.193);
vertex(126.312, 364.37);
vertex(126.25, 363.719);
vertex(125.979, 360.708);
vertex(125.854, 357.677);
vertex(125.693, 354.651);
vertex(125.213, 345.839);
vertex(124.547, 337.036);
vertex(126.5, 328.292);
vertex(127.818, 322.38);
vertex(130.734, 317.62);
vertex(135.979, 314.349);
vertex(137.693, 313.286);
vertex(139.427, 312.016);
vertex(140.635, 310.437);
vertex(143.568, 306.609);
vertex(141.156, 301.182);
vertex(136.443, 300.422);
vertex(134.802, 300.161);
vertex(134.062, 300.594);
vertex(133.646, 302.286);
vertex(132.995, 304.948);
vertex(132.312, 307.682);
vertex(131.104, 310.115);
vertex(129.406, 313.51);
vertex(126.641, 315.771);
vertex(121.844, 315.896);
vertex(123.276, 310.51);
vertex(124.469, 305.437);
vertex(125.99, 300.464);
vertex(127.838, 294.391);
vertex(131.354, 289.281);
vertex(135.682, 284.661);
vertex(138.229, 281.964);
vertex(140.198, 278.859);
vertex(139.786, 274.88);
vertex(139.583, 272.917);
vertex(138.854, 271.073);
vertex(136.599, 270.844);
vertex(134.187, 270.604);
vertex(133.187, 272.349);
vertex(132.646, 274.391);
vertex(132.182, 276.125);
vertex(131.74, 277.854);
vertex(131.088, 280.323);
vertex(130.026, 276.885);
vertex(129.213, 274.255);
vertex(128.401, 271.63);
vertex(128.068, 271.573);
vertex(127.724, 271.526);
vertex(127.391, 271.474);
vertex(125.37, 274.641);
vertex(122.844, 277.609);
vertex(121.453, 281.036);
vertex(119.844, 285.036);
vertex(119.005, 289.391);
vertex(118.26, 293.672);
vertex(117.088, 300.417);
vertex(115.625, 307.208);
vertex(115.484, 314.01);
vertex(115.318, 322.146);
vertex(116.422, 330.312);
vertex(116.943, 338.474);
vertex(117.161, 341.87);
vertex(117.286, 345.281);
vertex(117.448, 348.687);
vertex(117.224, 348.719);
vertex(117, 348.76);
vertex(116.771, 348.792);
vertex(116.484, 348.177);
vertex(116.057, 347.594);
vertex(115.922, 346.958);
vertex(114.651, 341.151);
vertex(113.052, 335.391);
vertex(112.323, 329.51);
vertex(111.766, 325.047);
vertex(112.323, 320.453);
vertex(112.396, 315.911);
vertex(112.427, 313.885);
vertex(111.625, 312.276);
vertex(109.578, 311.969);
vertex(107.307, 311.625);
vertex(106.906, 313.536);
vertex(106.495, 315.219);
vertex(106.432, 315.479);
vertex(106.463, 315.781);
vertex(106.338, 316.005);
vertex(105.729, 317.099);
vertex(105.083, 318.172);
vertex(104.448, 319.255);
vertex(103.354, 318.526);
vertex(101.948, 318.016);
vertex(101.234, 317.016);
vertex(99.078, 314);
vertex(97.1874, 310.802);
vertex(95.1926, 307.677);
vertex(94.427, 314.219);
vertex(93.9322, 320.625);
vertex(99.8072, 325.245);
vertex(104.208, 328.703);
vertex(106.203, 333.193);
vertex(105.812, 338.797);
vertex(105.75, 339.708);
vertex(105.885, 340.99);
vertex(106.458, 341.516);
vertex(109.495, 344.302);
vertex(109.687, 348.042);
vertex(110.479, 351.708);
vertex(111.047, 354.318);
vertex(111.88, 357.339);
vertex(113.651, 359.135);
vertex(120.354, 365.979);
vertex(122.151, 374.339);
vertex(122.323, 383.391);
vertex(122.354, 384.906);
vertex(122.26, 386.427);
vertex(122.213, 388.307);
vertex(118.057, 385.714);
vertex(116.042, 382.141);
vertex(114.75, 378.234);
vertex(113.208, 373.599);
vertex(112.151, 368.797);
vertex(110.745, 364.115);
vertex(110.078, 361.917);
vertex(109.177, 359.776);
vertex(108.146, 357.724);
vertex(107.828, 357.094);
vertex(106.713, 356.88);
vertex(105.953, 356.469);
vertex(105.588, 357.203);
vertex(104.891, 357.958);
vertex(104.922, 358.672);
vertex(105.005, 360.698);
vertex(105.307, 362.734);
vertex(105.682, 364.734);
vertex(106.094, 366.917);
vertex(106.838, 369.052);
vertex(107.13, 371.24);
vertex(107.432, 373.495);
vertex(107.943, 376.479);
vertex(105.385, 377.349);
vertex(102.536, 378.323);
vertex(101.208, 375.443);
vertex(100.266, 373.307);
vertex(98.651, 369.651);
vertex(97.5051, 365.781);
vertex(95.9843, 362.078);
vertex(95.0103, 359.703);
vertex(93.8905, 357.354);
vertex(92.5051, 355.203);
vertex(91.3749, 353.437);
vertex(89.5728, 352.781);
vertex(87.3645, 353.984);
vertex(88.9166, 358.651);
vertex(90.5989, 363.151);
vertex(91.901, 367.771);
vertex(94.6614, 377.521);
vertex(100.333, 384.693);
vertex(109.641, 388.901);
vertex(114.594, 391.141);
vertex(117.818, 394.979);
vertex(119.812, 400.036);
vertex(122.781, 407.573);
vertex(125.963, 415.036);
vertex(128.958, 422.562);
vertex(129.641, 424.281);
vertex(130.229, 426.146);
vertex(130.307, 427.969);
vertex(130.391, 430.062);
vertex(130.26, 432.359);
vertex(129.432, 434.219);
vertex(129.021, 435.141);
vertex(126.75, 435.109);
vertex(125.479, 435.807);
vertex(123.401, 436.943);
vertex(121.271, 438.104);
vertex(119.51, 439.661);
vertex(118.375, 440.661);
vertex(117.875, 442.391);
vertex(116.974, 443.99);
vertex(127.99, 445.807);
vertex(138.391, 447.516);
vertex(149, 449.26);
vertex(149.588, 443.573);
vertex(146.266, 440.391);
vertex(141.823, 437.276);
vertex(143.193, 436.453);
vertex(144.187, 435.661);
vertex(145.318, 435.214);
vertex(151.588, 432.687);
vertex(157.901, 430.25);
vertex(164.193, 427.776);
vertex(167.406, 426.5);
vertex(170.573, 426.719);
vertex(173.849, 427.719);
vertex(176.812, 428.62);
vertex(179.865, 429.552);
vertex(182.917, 429.714);
vertex(191.286, 430.156);
vertex(197.677, 424.792);
vertex(205.062, 421.911);
endShape(CLOSE);

  pushMatrix();
  translate(characterX, characterY);
  rotate(angle);
  scale(0.5); 
  drawCharacter();
  popMatrix();

  characterX += velocityX;
  characterY += velocityY;
  velocityX += random(-0.1, 0.1);
  velocityY += random(-0.1, 0.1);
  velocityX = constrain(velocityX, -3, 3);
  velocityY = constrain(velocityY, -3, 3);
  if (characterX < 0 || characterX > width) velocityX *= -1;
  if (characterY < 0 || characterY > height) velocityY *= -1;
  angle += 0.02;

  // mySound.play(); // Tidak perlu memanggil play di sini karena sudah diatur di metode draw
}

void drawCharacter() {
  fill(#F8D8B6);
  beginShape();
  vertex(149, 61);
  bezierVertex(146, 69, 141, 75, 133, 78);
  vertex(116, 84);
  bezierVertex(109, 86, 103, 85, 98, 80);
  vertex(87, 78);
  bezierVertex(79, 75, 74, 70, 71, 62);
  bezierVertex(75, 55, 76, 48, 77, 41);
  bezierVertex(80, 39, 82, 37, 84, 34);
  bezierVertex(88, 35, 91, 36, 95, 37);
  bezierVertex(110, 38, 125, 37, 140, 34);
  bezierVertex(140, 37, 141, 39, 144, 41);
  bezierVertex(145, 47, 146, 54, 147, 60);
  endShape(CLOSE);

  fill(#323232);
  beginShape();
  vertex(149, 61);
  bezierVertex(148, 61, 147, 61, 147, 60);
  bezierVertex(146, 54, 145, 47, 144, 41);
  bezierVertex(141, 39, 140, 37, 140, 34);
  bezierVertex(125, 37, 110, 38, 95, 37);
  bezierVertex(91, 36, 88, 35, 84, 34);
  bezierVertex(82, 37, 80, 39, 77, 41);
  bezierVertex(76, 48, 75, 55, 75, 62);
  bezierVertex(73, 63, 72, 63, 71, 62);
  bezierVertex(63, 49, 62, 35, 69, 21);
  bezierVertex(72, 16, 77, 12, 84, 11);
  bezierVertex(85, 11, 87, 12, 89, 12);
  bezierVertex(94, 9, 99, 7, 106, 8);
  bezierVertex(113, 8, 120, 9, 127, 11);
  bezierVertex(132, 10, 137, 7, 141, 3);
  bezierVertex(142, 5, 143, 7, 144, 9);
  bezierVertex(147, 7, 151, 4, 154, 1);
  vertex(156, 3);
  bezierVertex(156, 5, 156, 8, 157, 10);
  bezierVertex(159, 9, 161, 8, 163, 6);
  bezierVertex(166, 15, 164, 22, 157, 28);
  bezierVertex(157, 40, 154, 51, 149, 61);
  endShape(CLOSE);

  fill(#15110F);
  ellipse(95, 49, 10, 10);

  fill(#1E1917);
  ellipse(125, 49, 10, 10);

  fill(#33C8C8);
  beginShape();
  vertex(87, 78);
  bezierVertex(91, 79, 94, 79, 98, 80);
  bezierVertex(103, 85, 109, 86, 116, 84);
  bezierVertex(121, 80, 127, 78, 133, 78);
  bezierVertex(146, 79, 158, 81, 171, 82);
  vertex(171, 92);
  bezierVertex(160, 93, 148, 93, 137, 93);
  vertex(137, 148);
  vertex(135, 150);
  bezierVertex(128, 152, 122, 154, 115, 155);
  vertex(104, 155);
  bezierVertex(98, 154, 91, 152, 85, 150);
  vertex(84, 148);
  vertex(83, 93);
  vertex(49, 93);
  vertex(49, 82);
  bezierVertex(62, 81, 74, 79, 87, 78);
  endShape(CLOSE);

  fill(#6F6B63);
  beginShape();
  vertex(85, 150);
  bezierVertex(91, 152, 98, 154, 104, 155);
  vertex(102, 199);
  vertex(100, 201);
  vertex(97, 206);
  vertex(97, 201);
  vertex(89, 201);
  vertex(85, 201);
  endShape(CLOSE);

  beginShape();
  vertex(135, 150);
  bezierVertex(134, 168, 133, 186, 131, 204);
  vertex(129, 201);
  vertex(127, 206);
  vertex(127, 201);
  vertex(122, 201);
  vertex(120, 205);
  bezierVertex(119, 199, 118, 194, 117, 188);
  bezierVertex(117, 177, 116, 166, 115, 155);
  bezierVertex(122, 154, 128, 152, 135, 150);
  endShape(CLOSE);

  fill(#F7CDA0);
  beginShape();
  vertex(49, 82);
  vertex(49, 93);
  vertex(10, 93);
  bezierVertex(8, 88, 9, 85, 14, 84);
  bezierVertex(26, 83, 37, 82, 49, 82);
  endShape(CLOSE);

  fill(#F7CC9F);
  beginShape();
  vertex(171, 82);
  bezierVertex(183, 82, 196, 83, 208, 85);
  bezierVertex(211, 86, 212, 89, 210, 92);
  bezierVertex(197, 93, 184, 93, 171, 92);
  vertex(171, 82);
  endShape(CLOSE);

  fill(#403C38);
  beginShape();
  vertex(89, 201);
  vertex(92, 201);
  vertex(92, 207);
  bezierVertex(94, 207, 96, 207, 97, 206);
  bezierVertex(97, 204, 98, 202, 100, 201);
  bezierVertex(101, 206, 99, 210, 95, 213);
  bezierVertex(91, 210, 89, 206, 89, 201);
  endShape(CLOSE);

  fill(#3C3834);
  beginShape();
  vertex(122, 201);
  bezierVertex(122, 203, 122, 205, 123, 207);
  bezierVertex(125, 209, 126, 208, 127, 206);
  bezierVertex(128, 204, 128, 203, 129, 201);
  bezierVertex(130, 202, 130, 203, 130, 204);
  bezierVertex(130, 208, 128, 211, 125, 213);
  bezierVertex(122, 211, 120, 208, 120, 205);
  bezierVertex(120, 203, 120, 202, 122, 201);
  endShape(CLOSE);

  fill(#EBF0F0);
  rect(92, 201, 5, 6);

  fill(#DEE3E2);
  rect(122, 201, 5, 6);
}

void scene4() {
  if (frameCount % 300 == 0) {
    isSunny = !isSunny;
  }
  
  if (isSunny) {
    drawSunnySky();
  } else {
    drawStormySky();
  }
  
  fill(255, 220, 180);
  rect(0, height*0.5, width, height*0.5);
  
  fill(isSunny ? color(100, 180, 255) : color(50, 90, 120));
  beginShape();
  vertex(0, height*0.7);
  for (int x = 0; x <= width; x += 20) {
    float y = height*0.7 + sin(x*0.02 + frameCount*0.02) * 15;
    vertex(x, y);
  }
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);
  
  pushMatrix();
  translate(width/2, height*0.6);
  scale(1.5);
  rotate(sin(frameCount * 0.05) * 0.1);
  drawSwimmingCharacter(!isSunny);
  popMatrix();
}

void drawSunnySky() {
  background(220, 240, 255);
  
  fill(255, 200, 0);
  ellipse(100, 100, 120, 120);
}

void drawStormySky() {
  background(50, 50, 70);
  
  fill(30, 30, 40);
  noStroke();
  ellipse(200, 100, 200, 80);
  ellipse(400, 80, 250, 100);
  ellipse(600, 120, 180, 70);
  
  if (random(1) < 0.05) {
    stroke(255, 255, 0);
    strokeWeight(3);
    float x1 = random(width);
    float y1 = 0;
    float x2 = x1 + random(-50, 50);
    float y2 = random(height/3);
    line(x1, y1, x2, y2);
  }
}

void drawSwimmingCharacter(boolean isPanicked) {
  noStroke();
  
  fill(248, 206, 162);
  drawArm(36.5, 75.5, 2.5, 87);
  drawArm(135.5, 76.5, 167.5, 78);
  
  fill(49, 49, 49);
  drawBody();
  
  fill(248, 216, 181);
  drawFace();
  
  fill(28, 23, 21);
  if (isPanicked) {
    ellipse(68.5, 39.5, 10, 15);
    ellipse(98.5, 39.5, 10, 15);
  } else {
    ellipse(68.5, 39.5, 8, 8);
    ellipse(98.5, 39.5, 8, 8);
  }
  
  fill(234, 69, 65);
  if (isPanicked) {
    ellipse(83, 55, 15, 20);
  } else {
    arc(83, 55, 15, 10, 0, PI);
  }
  
  fill(252, 152, 152);
  drawClothes();
}

void drawArm(float x1, float y1, float x2, float y2) {
  beginShape();
  vertex(x1, y1);
  bezierVertex(x1-3, y1+4, x1-4, y1+8, x1-1, y1+12);
  bezierVertex(x2-8, y1+12, x2-4, y1+12, x2, y2);
  bezierVertex(x2-3, y2-4, x2-2, y2-7, x2+2, y2-10);
  bezierVertex(x1+10, y1+1, x1+20, y1+1, x1, y1);
  endShape(CLOSE);
}

void drawBody() {
  beginShape();
  vertex(63.5, 2.5);
  bezierVertex(63.4208, 3.9305, 63.7542, 5.2638, 64.5, 6.5);
  bezierVertex(69.1739, 9.497, 71.8406, 8.1636, 72.5, 2.5);
  bezierVertex(92.713, -1.70548, 109.879, 3.6279, 124, 18.5);
  bezierVertex(129.095, 26.131, 130.761, 34.4643, 129, 43.5);
  bezierVertex(127.465, 50.2365, 125.798, 56.9031, 124, 63.5);
  bezierVertex(122.005, 65.747, 119.505, 66.747, 116.5, 66.5);
  bezierVertex(114.855, 65.5213, 113.521, 64.188, 112.5, 62.5);
  bezierVertex(120.935, 54.2468, 120.435, 46.5802, 111, 39.5);
  bezierVertex(110.771, 36.5424, 109.604, 34.0424, 107.5, 32);
  bezierVertex(94.808, 34.294, 82.141, 33.9607, 69.5, 31);
  bezierVertex(67.2537, 29.9605, 65.087, 28.7938, 63, 27.5);
  bezierVertex(59.6667, 32.8333, 56.3333, 38.1667, 53, 43.5);
  bezierVertex(51.3816, 52.2633, 54.5483, 58.5966, 62.5, 62.5);
  bezierVertex(60.9881, 65.3491, 58.6548, 67.0158, 55.5, 67.5);
  bezierVertex(52.1694, 67.9819, 49.5027, 66.9819, 47.5, 64.5);
  bezierVertex(45.8564, 63.6836, 44.6897, 62.3502, 44, 60.5);
  bezierVertex(44.0116, 52.3039, 42.8449, 44.3039, 40.5, 36.5);
  bezierVertex(41.0124, 33.8141, 41.179, 31.1475, 41, 28.5);
  bezierVertex(40.7679, 29.7375, 40.2679, 30.7375, 39.5, 31.5);
  bezierVertex(38.7781, 24.8414, 38.6114, 18.1747, 39, 11.5);
  bezierVertex(44.6845, 1.4408, 52.8512, -1.55923, 63.5, 2.5);
  endShape(CLOSE);
}

void drawFace() {
  beginShape();
  vertex(116.5, 66.5);
  bezierVertex(113.308, 69.5951, 109.641, 71.9284, 105.5, 73.5);
  bezierVertex(102.482, 73.3354, 99.482, 73.502, 96.5, 74);
  bezierVertex(88.833, 81.3333, 81.167, 81.3333, 73.5, 74);
  bezierVertex(70.854, 73.5026, 68.1873, 73.3359, 65.5, 73.5);
  bezierVertex(61.5801, 72.5375, 58.2467, 70.5375, 55.5, 67.5);
  bezierVertex(58.6548, 67.0158, 60.9881, 65.3491, 62.5, 62.5);
  bezierVertex(54.5483, 58.5966, 51.3816, 52.2633, 53, 43.5);
  bezierVertex(56.3333, 38.1667, 59.6667, 32.8333, 63, 27.5);
  bezierVertex(65.087, 28.7938, 67.2537, 29.9605, 69.5, 31);
  bezierVertex(82.141, 33.9607, 94.808, 34.294, 107.5, 32);
  bezierVertex(109.604, 34.0424, 110.771, 36.5424, 111, 39.5);
  bezierVertex(120.435, 46.5802, 120.935, 54.2468, 112.5, 62.5);
  bezierVertex(113.521, 64.188, 114.855, 65.5213, 116.5, 66.5);
  endShape(CLOSE);
}

void drawClothes() {
  beginShape();
  vertex(65.5, 73.5);
  bezierVertex(68.1873, 73.3359, 70.854, 73.5026, 73.5, 74);
  bezierVertex(81.167, 81.3333, 88.833, 81.3333, 96.5, 74);
  bezierVertex(99.482, 73.502, 102.482, 73.3354, 105.5, 73.5);
  bezierVertex(115.6, 73.9718, 125.6, 74.9718, 135.5, 76.5);
  bezierVertex(137.126, 80.4273, 136.793, 84.094, 134.5, 87.5);
  bezierVertex(126.167, 87.5, 117.833, 87.5, 109.5, 87.5);
  bezierVertex(108.421, 94.984, 107.421, 102.484, 106.5, 110);
  bezierVertex(106.763, 115.552, 107.43, 121.052, 108.5, 126.5);
  bezierVertex(108.427, 128.59, 108.094, 130.59, 107.5, 132.5);
  bezierVertex(100.935, 134.047, 94.268, 134.714, 87.5, 134.5);
  bezierVertex(85.833, 134.5, 84.167, 134.5, 82.5, 134.5);
  bezierVertex(75.7, 134.872, 69.0334, 134.206, 62.5, 132.5);
  bezierVertex(61.9386, 131.092, 61.6052, 129.592, 61.5, 128);
  bezierVertex(62.608, 122.019, 63.608, 116.019, 64.5, 110);
  bezierVertex(62.9222, 102.527, 61.5888, 95.027, 60.5, 87.5);
  bezierVertex(52.1667, 87.5, 43.8333, 87.5, 35.5, 87.5);
  bezierVertex(32.7004, 83.1871, 33.0338, 79.1871, 36.5, 75.5);
  bezierVertex(46.1543, 74.7091, 55.821, 74.0424, 65.5, 73.5);
  endShape(CLOSE);
}

void scene5() {
  background(240);
  
  if (scaleFactor < targetScale) {
    scaleFactor += scaleSpeed;
  }
  
  float scaledWidth = jawaImage.width * scaleFactor;
  float scaledHeight = jawaImage.height * scaleFactor;
  image(jawaImage, width/2, height/2, scaledWidth, scaledHeight);
}
