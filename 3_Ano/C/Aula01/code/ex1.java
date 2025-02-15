package code;

import java.util.Scanner;

public class ex1 {
    
    public static void main(String[] args) {
        try {
            Scanner sc = new Scanner(System.in);
            System.out.print("Introduza uma operação do tipo <número> <operador> <número>: ");
            double num1 = sc.nextDouble();
            char op = sc.next().charAt(0);
            double num2 = sc.nextDouble();
            double result = calculator(num1, op, num2);
            System.out.println("Resultado: " + result);
            sc.close();
            
        } catch (Exception e) {
            System.out.println("Operação Inválida");
        }
    }

    public static double calculator(double num1, char op, double num2) {
        double result = 0;
        switch (op) {
            case '+':
                result = num1 + num2;
                break;
            case '-':
                result = num1 - num2;
                break;
            case '*':
                result = num1 * num2;
                break;
            case '/':
                result = num1 / num2;
                break;
            default:
                System.out.println("Operador Inválido");
                break;
        }
        return result;
    }
}
