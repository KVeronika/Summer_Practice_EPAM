using System;

namespace Entities
{
    public class Question
    {
        public Question(int id, string textQuestion)
        {
            if(string.IsNullOrWhiteSpace(textQuestion) )
            {
                throw new ArgumentOutOfRangeException();
            }
            this.Id = id;
            this.TextQuestion = textQuestion;
        }
        public int Id { get; }

        public int IdTest { get; }

        public string TextQuestion { get; }
    }
}
