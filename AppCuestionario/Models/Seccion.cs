using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace AppCuestionario.Models
{
    [Table("secciones")]
    public class Seccion
    {
        [Key]
        [Column("seccion_id")]
        public int SeccionID { get; set; }
        [Column("cuestionario_id")]
        public int CuestionarioID { get; set; }
        public virtual Cuestionario Cuestionario { get; set; }
        [Column("nombre")]
        public string Nombre { get; set; }

        public ICollection<Pregunta> Preguntas { get; set; }
    }
}
