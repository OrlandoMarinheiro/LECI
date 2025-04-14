import java.util.HashMap;
import java.util.Map;

@SuppressWarnings("CheckReturnValue")
public class Interpreter extends CalculatorBaseVisitor<Double> {

   protected Map<String, Double> dict = new HashMap<>();


   @Override public Double visitProgram(CalculatorParser.ProgramContext ctx) {
      Double res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Double visitStat(CalculatorParser.StatContext ctx) {
      if (ctx.expr() != null) {
			Double res = visit(ctx.expr());
         if (res != null) {
            System.out.println(res);
         } 
		}
		return visitChildren(ctx);
      
   }

   @Override public Double visitAssignment(CalculatorParser.AssignmentContext ctx) {
      String id = ctx.ID().getText();
      Double value = visit(ctx.expr());
      dict.put(id, value);
      if (id != null && value != null) {
         System.out.println(id + " = " + value);
      }
		return visitChildren(ctx);
   }

   @Override public Double visitExprAddSub(CalculatorParser.ExprAddSubContext ctx) {
      Double exp1 = visit(ctx.expr(0));
      Double exp2 = visit(ctx.expr(1));
      String op = ctx.op.getText();

      if (exp1 == null || exp2 == null) {
         return null;
      }

      switch (op) {
         case "+":
            return exp1 + exp2;
         case "-":
            return exp1 - exp2;
         default:
            return null;
      }
   }

   @Override public Double visitExprParent(CalculatorParser.ExprParentContext ctx) {
      return visit(ctx.expr());
   }

   @Override public Double visitExprUnary(CalculatorParser.ExprUnaryContext ctx) {
      Double res = visit(ctx.expr());
      String op = ctx.op.getText();

      switch (op) {
         case "-":
            return -res;
         case "+":
            return res;
         default:
            return null;
      }
   }

   @Override public Double visitExprInteger(CalculatorParser.ExprIntegerContext ctx) {
      return Double.parseDouble(ctx.Integer().getText());
   }

   @Override public Double visitExprId(CalculatorParser.ExprIdContext ctx) {
      String ID = ctx.ID().getText();
      if (dict.containsKey(ID)) {
         return dict.get(ID);
      } 
      System.out.println("ERRO: variavel " + ID + " não encontrada!");
      return null;
   }

   @Override public Double visitExprMultDivMod(CalculatorParser.ExprMultDivModContext ctx) {
      Double exp1 = visit(ctx.expr(0));
      Double exp2 = visit(ctx.expr(1));
      String op = ctx.op.getText();
      
      if (exp1 == null || exp2 == null) {
         return null;
      }

      switch (op) {
         case "*":
            return exp1 * exp2;
         case "/":
            if (exp2 == 0) {
               return null;
            }
            return exp1 / exp2;
         case "%":
            if (exp2 == 0) {
               return null;
            }
            return exp1 % exp2;
         default:
            return null;
      }
   }
}
