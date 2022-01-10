using LAB3_BookMalen.Data;
using LAB3_BookMalen.Models;

while (true)
{
    Console.WriteLine("Store (B)alace, Book(M)anagement, (C),lear Screen, (Q)uite");
    string subInout1 = Console.ReadLine();
    string mainInput1 = subInout1.ToUpper();


    if (mainInput1 == "B")
    {
        Console.WriteLine("(Ad)libris, (Sc)iencefiction bokhandeln, (Ak)ademibokhandeln");

        string subInout2 = Console.ReadLine();
        string mainInput2 = subInout2.ToUpper();
        if (mainInput2 == "AD")
        {
            Butik(1);
        }
        else if (mainInput2 == "SC")
        {
            Butik(2);
        }
        else if (mainInput2 == "AK")
        {
            Butik(3);
        }
        Console.ReadKey();
    }
    else if (mainInput1 == "M")
    {
        Console.WriteLine("(A)dd, (R)emove");

        string subInout2 = Console.ReadLine();
        string mainInput2 = subInout2.ToUpper();
        if (mainInput2 == "A")
        {

            int Bid = FindButik();

            int BookNum = FindBook(Bid);


            UpdateDB(Bid, BookNum);
        }
        else if (mainInput2 == "R")
        {
            int Bid = FindButik();
            int returnNum = FindForRemove(Bid-1)-1;
            removeAmount(Bid, returnNum);
        }
    }
    else if (mainInput1 == "Q")
    {
        Environment.Exit(0);
    }
    else if (mainInput1 == "C")
    {
        Console.Clear();
    }
}


void Butik(int Bid)
{
    using var context = new BookMalenContext();
    {

        var butikId = context.LagerSaldos.Where(a => a.ButikId == Bid).Select(l => l.Isbn13).ToList();//getting the books for the store

        for (int i = 0; i < butikId.Count; i++)
        {
            var Lager = context.LagerSaldos.Where(l => l.Isbn13 == butikId[i]).Select(l => l.Antal).ToList();
            var böcker = context.Böckers.Where(b => b.Isbn13 == butikId[i]).Select(b => b.Titel).ToList();


            Console.WriteLine($"Titel: {böcker[0]} Antal: {Lager[0]}");

        }
        Console.WriteLine("Press ESC to return to menu");
    }
}
int FindButik()
{
    int Bid = 0;
    int NewButikId = 0;


    using var context = new BookMalenContext();
    {
        var butik = context.Butikers.ToList();
        foreach (var item in butik)
        {
            NewButikId++;
            Console.WriteLine("({0}) {1}", NewButikId, item.Butiksnamn);
        }
        string input = Console.ReadLine();
        if (input != null)
            Bid = int.Parse(input);

    }

    return Bid;
}
int FindBook(int Bid)
{

    int BookNum = 0;
    int j = 0;
    var context = new BookMalenContext();
    {
        var book = context.Böckers.ToList();

        var butik = context.Butikers.ToList();
        for (int i = 0; i < butik.Count; i++)
        {
            if (Bid == i)
            {

                foreach (var time1 in book)
                {
                    j++;

                    Console.WriteLine($"({j}) {time1.Titel}");

                }
            }
        }
        String Input2 = Console.ReadLine();
        if (Input2 != null)
            BookNum = int.Parse(Input2) - 1;
    }
    return BookNum;
}

void UpdateDB(int Bid, int BookNum)
{
    using var context = new BookMalenContext();
    {
        var Lager = context.LagerSaldos.Where(l => l.ButikId == Bid).ToList();
        var book2 = context.Böckers.Select(b => b.Isbn13).ToList();
        var lagerLenght = context.LagerSaldos.ToList();
        if (Lager.Exists(l => l.Isbn13 == book2[BookNum]))
        {

            Console.WriteLine("How many do you want to add?");
            string input3 = Console.ReadLine();

            for (int i = 0; i < lagerLenght.Count + 1; i++)
            {
                var dep = context.LagerSaldos.Find(i);
                if (dep != null && dep.Isbn13 == book2[BookNum] && dep.ButikId == Bid && dep.Id == i)
                {
                    dep.Antal = int.Parse(input3) + dep.Antal;
                    context.SaveChanges();

                }
            }
        }
        else if (Lager.Exists(l => l.Isbn13 != book2[BookNum]))
        {

            Console.WriteLine("How many do you want to add?");
            string input3 = Console.ReadLine();


            var newBook = new LagerSaldo { Antal = int.Parse(input3), ButikId = Bid + 1, Id = lagerLenght.Count() + 1, Isbn13 = book2[BookNum] };


            context.LagerSaldos.Add(newBook);
            context.SaveChanges();




        }
    }
}
 int FindForRemove(int Bid)
{
    int returnNum;
    int j = 0;
    using var context = new BookMalenContext();
    {


        var butik = context.LagerSaldos.Where(l => l.ButikId == Bid+1).Select(l => l.Isbn13).ToList();

        for (int i = 0; i < butik.Count; i++)
        {
            var book = context.Böckers.Where(b => b.Isbn13 == butik[i]).Select(b => b.Titel).ToList();

            j++;

            Console.WriteLine($"({j}) {book[0]}");

        }
        string input = Console.ReadLine();
        returnNum = int.Parse(input);


    }
    return returnNum;

}
void removeAmount(int Bid, int returnNum)
{
    using var context = new BookMalenContext();
    {
        var butik = context.LagerSaldos.Where(l => l.ButikId == Bid).Select(l => l.Isbn13).ToList();
      
        var returnstring = context.Böckers.Where(b => b.Isbn13 == butik[returnNum]).Select(b => b.Isbn13).FirstOrDefault();
        var lagerLenght = context.LagerSaldos.ToList();

        Console.WriteLine("How many do you want to remove?");
        string input3 = Console.ReadLine();
        for (int i = 0; i < lagerLenght.Count + 1; i++)
        {
            var dep = context.LagerSaldos.Find(i);
            if (dep != null && dep.Isbn13 == returnstring && dep.ButikId == Bid && dep.Id == i)
            {
                dep.Antal = dep.Antal - int.Parse(input3);
                if (dep.Antal <= 0)
                    context.LagerSaldos.Remove(dep);
                context.SaveChanges();

            }
        }


    }
}




