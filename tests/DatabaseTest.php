<?php

namespace EDP\Tests;

use PHPUnit\Framework\TestCase;
use EDP\Database;

final class DatabaseTest extends TestCase
{
    public static function setUpBeforeClass(): void
    {
        Database::connect();
    }

    public function testConnection(): void
    {
        $this->assertTrue(Database::isConnected());
    }

    public function testDotenv()
    {
        $this->assertEquals('5432', Database::get('port'));
    }

    public static function setUpAfterClass(): void
    {
        Database::disconnect();
    }
}