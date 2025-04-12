package code;

import java.util.Arrays;
import java.util.HashMap;
import java.io.File;
import java.util.Scanner;

public class ex6 {
    public static void main(String[] args) {
        
        HashMap<String, String> tradutor = new HashMap<String, String>();

        Scanner sc = new Scanner(System.in);

        System.out.println("-Dicionario para tradução -> dic1.txt)");
        System.out.println("-Dicionario para definição -> dic2.txt)");
        System.out.println("-Ficheiros de teste: texto.txt, texto2.txt");
        System.out.println("Escolha uma opção:");
        System.out.println("1 - Definição");
        System.out.println("2 - Tradução");
        System.out.println("0 - Sair");
        int option = sc.nextInt();
        sc.nextLine(); 

        if (option == 0) {
            sc.close();
            return;
        }

        if (args.length == 0) {
            System.out.println("Nenhum ficheiro fornecido.");
            sc.close();
            return;
        }

        String input = args[0];
        String[] args_in = input.split(" ");
        String dict_path = String.format("files/%s", args_in[0]);
        loadDictionary(dict_path, tradutor);
        args_in = Arrays.copyOfRange(args_in, 1, args_in.length);

        if (option == 1) {
            for (String file : args_in) {
                String file_path = String.format("files/%s", file);
                System.out.println("\nDefinição: " + wordDefinition(file_path, tradutor));
            }
        } else if (option == 2) {
            for (String file : args_in) {
                String file_path = String.format("files/%s", file);
                System.out.println("\nTradução: " + translate(file_path, tradutor));
            }
        } else {
            System.out.println("\nOpção inválida");
        }
        sc.close();
    }

    public static void loadDictionary(String path, HashMap<String, String> dict) {
        try {
            File file = new File(path);
            System.out.println(String.format("\nCaminho absoluto do arquivo (%s): " + file.getAbsolutePath(), file.getName()));

            Scanner sc = new Scanner(file);

            while (sc.hasNextLine()) {
                String line[] = sc.nextLine().split(" ", 2);
                dict.put(line[0].trim(), line[1].trim());
            }
            sc.close();

        } catch (Exception e) {
            System.out.println("\nErro ao ler o ficheiro");
        }
    }

    public static String translate(String file, HashMap<String, String> dict) {
        String result = "";

        try {
            File f = new File(file);
            System.out.println(String.format("\nCaminho absoluto do arquivo (%s): " + f.getAbsolutePath(), f.getName()));

            Scanner sc = new Scanner(f);
            while (sc.hasNextLine()) {
                String[] line = sc.nextLine().split(" ");
                for (String word : line) {
                    if (dict.containsKey(word)){
                        result += dict.get(word) + " ";
                    } else {
                        result += word + " ";
                    }
                }
            }
            sc.close();

        } catch (Exception e) {
            System.out.println("\nErro ao ler o ficheiro");
        }
        return result;
    }

    public static String wordDefinition(String file, HashMap<String, String> dict) {
        String texto = "";
        String[] result;

        try {
            File f = new File(file);
            System.out.println(String.format("\nCaminho absoluto do arquivo (%s): " + f.getAbsolutePath(), f.getName()));

            Scanner sc = new Scanner(f);
            while (sc.hasNextLine()) {
                texto += sc.nextLine() + " ";
            }
            sc.close();

            System.out.println("Texto: " + texto);

            boolean flag = true;
            while (flag) {
                flag = false; 
                result = texto.trim().split(" ");
                for (int i = 0; i < result.length; i++) {
                    if (dict.containsKey(result[i])) {
                        result[i] = dict.get(result[i]); 
                        flag = true; 
                    }
                }
                texto = String.join(" ", result);
            }

        } catch (Exception e) {
            System.out.println("\nErro ao ler o ficheiro: " + e.getMessage());
        }
        return texto.trim(); 
    }
}
