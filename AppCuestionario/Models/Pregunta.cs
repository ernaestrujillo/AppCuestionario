using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace AppCuestionario.Models
{
    [Table("preguntas")]
    public class Pregunta
    {
        [Key]
        [Column("pregunta_id")]
        public int PreguntaID { get; set; }
        [Column("seccion_id")]
        public int SeccionID { get; set; }
        public virtual Seccion Seccion { get; set; }
        [Column("pregunta_tipo_id")]
        public int PreguntaTipoID { get; set; }
        public virtual PreguntaTipo PreguntaTipo { get; set; }
        [Column("pregunta")]
        public string Descripcion { get; set; }
        [Column("orden")]
        public int Orden { get; set; }
        [Column("numero")]
        public string Numero { get; set; }

        public ICollection<Respuesta> Respuestas { get; set; }

    }
}
