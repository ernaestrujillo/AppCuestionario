using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace AppCuestionario.Models
{
    [Table("vw_cuestionario_resuelto")]
    [Keyless]
    public class VwCuestionarioResuelto
    {
        [Column("id")]
        public int ID { get; set; }
        [Column("fecha_hora")]
        public DateTime FechaHora { get; set; }
        [Column("cuestionario")]
        public string Cuestionario { get; set; }
        [Column("pregunta")]
        public string Pregunta { get; set; }
        [Column("respuesta")]
        public string Respuesta { get; set; }
    }
}
