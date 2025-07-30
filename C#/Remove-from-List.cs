//post will discuss how to remove an item from a list in C#.

A List<T> class has several methods that can be used to remove elements from it. These are discussed below in detail with code examples:
1. Using List<T>RemoveAt() Method

The List<T>RemoveAt() method removes the item at the specified index from the List<T>. After removing the item, all the items in the list that follows the removed item are reindexed by one position to the left. This method is an O(n) operation that performs a linear search on the list.

using System;
using System.Collections.Generic;

public class Example
{
    public static void Main()
    {
        var list = new List<int> { 1, 2, 3, 4, 5 };
        int indexToRemove = 1;

        list.RemoveAt(indexToRemove);

        Console.WriteLine(String.Join(", ", list));        // 1, 3, 4, 5
    }
}

Download  Run Code


The List<T>.RemoveAt() method throws a System.ArgumentOutOfRangeException if the specified index is out of range. The specified index must be non-negative and less than the size of the list.

using System;
using System.Collections.Generic;

public class Example
{
    public static void Main()
    {
        List<int> list = new List<int>() { 1, 2 };
        int indexToRemove = 2;

        if (indexToRemove >= 0 && indexToRemove < list.Count) {
            list.RemoveAt(indexToRemove);
        }

        Console.WriteLine(String.Join(", ", list));        // 1, 2
    }
}

Download  Run Code
2. Using List<T>Remove() Method

The List<T>Remove() method removes the first occurrence of a specific object from the List<T> in O(n) time, and return a boolean value determining if the item is successfully removed or not. It also returns false if the item was not present in the list. The following example demonstrates its usage:

using System;
using System.Collections.Generic;

public class Example
{
    public static void Main()
    {
        var list = new List<int> { 2, 5, 8, 1, 4 };
        int itemToRemove = 8;

        list.Remove(itemToRemove);

        Console.WriteLine(String.Join(", ", list));        // 2, 5, 1, 4
    }
}

Download  Run Code
3. Using List<T>RemoveAll() Method

The List<T>.RemoveAll() method removes all the elements from the list that matches the specified predicate. The following code shows how to use the RemoveAll() method to in-place remove all occurrences of an element from the list.

using System;
using System.Collections.Generic;

public class Example
{
    public static void Main()
    {
        List<int> list = new List<int> { 2, 5, 1, 2, 4 };
        int itemToRemove = 2;

        list.RemoveAll(x => x == itemToRemove);

        Console.WriteLine(String.Join(", ", list));        // 5, 1, 4
    }
}

Download  Run Code
4. Using Except() Method

Finally, to remove items from a list that are present in another list, use the Enumerable.Except() method. It returns the set difference of two sequences. i.e. the unique elements in the first list that don’t appear in the second list. Note that this method does not modify either list but returns a sequence containing the set difference.

using System;
using System.Linq;
using System.Collections.Generic;

public class Example
{
    public static void Main()
    {
        List<int> list = new List<int> { 2, 5, 1, 2, 4 };
        List<int> toRemove = new List<int> { 2, 5 };

        List<int> result = list.Except(toRemove).ToList();

        Console.WriteLine(String.Join(", ", result));        // 1, 4
    }
}


