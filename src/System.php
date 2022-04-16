<?php

namespace EDP;

final class System 
{
    /**
     * Inicializa o sistema
     */
    public static function start(): void
    {
        echo $_SERVER['REQUEST_URI'];
    }
}