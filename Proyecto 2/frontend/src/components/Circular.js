import React from 'react'
import { Chart as ChartJS, ArcElement, Tooltip, Legend } from 'chart.js';
import { Doughnut } from 'react-chartjs-2';

ChartJS.register(ArcElement, Tooltip, Legend);

export default function Circular(props) {
    const labels = [];
    const percentages = [];
    const { datos } = props;
    //console.log(props.datos);
    let etiquetas = Object.keys(datos);  
    //console.log(etiquetas);
    etiquetas.forEach(element => {
        datos[element].forEach(element2 => {
            labels.push(element+" - "+element2.partido);
        });
    });

    etiquetas.forEach(element => {
        datos[element].forEach(element2 => {
            percentages.push(element2.porcentaje_votos);
        });
    });
    //console.log(percentages);

    //console.log(labels);
    
    const data = {
        labels: labels,
        datasets: [
            {
                label: '% of de votos',
                data: percentages,
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 159, 64, 0.2)',
                  ],
                  borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)',
                  ],
                borderWidth: 1,
            },
        ],
    };
    return (
        <div>
            <Doughnut data={data} />
        </div>
    )
}
