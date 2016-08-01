package meteorolig;

public class GameMineSweeper implements MineSweeper {
	 private Boolean IsSet = false;
	 private char MineFieldArray[][];
	@Override
	public void setMineField(String mineField) throws IllegalArgumentException {
		// Check if mine field  is properly set, throw IllegalArgumentException otherwise
		if (mineField == null || mineField == ""){
			throw new IllegalArgumentException("Empty mine field");
		}
		if (!mineField.toString().matches("^[.\n*]+$")){
			throw new IllegalArgumentException("Unaccepted characters in minefield");
		}
		String mineFields[] = mineField.split("\n");
		int size = 0;
		char[][] fieldarray = new char[mineFields.length][];
		int i = 0;
		for (String field: mineFields){
			fieldarray[i] = field.toCharArray();
			i++;
			int len = field.length();
			if (size == 0){
				size = len;
			}
			else if(size != len){
				throw new IllegalArgumentException("Mine field not properly formated");
			}
		}
		MineFieldArray = fieldarray;
		IsSet = true;
	}

	@Override
	public String getHintField() throws IllegalStateException {
		// throw IllegalStateException if SetMinefield is not called
		if (IsSet == false){
			throw new IllegalStateException("Minefield not set!");
		} 
		String result ="";
		for (int i = 0; i<MineFieldArray.length; i++){
			for(int j = 0; j< MineFieldArray[i].length; j++){
				if(MineFieldArray[i][j]=='*'){
					result = result + "*";
					continue;
				}
				int upperlimit = i > 0 ? i-1 : i;
				int leftlimit = j > 0 ? j-1 : j;
				int rightlimit = j < MineFieldArray[i].length - 1? j + 1 : j;
				int downlimit = i < MineFieldArray.length - 1 ? i + 1 : i;
				int number_mines = 0;
				for (int s = upperlimit; s<=downlimit; s++){
					for(int t = leftlimit; t<=rightlimit; t++){
						if(MineFieldArray[s][t]=='*'){
							number_mines+=1;
						}
					}			
				}
				//get corresponding char adding the correct offset
				char num_mines = (char)(number_mines+48);
				//append number of mines to result
				result = result + num_mines;
				//MineFieldArray[i][j] = num_mines;
			}
			//append new line to result as delimiter 
			if (i<MineFieldArray.length -1){
				result = result + "\n";}
			}
		// return result as string
		return result;
	}
	public static void main(String []argv){
		String myField = ".*..\n..*.\n....";
		GameMineSweeper game = new GameMineSweeper();
		game.setMineField(myField);
		game.getHintField();
	}

}
