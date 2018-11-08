let tableau  = document.getElementsByClassName("tableau");
let jouer = true;
let joueur1 = false;
let joueur2 = false;
let gagner = true;
let nbCellule ;
let celluleRestante ;
let nomJoueur1;
let nomJoueur2;
let scoreJoueur1;
let scoreJoueur2;


function start(){
    initJoueur1();
    initJoueur2();
    nbCellule = celluleTotal();
    celluleRestante = nbCellule;
//console.log(celluleRestante);
    tableau[0].addEventListener("click", ajoutElement);
    scoreJoueur1 = 0;
    scoreJoueur2 = 0;
}
function initJoueur1(){
    nomJoueur1 = window.prompt("Nom joueur1");
    document.getElementById("nomJoueur1").textContent = nomJoueur1;
}
function initJoueur2(){
    nomJoueur2= window.prompt("Nom joueur2");
    document.getElementById("nomJoueur2").textContent = nomJoueur2;
}
function setScoreJoueur1(){
    document.getElementById("pointJoueur1").textContent=scoreJoueur1;
}
function setScoreJoueur2(){
    document.getElementById("pointJoueur2").textContent=scoreJoueur2;
}
function celluleTotal() {


    let nbLigne = tableau[0].rows.length;
    let nbColonne = tableau[0].rows[0].cells.length;
    return nbLigne * nbColonne;

}

function partitFinit() {
        console.log("aucun gagnant");

}


    function isEmpty(e) {

        if (e.className === "") {
            return true;
        }
        return false;
    }

    function aJouer(joueur) {
        if (joueur === jouer) {
            return true
        }
        return false

    }

    function verifLigne() {
        return true;
    }

    function conditionDeVictoire(classe) {
        //ligne 1
        if(tableau[0].rows[0].cells[0].className === classe
            && tableau[0].rows[0].cells[1].className === classe
            && tableau[0].rows[0].cells[2].className === classe){
            return true;
        }
        //ligne 2
        if(tableau[0].rows[1].cells[0].className === classe
            && tableau[0].rows[1].cells[1].className === classe
            && tableau[0].rows[1].cells[2].className === classe){
            return true;
        }
        //ligne3
        if(tableau[0].rows[2].cells[0].className === classe
            && tableau[0].rows[2].cells[1].className === classe
            && tableau[0].rows[2].cells[2].className === classe){
            return true;
        }
        //colonne 1
        if(tableau[0].rows[0].cells[0].className === classe
            && tableau[0].rows[1].cells[0].className === classe
            && tableau[0].rows[2].cells[0].className === classe){
            return true;
        }
        //colonne 2
        if(tableau[0].rows[0].cells[1].className === classe
            && tableau[0].rows[1].cells[1].className === classe
            && tableau[0].rows[2].cells[1].className === classe){
            return true;
        }
        //colonne 3
        if(tableau[0].rows[0].cells[2].className === classe
            && tableau[0].rows[1].cells[2].className === classe
            && tableau[0].rows[2].cells[2].className === classe){
            return true;
        }
        //diagonal 1
        if(tableau[0].rows[0].cells[0].className === classe
            && tableau[0].rows[1].cells[1].className === classe
            && tableau[0].rows[2].cells[2].className === classe){
            return true;
        }
        //diagonal 2
        if(tableau[0].rows[0].cells[2].className === classe
            && tableau[0].rows[1].cells[1].className === classe
            && tableau[0].rows[2].cells[0].className === classe){
            return true;
        }
        return false;

    }
    function rechercheGagnantJoueur1(classe){
        if(conditionDeVictoire(classe)){
            console.log("joueur 1 victoire");
            return true;

        }
        return false;
    }
    function rechercheGagnantJoueur2(classe){
    if(conditionDeVictoire(classe)){
        console.log("joueur 2 victoire");
        return true;

    }
    return false;
}

    function ajoutElement(event) {

        let cellule = event.target;
        if (isEmpty(cellule) && !aJouer(joueur1) && celluleRestante >= 1) {
            if (celluleRestante === 1) {
                cellule.className = "cercle";
                cellule.textContent = "O";
                //console.log(celluleRestante);
                partitFinit();
                setTimeout(function(){ alert("match nul"); }, 100);
            } else {
                cellule.className = "cercle";
                cellule.textContent = "O";
                joueur1 = true;
                joueur2 = false
                celluleRestante = celluleRestante - 1;
                if(rechercheGagnantJoueur1(cellule.className)){
                    tableau[0].removeEventListener("click",ajoutElement);
                    let confirm;
                    setTimeout(function(){ confirm = confirm("Victoire joueur 1"); }, 100);
                    scoreJoueur1 = scoreJoueur1 +1;
                    console.log(scoreJoueur1);
                    setScoreJoueur1();
                    if(confirm){
                        tableau[0].rows[0].cells[0].textContent = "toto"
                    }

                }
                //console.log(celluleRestante);
            }


        }
        if (isEmpty(cellule) && !aJouer(joueur2) && celluleRestante >= 1) {
            if (celluleRestante === 1) {
                cellule.className = "croix";
                cellule.textContent = "X";
                partitFinit();
                setTimeout(function(){ alert("match nul"); }, 100);

            } else {
                cellule.className = "croix";
                cellule.textContent = "X";
                joueur2 = true;
                joueur1 = false;
                celluleRestante = celluleRestante - 1;
                if(rechercheGagnantJoueur2(cellule.className)){
                    tableau[0].removeEventListener("click",ajoutElement);
                    setTimeout(function(){ confirm("Victoire joueur 2"); }, 100);
                    scoreJoueur2 = scoreJoueur2 +1;
                    console.log(scoreJoueur1);
                    setScoreJoueur2();
                }
            }


        }

    }

    //nbCellule = celluleTotal();
    //celluleRestante = nbCellule;
//console.log(celluleRestante);
    //tableau[0].addEventListener("click", ajoutElement);
    //partitFinit();


//console.log(nbCellule);
start();


