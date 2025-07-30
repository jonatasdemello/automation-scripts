https://stebet.net/benchmarking-and-performance-optimizations-in-c-using-benchmarkdotnet/

dotnet run -p PerformanceTest.csproj -c Release


public static class IP2LocationHelper1
{
    public static uint IPAddressToInteger(string input)
    {
        uint[] elements = input.Split('.').Select(x => uint.Parse(x)).ToArray();
        return elements[0] * 256U * 256U * 256U + elements[1] * 256U * 256U + elements[2] * 256U + elements[3];
    }
}

The string.Split() method is actually defined with a params parameter accepting an array of characters as possible delimiters. What a params parameters does is, even provided with just one parameter, it always creates an array, and creating a new array every time we call the method is obviously expensive so we'll start by modifying it into a static variable.


public static class IP2LocationHelper2
{
    private static readonly char[] Delimiter = new[] { '.' };

    public static uint IPAddressToInteger(string input)
    {
        uint[] elements = input.Split(Delimiter).Select(x => uint.Parse(x)).ToArray();
        return elements[0] * 256U * 256U * 256U + elements[1] * 256U * 256U + elements[2] * 256U + elements[3];
    }
}

Since an IP address is made up of four bytes (32 bits) there is no reason for us to parse the individual elements as int. Let's try converting them to byte and see where that takes us.
Code

public static class IP2LocationHelper3
{
    private static readonly char[] Delimiter = new[] { '.' };

    public static uint IPAddressToInteger(string input)
    {
        byte[] elements = input.Split(Delimiter).Select(x => byte.Parse(x)).ToArray();
        return elements[0] * 256U * 256U * 256U + elements[1] * 256U * 256U + elements[2] * 256U + elements[3];
    }
}


For all four elements we are parsing the string representation into a byte using byte.Parse. This involves a lot of checking which really shouldn't be necessary. Since a byte can only have 256 different decimal string representations we might as well create a Dictionary<string, byte> mapping the possible string to their byte values. Let's create the following static variable and initialize it in the static constructor.
Code

public static class IP2LocationHelper4
{
    private static readonly char[] Delimiter = new[] { '.' };
    private static readonly Dictionary<string, byte> elementMapper = new Dictionary<string, byte>();

    static IP2LocationHelper4()
    {
        for (uint i = 0; i < 256; i++)
        {
            elementMapper[i.ToString()] = (byte)i;
        }
    }

    public static uint IPAddressToInteger(string input)
    {
        byte[] elements = input.Split(Delimiter).Select(x => elementMapper[x]).ToArray();
        return elements[0] * 256U * 256U * 256U + elements[1] * 256U * 256U + elements[2] * 256U + elements[3];
    }
}

By caching of data and pre-parsing the possible string the performance has drastically improved by 40%. But we're not done yet!

Avoid LINQ in performance critical code

It's been known that although LINQ is great tool to make complex filtering and composition easier to read it does come with a performance impact. Let's try replacing the Select() and ToArray() methods with a standard new.
Code

public static class IP2LocationHelper5
{
    private static readonly char[] Delimiter = new[] { '.' };
    private static readonly Dictionary<string, byte> elementMapper = new Dictionary<string, byte>();

    static IP2LocationHelper5()
    {
        for (uint i = 0; i < 256; i++)
        {
            elementMapper[i.ToString()] = (byte)i;
        }
    }

    public static uint IPAddressToInteger(string input)
    {
        string[] stringElements = input.Split(Delimiter);
        byte[] elements = new[] {
			elementMapper[stringElements[0]],
			elementMapper[stringElements[1]],
			elementMapper[stringElements[2]],
			elementMapper[stringElements[3]]
		};
        return elements[0] * 256U * 256U * 256U + elements[1] * 256U * 256U + elements[2] * 256U + elements[3];
    }
}

OK. That's a pretty big improvement right there! LINQ has a pretty hefty performance hit, and performance has improved by almost 60% now. But is there more we can do? Certainly, let's do some math!
Bit-shifting?

For the first three elements,we really are only shifting their bits around in an integer (multiplying an integer by 256 is really only doing a left shift of 8-bits). Fortunately, C# has the bit shifting operators << and >> (left and right shift respectively). Let's see if that improves our code in any way.
Code

public static class IP2LocationHelper6
{
    private static readonly char[] Delimiter = new[] { '.' };
    private static readonly Dictionary<string, uint> elementMapper = new Dictionary<string, uint>();

    static IP2LocationHelper6()
    {
        for (uint i = 0; i < 256; i++)
        {
            elementMapper[i.ToString()] = i;
        }
    }

    public static uint IPAddressToInteger(string input)
    {
        string[] stringElements = input.Split(Delimiter);
        uint[] elements = new[] { elementMapper[stringElements[0]], elementMapper[stringElements[1]], elementMapper[stringElements[2]], elementMapper[stringElements[3]] };
        return (elements[0] << 24) + (elements[1] << 16) + (elements[2] << 8) + elements[3];
    }
}

Not a lot of change, although allocations seem to have been reduced and just a minor speed bump. Looking at this code made me realize another alternative. Just like we created the map to convert strings into bytes, why don't we create four maps that would map all possible strings to pre-shifted unsigned integers.
Pre-shifting with more maps

Let's do some more pre-mapping, now with pre-shifted bytes so we only have to do additions after splitting up the string elements.
Code

public static class IP2LocationHelper7
{
    private static readonly char[] Delimiter = new[] { '.' };
    private static readonly Dictionary<string, uint> element0Mapper = new Dictionary<string, uint>();
    private static readonly Dictionary<string, uint> element1Mapper = new Dictionary<string, uint>();
    private static readonly Dictionary<string, uint> element2Mapper = new Dictionary<string, uint>();
    private static readonly Dictionary<string, uint> element3Mapper = new Dictionary<string, uint>();

    static IP2LocationHelper7()
    {
        for (uint i = 0; i < 256; i++)
        {
            element0Mapper[i.ToString()] = i << 24;
            element1Mapper[i.ToString()] = i << 16;
            element2Mapper[i.ToString()] = i << 8;
            element3Mapper[i.ToString()] = i;
        }
    }

    public static uint IPAddressToInteger(string input)
    {
        string[] stringElements = input.Split(Delimiter);
        return
			element0Mapper[stringElements[0]] +
			element1Mapper[stringElements[1]] +
			element2Mapper[stringElements[2]] +
			element3Mapper[stringElements[3]];
    }
}

Results
Method 	Median 	StdDev 	Scaled 	Gen 0 	Gen 1 	Get 2 	Bytes Allocated/Op
IPAddressToInteger_1 	784.7456 ns 	15.5832 ns 	1.00 	753.00 	- 	- 	94.92
IPAddressToInteger_2 	781.3869 ns 	15.8058 ns 	1.00 	737.00 	- 	- 	93.85
IPAddressToInteger_3 	781.2921 ns 	8.0850 ns 	1.00 	685.71 	- 	- 	87.25
IPAddressToInteger_4 	453.6526 ns 	4.4243 ns 	0.58 	664.50 	- 	- 	84.33
IPAddressToInteger_5 	320.2013 ns 	88.6061 ns 	0.41 	636.77 	- 	- 	80.30
IPAddressToInteger_6 	309.9793 ns 	6.2034 ns 	0.40 	618.12 	- 	- 	77.84
IPAddressToInteger_7 	302.1271 ns 	7.0767 ns 	0.39 	558.55 	- 	- 	70.64

Et voila! More allocations removed and small speed bump along with it. We'll make do with this for now.


    public static class IP2LocationHelper8
    {
        [Benchmark]
        public static uint IPAddressToInteger(string input)
        {
            uint ipAddress = 0;
            uint acc = 0;
            // Note: we assume that the string is well formed
            foreach (var c in input)
            {
                if (c == '.')
                {
                    ipAddress = (ipAddress << 8) | acc;
                    acc = 0;
                }
                else
                {
                    acc = acc * 10 + (uint)(c - '0');
                }
            }
            ipAddress = (ipAddress << 8) | acc;
            return ipAddress;
        }
    }