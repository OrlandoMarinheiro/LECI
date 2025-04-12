import java.util.Iterator;
import org.antlr.v4.runtime.tree.TerminalNode;

@SuppressWarnings("CheckReturnValue")
public class Execute extends HelloBaseVisitor<String> {

   @Override public String visitSaudacao(HelloParser.SaudacaoContext ctx) {
      String res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public String visitGreetings(HelloParser.GreetingsContext ctx) {
      String name = visit(ctx.name());
      System.out.println("Olá " + name);
      return name;
   }

   @Override public String visitBye(HelloParser.ByeContext ctx) {
      String name = visit(ctx.name());
      System.out.println("Adeus " + name);
      return name;
   }

   @Override public String visitName(HelloParser.NameContext ctx) {
      String res = " ";
      Iterator<TerminalNode> it = ctx.ID().iterator();

      while (it.hasNext()) {
         res += it.next() + " ";
      }
      return res.trim();
   }
}
