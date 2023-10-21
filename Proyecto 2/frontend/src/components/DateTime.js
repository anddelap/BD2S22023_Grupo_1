import React, { useState } from 'react'
import "../styles/components/DateTime.css";
import { getDatetime } from '../api/datetimeApi';
import { useQuery } from 'react-query';

export default function DateTime() {
    //var [date, setDate] = useState(new Date());
    const { isLoading, error, data } = useQuery({
        queryKey: ['history'],
        queryFn: () => getDatetime(),
        refetchInterval:1000,
    })
    if (isLoading) return 'Loading...'
    if (error) return 'An error has occurred: ' + error.message
    return (
        <div className='dt-main'>
            {data.datetime}
        </div>
    )
}
