<?php

namespace EDP\Tests;

use PHPUnit\Framework\TestCase;
use EDP\Composer;

final class ComposerTest extends TestCase
{
    /**
     * @covers \EDP\Composer
     */
    public function testComposer()
    {
        $this->assertTrue(Composer::test());
    }
}