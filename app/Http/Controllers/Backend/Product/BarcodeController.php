<?php

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
        $mode = $request->input('mode', 'barcode'); // Default to barcode mode

        $barcodes = [];

        for ($i = 1; $i <= $qty; $i++) {
            $code = $product->sku;
            
            // Determine which route to use based on mode
            $routeName = $mode === 'text-only' 
                ? 'backend.admin.barcode.generate-text-only' 
                : 'backend.admin.barcode.generate';

            $barcodes[] = [
                'value' => $code,
                'name' => $product->name,
                'price' => $product->price,
                'purchase_price' => $product->purchase_price,
                'img' => route($routeName, [
                    'code' => $code,
                    'mrp' => $product->purchase_price,
                    'price' => $product->price
                ]),
            ];
        }

        return response()->json($barcodes);
    }


public function generate(Request $request)
{
    // 1. Inputs
    $code  = strtoupper($request->query('code', 'H-4-ANTIQUE-6'));
    $mrp   = $request->query('mrp', '1099');
    $price = $request->query('price', '749');

    // 2. Barcode generator
    $generator = new BarcodeGeneratorPNG();

    // --- BARCODE SETTINGS (SCANNER SAFE) ---
    $scale  = 3;     // bar width
    $height = 100;   // bar height (px)
    $quiet  = 30;    // quiet zone (px)

    // 3. Generate Code 39 barcode
    $barcodeData = $generator->getBarcode(
        $code,
        $generator::TYPE_CODE_39,
        $scale,
        $height
    );

    $barcodeImg = imagecreatefromstring($barcodeData);
    $bw = imagesx($barcodeImg);
    $bh = imagesy($barcodeImg);

    // 4. Canvas (label size)
    $canvasW = $bw + ($quiet * 2);
    $canvasH = 300; // Increased to accommodate larger fonts

    $canvas = imagecreatetruecolor($canvasW, $canvasH);
    $white  = imagecolorallocate($canvas, 255, 255, 255);
    $black  = imagecolorallocate($canvas, 0, 0, 0);

    imagefill($canvas, 0, 0, $white);

    // 5. Draw barcode WITH quiet zones
    imagecopy($canvas, $barcodeImg, $quiet, 20, 0, 0, $bw, $bh);
    imagedestroy($barcodeImg);

    // 6. Fonts
    $fontPath = base_path('vendor/dompdf/dompdf/lib/fonts/DejaVuSans-Bold.ttf');

    // SKU text
    $skuFontSize = 26; // Increased from 22
    $skuBox = imagettfbbox($skuFontSize, 0, $fontPath, $code);
    $skuW = abs($skuBox[4] - $skuBox[0]);

    $skuX = ($canvasW - $skuW) / 2;
    $skuY = 20 + $bh + 50; // Adjusted spacing

    imagettftext($canvas, $skuFontSize, 0, $skuX, $skuY, $black, $fontPath, $code);

    // Divider line
    $lineY = $skuY + 20; // Adjusted spacing
    for ($i = 0; $i < 3; $i++) {
        imageline($canvas, 20, $lineY + $i, $canvasW - 20, $lineY + $i, $black);
    }

    // 7. Prices
    $labelFont = 18; // Increased from 14
    $priceFont = 26; // Increased from 22

    $labelY = $lineY + 40; // Adjusted spacing
    $priceY = $labelY + 40; // Adjusted spacing

    // Left column (MRP)
    $leftCenter = $canvasW / 4;
    imagettftext(
        $canvas,
        $labelFont,
        0,
        $leftCenter - 25, // Adjusted for larger text
        $labelY,
        $black,
        $fontPath,
        'MRP'
    );

    $mrpBox = imagettfbbox($priceFont, 0, $fontPath, $mrp);
    $mrpW = abs($mrpBox[4] - $mrpBox[0]);
    imagettftext(
        $canvas,
        $priceFont,
        0,
        $leftCenter - ($mrpW / 2),
        $priceY,
        $black,
        $fontPath,
        $mrp
    );

    // Right column (Cherry P)
    $rightCenter = ($canvasW * 3) / 4;
    $cherryLabelText = 'Cherry P';
    $cherryLabelBox = imagettfbbox($labelFont, 0, $fontPath, $cherryLabelText);
    $cherryLabelW = abs($cherryLabelBox[4] - $cherryLabelBox[0]);
    
    imagettftext(
        $canvas,
        $labelFont,
        0,
        $rightCenter - ($cherryLabelW / 2),
        $labelY,
        $black,
        $fontPath,
        $cherryLabelText
    );

    $priceBox = imagettfbbox($priceFont, 0, $fontPath, $price);
    $priceW = abs($priceBox[4] - $priceBox[0]);
    imagettftext(
        $canvas,
        $priceFont,
        0,
        $rightCenter - ($priceW / 2),
        $priceY,
        $black,
        $fontPath,
        $price
    );

    // 8. Output PNG
    ob_start();
    imagepng($canvas);
    $output = ob_get_clean();
    imagedestroy($canvas);

    return response($output)->header('Content-Type', 'image/png');
}


    public function generateTextOnly(Request $request)
    {
        $code = $request->query('code', '000000');
        $mrp = $request->query('mrp', '0.00');
        $price = $request->query('price', '0.00');
        
        // Create Canvas for 0.75" x 2" label
        $canvasW = 400; 
        $canvasH = 200; // Increased from 150
        $canvas = imagecreatetruecolor($canvasW, $canvasH);
        
        // Colors
        $white = imagecolorallocate($canvas, 255, 255, 255);
        $black = imagecolorallocate($canvas, 0, 0, 0);
        
        imagefill($canvas, 0, 0, $white);
        
        // Font setup
        $fontPath = base_path('vendor/dompdf/dompdf/lib/fonts/DejaVuSans-Bold.ttf');
        
        // 1. SKU at the top (Large font)
        $skuFontSize = 30; // Increased from 24
        $skuText = $code;
        $skuBox = imagettfbbox($skuFontSize, 0, $fontPath, $skuText);
        $skuWidth = abs($skuBox[4] - $skuBox[0]);
        
        $skuX = ($canvasW - $skuWidth) / 2;
        $skuY = 55; // Adjusted
        imagettftext($canvas, $skuFontSize, 0, $skuX, $skuY, $black, $fontPath, $skuText);
        
        // 2. Prices in column layout
        $labelFontSize = 20; // Increased from 14
        $priceFontSize = 30; // Increased from 20
        
        // Left column: MRP
        $mrpLabelText = "MRP";
        $mrpLabelBox = imagettfbbox($labelFontSize, 0, $fontPath, $mrpLabelText);
        $mrpLabelWidth = abs($mrpLabelBox[4] - $mrpLabelBox[0]);
        
        $mrpPriceText = $mrp;
        $mrpPriceBox = imagettfbbox($priceFontSize, 0, $fontPath, $mrpPriceText);
        $mrpPriceWidth = abs($mrpPriceBox[4] - $mrpPriceBox[0]);
        
        // Position MRP column on left
        $leftColumnCenter = $canvasW / 4;
        $mrpLabelX = $leftColumnCenter - ($mrpLabelWidth / 2);
        $mrpPriceX = $leftColumnCenter - ($mrpPriceWidth / 2);
        
        $labelY = $skuY + 60; // Adjusted
        $priceY = $labelY + 50; // Adjusted
        
        imagettftext($canvas, $labelFontSize, 0, $mrpLabelX, $labelY, $black, $fontPath, $mrpLabelText);
        imagettftext($canvas, $priceFontSize, 0, $mrpPriceX, $priceY, $black, $fontPath, $mrpPriceText);
        
        // Right column: Cherry P
        $cherryLabelText = "Cherry P";
        $cherryLabelBox = imagettfbbox($labelFontSize, 0, $fontPath, $cherryLabelText);
        $cherryLabelWidth = abs($cherryLabelBox[4] - $cherryLabelBox[0]);
        
        $cherryPriceText = $price;
        $cherryPriceBox = imagettfbbox($priceFontSize, 0, $fontPath, $cherryPriceText);
        $cherryPriceWidth = abs($cherryPriceBox[4] - $cherryPriceBox[0]);
        
        // Position Cherry P column on right
        $rightColumnCenter = ($canvasW * 3) / 4;
        $cherryLabelX = $rightColumnCenter - ($cherryLabelWidth / 2);
        $cherryPriceX = $rightColumnCenter - ($cherryPriceWidth / 2);
        
        imagettftext($canvas, $labelFontSize, 0, $cherryLabelX, $labelY, $black, $fontPath, $cherryLabelText);
        imagettftext($canvas, $priceFontSize, 0, $cherryPriceX, $priceY, $black, $fontPath, $cherryPriceText);
        
        // Output PNG
        ob_start();
        imagepng($canvas);
        $finalImage = ob_get_clean();
        imagedestroy($canvas);
        
        return response($finalImage)->header('Content-Type', 'image/png');
    }
}
