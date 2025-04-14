import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.tree.ErrorNode;
import org.antlr.v4.runtime.tree.TerminalNode;
import java.util.HashMap;

@SuppressWarnings("CheckReturnValue")

public class DictTranslate extends DictNumbersBaseListener {

   HashMap<String, Integer> dict = new HashMap<String, Integer>();
   

   @Override public void enterProgram(DictNumbersParser.ProgramContext ctx) {
      System.out.println("A ler o ficheiro...");
   }

   @Override public void exitProgram(DictNumbersParser.ProgramContext ctx) {
      System.out.println("Hash map criado!");
   }

   @Override public void enterStat(DictNumbersParser.StatContext ctx) {
   }

   @Override public void exitStat(DictNumbersParser.StatContext ctx) {
   }

   @Override public void enterExpr(DictNumbersParser.ExprContext ctx) {
   }

   @Override public void exitExpr(DictNumbersParser.ExprContext ctx) {
      dict.put(ctx.Word().getText(), Integer.parseInt(ctx.Integer().getText()));
   }

   @Override public void enterEveryRule(ParserRuleContext ctx) {
   }

   @Override public void exitEveryRule(ParserRuleContext ctx) {
   }

   @Override public void visitTerminal(TerminalNode node) {
   }

   @Override public void visitErrorNode(ErrorNode node) {
   }
}
