<?php

namespace App\Helpers;

class ResponseFormatter
{
    protected static $response = [
        'message' => null,
        'data' => null,
        'error' => null
    ];

    public static function success($code = 200, $message = null, $data = null)
    {
        self::$response['data'] = $data;
        self::$response['message'] = $message ?? 'Success';
        return response()->json(self::$response)->setStatusCode($code);
    }

    public static function paginate($meta, $code = 200, $message = null, $data = null)
    {
        self::$response['data'] = $data;
        self::$response['meta'] = formatMetaPagination($meta);
        self::$response['message'] = $message ?? 'success';
        return response()->json(self::$response)->setStatusCode($code);
    }

    public static function error($code = 400, $message = null, $error = null)
    {
        self::$response['error'] = $error;
        self::$response['message'] = $message ?? 'Error';
        return response()->json(self::$response)->setStatusCode($code);
    }
}

function formatMetaPagination($paginator)
{
    return [
        'current_page'    => $paginator->currentPage(),
        'per_page'        => $paginator->perPage(),
        'from'            => $paginator->firstItem(),
        'to'              => $paginator->lastItem(),
        'next_page_url'   => $paginator->nextPageUrl(),
        'prev_page_url'   => $paginator->previousPageUrl(),
        'path'            => $paginator->path(),
    ];
}