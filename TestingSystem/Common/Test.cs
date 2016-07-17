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

            this.id = id;
            this.name = name;
        }

        public int Id
        {
            get
            {
                return id;
            }
        }

        public string Name
        {
            get
            {
                return name;
            }
        }
    }
}
