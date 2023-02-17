using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace AppCuestionario.Models
{
    [Table("pregunta_tipo")]
    public class PreguntaTipo
    {
        [Key]
        [Column("pregunta_tipo_id")]
        public int PreguntaTipoID { get; set; }
        [Column("tipo")]
        public string Tipo { get; set; }
    }
}
