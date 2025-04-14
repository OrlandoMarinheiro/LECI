@SuppressWarnings("CheckReturnValue")
public class Interpreter extends PrefixCalculatorBaseVisitor<Double> {

   @Override public Double visitProgram(PrefixCalculatorParser.ProgramContext ctx) {
      Double res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Double visitStat(PrefixCalculatorParser.StatContext ctx) {
      if (ctx.expr() != null) {
         Double res = visit(ctx.expr());
         System.out.println("Result: " + res);
      }
      return visitChildren(ctx);
   }

   @Override public Double visitExprPrefix(PrefixCalculatorParser.ExprPrefixContext ctx) {
      Double exp1 = visit(ctx.expr(0));
      Double exp2 = visit(ctx.expr(1));
      String op = ctx.op.getText();
      switch (op) {
         case "*":
            return exp1 * exp2;
         case "/":
            if (exp2 == 0) {
               return null;
            }
            return exp1 / exp2;
         case "+":
            return exp1 + exp2;
         case "-":
            return exp1 - exp2;
         default:
            return null;
      }
   }

   @Override public Double visitExprNumber(PrefixCalculatorParser.ExprNumberContext ctx) {
      return Double.parseDouble(ctx.Number().getText());
   }
}
