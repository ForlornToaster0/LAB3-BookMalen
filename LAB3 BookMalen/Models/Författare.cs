using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace LAB3_BookMalen.Models
{
    [Table("Författare")]
    public partial class Författare
    {
        public Författare()
        {
            Böckers = new HashSet<Böcker>();
        }

        [Key]
        [Column("ID")]
        [StringLength(50)]
        public string Id { get; set; } = null!;
        [StringLength(50)]
        public string? Förnamn { get; set; }
        [StringLength(50)]
        public string? Efternamn { get; set; }
        [Column(TypeName = "date")]
        public DateTime? Födelsedatum { get; set; }

        [InverseProperty(nameof(Böcker.Författare))]
        public virtual ICollection<Böcker> Böckers { get; set; }
    }
}
