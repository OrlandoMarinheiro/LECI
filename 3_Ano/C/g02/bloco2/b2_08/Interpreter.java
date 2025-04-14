@SuppressWarnings("CheckReturnValue")
public class Interpreter extends CalculatorBaseVisitor<String> {

   @Override public String visitProgram(CalculatorParser.ProgramContext ctx) {
      String res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public String visitStat(CalculatorParser.StatContext ctx) {
      if (ctx.expr() != null) {
			String res = visit(ctx.expr());
         if (res != null) {
            System.out.println(ctx.expr().getText() + " -> " + res);
         } 
		} 
      if (ctx.assignment() != null) {
			String res = visit(ctx.assignment());
         if (res != null) {
            System.out.println(ctx.assignment().getText() + " -> " + res);
         } 
		} 

		return visitChildren(ctx);
   }

   @Override public String visitAssignment(CalculatorParser.AssignmentContext ctx) {
      return ctx.ID().getText() + " = " + visit(ctx.expr());
   }

   @Override public String visitExprAddSub(CalculatorParser.ExprAddSubContext ctx) {
      return visit(ctx.expr(0)) + " " + visit(ctx.expr(1)) + " " + ctx.op.getText();
   }

   @Override public String visitExprParent(CalculatorParser.ExprParentContext ctx) {
      return visit(ctx.expr());
   }

   @Override public String visitExprUnary(CalculatorParser.ExprUnaryContext ctx) {
      return visit(ctx.expr()) + " !" + ctx.op.getText();
   }

   @Override public String visitExprInteger(CalculatorParser.ExprIntegerContext ctx) {
      return ctx.Integer().getText();
   }

   @Override public String visitExprId(CalculatorParser.ExprIdContext ctx) {
      return ctx.ID().getText();
   }

   @Override public String visitExprMultDivMod(CalculatorParser.ExprMultDivModContext ctx) {
      return visit(ctx.expr(0)) + " " + visit(ctx.expr(1)) + " " + ctx.op.getText();
   }
}
