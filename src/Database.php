<?php

namespace EDP;

final class Database
{
    private static \PDO $pdo;

    public static function connect(): void
    {
        if (self::isConnected()) {
            return;
        }

        self::loadDotenv();

        $dsn = sprintf("pgsql:host=%s;port=%s;dbname=%s",
            $_ENV['hostname'],
            $_ENV['port'],
            $_ENV['database']
        );

        self::$pdo = new \PDO($dsn, $_ENV['username'], $_ENV['password']);
    }

    private static function loadDotenv(): void
    {
        $dotenv = \Dotenv\Dotenv::createImmutable(dirname(__FILE__, 2));
        $dotenv->load();
    }

    public static function isConnected(): bool
    {
        return isset(self::$pdo);
    }
}