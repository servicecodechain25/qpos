<?php

// namespace App\Http\Controllers;
namespace App\Http\Controllers\Backend\Product;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Product;
use Picqer\Barcode\BarcodeGeneratorPNG;

class BarcodeController extends Controller
{
    public function bulkGenerate(Request $request)
    {
        $request->validate([
            'product_id' => 'required|integer',
            'quantity' => 'required|integer|min:1',
        ]);

        $product = Product::findOrFail($request->product_id);
        $qty = $request->quantity;

        $generator = new BarcodeGeneratorPNG();
        $barcodes = [];

        for ($i = 1; $i <= $qty; $i++) {
            // $code = $product->sku . '-' . str_pad($i, 4, '0', STR_PAD_LEFT); // e.g., 1-0001
            $code = $product->sku;
            $image = $generator->getBarcode($code, $generator::TYPE_CODE_128);

            $barcodes[] = [
                'value' => $code,
                'img' => 'data:image/png;base64,' . base64_encode($image),
            ];
        }


        return response()->json($barcodes);
    }
}
