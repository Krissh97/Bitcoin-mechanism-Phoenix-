// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
var nonce = [];
var l=[];
for(var i=0; i<block_data.length; i++){
    nonce.push(block_data[i].nonce);
    l.push(i);
}
console.log(nonce);
var ctx = document.getElementById("myChart").getContext('2d');
var myChart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: l,
        datasets: [{
            label: 'Nonce Data',
            data: nonce,
            borderColor: [
                'rgba(255,99,132,1)'
            ]
        }]
    },
    options:{}
    
});