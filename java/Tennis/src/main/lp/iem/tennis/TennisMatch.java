package lp.iem.tennis;

public class TennisMatch {

    private Player player1;
    private Player player2;
    private MatchType matchType;
    private boolean tieBreakInLastSet;
    private int currentSetNumber;
    private Set[] set;



    public TennisMatch(Player player1, Player player2, MatchType matchType, boolean tieBreakInLastSet) {
        this.player1 = player1;
        this.player2 = player2;
        this.matchType = matchType;
        this.tieBreakInLastSet = tieBreakInLastSet;
        this.currentSetNumber = 1;
    }
    public boolean isTieBreak(){
       return set[currentSetNumber-1].getNbGamesPlayer1() == 6 && set[currentSetNumber-1].getNbGamesPlayer2() == 6;
    }
    public void updateWithPointWonBy(Player player){


        if(!isFinished()){
            if(player.equals(player1)){
                if((currentSetNumber != matchType.maxNumberOfSets() && isTieBreak()) || (tieBreakInLastSet && currentSetNumber == matchType.maxNumberOfSets() && isTieBreak())){
                    if(isTieBreak()){
                        set[currentSetNumber-1].getGame().setNbTieBreakPointPlayer1(getCurrentTieBreakPointPlayer1()+1);
                            if(set[currentSetNumber-1].hasWinSetPlayer1()){
                                set[currentSetNumber-1].setNbGamesPlayer1(set[currentSetNumber-1].getNbGamesPlayer1() + 1);
                                player1.setNbSetWin(player1.getNbSetWin()+1);
                                if(isFinished()){
                                    displayScore();
                                }else{
                                    setCurrentSetNumber(currentSetNumber+1);
                                }
                            }



                    }
                }else {
                    if(!set[currentSetNumber-1].isFinished()){
                        switch (getCurrentPointPlayer1()){
                            case "0":
                                set[currentSetNumber-1].getGame().setNbPointPlayer1("15");
                                break;
                            case "15":
                                set[currentSetNumber-1].getGame().setNbPointPlayer1("30");
                                break;
                            case "30":
                                set[currentSetNumber-1].getGame().setNbPointPlayer1("40");
                                break;
                            case "40":
                                switch (getCurrentPointPlayer2()){
                                    case "40":
                                        set[currentSetNumber-1].getGame().setNbPointPlayer1("A");
                                        break;
                                    case "A":
                                        set[currentSetNumber-1].getGame().setNbPointPlayer2("40");
                                        break;
                                    default:
                                        set[currentSetNumber-1].setNbGamesPlayer1(set[currentSetNumber-1].getNbGamesPlayer1() + 1);
                                        set[currentSetNumber-1].getGame().resetGameToStart();
                                        if(set[currentSetNumber-1].isFinished()){
                                            player1.setNbSetWin(player1.getNbSetWin()+1);
                                            if(isFinished()){
                                                displayScore();
                                            }else{
                                                setCurrentSetNumber(currentSetNumber+1);
                                            }

                                        }


                                }break;
                            case "A":
                                set[currentSetNumber-1].setNbGamesPlayer1(set[currentSetNumber-1].getNbGamesPlayer1() + 1);
                                set[currentSetNumber-1].getGame().resetGameToStart();
                                break;


                        }
                    }

                }

            } else if(player.equals(player2)) {
                if((currentSetNumber != matchType.maxNumberOfSets() && isTieBreak()) || (tieBreakInLastSet && currentSetNumber == matchType.maxNumberOfSets() && isTieBreak())){
                    if(isTieBreak()){
                        set[currentSetNumber-1].getGame().setNbTieBreakPointPlayer2(getCurrentTieBreakPointPlayer2()+1);
                        if(set[currentSetNumber-1].hasWinSetPlayer2()){
                            set[currentSetNumber-1].setNbGamesPlayer2(set[currentSetNumber-1].getNbGamesPlayer2() + 1);
                            player2.setNbSetWin(player2.getNbSetWin()+1);
                            if(isFinished()){
                                displayScore();
                            }else{
                                setCurrentSetNumber(currentSetNumber+1);
                            }
                        }
                    }
                }else {
                    if(!set[currentSetNumber-1].isFinished()){
                        switch (getCurrentPointPlayer2()){
                            case "0":
                                set[currentSetNumber-1].getGame().setNbPointPlayer2("15");
                                break;
                            case "15":
                                set[currentSetNumber-1].getGame().setNbPointPlayer2("30");
                                break;
                            case "30":
                                set[currentSetNumber-1].getGame().setNbPointPlayer2("40");
                                break;
                            case "40":
                                switch (getCurrentPointPlayer1()){
                                    case "40":
                                        set[currentSetNumber-1].getGame().setNbPointPlayer2("A");
                                        break;
                                    case "A":
                                        set[currentSetNumber-1].getGame().setNbPointPlayer1("40");
                                        break;
                                    default:
                                        set[currentSetNumber-1].setNbGamesPlayer2(set[currentSetNumber-1].getNbGamesPlayer2() + 1);
                                        set[currentSetNumber-1].getGame().resetGameToStart();
                                        if(set[currentSetNumber-1].isFinished()){
                                            player2.setNbSetWin(player2.getNbSetWin()+1);
                                            if(isFinished()){
                                                displayScore();
                                            }else{
                                                setCurrentSetNumber(currentSetNumber+1);
                                            }

                                        }


                                }break;
                            case "A":
                                set[currentSetNumber-1].setNbGamesPlayer2(set[currentSetNumber-1].getNbGamesPlayer2() + 1);
                                set[currentSetNumber-1].getGame().resetGameToStart();
                                break;


                        }
                    }

                }

            }
        }else {
            displayScore();
        }


    }

    public void displayScore() {
        StringBuilder builder = new StringBuilder();
        builder.append("Match terminé. Score ");
        for (Set sets:set
             ) {
            if(sets.getGame().hasWinTieBreakPlayer1() || sets.getGame().hasWinTieBreakPlayer2()){
                builder.append(sets.getNbGamesPlayer1())
                        .append("/")
                        .append(sets.getNbGamesPlayer2())
                        .append(" (")
                        .append(sets.getGame().getNbTieBreakPointPlayer1())
                        .append("/")
                        .append(sets.getGame().getNbTieBreakPointPlayer2())
                        .append(")")
                        .append(" ");
            }else {
                builder.append(sets.getNbGamesPlayer1())
                        .append("/")
                        .append(sets.getNbGamesPlayer2())
                        .append(" ");
            }



        }
        System.out.println(builder);
    }

    private int getCurrentTieBreakPointPlayer2() {
        return set[currentSetNumber-1].getGame().getNbTieBreakPointPlayer2();
    }

    private int getCurrentTieBreakPointPlayer1() {
        return set[currentSetNumber-1].getGame().getNbTieBreakPointPlayer1();
    }

    private String getCurrentPointPlayer1() {
        return set[currentSetNumber - 1].getGame().getNbPointPlayer1();
    }

    private String getCurrentPointPlayer2() {
        return set[currentSetNumber - 1].getGame().getNbPointPlayer2();
    }

    public String pointsForPlayer(Player player){
        String point = "";
        if(player.equals(player1)){
            point = set[currentSetNumber-1].getGame().getNbPointPlayer1();
            //point = player.getSet()[currentSetNumber-1].getGame().getNbPointPlayer1();
        }else if (player.equals(player2)) {
            //point = player.getSet()[currentSetNumber-1].getGame().getNbPointPlayer2();
            point = set[currentSetNumber-1].getGame().getNbPointPlayer2();
        }
        return point;

    }

    public int gamesInCurrentSetForPlayer(Player player){
        int game =0;
        if(player.equals(player1)){
            //game = player.getSet()[currentSetNumber-1].getNbGamesPlayer1();
            game = set[currentSetNumber-1].getNbGamesPlayer1();
        }else if (player.equals(player2)) {
            //game = player.getSet()[currentSetNumber-1].getNbGamesPlayer2();
            game = set[currentSetNumber-1].getNbGamesPlayer2();
        }
        return game;
    }
    public int gamesInSetForPlayer(int setNumber, Player player){
        int game =0;
        if(player.equals(player1)){
            //game = player.getSet()[setNumber-1].getNbGamesPlayer1();
            game = set[setNumber-1].getNbGamesPlayer1();
        }else if (player.equals(player2)) {
            //game = player.getSet()[setNumber-1].getNbGamesPlayer2();
            game = set[setNumber-1].getNbGamesPlayer2();
        }
        return game;
    }

    public int currentSetNumber(){
        return currentSetNumber;
    }

    public void setCurrentSetNumber(int currentSetNumber){
        this.currentSetNumber = currentSetNumber;
    }


    public boolean isFinished(){
        if(player1.getNbSetWin() == matchType.numberOfSetsToWin() || player2.getNbSetWin() == matchType.numberOfSetsToWin()){
            return true;
        }
        return false;
    }

    public Player getPlayer1() {
        return player1;
    }

    public void setPlayer1(Player player1) {
        this.player1 = player1;
    }

    public Player getPlayer2() {
        return player2;
    }

    public void setPlayer2(Player player2) {
        this.player2 = player2;
    }

    public MatchType getMatchType() {
        return matchType;
    }

    public void setMatchType(MatchType matchType) {
        this.matchType = matchType;
    }

    public boolean isTieBreakInLastSet() {
        return tieBreakInLastSet;
    }

    public void setTieBreakInLastSet(boolean tieBreakInLastSet) {
        this.tieBreakInLastSet = tieBreakInLastSet;
    }

    public Set[] getSet() {
        return set;
    }

    public Set getCurrentSet() {
        return set[currentSetNumber-1];
    }

    public void setSet(Set[] set) {
        this.set = set;
    }
}
