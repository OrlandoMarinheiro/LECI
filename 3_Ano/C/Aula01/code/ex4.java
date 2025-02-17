package code;

import java.io.File;
import java.util.HashMap;
import java.util.Scanner;

public class ex4 {
    
    public static void main(String[] args) {

        HashMap<String, Integer> nums = new HashMap<String, Integer>();

        String input;
        if (args.length == 0) {
            Scanner sc = new Scanner(System.in);
            input = sc.nextLine();
            sc.close();
        } else {
            input = args[0];
        }

        String path = "/home/marinheiro/Documentos/LECI/3_Ano/C/Aula01/files/numbers.txt"; 
        
        try {
            File file = new File(path);
            System.out.println("Caminho absoluto do arquivo: " + file.getAbsolutePath());

            Scanner sc = new Scanner(file);

            while (sc.hasNextLine()) {
                String line[] = sc.nextLine().split("-");
                nums.put(line[1].trim(), Integer.parseInt(line[0].trim()));
            }
            sc.close();



            String[] nums_args = input.split("[\\s-]+");
            for (String num : nums_args) {
                System.out.print(num + " ");
            }
            System.out.print("-> ");
            int result = findNumber(nums_args, nums);
            if (result == 0) {
                return;
            }
            System.out.println(findNumber(nums_args, nums));

        } catch (Exception e) {
            System.out.println("Erro ao ler o ficheiro");
        }

    }

    public static int findNumber(String[] nums_args, HashMap<String, Integer> nums) {
        int result = 0;
        
        for (int i = 0; i < nums_args.length; i++) {
            Integer currentNum = nums.get(nums_args[i]);

            if (currentNum == null) {
                if (nums_args[i].equals("and")) {
                    continue;
                } 
                System.out.println("Número desconhecido: " + nums_args[i]);
                return 0;
            }
            
            int j = i + 1;
            int cnt = 1;
            while (true) {
                if (j < nums_args.length) { 
                    Integer nextNum = nums.get(nums_args[j]);
                    if (nextNum != null && nextNum >= 100){
                        cnt = cnt * nextNum;
                        i++;
                    } else {
                        break;
                    }   
                } else {
                    break;
                }
                j++; 
            }
            if (currentNum > 0 && currentNum <= 9 && cnt > 1) {
                result += currentNum * cnt;
            } else {
                result += currentNum;
            }  
        }
        return result;
    }
    
}
