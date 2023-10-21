import React from 'react'
import '../styles/components/Footer.css'
import { FaGithubSquare } from "react-icons/fa";
//import { Link } from 'react-router-dom';

export default function Footer() {
  return (
    <div className='Footer'>
      <div>
        <a href="https://github.com/anddelap/BD2_Proyecto2_1" target="_blank" style={{ color: 'white' }} rel="noreferrer">
          <FaGithubSquare size={35} />
        </a>
      </div>
    </div>
  )
}
