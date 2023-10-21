import React from 'react'
import {
    Chart as ChartJS,
    CategoryScale,
    LinearScale,
    BarElement,
    Title,
    Tooltip,
    Legend,
} from 'chart.js';
import { Bar } from 'react-chartjs-2';
import { useQuery } from 'react-query';
import { getTopSedes } from '../api/dashboardApi';
ChartJS.register(
    CategoryScale,
    LinearScale,
    BarElement,
    Title,
    Tooltip,
    Legend
);
export const options = {
    responsive: true,
    plugins: {
      legend: {
        position: 'top'
      },
      title: {
        display: false,
        text: 'Chart.js Bar Chart',
      },
    },
  };

export default function Barchart() {
    const { isLoading, error, data } = useQuery({
        queryKey: ['top-sedes'],
        queryFn: () => getTopSedes(),
        refetchInterval: 1000,
    })
    if (isLoading) return 'Loading...'
    if (error) return 'An error has occurred: ' + error.message
    //console.log(data)
    const labels = [];
    const votos = [];
    data.resultado.forEach((element) => {
        labels.push("Sede "+element.sede);
    });
    data.resultado.forEach((element) => {
        votos.push(element.total_votos);
    });
    const datos = {
        labels,
        datasets: [
          {
            label: 'Sede',
            data: votos,
            backgroundColor: 'rgba(75, 192, 192, 1)',
          },
        ],
      };
    return (
        <Bar options={options} data={datos} />
    )
}
