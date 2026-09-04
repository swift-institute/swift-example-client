import Coder
public import Example
import Example_Counter
import Example_Counter_Signature
import Example_Greeting
import Example_Greeting_Signature
import Example_HTTP
public import Example_Signature
public import HTTP
public import HTTP_Client
import HTTP_Reply
import Tagged_Coder

extension Example {

    public static func client<Transport: Swift.Error>(
        over interpretation: HTTP.Interpretation<Transport>
    ) -> Example.Client<HTTP.Interpretation<Transport>.Error> {
        Example.Client.client(
            routing: Example.router,
            replying: Example.Replies(
                greeting: Example.Greeting.Replies(
                    greet: HTTP.reply {
                        HTTP.ok(Example.Greeting.Message.self)
                    }
                ),
                counter: Example.Counter.Replies(
                    increment: HTTP.reply {
                        HTTP.ok(Example.Counter.Value.self)
                        HTTP.badRequest(Example.Counter.Error.self)
                    }
                )
            ),
            over: interpretation
        )
    }
}
