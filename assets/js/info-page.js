function cleanUpActions(elements) {
  for(let element of elements) {
    let actionElements = $(element).children('.action');
    let actionCount = actionElements.length;
    for (let actionElement of actionElements) {
        $(actionElement).addClass('col-md-2')
    }
    let offset = (12 - 2 * actionCount) / 2;
    if (offset > 0) {
        $(actionElements[0]).addClass('col-md-offset-' + offset)
    } 
  }
}
