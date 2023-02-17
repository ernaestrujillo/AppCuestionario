using Microsoft.EntityFrameworkCore;

namespace AppCuestionario.Models
{

    public class DataContext : DbContext
    {
        public virtual DbSet<AccionTipo> AccionTipo { get; set; }
        public virtual DbSet<Cuestionario> Cuestionario { get; set; }
        public virtual DbSet<PreguntaTipo> PreguntaTipo { get; set; }
        public virtual DbSet<Pregunta> Pregunta { get; set; }
        public virtual DbSet<RespuestaTipo> RespuestaTipo { get; set; }
        public virtual DbSet<Seccion> Seccion { get; set; }
        public virtual DbSet<Respuesta> Respuesta { get; set; }
        public virtual DbSet<CuestionarioResultado> CuestionarioResultado { get; set; }
        public virtual DbSet<CuestionarioResueltoDet> CuestionarioResueltoDet { get; set; }
        public virtual DbSet<VwCuestionarioResuelto> VwCuestionarioResuelto { get; set; }
        public DataContext(DbContextOptions<DataContext> options) : base(options) { }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Seccion>(entity => {               
                entity.HasOne(e => e.Cuestionario).WithMany(e=>e.Secciones);                
            });

            modelBuilder.Entity<Pregunta>(entity => {
                entity.HasOne(e => e.Seccion).WithMany(e => e.Preguntas);
            });

            modelBuilder.Entity<Respuesta>(entity => {
                entity.HasOne(e => e.Pregunta).WithMany(e => e.Respuestas);
            });

            modelBuilder.Entity<CuestionarioResueltoDet>(entity => {
                entity.HasOne(e => e.CuestionarioResultado).WithMany(e => e.Detalle);
            });

        }
    }
}
