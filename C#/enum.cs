public enum Suits
{
    Spades,
    Hearts,
    Clubs,
    Diamonds,
    NumSuits
}

public void PrintAllSuits()
{
    foreach (var suit in Enum.GetValues(typeof(Suits)))
    {
        System.Console.WriteLine(suit.ToString());
    }
}


public void PrintAllSuits()
{
    foreach (string name in Enum.GetNames(typeof(Suits)))
    {
        System.Console.WriteLine(name);
    }
}


foreach (Suit suit in (Suit[]) Enum.GetValues(typeof(Suit)))
{
}



