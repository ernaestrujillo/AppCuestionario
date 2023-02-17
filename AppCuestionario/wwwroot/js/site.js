// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.

function msgNotificacion(tipo, msg, contenedor ="msgAlertContainer") {
    let alertPlaceholder = document.getElementById(contenedor);
    let alertTrigger = document.getElementById('liveAlertBtn');   
    let wrapper = document.createElement('div');
    if (tipo == 1) {
        wrapper.innerHTML = `<div class="alert alert-primary alert-dismissible d-flex align-items-center" role="alert">
                              <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Info:"><use xlink:href="#info-fill"/></svg>
                              <div>
                                ${msg}
                              </div>
                              <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>`;
    }

    if (tipo == 2) {
        wrapper.innerHTML = `<div class="alert alert-success alert-dismissible d-flex align-items-center" role="alert">
                              <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Info:"><use xlink:href="#info-fill"/></svg>
                              <div>
                                ${msg}
                              </div>
                              <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>`;
    }

    if (tipo == 3) {
        wrapper.innerHTML = `<div class="alert alert-warning alert-dismissible d-flex align-items-center" role="alert">
                              <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Warning:"><use xlink:href="#exclamation-triangle-fill"/></svg>
                              <div>
                                ${msg}
                              </div>
                              <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>`;
    }

    if (tipo == 4) {
        wrapper.innerHTML = `<div class="alert alert-danger alert-dismissible d-flex align-items-center" role="alert">
                              <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Danger:"><use xlink:href="#exclamation-triangle-fill"/></svg>
                              <div>
                               ${msg}
                              </div>
                              <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>`;
    }
   
    alertPlaceholder.append(wrapper);   
}

function showSpinner() {
   
    let spinner = `<div class="spinner" id="spnLoad">
                    <div class="d-flex justify-content-center">
                      <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Cargando...</span>
                      </div>
                    </div>
                    </div>`;

    $("main").append(spinner);
}

function hideSpinner() {
    $("#spnLoad").remove();
}