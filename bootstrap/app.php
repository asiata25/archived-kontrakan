<?php

use App\Helpers\ResponseFormatter;
use Illuminate\Auth\AuthenticationException;
use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Illuminate\Validation\ValidationException;
use Laravel\Sanctum\Http\Middleware\CheckAbilities;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__ . '/../routes/web.php',
        api: __DIR__ . '/../routes/api.php',
        apiPrefix: 'api/v1',
        commands: __DIR__ . '/../routes/console.php',
        health: '/up',
        then: function () {
            Route::middleware(['api'])
                ->prefix('/api/v1/admin')
                ->group(base_path('routes/api_admin.php'));
        }
    )
    ->withMiddleware(function (Middleware $middleware): void {
        $middleware
            ->throttleApi('api')
            ->alias([
                'abilities' => CheckAbilities::class
            ]);
    })
    ->withExceptions(function (Exceptions $exceptions): void {
        $exceptions->render(function (Throwable $exception) {
            if ($exception instanceof ValidationException) {
                return ResponseFormatter::error(
                    message: $exception->getMessage(),
                    error: $exception->validator->errors(),
                    code: $exception->status
                );
            }

            if ($exception instanceof AuthenticationException) {
                return ResponseFormatter::error(
                    message: strtolower($exception->getMessage()),
                    code: 401
                );
            }
        });
    })->create();
