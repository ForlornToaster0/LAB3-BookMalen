using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace LAB3_BookMalen.Models
{
    [Keyless]
    [Table("Förlag")]
    public partial class Förlag
    {
        [Column("ID")]
        [StringLength(50)]
        public string? Id { get; set; }
        [StringLength(50)]
        public string? Förlagnamn { get; set; }
        [StringLength(50)]
        public string? Adressuppgifter { get; set; }
    }
}
