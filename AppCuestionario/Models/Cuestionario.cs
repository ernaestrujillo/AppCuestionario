using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace AppCuestionario.Models
{
    [Table("cuestionarios")]
    public class Cuestionario
    {
        [Key]
        [Column("cuestionario_id")]
        public int CuestionarioID { get; set; }
        [Column("nombre")]
        public string Nombre { get; set; }
        [Column("titulo")]
        public string Titulo { get; set; }

        public ICollection<Seccion> Secciones { get; set; }
    }
}
