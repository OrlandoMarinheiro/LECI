package code;

import java.util.Scanner;

class Node {
    String value;
    Node left, right;

    public Node(String value) {
        this.value = value;
        this.left = this.right = null;
    }
}

public class ex7 {
    private static int index = 0; 

    public static Node buildExpressionTree(String[] expression) {
        if (index >= expression.length) {
            return null;
        }

        String token = expression[index++];
        
        if (token.matches("[+\\-*/]")) {  
            Node root = new Node(token);
            root.left = buildExpressionTree(expression); 
            root.right = buildExpressionTree(expression); 
            return root;
        } else { 
            return new Node(token); 
        }
    }

    public static Node ExpressionTree(String[] expression) {
        index = 0;  
        return buildExpressionTree(expression);
    }

    public static boolean isValidExpression(String[] expression) {
        int cntOperando = 0;
        int cntOperator = 0;

        for (String token : expression) {
            if (token.matches("[0-9]+")) {
                cntOperando++;
            } else if (token.matches("[+\\-*/]")) {
                cntOperator++;
            } else {
                return false;
            }
        }

        if (cntOperator >= cntOperando) {
            return false;
        }
        return cntOperando == cntOperator + 1;
    }


    public static String printInfix(Node root) {
        if (root == null) {
            return "";
        }
        if (root.left == null && root.right == null) {
            return root.value;
        }
        return "(" + printInfix(root.left) + " " + root.value + " " + printInfix(root.right) + ")";
    }

    public static double eval(Node root){
        
        if (root == null) {
            return 0;
        }
        if (root.left == null && root.right == null) {
            return Double.parseDouble(root.value);
        }

        double left = eval(root.left);
        double right = eval(root.right);

        if (root.value.equals("/") && right == 0) {
            throw new ArithmeticException("Impossivel dividir por 0");
        }

        switch (root.value) {
            case "+":
                return left + right;
            case "-":
                return left - right;
            case "*":
                return left * right;
            case "/":
                return left / right;
            default:
                throw new IllegalArgumentException("Operador inválido: " + root.value);
        }
    }



    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println("Digite a expressão: ");
        String input = sc.nextLine();
        sc.close();

        String[] expressao = input.trim().split("\\s+");

        if (!isValidExpression(expressao)) {
            System.out.println("Expressão inválida");
            return;
        }
        Node root = ExpressionTree(expressao);
        System.out.println("Notação infixa: " + printInfix(root)); 
        System.out.println("Resultado: " + eval(root)); 
    }
}
