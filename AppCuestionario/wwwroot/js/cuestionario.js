function validaPregunta(pregunta) {
    if (pregunta.preguntaTipoID == 1) {
        let radiosSeleccionados = $('#frm-' + pregunta.preguntaID + ' input[type=radio]:checked');
        if (radiosSeleccionados.length == 0) {
            msgNotificacion(4, "Seleccione al menos una respuesta", "msgError");
        } else {
            $("#msgError").html("");
            let radioSeleccionado = $(radiosSeleccionados[0]);
            let respuestaID = radioSeleccionado.attr("id");
            const respuesta = pregunta.respuestas.find(x => x.respuestaID == respuestaID);
            if (respuesta != undefined) {
                try {
                    guardarRespuesta(respuesta, pregunta);
                    Accion(respuesta, pregunta);                    
                } catch (e) {
                    msgNotificacion(4, e.message, "msgError");
                }
            }

        }
    }

    if (pregunta.preguntaTipoID == 2) {
        let checkSeleccionados = $('#frm-' + pregunta.preguntaID + ' input[type=checkbox]:checked');
        if (checkSeleccionados.length == 0) {
            msgNotificacion(4, "Seleccione al menos una respuesta", "msgError");
        } else {
            $("#msgError").html("");
            let checkSeleccionado = $(checkSeleccionados[0]);
            let respuestaID = checkSeleccionado.attr("id");
            let respuesta = pregunta.respuestas.find(x => x.respuestaID == respuestaID);
            if (respuesta != undefined) {
                try {                    
                    checkSeleccionados.each(function () {
                        respuestaID = $(this).attr("id");
                        respuesta = pregunta.respuestas.find(x => x.respuestaID == respuestaID);
                        guardarRespuesta(respuesta, pregunta);
                    });
                    Accion(respuesta, pregunta);
                } catch (e) {
                    msgNotificacion(4, e.message, "msgError");
                }
            }

        }
    }

    if (pregunta.preguntaTipoID == 4) {
        let textoRespuesta = $('#frm-' + pregunta.preguntaID + ' input[type=number]');
        if (textoRespuesta.length > 0) {
            textoRespuesta = textoRespuesta[0]
            if ($(textoRespuesta).val() == "") {
                msgNotificacion(4, "Coloque un número en el input", "msgError");
            } else {
                $("#msgError").html("");
                let respuestaID = $(textoRespuesta).attr("respuestaID");
                const respuesta = pregunta.respuestas.find(x => x.respuestaID == respuestaID);
                if (respuesta != undefined) {
                    try {
                        respuesta.valorNumDec = parseFloat($(textoRespuesta).val());
                        guardarRespuesta(respuesta, pregunta);
                        Accion(respuesta, pregunta);                       
                    } catch (e) {
                        msgNotificacion(4, e.message, "msgError");
                    }
                }

            }
        } else {
            msgNotificacion(4, "No se localizo el componente de tipo númerico", "msgError");
        }
    }
}

function guardarRespuesta(respuesta,pregunta) {
    let valorTexto = null;
    let valorTextoArea = null;
    let valorNumDec = null;
    let valorNum = null;
    let respuestaID = respuesta.respuestaID;
    let preguntaID = respuesta.preguntaID;

    if (pregunta.preguntaTipoID == 1 || pregunta.preguntaTipoID == 2) {

        if (respuesta.respuestaTipoID == 1) {
            valorNum = parseInt($("#txt_" + respuesta.respuestaID).val());
        }
        if (respuesta.respuestaTipoID == 2) {
            valorNumDec = parseFloat($("#txt_" + respuesta.respuestaID).val());
        }
        if (respuesta.respuestaTipoID == 3) {
            valorTexto = $("#txt_" + respuesta.respuestaID).val();
        }
    } else if (pregunta.preguntaTipoID==4){
        valorNumDec = respuesta.valorNumDec;
    }
    respuestas.push({ respuestaID, valorNum, valorNumDec, valorTexto, valorTextoArea, preguntaID });
}

function Accion(respuesta, pregunta) {
    let accionID = respuesta.accionTipoID;
    let respuestaTipoID = respuesta.respuestaTipoID;
    if (accionID == 1) {
        MoverXPregunta(respuesta.accionPregunta);
        avancePregunta.push(pregunta);
        CalculoProgreso();
    }

    if (accionID == 2) {
        if (respuesta.accionSeccion.preguntas.length > 0) {
            let primeraPregunta = respuesta.accionSeccion.preguntas[0];
            primeraPregunta.seccionNombre = respuesta.accionSeccion.nombre;
            MoverXPregunta(primeraPregunta);
            avancePregunta.push(pregunta);
            CalculoProgreso();
        } else {
            throw new Error('La sección no tiene preguntas');
        }
    }

    if (accionID == 3) {
        FinCuestionario();
    }
}



function MoverXPregunta(pregunta) {
    preguntaAnterior = preguntaActual;
    preguntaActual = pregunta;
    MostrarOcultarPregunta(preguntaActual, 1);
    MostrarOcultarPregunta(preguntaAnterior, 2);
    $("#seccionTitulo").text(pregunta.seccionNombre);
}

function MostrarOcultarPregunta(pregunta, tipo) {
    if (tipo == 1) {
        $("#pregunta" + pregunta.preguntaID).removeClass("d-none");
    }

    if (tipo == 2) {
        $("#pregunta" + pregunta.preguntaID).addClass("d-none");
    }

}

function CalculoProgreso() {
    const [ultima] = avancePregunta.slice(-1);
    const cal = ultima.preguntaID * 100 / (preguntas.length - 1);
    Progreso(parseInt(cal));
}

function Progreso(porc) {
    $("#progreso").width(porc + "%");
    $("#progreso").html(porc + "%");
}

function FinCuestionario() {

    if (respuestas.length > 0) {
        showSpinner();
        $.ajax({
            type: "POST",
            url: urlGuardar,
            data: { cuestionarioID: cuestionario.cuestionarioID, detalle: respuestas },
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            success: function (response) {      
                hideSpinner();
                if (!response.error) {
                    Progreso(100);
                    $(".secciones").addClass("d-none");
                    $(".preguntas").addClass("d-none");
                    $("#fin").removeClass("d-none");
                    registro = response.id;
                } else {
                    msgNotificacion(4, response.msg, "msgError");
                }
            },
            error: function (response) {
                hideSpinner();
                msgNotificacion(4, response.responseText, "msgError");
            }
        });
    } else {
        Progreso(100);
        $(".secciones").addClass("d-none");
        $(".preguntas").addClass("d-none");
        $("#fin").removeClass("d-none");
    }

    


}

function eliminarRespuestas(preguntaID) {    
    const objWithIdIndex = respuestas.findIndex((obj) => obj.preguntaID == preguntaID);

    if (objWithIdIndex > -1) {
        respuestas.splice(objWithIdIndex, 1);
    }       
 }

function obtenerCuestionario() {
    $.get(urlObtenerCuestionario).done(function (data) {
        cuestionario = data;
        generarCuestionario(cuestionario);
        if (preguntas.length > 0) {
            let primeraPregunta = preguntas[0];
            MoverXPregunta(primeraPregunta);
        }
        total = preguntas.length - 1;

        $(".btnAnterior").click(function () {
            const [pregunta] = avancePregunta.slice(-1);
            MoverXPregunta(pregunta);
            avance = pregunta.preguntaID;
            avancePregunta.pop();
            eliminarRespuestas(pregunta.preguntaID);
            CalculoProgreso();
        });

        $(".btnSiguiente").click(function () {
            let preguntaID = $(this).attr("id");
            const pregunta = preguntas.find(x => x.preguntaID == preguntaID);
            if (pregunta != undefined) {
                if (preguntaID != "") {
                    validaPregunta(pregunta);
                }
            }
        });



        $("input[type=checkbox]").change(function () {
            let preguntaID = $(this).attr("preguntaID");
            let respuestaID = $(this).attr("id");
            const pregunta = preguntas.find(x => x.preguntaID == preguntaID);
            if (pregunta != undefined) {
                const respuesta = pregunta.respuestas.find(x => x.respuestaID == respuestaID);
                if (respuesta != undefined) {
                    if (respuesta.respuestaTipoID != null) {
                        if (this.checked) {
                            $("#txt_" + respuestaID).prop("disabled", false);
                            $("#txt_" + respuestaID).focus();
                        } else {
                            $("#txt_" + respuestaID).prop("disabled", true);
                        }
                    }
                }
            }
        })


        hideSpinner();
    });
}

function generarCuestionario(cuestionario) {
    $("#nombreCuestionario").text(cuestionario.nombre);
    $("#tituloCuestionario").text(cuestionario.titulo);
    generarSecciones(cuestionario.secciones);
}

function generarSecciones(secs) {
    secciones = secs;
    secciones.forEach((seccion) => {
        let preguntas = generarPreguntas(seccion.preguntas, seccion.nombre);
        let tmpSeccion = `${preguntas}`;
        $("#secciones").append(tmpSeccion);
    });
}

function generarPreguntas(pregs, seccionNombre) {
    let result = "";
    pregs.forEach((pregunta) => {
        let respuestas = generarRespuestas(pregunta);
        pregunta.seccionNombre = seccionNombre;
        preguntas.push(pregunta);
        result += `<div class="card preguntas shadow-sm d-none" style="margin:20px;" id="pregunta${pregunta.preguntaID}">
                    <div class="card-header">
                      <h4>${pregunta.numero} - ${pregunta.descripcion}</h4>
                    </div>
                    <div class="card-body fs-5" style="padding:50px;">    
                        <form id="frm-${pregunta.preguntaID}">                          
                            ${respuestas}
                             <div class="text-center" style="margin-top:20px;">
                                <button type="button" class="btn btn-secondary btn-lg btnAnterior ${pregunta.orden == 1 ? 'd-none' : ''}" id="${pregunta.preguntaID}" >Anterior</button>
                                <button type="button" class="btn btn-primary btn-lg btnSiguiente" id="${pregunta.preguntaID}" >Siguiente</button>
                            </div>
                        </form>
                    </div>
                </div>`;
    });
    return result;
}

function generarRespuestas(pregunta) {
    let result = "";
    if (pregunta.preguntaTipoID == 1) {
        pregunta.respuestas.forEach((respuesta) => {
            result += `<div class="form-check px-2">
                          <input class="form-check-input" type="radio" name="respuesta${pregunta.preguntaID}" id="${respuesta.respuestaID}" preguntaID="${pregunta.preguntaID}" >
                          <label class="form-check-label" for="${respuesta.respuestaID}">
                            ${respuesta.titulo}
                          </label>
                    </div>`;
        });
    }

    if (pregunta.preguntaTipoID == 2) {
        pregunta.respuestas.forEach((respuesta) => {

            if (respuesta.respuestaTipoID == 3) {
                result += `<div class="form-check px-2">
                              <input class="form-check-input" type="checkbox" name="respuesta${pregunta.preguntaID}" id="${respuesta.respuestaID}" preguntaID="${pregunta.preguntaID}">
                              <label class="form-check-label" style="width:100%" for="${respuesta.respuestaID}">
                               <input class="form-control" disabled type="text" for="${respuesta.respuestaID} name="respuesta${pregunta.preguntaID}" id="txt_${respuesta.respuestaID}">           
                              </label>
                        </div>`;

            } else {
                result += `<div class="form-check px-2">
                              <input class="form-check-input" type="checkbox" name="respuesta${pregunta.preguntaID}" id="${respuesta.respuestaID}" preguntaID="${pregunta.preguntaID}">
                              <label class="form-check-label" for="${respuesta.respuestaID}">
                                ${respuesta.titulo}
                              </label>
                        </div>`;
            }
        });
    }

    if (pregunta.preguntaTipoID == 4) {
        pregunta.respuestas.forEach((respuesta) => {
            result += ` 
                          <input class="form-control"  type="number" respuestaID="${respuesta.respuestaID}" >           
                      
                    `;
        });
    }

    return result;
}


$(document).ready(() => {
    showSpinner();
    obtenerCuestionario();
    $("#btnReload").click(function () {
        document.location.reload();
    });

    $("#btnDownload").click(function () {
        if (registro > 0) {
            document.location.href = urlDownload + "/" + registro;
        } else {
            msgNotificacion(4, "No hay un registro guardado");
        }
    });
})