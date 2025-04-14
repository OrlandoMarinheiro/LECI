import java.io.IOException;
import java.util.Scanner;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;

public class DictNumbersMain {
   public static void main(String[] args) {
      try {
         // create a CharStream that reads from standard input:
         CharStream input = CharStreams.fromFileName("numbers.txt");
         // create a lexer that feeds off of input CharStream:
         DictNumbersLexer lexer = new DictNumbersLexer(input);
         // create a buffer of tokens pulled from the lexer:
         CommonTokenStream tokens = new CommonTokenStream(lexer);
         // create a parser that feeds off the tokens buffer:
         DictNumbersParser parser = new DictNumbersParser(tokens);
         // replace error listener:
         //parser.removeErrorListeners(); // remove ConsoleErrorListener
         //parser.addErrorListener(new ErrorHandlingListener());
         // begin parsing at program rule:
         ParseTree tree = parser.program();
         if (parser.getNumberOfSyntaxErrors() == 0) {
            // print LISP-style tree:
            // System.out.println(tree.toStringTree(parser));
            ParseTreeWalker walker = new ParseTreeWalker();
            DictTranslate listener0 = new DictTranslate();
            walker.walk(listener0, tree);

            Scanner sc = new Scanner(System.in);
            while (sc.hasNextLine()) {

               String line = sc.nextLine();
               String[] words = line.split("[ \\s-]+");
               
               StringBuilder res = new StringBuilder();
               for (String word : words) {
                  Integer num = listener0.dict.get(word);
                  if (num != null) {
                     res.append(num);
                     res.append(" ");
                  } else {
                     continue;
                  }
               }
               System.out.println("A list of numbers: " + res);

            }
            sc.close();
         }
      }
      catch(IOException e) {
         e.printStackTrace();
         System.exit(1);
      }
      catch(RecognitionException e) {
         e.printStackTrace();
         System.exit(1);
      }
   }
}
