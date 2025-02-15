package code;

import java.util.HashMap;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ex2 {
    
    public static void main(String[] args) {

        HashMap<String, Double> vars = new HashMap<String, Double>();

        Scanner sc = new Scanner(System.in);

        // detetar atribuições a variáveis (n = 1 ou n = n + 1)
        Pattern p = Pattern.compile("([a-zA-Z]+)\\s*=\\s*(.+)");
        
        while(true){
            System.out.print("Introduza uma operação ou 'exit' para sair: ");
            String input = sc.nextLine();
            Matcher m = p.matcher(input);

            if (input.equals("exit")){
                break;
            }

            if (m.matches()){

                String var = m.group(1);
                String exp = m.group(2);
                calculateExpression(var, exp, vars);
                System.out.println("\n--------------------");
                for (String key : vars.keySet()) {
                    System.out.println(key + " = " + vars.get(key));
                }
                System.out.println("--------------------\n");
            } else {
                try {
                    calculateExpression(null, input, vars);
                } catch (Exception e) {
                    System.err.println("Operação Inválida");
                }
            }
        }
        sc.close();
    }

    public static Double getVariableValue(String var, HashMap<String, Double> vars){
        var = var.trim();
        if (vars.containsKey(var)){
            return vars.get(var);
        } else {
            return Double.parseDouble(var);
        }
    }

    public static void calculateExpression(String var, String exp, HashMap<String, Double> vars){
        
        // detetar se existe uma operação do tipo <número> <operador> <número>
        Pattern p2 = Pattern.compile("\\s*(\\S+)\\s*([+\\-*/])\\s*(\\S+)\\s*");
        Matcher m2 = p2.matcher(exp);

        if (m2.matches()){

            try {
                Double var1 = getVariableValue(m2.group(1), vars);
                Double var2 = getVariableValue(m2.group(3), vars);

                char op = m2.group(2).charAt(0);

                if (var != null){
                    vars.put(var, ex1.calculator(var1, op, var2));
                } else {
                    System.out.println(String.format("Resultado de (%s): %.2f", exp, ex1.calculator(var1, op, var2)));
                }
            } catch (Exception e) {
                System.out.println("Variável não definida.");
            }
        } else {
            try {
                vars.put(var, Double.parseDouble(exp));
            } catch (Exception e) {
                System.out.println("Operação Inválida");
            }
        }
    }
}


