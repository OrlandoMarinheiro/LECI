package code;

import java.util.Arrays;
import java.util.HashMap;
import java.io.File;
import java.util.Scanner;

public class ex6 {
    public static void main(String[] args) {
        
        HashMap<String, String> tradutor = new HashMap<String, String>();

        String input;

        if (args.length == 0) {
            Scanner sc = new Scanner(System.in);
            input = sc.nextLine();
            sc.close();
        } else {
            input = args[0];
        }

        String[] args_in = input.split(" ");
 
        String dict_path = String.format("files/%s", args_in[0]);
         
        loadDictionary(dict_path, tradutor);

        args_in = Arrays.copyOfRange(args_in, 1, args_in.length);
        /* 

        for (String file : args_in) {
            String file_path = String.format("files/%s", file);
            System.out.println("Tradução: " + translate(file_path, tradutor));
        } 
        System.out.println(); */ 

        /////////////////////////////////////////////////////////////
        
        //loadDictionary(dict_path, tradutor);

        for (String file : args_in) {
            String file_path = String.format("files/%s", file);
            System.out.println("Definição: " + String.join(" ", wordDefinition(file_path, tradutor)));
        }

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
            System.out.println("Erro ao ler o ficheiro");
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
            System.out.println("Erro ao ler o ficheiro");
        }
        return result;
    }

    public static String wordDefinition(String file, HashMap<String, String> dict) {
        String texto = "";
        String result[] = new String[0];
        try {
            File f = new File(file);
            System.out.println(String.format("\nCaminho absoluto do arquivo (%s): " + f.getAbsolutePath(), f.getName()));

            Scanner sc = new Scanner(f);
            while (sc.hasNextLine()) {
                texto += sc.nextLine() + " "; 
            }
            System.out.println("Texto: " + texto);
            sc.close();

            boolean flag = true;
            while (flag) {
                result = texto.split(" ");
                for (String word : result) {
                    if (dict.containsKey(word)) {
                        int i = Arrays.asList(result).indexOf(word);
                        result[i] = dict.get(word);
                        flag = true;
                    } else {
                        flag = false;
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Erro ao ler o ficheiro");
        }
        return Arrays.toString(result);
    }
}
