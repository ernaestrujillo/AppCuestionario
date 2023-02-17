using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace AppCuestionario.Models
{
    [Table("respuestas")]
    public class Respuesta
    {
        [Key]
        [Column("respuesta_id")]
        public int RespuestaID { get; set; }
        [Column("pregunta_id")]
        public int PreguntaID { get; set; }
        public virtual Pregunta Pregunta { get; set; }
        [Column("accion_tipo_id")]
        public int AccionTipoID { get; set; }
        public virtual AccionTipo AccionTipo { get; set; }
        [Column("accion_seccion_id")]
        public int? AccionSeccionID { get; set; }
        public virtual Seccion? AccionSeccion { get; set; }
        [Column("accion_pregunta_id")]
        public int? AccionPreguntaID { get; set; }
        public virtual Pregunta AccionPregunta { get; set; }
        [Column("titulo")]
        public string Titulo { get; set; }
        [Column("orden")]
        public int Orden { get; set; }
        [Column("respuesta_tipo_id")]
        public int? RespuestaTipoID { get; set; }
        public virtual RespuestaTipo? RespuestaTipo { get; set; }


    }
}
