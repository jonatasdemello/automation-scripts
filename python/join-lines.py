
# Instead of printing, you can append these to a text file or a list:

with open("test.txt") as f:
    content = f.readlines()
    str = ""
    for i in xrange(1,len(content)+1):
        str += content[i-1].strip()
        if i % 2 == 0:
            print str
            str = ""

# or

with open("test.txt") as f:
    content = f.readlines()
    for i in xrange(1, len(content)+1):
        if i % 2 == 0: print content[i-2].strip() + content[i-1].strip()


with open("test.txt") as f:
    data = [x for x in f.read().split("\n") if x.strip() != ""]
    for line1, line2 in list(zip(data, data[1:]))[::2]:
        print(" ".join([line1, line2]))


# variable z that holds this information.

lines_iter = iter(z.splitlines())  # If z is a file, lines_iter = z works
# itertools.izip() is usable, too, for a low memory footprint:
for date_time_order in zip(lines_iter, lines_iter, lines_iter):
    print " ".join(date_time_order)  # "<date> <time> <order>"


# z is a single string

z = """Hello,
how
are
you?
I
am
fine.
Lovely
Weather."""

threelines = range(0,len(z),3)
for num, line in enumerate(z):
    if num in threelines:
        print ' '.join(z[num:num+3])


# Using a list instead:
z = """Hello,
how
are
you?
I
am
fine.
Lovely
Weather."""

z = z.split("\n")

threelines = range(0,len(z),3)
for num, line in enumerate(z):
    if num in threelines:
        print ' '.join(z[num:num+3])

# Incidentally, your num in threelines check is a little inefficient for large inputs. I suggest using the chunking recipe from this post instead.

z = """Hello,
how
are
you?
I
am
fine.
Lovely
Weather."""

z = z.split("\n")

def chunks(l, n):
    """ Yield successive n-sized chunks from l.
    """
    for i in xrange(0, len(l), n):
        yield l[i:i+n]

for chunk in chunks(z, 3):
    print " ".join(chunk)


# -------------------------------------------------------------------------------------------------------------------------------

# https://stackoverflow.com/questions/312443/how-do-you-split-a-list-into-evenly-sized-chunks

# Here's a generator that yields the chunks you want:

def chunks(lst, n):
    """Yield successive n-sized chunks from lst."""
    for i in range(0, len(lst), n):
        yield lst[i:i + n]

import pprint
pprint.pprint(list(chunks(range(10, 75), 10)))
[[10, 11, 12, 13, 14, 15, 16, 17, 18, 19],
 [20, 21, 22, 23, 24, 25, 26, 27, 28, 29],
 [30, 31, 32, 33, 34, 35, 36, 37, 38, 39],
 [40, 41, 42, 43, 44, 45, 46, 47, 48, 49],
 [50, 51, 52, 53, 54, 55, 56, 57, 58, 59],
 [60, 61, 62, 63, 64, 65, 66, 67, 68, 69],
 [70, 71, 72, 73, 74]]


#If you're using Python 2, you should use xrange() instead of range():

def chunks(lst, n):
    """Yield successive n-sized chunks from lst."""
    for i in xrange(0, len(lst), n):
        yield lst[i:i + n]


# Also you can simply use list comprehension instead of writing a function,
# though it's a good idea to encapsulate operations like this in named functions
# so that your code is easier to understand. Python 3:

[lst[i:i + n] for i in range(0, len(lst), n)]

# Python 2 version:

[lst[i:i + n] for i in xrange(0, len(lst), n)]


#-------------------------------------------------------------------------------------------------------------------------------
# If you want something super simple:

def chunks(l, n):
    n = max(1, n)
    return (l[i:i+n] for i in range(0, len(l), n))

# Use xrange() instead of range() in the case of Python 2.x

