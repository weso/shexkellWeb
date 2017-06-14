var API_ENDPOINT = "http://localhost:8080"

var app = new Vue({
  el: "#app",
  data: {
    shapeMap: [
      {
        node: "",
        shape: "",
        expectedResult: "positive"
      }
    ],

    graph: "",

    schema: "",

    resultsMap: []
  },

  methods: {
    validate: function() {
      validate(this.shapeMap, this.graph, this.schema, result => this.resultsMap = fromValidation(result));
    }
  }
});

/**
 * Create the Shape Map with the format used by the API
 * @param {Array<object>} shapeMapRef 
 */
function makeShapeMap(shapeMapRef) {
  return shapeMapRef.map(node => ({
    "node": {
      nodeType: "unode",
      value: node.node
    },
    "shapes": [
      {
        shape: node.shape,
        result: node.expectedResult
      }
    ]
  }));

}

/**
 * Perform the validation against the API
 * @param {} validationCallback 
 * @param {Array<object>} shapeMap
 * @param {string} graph
 * @param {string} schema
 */
function validate(shapeMap, graph, schema, validationCallback) {
  let shapeMapRequest = JSON.stringify(makeShapeMap(shapeMap));
  $.ajax({
    type: "POST",
    url: `${API_ENDPOINT}/validate`,
    contentType: "application/json",
    data: JSON.stringify({
      shapeMap: shapeMapRequest,
      graph: graph,
      schema: schema
    }),
    success: validationCallback
  });
}



/**
 * 
 * @param {Array<object>} shapeMap 
 */
function fromValidation(shapeMap) {
  return shapeMap.map(node => ({
    "node": node.node.value,
    "shape": node.shapes.find(sh => sh.shape != "")
  }))
  .filter(n => n.shape !== undefined);
}