<?php

// namespace App\Http\Controllers;
namespace App\Http\Controllers\Backend\Product;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Product;
use Picqer\Barcode\BarcodeGeneratorPNG;
use Picqer\Barcode\BarcodeGeneratorSVG;
use Illuminate\Support\Facades\Storage;
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

        $barcodes = [];

        for ($i = 1; $i <= $qty; $i++) {
            $code = $product->sku;

            $barcodes[] = [
                'value' => $code,
                'name' => $product->name,
                'price' => $product->price,
                'purchase_price' => $product->purchase_price,
                'img' => route('backend.admin.barcode.generate', ['code' => $code]),
            ];
        }

        return response()->json($barcodes);
    }

    public function generate(Request $request)
    {
        $code = $request->query('code', '000000');
        $generator = new BarcodeGeneratorPNG();
        
        // SCALE = 3, HEIGHT = 80 → perfect for 203 DPI
        $image = $generator->getBarcode(
            $code,
            $generator::TYPE_CODE_128,
            3,    // scale
            80    // height
        );

        return response($image)->header('Content-Type', 'image/png');
    }
}
