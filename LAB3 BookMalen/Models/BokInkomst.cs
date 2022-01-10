using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace LAB3_BookMalen.Models
{
    [Keyless]
    [Table("BokInkomst")]
    public partial class BokInkomst
    {
        [Column("ISBN13")]
        [StringLength(50)]
        public string? Isbn13 { get; set; }
        public int? Solda { get; set; }
        [Column("ButikID")]
        [StringLength(50)]
        public string? ButikId { get; set; }

        [ForeignKey(nameof(Isbn13))]
        public virtual Böcker? Isbn13Navigation { get; set; }
    }
}
