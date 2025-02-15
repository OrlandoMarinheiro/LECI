package code;

import java.util.Scanner;
import java.util.Stack;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ex3 {
    public static void main(String[] args) {

        Stack<Double> stack = new Stack<>();
        
        Pattern val_p = Pattern.compile("([0-9]+)\\s*"); //detetar numeros
        Pattern op_p = Pattern.compile("([+\\-*/])\\s*"); //detetar operadores

        String input;
        if (args.length == 0) {
            Scanner sc = new Scanner(System.in);
            input = sc.nextLine();
            sc.close();
        } else {
            input = args[0];
        }

        for (String arg : input.split(" ")) {
            Matcher val_m = val_p.matcher(arg);
            Matcher op_m = op_p.matcher(arg);

            if (val_m.matches()) {
                stack.add(Double.parseDouble(val_m.group(0).trim()));
                printStack(stack);

            } else if (op_m.matches()) {
                try {
                    Double val1 = stack.pop();
                    Double val2 = stack.pop();
                    char op = op_m.group(0).trim().charAt(0);
                    stack.add(ex1.calculator(val1, op, val2));
                    printStack(stack);

                } catch (Exception e) {
                    System.err.println(String.format("Operação Inválida! São necessários dois operandos"));
                }
            } else {
                System.err.println("Operadores utilizados invalidos. Operados válidos: + - * /");
            }
        }
    }

    public static void printStack(Stack<Double> stack) {
        System.out.println("Stack: " + stack);
    }
}
