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

    $generator = new BarcodeGeneratorPNG();
    $barcodes = [];

    for ($i = 1; $i <= $qty; $i++) {
        $code = $product->sku;

        // SCALE = 3, HEIGHT = 80 → perfect for 203 DPI
        $image = $generator->getBarcode(
            $code,
            $generator::TYPE_CODE_128,
            3,    // scale
            80    // height
        );

        $filename = "barcodes/{$code}-{$i}.png";
        Storage::disk('public')->put($filename, $image);

        $barcodes[] = [
            'value' => $code,
            'price' => $product->price,
            'purchase_price' => $product->purchase_price,
            'img' => asset("storage/{$filename}"),
        ];
    }

    return response()->json($barcodes);
}

}
