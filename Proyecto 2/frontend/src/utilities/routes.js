import IngresoView from '../views/IngresoView/IngresoView';
import ReportesView from '../views/ReportesView/ReportesView';

export const rutas = [
    {
        path: "/",
        element: ReportesView
    },
    {
        path: "/ingreso-datos",
        element: IngresoView
    }
]