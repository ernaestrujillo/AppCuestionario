using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace AppCuestionario.Models
{
    [Table("respuesta_tipo")]
    public class RespuestaTipo
    {
        [Key]
        [Column("respuesta_tipo_id")]
        public int RespuestaTipoID { get; set; }
        [Column("Tipo")]
        public string Tipo { get; set; }
    }
}
