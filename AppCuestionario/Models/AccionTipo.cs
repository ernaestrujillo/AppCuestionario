using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace AppCuestionario.Models
{
    [Table("accion_tipo")]
    public class AccionTipo
    {
        [Key]
        [Column("accion_tipo_id")]
        public int AccionTipoID { get; set; }
        [Column("accion")]
        public string Accion { get; set; }

    }
}
