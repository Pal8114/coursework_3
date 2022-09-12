import Blob "mo:base/Blob";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Nat16 "mo:base/Nat16";
import Text "mo:base/Text";
import http_types "./http_types";

actor {
  stable var currentValue : Nat = 0;

  // Increment the counter with the increment function.
  public func increment() : async () {
    currentValue += 1;
  };

  // Read the counter value with a get function.
  public query func get() : async Nat {
    currentValue
  };

  // Write an arbitrary value with a set function.
  public func set(n: Nat) : async () {
    currentValue := n;
  };

  public shared query func http_request(req : http_types.HttpRequest) : async http_types.HttpResponse {
    var html = "<html><body><h1>" # " The value obtained is " # Nat.toText(currentValue) # "</h1></body></html>";
    {
        body = Blob.toArray(Text.encodeUtf8(html));
        headers = [ ("Content-Type", "text/html; charset=UTF-8") ];
        streaming_strategy = null;
        status_code = 200;
    };
  };
};