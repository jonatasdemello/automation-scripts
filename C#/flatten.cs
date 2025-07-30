// https://stackoverflow.com/questions/11830174/how-to-flatten-tree-via-linq

So I have simple tree:

public class MyNode
{
	public MyNode Parent;
	public IEnumerable<MyNode> Elements;
	int group = 1;
}

// You can flatten a tree like this:

IEnumerable<MyNode> Flatten(IEnumerable<MyNode> e) =>
    e.SelectMany(c => Flatten(c.Elements)).Concat(new[] { e });

You can then filter by group using Where(...).

To earn some "points for style", convert Flatten to an extension function in a static class.

public static IEnumerable<MyNode> Flatten(this IEnumerable<MyNode> e) =>
    e.SelectMany(c => c.Elements.Flatten()).Concat(e);

To earn more points for "even better style", convert Flatten to a generic extension method that takes a tree and a function that produces descendants from a node:

public static IEnumerable<T> Flatten<T>(
    this IEnumerable<T> e
,   Func<T,IEnumerable<T>> f
) => e.SelectMany(c => f(c).Flatten(f)).Concat(e);

Call this function like this:

IEnumerable<MyNode> tree = ....
var res = tree.Flatten(node => node.Elements);

If you would prefer flattening in pre-order rather than in post-order, switch around the sides of the Concat(...).

-------------------------------------------------------------------------------------------------------------------------------

// The problem with the accepted answer is that it is inefficient if the tree is deep.
// If the tree is very deep then it blows the stack.
// You can solve the problem by using an explicit stack:

public static IEnumerable<MyNode> Traverse(this MyNode root)
{
    var stack = new Stack<MyNode>();
    stack.Push(root);
    while(stack.Count > 0)
    {
        var current = stack.Pop();
        yield return current;
        foreach(var child in current.Elements)
            stack.Push(child);
    }
}

// Assuming n nodes in a tree of height h and a branching factor considerably less than n,
// this method is O(1) in stack space, O(h) in heap space and O(n) in time.
// The other algorithm given is O(h) in stack, O(1) in heap and O(nh) in time.
// If the branching factor is small compared to n then h is between O(lg n) and O(n),
// which illustrates that the naïve algorithm can use a dangerous amount of stack and a large amount of time if h is close to n.
// Now that we have a traversal, your query is straightforward:

root.Traverse().Where(item=>item.group == 1);


// Just for completeness, here is the combination of the answers from dasblinkenlight and Eric Lippert. Unit tested and everything. :-)

 public static IEnumerable<T> Flatten<T>(
        this IEnumerable<T> items,
        Func<T, IEnumerable<T>> getChildren)
 {
     var stack = new Stack<T>();
     foreach(var item in items)
         stack.Push(item);

     while(stack.Count > 0)
     {
         var current = stack.Pop();
         yield return current;

         var children = getChildren(current);
         if (children == null) continue;

         foreach (var child in children)
            stack.Push(child);
     }
 }




-------------------------------------------------------------------------------------------------------------------------------

public static IEnumerable<SiteMenuItemEditViewModel> FlattenItems(IEnumerable<SiteMenuItemEditViewModel> parents)
{
    var stack = new Stack<SiteMenuItemEditViewModel>();
    var order = 0;

    foreach (var item in parents.Reverse())
    {
        item.parentId = null;
        stack.Push(item);
    }

    while (stack.Count > 0)
    {
        var current = stack.Pop();

        current.order = order;
        current.menuItems.Reverse();

        yield return current;

        foreach (var child in current.children)
        {
            child.parentId = current.id;
            stack.Push(child);
        }

        order++;
    }
}

public SiteMenuItem
{
    public int Id {get;set;}
    public string Name {get;set;}
    public int? ParentId {get;set;}
    public int? Order {get;set;}

    public virtual List<SiteMenuItem> Children {get;set;} //null on initialization
}


This question already has answers here:
How to flatten tree via LINQ? (14 answers)
Closed 5 years ago.

I store a series of objects into the database that have a pretty simple structure. Represented as a model, they looks similar to

public SiteMenuItem
{
    public int Id {get;set;}
    public string Name {get;set;}
    public int? ParentId {get;set;}
    public int? Order {get;set;}

    public virtual List<SiteMenuItem> Children {get;set;} //null on initialization
}

When I retrieve these values from the database,
I transform these values into a nested-list tree-like structure for use in our web-app.
I do that in a fashion similar to:

private static List<SiteMenuItem> GetChildren(List<SiteMenuItem> menu)
{
    // For every SiteMenuItem with a parentId, place the child under their parent.
    menu.ForEach(menuItem => menuItem.Children = menu.Where(n => n.ParentId == menuItem.Id).ToList());
    // Remove all orphaned items.
    menu.RemoveAll(n => n.ParentId != null);

    return menu;
}


[
   {
      "Id":1,
      "Name":"Menu Item 1",
      "Children":[
         {
            "Id":2,
            "Name":"Sub Menu Item 1",
            "Children":[

            ]
         },
         {
            "Id":3,
            "Name":"Sub Menu Item 2",
            "Children":[

            ]
         }
      ]
   },
   {
      "Id":4,
      "Name":"Menu Item 2",
      "Children":[

      ]
   },
   {
      "Id":5,
      "Name":"Menu Item 3",
      "Children":[
         {
            "Id":6,
            "Name":"Sub Menu Item 1",
            "Children":[
               {
                  "Id":7,
                  "Name":"Sub Menu Item 2"
               }
            ]
         },
         {
            "Id":8,
            "Name":"Sub Menu Item 1",
            "Children":[

            ]
         }
      ]
   }
]

Would be transformed into:

[
   {
      "Id":1,
      "Name":"Menu Item 1",
      "Parent":"",
      "Order":1
   },
   {
      "Id":2,
      "Name":"Sub Menu Item 1",
      "Parent":1,
      "Order":1
   },
   {
      "Id":3,
      "Name":"Sub Menu Item 2",
      "Parent":1,
      "Order":2
   },
   {
      "Id":4,
      "Name":"Menu Item 2",
      "Parent":"",
      "Order":2
   },
   {
      "Id":5,
      "Name":"Menu Item 3",
      "Parent":"",
      "Order":3
   },
   {
      "Id":6,
      "Name":"Sub Menu Item 1",
      "Parent":5,
      "Order":1
   },
   {
      "Id":7,
      "Name":"Sub Sub Menu Item 1",
      "Parent":6,
      "Order":1
   },
   {
      "Id":8,
      "Name":"Sub Menu Item 2",
      "Parent":5,
      "Order":2
   }
]


