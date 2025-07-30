public enum IdentityProtocols
{
    SAML,
    OAuth,
    OpenID
};

var isEnumParsed=Enum.TryParse("0", true, out IdentityProtocols parsedEnumValue);
Console.WriteLine(isEnumParsed?parsedEnumValue.ToString():"Not Parsed");

// # The above code will print the SAML because the enum is started by default with the value 0.
// # What happens if we run the below code with the same Enum declaration?

var isEnumParsed=Enum.TryParse("-1", true, out IdentityProtocols parsedEnumValue);
Console.WriteLine(isEnumParsed?parsedEnumValue.ToString():"Not Parsed");

