using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace LAB3_BookMalen.Models
{
    [Keyless]
    public partial class VTitlarPerFörfattare
    {
        [StringLength(101)]
        public string Name { get; set; } = null!;
        public int? Ålder { get; set; }
        public int? Titlar { get; set; }
        public int? Lagervärde { get; set; }
    }
}
