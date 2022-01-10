using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using LAB3_BookMalen.Models;

namespace LAB3_BookMalen.Data
{
    public partial class BookMalenContext : DbContext
    {
        public BookMalenContext()
        {
        }

        public BookMalenContext(DbContextOptions<BookMalenContext> options)
            : base(options)
        {
        }

        public virtual DbSet<BokInkomst> BokInkomsts { get; set; } = null!;
        public virtual DbSet<Butiker> Butikers { get; set; } = null!;
        public virtual DbSet<Böcker> Böckers { get; set; } = null!;
        public virtual DbSet<Författare> Författares { get; set; } = null!;
        public virtual DbSet<Förlag> Förlags { get; set; } = null!;
        public virtual DbSet<LagerSaldo> LagerSaldos { get; set; } = null!;
        public virtual DbSet<VTitlarPerFörfattare> VTitlarPerFörfattares { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=BookMalen;Integrated Security=True");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<BokInkomst>(entity =>
            {
                entity.HasOne(d => d.Isbn13Navigation)
                    .WithMany()
                    .HasForeignKey(d => d.Isbn13)
                    .HasConstraintName("FK_Table_5_Table_2");
            });

            modelBuilder.Entity<Butiker>(entity =>
            {
                entity.Property(e => e.Id).ValueGeneratedNever();
            });

            modelBuilder.Entity<Böcker>(entity =>
            {
                entity.HasKey(e => e.Isbn13)
                    .HasName("PK_Table_2");

                entity.HasOne(d => d.Författare)
                    .WithMany(p => p.Böckers)
                    .HasForeignKey(d => d.FörfattareId)
                    .HasConstraintName("FK_Table_2_Table_1");
            });

            modelBuilder.Entity<LagerSaldo>(entity =>
            {
                entity.Property(e => e.Id).ValueGeneratedNever();

                entity.HasOne(d => d.Butik)
                    .WithMany(p => p.LagerSaldos)
                    .HasForeignKey(d => d.ButikId)
                    .HasConstraintName("FK_LagerSaldo_Butiker");

                entity.HasOne(d => d.Isbn13Navigation)
                    .WithMany(p => p.LagerSaldos)
                    .HasForeignKey(d => d.Isbn13)
                    .HasConstraintName("FK_LagerSaldo_Table_2");
            });

            modelBuilder.Entity<VTitlarPerFörfattare>(entity =>
            {
                entity.ToView("v_TitlarPerFörfattare");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
