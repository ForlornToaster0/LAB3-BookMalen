using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace LAB3_BookMalen.Models
{
    [Table("LagerSaldo")]
    public partial class LagerSaldo
    {
        [Column("ButikID")]
        public int? ButikId { get; set; }
        [Column("ISBN13")]
        [StringLength(50)]
        public string? Isbn13 { get; set; }
        public int? Antal { get; set; }
        [Key]
        public int Id { get; set; }

        [ForeignKey(nameof(ButikId))]
        [InverseProperty(nameof(Butiker.LagerSaldos))]
        public virtual Butiker? Butik { get; set; }
        [ForeignKey(nameof(Isbn13))]
        [InverseProperty(nameof(Böcker.LagerSaldos))]
        public virtual Böcker? Isbn13Navigation { get; set; }
    }
}
