using System;

namespace Entities
{
    public class Test
    {
        private int id;

        private string name;

        public Test(int id, string name)
        {
            if (string.IsNullOrWhiteSpace(name) || id < 0)
            {
                throw new ArgumentOutOfRangeException();
            }

            this.Id = id;
            this.Name = name;
        }

        public int Id { get; }

        public string Name { get; }
    }
}
