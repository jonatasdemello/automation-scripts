// https://stackoverflow.com/questions/25532262/mapping-a-flat-list-to-a-hierarchical-list-with-parent-ids-c-sharp

// I have a flat list of categories as shown in the following classes
public class FlatCategoryList
{
    public List<FlatCategory> Categories { get; set; }
}
public class FlatCategory
{
    public string ID { get; set; }
    public string Name { get; set; }
    public string ParentID { get; set; }
}

// I'm trying to map my flat list of categories to a heirarical structure such as shown below:
public class HieraricalCategoryList
{
    public List<Category> Categories { get; set; }
}
public class Category
{
    public string ID { get; set; }
    public string Name { get; set; }
    public string ParentID { get; set; }

    public List<Category> ChildCategories { get; set; }
}

// My question is, what is the best way to achieve this, given the fact that there could be an infinite number child tiers?

public HieraricalCategoryList MapCategories(FlatCategoryList flatCategoryList)
{
    var hieraricalCategoryList = new HieraricalCategoryList();

    //Do something here to map the flat category list to the hierarichal one...

    return hieraricalCategoryList;
}

//-------------------------------------------------------------------------------------------------------------------------------
// solution 1
public HieraricalCategoryList MapCategories(FlatCategoryList flatCategoryList)
{
    var categories = (from fc in flatCategoryList.Categories
                      select new Category() {
                          ID = fc.ID,
                          Name = fc.Name,
                          ParentID = fc.ParentID
                      }).ToList();

    var lookup = categories.ToLookup(c => c.ParentID);

    foreach(var c in categories)
    {
        // you can skip the check if you want an empty list instead of null when there is no children
        if(lookup.Contains(c.ID))
            c.ChildCategories = lookup[c.ID].ToList();
    }

    return new HieraricalCategoryList() { Categories = categories };
}

//-------------------------------------------------------------------------------------------------------------------------------
// A very easy and highly performant way to make this transformation
// is to create a lookup in which you map ID values to the nodes that should be the children of that ID value.
// This lookup can be created in a single pass of the nodes.
// After that you can iterate through all of the nodes again
// assigning their child collection to be the value of their ID value in the lookup.
// Note that this is simpler if the lookup maps to objects of the type you are converting to, not converting from.

var lookup = list.Categories
    .Select(category => new Category()
    {
        ID = category.ID,
        Name = category.Name,
        ParentID = category.ParentID,
    })
    .ToLookup(category => category.ParentID);

foreach (var category in lookup.SelectMany(x => x))
    category.ChildCategories = lookup[category.ID].ToList();

var newList = new HieraricalCategoryList()
{
    Categories = lookup[null].ToList(),
};


// Improved the suggested answer

public HieraricalCategoryList MapCategories(FlatCategoryList flatCategoryList)
{
    var categories = (from fc in flatCategoryList.Categories
                      select new Category() {
                          ID = fc.ID,
                          Name = fc.Name,
                          ParentID = fc.ParentID
                      }).ToList();

    var lookup = categories.ToLookup(c => c.ParentID);

    foreach(var c in rootCategories)//only loop through root categories
    {
        // you can skip the check if you want an empty list instead of null
        // when there is no children
        if(lookup.Contains(c.ID))
            c.ChildCategories = lookup[c.ID].ToList();
    }

    //if you want to return only root categories not all the flat list
    //with mapped child

    categories.RemoveAll(c => c.ParentId != 0);//put what ever your parent id is

    return new HieraricalCategoryList() { Categories = categories };
}

-------------------------------------------------------------------------------------------------------------------------------

{
	var careers = results.Read<CareerListDtoModel>().ToList();

	var tmpCareerGroup = results.Read<CareerGroupListModel>().ToList();

	var dicCareerGroup = tmpCareerGroup.ToLookup(x => x.CareerId);

	if (careers.Any())
	{
		for (int i = 0; i < careers.Count(); i++)
		{
			careers[i].CareerGroup = dicCareerGroup[careers[i].CareerId].Select(x => x.GroupId).ToList();
		}
	}

	return careers;
}

-------------------------------------------------------------------------------------------------------------------------------

// Linq Group By
// https://dotnettutorials.net/lesson/linq-distinct-method/

https://newbedev.com/building-hierarchy-objects-from-flat-list-of-parent-child

public class TreeObject
{
    public int Id { get; set; }
    public int ParentId { get; set; }
    public string Name { get; set; }
    public IList<TreeObject> Children { get; set; } = new List<TreeObject>();
}

public IEnumerable<TreeObject> FlatToHierarchy(List<TreeObject> list)
{
    // hashtable lookup that allows us to grab references to containers based on id
    var lookup = new Dictionary<int, TreeObject>();
    // actual nested collection to return
    var nested = new List<TreeObject>();

    foreach (TreeObject item in list)
    {
        if (lookup.ContainsKey(item.ParentId))
        {
            // add to the parent's child list
            lookup[item.ParentId].Children.Add(item);
        }
        else
        {
            // no parent added yet (or this is the first time)
            nested.Add(item);
        }
        lookup.Add(item.Id, item);
    }

    return nested;
}

void Main()
{
    var list = new List<TreeObject>() {
        new TreeObject() { Id = 1, ParentId = 0, Name = "A" },
        new TreeObject() { Id = 2, ParentId = 1, Name = "A.1" },
        new TreeObject() { Id = 3, ParentId = 1, Name = "A.2" },
        new TreeObject() { Id = 4, ParentId = 3, Name = "A.2.i" },
        new TreeObject() { Id = 5, ParentId = 3, Name = "A.2.ii" }
    };

    FlatToHierarchy(list).Dump();
}

// Since I'm updating this 5 years later, here's a recursive LINQ version:

public IList<TreeObject> FlatToHierarchy(IEnumerable<TreeObject> list, int parentId = 0) {
    return (from i in list
            where i.ParentId == parentId
            select new TreeObject {
                Id = i.Id,
                ParentId = i.ParentId,
                Name = i.Name,
                Children = FlatToHierarchy(list, i.Id)
            }).ToList();
}
/*
	foreach Item item in flatlist
	   if item.Parent != null
		  Add item to item.Parent.ChildrenList
		  Remove item from flatlist
	   end if
	end for
*/
