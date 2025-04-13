import javax.naming.spi.DirObjectFactory;

@SuppressWarnings("CheckReturnValue")
public class Interpreter extends CalculatorBaseVisitor<Double> {

   @Override public Double visitProgram(CalculatorParser.ProgramContext ctx) {
      Double res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Double visitStat(CalculatorParser.StatContext ctx) {
      if (ctx.expr() != null) {
         Double res = visit(ctx.expr());
         System.out.println(res);
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
