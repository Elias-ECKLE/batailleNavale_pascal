//amorce d' algo pour le jeu de la bataille

{//ALGORITHME: batailleNav_algo
//BUT: Faire un jeu de bataille navale
//ENTREE: grille de chaque joueur, emplacement des bateaux et leurs tirs
//SORTIE: une des deux grilles sans bateau et un vainqueur

type tabDeChar = tableau[1..10] de CAR

PROCEDURE affichMap()
//But: afficher la map du joueur
//ENTREE: rien
//SORTIE : map dessinée

VAR : map:tableau[1..10, 1..10] de CAR
    i:ENTIER
DEBUT
    POUR i DE 1 A 10 Faire
    DEBUT
        POUR j DE 1 A 10 Faire
        DEBUT
            map[i,j]<--car
            ECRIRE map[i,j]
        FINPOUR
        ECRIRE
    FINPOUR
FINFONCTION


//main program
VAR
DEBUT
    //present jeu
    gotoxy(10,1)
    ECRIRE "Jeu de la bataille"
    ECRIRE"Bienvenue dans le jeu de la bataille programmé avec le magnifique langage qu'est le pascal. Il se déroule à deux joueurs sur une meme machine.
    ECRIRE"Pour cela, merci de jouer le jeu et de ne pas regarder ce que l'adversaire marque sur le poste. En esperant que vous passerez un bon moment, baby Yoda"
FIN
________________________________________________________________________________________________________________________________________________________________________________________________________
}

program batailleNav_algo;
uses crt;

//type de tableau initialisé pour pouvoir l'utiliser ensuite comme map dans le jeu de la bataille suivant
type
    tabChar = array[1..10,'A'..'J'] of char;






function recupNom(nbJ:integer):string;
//BUT: recuperer et stocker le nom du joueur pour pouvoir l'utiliser lors d'interactions machine-joueur
//ENTREE: numero du joueur auquel on va recuperer son nom
//SORTIE: nom du joueur
var nomJ :string;
begin
    if nbJ=1 then
    begin
        gotoxy(42,5);
        writeln('Tout d''abord, Joueur ',nbJ,', quel est votre nom ?');
        gotoxy(50,6);
        readln(nomJ);
        gotoxy(37,8);
        writeln('Vous vous nommez ',nomJ,'. Quel jolie nom ;). Etes-vous pret a en decoudre');
        readln;
        clrscr;
    end;

    if nbJ=2 then
    begin
        gotoxy(42,5);
        writeln('Ensuite, au tour du joueur ',nbJ,'. Comment vous appellez-vous ?');
        gotoxy(50,6);
        readln(nomJ);
        gotoxy(37,8);
        writeln('Vous vous prenommez ',nomJ,'. ');
        gotoxy(30,8);
        writeln('Voila un prenom encore plus adorable que le premier. Tenez vous pret pour la bataille;)');
        readln;
        clrscr;
    end;
    recupNom:=nomJ;
end;
procedure affichMap(var map:tabChar);
//BUT : afficher la map
//ENTREE: la map d'un des joueurs
var i, j, asciiCode:integer;
var enteteMap: array[1..10, 'A'..'J'] of integer;
BEGIN
    //affichage entete tableau, c'est a dire le 1 a 10 fait horizontalement et le A a J affiché verticalement
    i:=1;
    j:=1;
    for i:=1 to 10 do
    begin
        enteteMap[i,'A']:=i;
        gotoxy(i+2,1);
        textcolor(8); //grey=8
        write(enteteMap[i,'A']);

        asciiCode:=64+i;            //Au cours du prog, utilisation de la fonction CHR() et ORD() afin de passer de l'ascii au caractere correspondant et du caractere a l'ascii
        enteteMap[1, CHR(asciiCode)]:= asciiCode;
        gotoxy(1,i+1);
        textcolor(8);
        writeln(CHR(enteteMap[1, CHR(asciiCode)]));
    end;
    textcolor(white);
    //affichage des donnees de la map,  avec une couleur differente selon le caractere a afficher
    for i:=1 to 10 do
    begin
        for j:=1 to 10  do
        begin
            asciiCode:=64+j;
            gotoxy(i+2,j+1);
            if map[i,CHR(asciiCode)]='-' then
                textcolor(blue)
            else if map[i,CHR(asciiCode)]='X' then
                textcolor(green)
            else if map[i,CHR(asciiCode)]='o' then
                textcolor(6)//orange
            else
                textcolor(red);
            writeln(map[i,CHR(asciiCode)]);
                textcolor(white); //ecriture remise a zero pour les autres affichages
        end;
    end;
END;

function mapA_vide(var map:tabChar; car:char):tabChar;
//BUT: mettre le caractere par défaut, définissant donc une map vierge
//ENTREE: la map sans caractere et le caractere qui va la remplir
//SORTIE: tableaumap composé de ce caractere
var i, j,asciiCode:integer;
begin
    for i:=1 to 10 do
    begin
        for j:=1 to 10  do
        begin
            asciiCode:=64+j;
           map[i,CHR(asciiCode)]:=car;
        end;
    end;
    mapA_vide:=map;
end;






function remplacMap(entre1,sortie1:char; entre2, sortie2:integer; map:tabChar; sensPoseBat:char):tabChar;
//BUT: Remplacer les caracteres deja presents dans la map par d'autres caracteres, le tout selon le contexte et les positions donnees par les joueurs
//ENTREE: map d'un des joueurs
//SORTIE: map avec des caracteres ajoutes ou modifies
var mapTemp:tabChar;
var i,j,asciiCode, entre1_N, sortie1_N:integer;
begin
    mapTemp:=map;
    entre1_N:=ord(entre1); //transforme les lettres entres par le joueur en chiffre afin de ne pas faire planter le prog lors de la lecture du tableau
    sortie1_N:=ord(sortie1);

    //si le joueur veut poser verticalement ses bateaux alors les X vont etre poses selon cette configuration
    if sensPoseBat='V' then
    begin
        for i:=entre2 to sortie2 do
        begin
            for j:=entre1_N to sortie1_N do
            begin
                mapTemp[i, CHR(entre1_N)]:='X';
                entre1_N:=entre1_N+1;
            end;
        end;
        affichMap(mapTemp);
    end
    //si le joueur veut poser verticalement ses bateaux alors les X vont etre poses selon cette configuration
    else if sensPoseBat='H' then
        begin
            for i:=entre1_N to sortie1_N do
            begin
                asciiCode:=64+i;
                for j:=entre2 to sortie2 do
                begin
                    mapTemp[j, CHR(entre1_N)]:='X'
                end;
            end;
            affichMap(mapTemp);
        end
    //si le sens dans lequel poser le bateau correspond a un vide, alors l'un des joueurs a tire sur une des cases adverses et occupee par un de ses bateaux.
    //De fait,  la mapAdvers est marquee par une etoile pour indiquer qu'un bout de bateau a ete touche
    else if sensPoseBat=' ' then
        begin
        mapTemp[entre2, entre1]:='*';
        end;
    remplacMap:=mapTemp;
end;

function saisiCoords(var map:tabChar; sensPoseBat:char; casesBateau:integer):tabChar;
//BUT: recuperer les coordonnees que le joueur saisi pour placer l'un de ses bateaux
//ENTREE: map du joueur, sens dans lequel le joueur veut poser le bateau et le nb de cases que doit occuper le bateau
//SORTIE:coordonnees d'entree chiffre et lettre; coordonnees de sortie du bateau en chiffre et en lettre
var entre1,sortie1:char;
var entre1_N, sortie1_N, entre2, sortie2, deltaPlace:integer;
begin
    repeat
        entre1:=' ';
        sortie1:=' ';
        entre2:=0;
        sortie2:=0;
        //entree des coords ou le joueur veut placer son bateau
        while ((entre1<'A') or (entre1>'J')) do
        begin
             gotoxy(5,17);
             writeln('Veuillez saisir la lettre correspondant au point de départ du navire');
             gotoxy(5,18);
             readln(entre1);
        end;
        while ((entre2<1) or (entre2>10)) do
        begin
            gotoxy(5,19);
             writeln('Veuillez saisir le chiffre correspondant au point de départ du navire');
             gotoxy(5,20);
             readln(entre2);
        end;
        while ((sortie1<'A') or (sortie1>'J')) do
        begin
            gotoxy(5,21);
             writeln('Veuillez saisir la lettre correspondant au point d''arrivee du navire');
             gotoxy(5,22);
             readln(sortie1);
        end;
        while ((sortie2<1) or (sortie2>10)) do
        begin
            gotoxy(5,23);
             writeln('Veuillez saisir le chiffre correspondant au point d''arrivee du navire');
             gotoxy(5,24);
             readln(sortie2);
        end;
    //on verifie si les coords correposndent au nb de cases du bateau
        if sensPoseBat='V' then
        begin
            entre1_N:=ord(entre1);      //on transforme les caracteres entre1 et entre2 en nombre
            sortie1_N:=ord(sortie1);
            deltaPlace:=(sortie1_N-entre1_N)+1; //le delta entre les deux positions permet de savoir si la place allouee au bateau correspond bien a sa longueur. Ici delta fait verticalement
        end;
        if sensPoseBat='H' then
        begin
            deltaPlace:=(sortie2-entre2)+1; //ici delta sur l'horizontal
        end;

    //conditions sous lesquelles les coords ne sont pas acceptés par la machine sinon sous peine de planter le programme
        if (map[entre2, entre1]='o') or (map[sortie2, sortie1]='o') or (map[entre2, entre1]='X') or (map[sortie2, sortie1]='X') or (deltaPlace>casesBateau) or (deltaPlace<casesBateau) then
            begin
                 writeln('L''emplacement designe manque de place ou n''existe pas.');
                 writeln('Veuillez appuyer sur entrer pour choisir un nouvel emplacement');
            end;
            readln;

    until (map[entre2, entre1]='-') and (map[sortie2, sortie1]='-') and (deltaPlace=casesBateau);
    saisiCoords:=remplacMap(entre1,sortie1, entre2,sortie2, map, sensPoseBat);
end;

function placeLibreMap(var map:tabChar;carVide:char; bateauNom:string; casesBateau:integer):tabChar;
//BUT :Détecter les emplacements libres permettant de stocker des bateaux et les indiquer aux joueurs en leur attribuant le caracetre "-"
//ENTREE: la map du joueur
//SORTIE: la map du joueur avec les emplacements libres indiqués
var i,j,nbcases, casesLibr,asciiCode,jTemp, asciiTemp:integer;
var carLibre, sensPoseBat:char;
var mapTemp:tabChar;
begin
    casesLibr:=0;
    asciiCode:=65;
    nbcases:=1;
    jTemp:=2;
    carLibre:=' ';
    mapTemp:= map;

    affichMap(map);
    gotoxy(4,13);
    writeln('Le ',bateauNom,' comprend ',casesBateau, ' cases.');
    repeat
        gotoxy(5,14);
        writeln('Voulez-vous le placer horizontalement ou verticalement ? (H ou V)');   //saisi h ou v et verif du car entré
        gotoxy(5,15);
        readln(sensPoseBat);
    until(sensPoseBat='V') or(sensPoseBat='H');


    // SI V entré, on compte le nb d'emplacement libres verticalement pour pouvoir accueillir ou non le bateau ciblé et on l'indique au joueur en retournant un carLibre(dispo)='-' si oui
    //si non, en lui laissant le carVide(par defaut)='o'
    if sensPoseBat='V' then
    begin
        for i:=1 to 10 do
        begin

             for j:=1 to 10 do
             begin

                asciiCode:=64+j;
                 if mapTemp[i,CHR(asciiCode)]=carVide then //on ajoute 1 a casesLibr lorsque le carVide est present et cela jusqu'a atteindre la longueur du bateau voulu
                    casesLibr:=casesLibr+1
                 else
                    casesLibr:=0;

                 if casesLibr=casesBateau then      ///puis on revient (on decremente) progressivement sur les cases libres afin d'y placer un car '-'
                 begin
                    mapTemp[i, CHR(asciiCode)]:='-';
                     asciiTemp:=asciiCode+1;
                     for nbcases:=1 to casesBateau do
                     begin
                        asciiTemp:=asciiTemp-1;
                        mapTemp[i, CHR(asciiTemp)]:='-';
                     end;
                     casesLibr:=0;
                 end;

             end;
             casesLibr:=0;
        end;
     end;

    //idem pour H mais realisé cette fois ci horizontalement
    if sensPoseBat='H' then
    begin
        for i:=1 to 10 do
        begin
            asciiCode:=64+i;
             for j:=1 to 10 do
             begin
                 if mapTemp[j,CHR(asciiCode)]=carVide then //on compte le nb de cases dispo se suivant
                    casesLibr:=casesLibr+1
                 else
                    casesLibr:=0;

                 if casesLibr=casesBateau then //caraVides remplaces par "-" lorsque le nb de cases vides est egal au nb de cases requis par le bateau
                 begin
                     mapTemp[j, CHR(asciiCode)]:='-';
                     jTemp:=j+1;
                     for nbcases:=1 to casesBateau do // pour indiquer les emplacements ou on peut placer le bateau, on fait le chemin inverse des cases libres et on met un "-"
                     begin
                        jTemp:=jTemp-1;
                        mapTemp[jTemp, CHR(asciiCode)]:='-';
                     end;
                     casesLibr:=0; //cpt mis a zero pour un nouvel emplacement

                 end;
             end;
             casesLibr:=0; //compteur de places libres remi a 0 pour la ligne suivante
        end;
     end;

    affichMap(mapTemp);
     placeLibreMap:=saisiCoords(mapTemp, sensPoseBat, casesBateau);
end;

function initMap(var map:tabChar;carVide:char; bateauNom:string; casesBateau:integer):tabChar;
//BUT: appeler les differentes fcts qui permettent la mise en place des bateaux sur la map; regroupe la phase d'initialisation qui est la pose des bateaux
//ENTREE:map du joueur, bateau que l'on veut placer, sa longueur
//SORTIE:map modifié en fct des coords entres par le joueur, la place dispo pour le placer et le caract qui indique les positions qu'il occupe
begin
    map:=placeLibreMap(map, carVide, bateauNom, casesBateau); //permet d'estimer la place libre pour placer un bateau, feedback vers le joueur puis

    //appel ftc saisiCoords qui permet de demander au joueur un emplacement ou placer ses bateaux
    //appel fct remplacMap qui permet de placer le dit bateau sur la map
    readln;
    clrscr;
    initMap:=map; //enfin, retour de la map, une fois les modifications effectuees
end;





function verifPosition(entre1:char;entre2:integer; var map:tabChar):tabChar;
//BUT: Verifie si le tir d'un des joueur touche bien l'un des bateaux du joueur adverse et l'indique textuellement
//ENTREE:position du tir et map du joueur sur laquelle on tire
//SORTIE:texte qui affiche si un bateau est touche ou non et map modifié si le tir touche un bateau
var mapTemp:tabChar;
var entre1_N:integer;
begin
    entre1_N:=ord(entre1); //passage du caractere au codeAscii
    mapTemp:=map;

    //Si la position tirée correspond a un emplacement ou il y a un 'X'(bout de bateau), alors on indique 'touche' au joueur, ou bien "touché coule" si le navire est entierement detruit une fois tiré
    //puis on appelle "RemplacMap" afin de remplacer les 'X' par des '*' dans la map et indiquer ou se trouvent les tirs réussis. Cela servira ensuite a preciser au joueur ou se trouvent les tirs ayant touchés
    //les bateaux et creer un historique pour l'aider dans sa bataille
    if map[entre2, entre1]='X' then
     begin
    //   /les si suivants prennent en compte toutes les possibilites de plantage. En effet, pour differencier le "touché" qui donc signifie que le bateau n'est pas totalement detruit du "touche coule"
    //ou il ne reste plus rien du bateau, je verifie que les quatres cases entourant la position tirée sont egales a 'X' ou non et en fct de cela j'en deduit si le bateau est entierement aneanti ou non
        if (entre1>'A') or (entre1<'J') then
            begin

            //or comme certaines positions ne disposent pas de quatres cases les entourant (les coins par exemple), il faut en tenir compte lors de la verification des
            // 'X' voisins et ainsi eviter le plantage du prog en placant des condtions
                if (entre2>1) or (entre2<10) then
                begin
                     if  (map[entre2-1, entre1]='X') or (map[entre2+1, entre1]='X') or(map[entre2, CHR(entre1_N-1)]='X') or (map[entre2, CHR(entre1_N+1)]='X') then
                        begin
                         writeln('Touche');
                         end
                     else
                        begin
                        writeln('Touche...coule !');
                        end;
                end
                else if entre2=1 then
                begin
                    if   (map[entre2+1, entre1]='X') or(map[entre2, CHR(entre1_N-1)]='X') or (map[entre2, CHR(entre1_N+1)]='X') then
                    begin
                        writeln('Touche');
                     end
                     else
                     begin
                        writeln('Touche...coule !');
                     end;
                 end
                else if entre2=10 then
                begin
                    if  (map[entre2-1, entre1]='X') or(map[entre2, CHR(entre1_N-1)]='X') or (map[entre2, CHR(entre1_N+1)]='X') then
                        begin
                        writeln('Touche');
                        end
                     else
                     begin
                        writeln('Touche...coule !');
                       end;
                end;
            end
        else if entre1='A' then
        begin
                if (entre2>1) or (entre2<10) then
                begin
                     if  (map[entre2-1, entre1]='X') or (map[entre2+1, entre1]='X') or (map[entre2, CHR(entre1_N+1)]='X') then
                    begin
                         writeln('Touché')
                     end
                     else
                     begin
                        writeln('Touché...coulé !');
                     end;
                end
                else if entre2=1 then
                begin
                      if (map[entre2+1, entre1]='X') or (map[entre2, CHR(entre1_N+1)]='X') then
                        begin
                        writeln('Touché');
                        end
                     else
                     begin
                        writeln('Touché...coulé !');
                      end;
                 end
                else if entre2=10 then
                begin
                      if  (map[entre2-1, entre1]='X') or (map[entre2, CHR(entre1_N+1)]='X') then
                      begin
                        writeln('Touché');
                        end
                     else
                     begin
                        writeln('Touché...coulé !');
                     end;
                end;

         end
         else if entre1='J' then
         begin
                if (entre2>1) or (entre2<10) then
                begin
                     if  (map[entre2-1, entre1]='X') or (map[entre2+1, entre1]='X') or(map[entre2, CHR(entre1_N-1)]='X') then
                     begin
                         writeln('Touché');
                     end
                     else
                     begin
                        writeln('Touché...coulé !');
                     end;
                end
                else if entre2=1 then
                begin
                     if  (map[entre2+1, entre1]='X') or (map[entre2, CHR(entre1_N-1)]='X') then
                        begin
                        writeln('Touché')
                        end
                     else
                     begin
                        writeln('Touché...coulé !');
                     end;
                 end
                else if entre2=10 then
                begin
                     if  (map[entre2-1, entre1]='X') or (map[entre2, CHR(entre1_N-1)]='X') then
                     begin
                        writeln('Touché');
                     end
                     else
                     begin
                        writeln('Touché...coulé !');
                     end;
                end;

         end;
         mapTemp:=remplacMap(entre1,' ',entre2,0,map, ' ');
    end
    //si la position tiree ne correspond pas a un emplacement ou se trouve un 'X' et donc un bateau, alors on affiche raté au joueur
    else
        begin
        writeln('Rate');
        end;
     verifPosition:=mapTemp;
end;

function tirMap (var map:tabChar):tabChar;
//BUT:fct qui recupere la position sur laquelle les joueurs veulent tirer et appel des fcts qui permettent la mise en réal du tir, donc qui regroupe la phase de tir
//ENTREE:map du joueur adverse afin de pouvoir tirer dessus avec l'aide des fcts precedentes/ et texte demandant d'entrer une lettre et un chiffre afin de determiner une position
//SORTIE: map modifie ou non selon le tir effectué
var entre1:char;
var entre2:integer;
var mapTemp:tabChar;
begin
    mapTemp:=map;
    entre1:=' ';
    entre2:=0;

    while (entre1<'A') or (entre1>'J') do
    begin
    gotoxy(5,15);
    writeln('Veuillez entrer la lettre correspondant a la position que vous souhaitez attaquer');
    gotoxy(5,16);
    readln(entre1);
    end;
    while (entre2<1) or (entre2>10) do
    begin
    gotoxy(5,17);
    writeln('Veuillez entrer le chiffre correspondant a la position que vous souhaitez attaquer');
    gotoxy(5,18);
    readln(entre2);
    end;

    mapTemp:=verifPosition(entre1, entre2, map);
    tirMap:=mapTemp;
end;

function suiviTirMap(var map:tabChar; suiviMap:tabChar):tabChar;
//BUT: fct qui permet de remplir une map de suivie indiquant ou les tirs touchant des bateaux ont ete faits
//ENTREE:map du joeur sur laquelle on tire et map de suivi
//SORTIE:map de suivi modifié en fct des modifs apportés précedemment sur la map du joueur
var i,j,asciiCode:integer;
begin
    for i:=1 to 10 do
    begin
        for j:=1 to 10 do
        begin
            asciiCode:=64+j;
            if map[i,CHR(asciiCode)]='*' then //si on trouve un car '*' alors un tir touchant un bateau a ete effectué sur la map et donc on recupere la position pour indiquer ce tir
            //par l'ajoout d'un "/" dans la map de suvi
                suiviMap[i,CHR(asciiCode)]:='/';
        end;
    end;
    suiviTirMap:=suiviMap;
end;






function estVictoire(var map:tabChar; nbCasesAbattre:integer):boolean;
//BUT: detecter si la map n'a plus aucun bateau
//ENTREE:map du joueur et le nb de cases abattues
//SORTIE:valeur booleenne indiquant si la map n'a plus de bateau ou non et donc s'il y a vainqueur ou non
var i,j,asciiCode,cptCasesLibr:integer;
var bool:boolean;
begin
    bool:=false;
    cptCasesLibr:=0;
    for i:=1 to 10 do
        begin
        for j:=1 to 10 do
            begin
            asciiCode:=64+j; //asciiCode mis a jour pour qu'on puisse naviguer dans la deuxieme dimension du tableau map
            if map[i,CHR(asciiCode)]='*' then
                cptCasesLibr:=cptCasesLibr+1; //on ajoute 1 au nb de casesAbattues lorsque l'emplacement de la map est marqué par une '*' car signifiant qu'un tir touchant un navire à bien ete réalisé
            end;
        end;

    if cptCasesLibr=nbCasesAbattre then //le nb de cases qu'occupe la totalite des navires
        bool:=true
    else
        bool:=false;
    estVictoire:=bool;
end;








//progr principal (main program)
//BUT: prog ou deux joueurs jouent au jeu de la bataille chacun a leur tour, le tout après avoir placé leurs bateaux sur une map
//ENTREE:nomJoueurs pour créer de l'interaction homme-machine, coordoonnées ou ils souhaitent placer leurs navires, et position de la map adverse ou ils souhaitent tirer
//SORTIE:texte permettant l'interaction et la compréhension du jeu, map des deux joueurs, 2 maps qui permet de suivre l'avancé des tirs réussis par les joueurs
var i, j, asciiCode, porteAvion, croiseur, contreCroiseur, sousMarin, torpilleur, nbCasesNavires,nbJ1,nbJ2:integer;
var porteAvionNom, croiseurNom, contreCroiseurNom, sousMarinNom, torpilleurNom, nomJ1, nomJ2:string;
var carVide:char;
var map1, map2,suiviMap1, suiviMap2: tabChar;
var victoireJ1, victoireJ2:boolean;
BEGIN
 //initi variables
    carVide:='o'; //car choisi pour initialiser les maps
        //la longueur de chaque bateau
    porteAvion:=5;
    croiseur:=4;
    contreCroiseur:=3;
    sousMarin:=3;
    torpilleur:=2;
    nbCasesNavires:=17; //nb des cases ocuupes par la totalite des navires
    nbJ1:=1;
    nbJ2:=2;
    nomJ1:=' ';
    nomJ2:=' ';
    porteAvionNom:='porte avion';
    croiseurNom:='croiseur';
    contreCroiseurNom:='contre croiseur';
    sousMarinNom:='sous marin';
    torpilleurNom:='torpilleur';
        //map mise a vide, vierge
    map1:=mapA_vide(map1, carVide);
    map2:=mapA_vide(map2, carVide);
    suiviMap1:=mapA_vide(suiviMap1, carVide); //suivi de la map 1
    suiviMap2:=mapA_vide(suiviMap2, carVide); //suivi de la map 2




    //presentation du jeu
    clrscr;
    gotoxy(45,1);
    writeln('Jeu de la bataille');
    gotoxy(24,2);
    writeln('Bienvenue dans le jeu de la bataille programmé en pascal.');
    gotoxy(28,3);
    writeln('Il se déroule à deux joueurs sur une meme machine.');
    gotoxy(10,4);
    writeln('Pour cela, merci de jouer le jeu et de ne pas regarder ce que l''adversaire marque sur le poste.');
    gotoxy(23,5);
    writeln('En esperant que vous passerez un bon moment,  E.E ;)');
    readln;
    clrscr;
    nomJ1:=recupNom(nbJ1);
    nomJ2:=recupNom(nbJ2);




   //init mapJoueur1
    affichMap(map1);
    gotoxy(45,3);
    writeln('Voici votre map, ',nomJ1);
    gotoxy(26,4);
    writeln('Pour commencer le placement des differents navires, veuillez appuyer sur entrer');
    readln;
    clrscr;
        //appel des fcts qui permettent la mise en place de chaque navire sur la map
    map1:=initMap(map1, carVide, sousMarinNom, sousMarin);
    map1:=initMap(map1, carVide, croiseurNom, croiseur);
    map1:=initMap(map1, carVide, porteAvionNom, porteAvion);
    map1:=initMap(map1, carVide, contreCroiseurNom, contreCroiseur);
    map1:=initMap(map1, carVide, torpilleurNom, torpilleur);
    readln;
    clrscr;

    //init mapJoueur2
    affichMap(map2);
    gotoxy(45,3);
    writeln('Voici votre map, ',nomJ2);
    gotoxy(26,4);
    writeln('Pour commencer le placement des differents navires, veuillez appuyer sur entrer');
    readln;
    clrscr;
        //appel des fcts qui permettent la mise en place de chaque navire sur la map
    map2:=initMap(map2, carVide, porteAvionNom, porteAvion);
    map2:=initMap(map2, carVide, croiseurNom, croiseur);
    map2:=initMap(map2, carVide, contreCroiseurNom, contreCroiseur);
    map2:=initMap(map2, carVide, sousMarinNom, sousMarin);
    map2:=initMap(map2, carVide, torpilleurNom, torpilleur);
    readln;
    clrscr;




//session de tirs se repetant jusqu'a un vainqueur soit désigné. -->Condition : plus aucun bateau chez l'adversaire
    gotoxy(26,4);
    writeln('Le placement des navires est terminé. Le jeu peut commencer:');

    repeat
        //tirs du joueur1 sur map du joueur 2
        affichMap(suiviMap2);
        gotoxy(34,5);
        writeln('Ou voulez-vous attaquer, tres cher(e) ',nomJ1,' ?');
        map2:=tirMap(map2); //fct qui appelle d'autres fcts permettant de tirer sur la map du joueur 2
        suiviMap2:=suiviTirMap(map2, suiviMap2);  //map de suvi de tirs(reussis) mise a jour et affichage de cette derniere
        affichMap(suiviMap2);
        victoireJ1:=estVictoire(map2, nbCasesNavires);  //booleen permettant de savoir si le joueur 1 a gagné la partie ou non
        readln;
        clrscr;

        //tirs du joueur2 sur map du joueur 1
        affichMap(suiviMap1);
        gotoxy(27,5);
        writeln('Ou voulez-vous attaquer, tres cher(e) ',nomJ2,' ?');
        map1:=tirMap(map1); //fct qui appelle d'autres fcts permettant de tirer sur la map du joueur 1
        suiviMap1:=suiviTirMap(map1, suiviMap1);  //map de suvi de tirs(reussis) mise a jour et affichage de cette derniere
        affichMap(suiviMap1);
        victoireJ2:=estVictoire(map1, nbCasesNavires); //booleen permettant de savoir si le joueur 2 a gagné la partie ou non
        readln;
        clrscr;
    until((victoireJ1=true) or (victoireJ2=true));






//fin de la partie
    gotoxy(33,10);
    writeln('Fin de la partie, nous avons un vainqueur');
    if victoireJ1=true then
        begin
        gotoxy(33,13);
        writeln('Félicitation ',nomJ1,', vous gagnez la partie');
        end
    else if victoireJ2=true then
        begin
        gotoxy(33,13);
        writeln('Félicitation ',nomJ2,', vous  gagnez la partie');
        end
    else if victoireJ1=true and victoireJ2=true   then
        begin
        gotoxy(33,13);
            writeln('Egalite parfaite entre les deux joueurs. Tous les deux sont vainqueurs');
        end;






    readln;

END.



