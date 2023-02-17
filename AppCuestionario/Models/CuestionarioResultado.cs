using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace AppCuestionario.Models
{
    [Table("cuestionarios_resueltos")]
    public class CuestionarioResultado
    {
        [Key]
        [Column("cues_resuelto_id")]
        public int CuesResultoID { get; set; }
        [Column("cuestionario_id")]
        public int CuestionarioID { get; set; }
        public virtual Cuestionario Cuestionario { get;set;}
        [Column("fecha_hora")]
        public DateTime FechaHora { get; set; }

        public ICollection<CuestionarioResueltoDet> Detalle { get; set; }
    }
}
