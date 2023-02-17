using AppCuestionario.Models;
using ClosedXML.Excel;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Diagnostics;

namespace AppCuestionario.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly DataContext _dataContext;

        public HomeController(ILogger<HomeController> logger,DataContext dataContext)
        {
            _logger = logger;
            _dataContext = dataContext;
        }

        public IActionResult Index()
        {
            var cuestionarios = _dataContext.Cuestionario.ToList();
            return View(cuestionarios);
        }

        public IActionResult Cuestionario(int id)
        {
            
            return View(new Cuestionario { CuestionarioID=id});
        }

        [HttpGet]
        public async Task<IActionResult> CuestionarioPorID(int id)
        {
            var cuestionario = _dataContext.Cuestionario.Include(e=>e.Secciones.OrderBy(f=>f.SeccionID)).
                                                         ThenInclude(e=>e.Preguntas.OrderBy(f=>f.Orden)).                                                         
                                                         ThenInclude(e => e.Respuestas.OrderBy(f=>f.Orden)).                                                        
                                                         FirstOrDefault(op => op.CuestionarioID == id);
            return Json(cuestionario);
        }

        [HttpPost]      
        public async Task<IActionResult> GuardarCuestionario(CuestionarioResultado cuestionarioResultado)
        {
            dynamic resultado = null;
            try
            {
                cuestionarioResultado.FechaHora = DateTime.Now;
                _dataContext.Add(cuestionarioResultado);
                await _dataContext.SaveChangesAsync();
                resultado = new
                {
                    error = false,
                    id= cuestionarioResultado.CuesResultoID,
                    msg = "Registro guardado exitosamente"
                };
            }
            catch(Exception ex)
            {
                resultado = new
                {
                    error = true,
                    msg = ex.Message
                };
            }
            return Json(resultado);
        }

        public IActionResult ExportarExcel(int id)
        {
            string excelContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            var preguntas = _dataContext.VwCuestionarioResuelto.Where(e => e.ID == id).OrderBy(e => e.ID).ToList();
            using (var workbook = new XLWorkbook())
            {
                var worksheet = workbook.Worksheets.Add("Users");
                var currentRow = 1;
                worksheet.Cell(currentRow, 1).Value = "Id";
                worksheet.Cell(currentRow, 1).Style.Font.Bold = true;
                worksheet.Cell(currentRow, 2).Value = "Fecha";
                worksheet.Cell(currentRow, 2).Style.Font.Bold = true;
                worksheet.Cell(currentRow, 3).Value = "Cuestionario";
                worksheet.Cell(currentRow, 3).Style.Font.Bold = true;
                worksheet.Cell(currentRow, 4).Value = "Pregunta";
                worksheet.Cell(currentRow, 4).Style.Font.Bold = true;
                worksheet.Cell(currentRow, 5).Value = "Respuesta";
                worksheet.Cell(currentRow, 5).Style.Font.Bold = true;

                foreach (var pregunta in preguntas)
                {
                    currentRow++;
                    worksheet.Cell(currentRow, 1).Value = pregunta.ID;
                    worksheet.Cell(currentRow, 2).Value = pregunta.FechaHora.ToString("dd/MM/yy HH:mm");
                    worksheet.Cell(currentRow, 3).Value = pregunta.Cuestionario;
                    worksheet.Cell(currentRow, 4).Value = pregunta.Pregunta;
                    worksheet.Cell(currentRow, 5).Value = pregunta.Respuesta;
                }

                worksheet.Columns().AdjustToContents();
                using (var stream = new MemoryStream())
                {
                    workbook.SaveAs(stream);
                    var content = stream.ToArray();

                    return File(content, excelContentType);
                }
            }
        }
        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}