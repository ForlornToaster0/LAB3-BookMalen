using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace LAB3_BookMalen.Models
{
    [Table("Böcker")]
    public partial class Böcker
    {
        public Böcker()
        {
            LagerSaldos = new HashSet<LagerSaldo>();
        }

        [Key]
        [Column("ISBN13")]
        [StringLength(50)]
        public string Isbn13 { get; set; } = null!;
        [StringLength(50)]
        public string? Titel { get; set; }
        [StringLength(50)]
        public string? Språk { get; set; }
        public int? Pris { get; set; }
        [Column("FörfattareID")]
        [StringLength(50)]
        public string? FörfattareId { get; set; }

        [ForeignKey(nameof(FörfattareId))]
        [InverseProperty("Böckers")]
        public virtual Författare? Författare { get; set; }
        [InverseProperty(nameof(LagerSaldo.Isbn13Navigation))]
        public virtual ICollection<LagerSaldo> LagerSaldos { get; set; }
    }
}
