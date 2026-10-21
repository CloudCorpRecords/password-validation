import { strict as assert } from 'node:assert';
import { test } from 'node:test';
import { getPasswordStrength } from './solution.ts';

test('example from the problem statement', () => {
    assert.deepEqual(
        getPasswordStrength(
            ['iliketoCoDe', 'teaMAKEsmehappy', '123456789', 'xYz12', 'password'],
            ['coffee', 'code', 'happy'],
        ),
        ['strong', 'weak', 'weak', 'weak', 'weak'],
    );
});

test('edge cases', () => {
    assert.deepEqual(
        getPasswordStrength(['ABCDEFG', 'abc123', 'Abcdef', '12345a', 'Abc12'], []),
        ['weak', 'strong', 'strong', 'strong', 'weak'],
    );
});
