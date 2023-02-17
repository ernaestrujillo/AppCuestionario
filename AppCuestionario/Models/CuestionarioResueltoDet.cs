using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace AppCuestionario.Models
{
    [Table("cuestionarios_resueltos_det")]
    public class CuestionarioResueltoDet
    {
        [Key]
        [Column("detalle_id")]
        public int DetalleID { get; set; }

        [Column("cues_resuelto_id")]
        public int CuestionarioResultadoCuesResultoID { get; set; }
        public virtual CuestionarioResultado CuestionarioResultado { get; set; }
        [Column("respuesta_id")]
        public int RespuestaID { get; set; }
        public virtual Respuesta Respuesta { get; set; }
        [Column("valor_num")]
        public int ValorNum { get; set; }
        [Column("valor_num_dec")]
        public double ValorNumDec { get; set; }
        [Column("valor_texto")]
        public string ValorTexto { get; set; }
        [Column("valor_texto_area")]
        public string ValorTextoArea { get; set; }
    }
}
