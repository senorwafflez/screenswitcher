// See https://aka.ms/new-console-template for more information

var randomList = new List<string>();
  Random random = new Random();
        int max = 2; // Maximum value (inclusive)
        int threshold = 20; // 20% threshold for number 2

        for (int i = 0; i < 255; i++) // Generate 255 random numbers
        {
            int randomNumber = GetRandomNumber(random, max, threshold);
            randomList.Add($"$0{randomNumber}");
          //  Console.WriteLine("Random Number: " + randomNumber);
        }

var occurrences = GetIndicesOfOccurrences(randomList, "$02");
var percentage = occurrences.Count() / 255 * 100;
Console.WriteLine($"Percentage : {percentage}%")
var indexToReplace = GetRandomNumber(random, occurrences.Count(), 100);
// while (randomList.Count("$02") > threshold / 255)
// {

// }


Console.WriteLine();

foreach (var chunk in randomList.Chunk(16))
{
    Console.WriteLine($".byte {string.Join(", ", chunk)}");
}


 static int GetRandomNumber(Random random, int max, int threshold)
    {
        int randomNumber;
        int maxWithThreshold = max + 1; // Add 1 to include the maximum value in the range

        int chance = random.Next(0, 100); // Generate a random chance value from 0 to 99

        if (chance < threshold) // If the chance is less than the threshold, generate number 2
        {
            randomNumber = 2;
        }
        else // Otherwise, generate numbers 0 or 1 with equal probability
        {
            randomNumber = random.Next(0, maxWithThreshold);
        }

        return randomNumber;
    }

 static List<int> GetIndicesOfOccurrences<T>(List<T> list, T targetValue)
    {
        List<int> indices = new List<int>();

        for (int i = 0; i < list.Count; i++)
        {
            if (EqualityComparer<T>.Default.Equals(list[i], targetValue))
            {
                indices.Add(i);
            }
        }

        return indices;
    }