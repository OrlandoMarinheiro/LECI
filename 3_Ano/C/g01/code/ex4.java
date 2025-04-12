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

            System.out.print("A list of numbers: ");
            for (String num : nums_args) {
                int result = findNumber(num, nums);
                if (result == 0) {
                    continue;
                }
                System.out.print(findNumber(num, nums) + " ");
            }
            System.out.println();

        } catch (Exception e) {
            System.out.println("Erro ao ler o ficheiro");
        }

    }

    public static int findNumber(String num, HashMap<String, Integer> nums) {
        
        Integer currentNum = nums.get(num);
        if (currentNum != null) {
            return currentNum;
        }
        return 0;
    }
}
