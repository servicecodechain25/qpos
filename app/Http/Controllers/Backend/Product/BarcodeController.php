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
            'product_ids' => 'required|array',
            'product_ids.*' => 'integer|exists:products,id',
            'quantity' => 'required|integer|min:1',
        ]);

        $productIds = $request->product_ids;
        $qty = $request->quantity;
        $mode = $request->input('mode', 'barcode'); // Default to barcode mode

        $barcodes = [];

        foreach ($productIds as $id) {
            $product = Product::find($id);
            if (!$product) continue;

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
        }

        return response()->json($barcodes);
    }


public function generate(Request $request)
    {
        $code = $request->query('code', '000000');
        $mrp = $request->query('mrp', '0.00');
        $price = $request->query('price', '0.00');
        
        $generator = new BarcodeGeneratorPNG();
        
        // 1. Generate core barcode image (SCALE 2, HEIGHT 80)
        // Scale 2 is much safer for 200 DPI thermal printers and ensures the barcode fits on the label.
        $barcodeData = $generator->getBarcode($code, $generator::TYPE_CODE_128, 2, 80);
        $barcodeImg = imagecreatefromstring($barcodeData);
        
        $bw = imagesx($barcodeImg);
        $bh = imagesy($barcodeImg);
        
        // 2. Create Canvas (400px fits perfectly on 2" labels and prevents cropping)
        $canvasW = 400; 
        $canvasH = 320; // Increased from 280
        $canvas = imagecreatetruecolor($canvasW, $canvasH);
        
        // Colors
        $white = imagecolorallocate($canvas, 255, 255, 255);
        $black = imagecolorallocate($canvas, 0, 0, 0);
        
        imagefill($canvas, 0, 0, $white);
        
        // 3. Center and Draw Barcode (Quiet zone is essential for scanning)
        $bx = ($canvasW - $bw) / 2;
        $by = 25;
        imagecopy($canvas, $barcodeImg, $bx, $by, 0, 0, $bw, $bh);
        imagedestroy($barcodeImg);
        
        // 4. SKU Text (Centered below barcode)
        $fontPath = base_path('vendor/dompdf/dompdf/lib/fonts/DejaVuSans-Bold.ttf');
        $skuFontSize = 30; // Increased from 24
        
        $skuText = $code;
        $skuBox = imagettfbbox($skuFontSize, 0, $fontPath, $skuText);
        $skuWidth = abs($skuBox[4] - $skuBox[0]);
        
        $tx = ($canvasW - $skuWidth) / 2;
        $ty = $by + $bh + 55; // Increased spacing
        imagettftext($canvas, $skuFontSize, 0, $tx, $ty, $black, $fontPath, $skuText);
        
        // 5. Drawing Line (Thickened)
        $lx1 = 20;
        $lx2 = $canvasW - 20;
        $ly = $ty + 20;
        imageline($canvas, $lx1, $ly, $lx2, $ly, $black);
        imageline($canvas, $lx1, $ly + 1, $lx2, $ly + 1, $black);
        imageline($canvas, $lx1, $ly + 2, $lx2, $ly + 2, $black);
        
        // 6. Prices (Column layout: labels on top, prices below)
        $labelFontSize = 20; // Increased from 16
        $priceFontSize = 30; // Increased from 24
        
        // Left column: MRP
        $mrpLabelText = "MRP";
        $mrpLabelBox = imagettfbbox($labelFontSize, 0, $fontPath, $mrpLabelText);
        $mrpLabelWidth = abs($mrpLabelBox[4] - $mrpLabelBox[0]);
        
        $mrpPriceText = $mrp;
        $mrpPriceBox = imagettfbbox($priceFontSize, 0, $fontPath, $mrpPriceText);
        $mrpPriceWidth = abs($mrpPriceBox[4] - $mrpPriceBox[0]);
        
        // Position MRP column on left (centered in left half)
        $leftColumnCenter = $canvasW / 4;
        $mrpLabelX = $leftColumnCenter - ($mrpLabelWidth / 2);
        $mrpPriceX = $leftColumnCenter - ($mrpPriceWidth / 2);
        
        $labelY = $ly + 40; // Increased spacing
        $priceY = $labelY + 45; // Increased spacing
        
        imagettftext($canvas, $labelFontSize, 0, $mrpLabelX, $labelY, $black, $fontPath, $mrpLabelText);
        imagettftext($canvas, $priceFontSize, 0, $mrpPriceX, $priceY, $black, $fontPath, $mrpPriceText);
        
        // Right column: Cherry P
        $cherryLabelText = "Cherry P";
        $cherryLabelBox = imagettfbbox($labelFontSize, 0, $fontPath, $cherryLabelText);
        $cherryLabelWidth = abs($cherryLabelBox[4] - $cherryLabelBox[0]);
        
        $cherryPriceText = $price;
        $cherryPriceBox = imagettfbbox($priceFontSize, 0, $fontPath, $cherryPriceText);
        $cherryPriceWidth = abs($cherryPriceBox[4] - $cherryPriceBox[0]);
        
        // Position Cherry P column on right (centered in right half)
        $rightColumnCenter = ($canvasW * 3) / 4;
        $cherryLabelX = $rightColumnCenter - ($cherryLabelWidth / 2);
        $cherryPriceX = $rightColumnCenter - ($cherryPriceWidth / 2);
        
        imagettftext($canvas, $labelFontSize, 0, $cherryLabelX, $labelY, $black, $fontPath, $cherryLabelText);
        imagettftext($canvas, $priceFontSize, 0, $cherryPriceX, $priceY, $black, $fontPath, $cherryPriceText);
        
        // 7. Output PNG
        ob_start();
        imagepng($canvas);
        $finalImage = ob_get_clean();
        imagedestroy($canvas);
        
        return response($finalImage)->header('Content-Type', 'image/png');
    }


   public function generateTextOnly(Request $request)
    {
        $code  = $request->query('code', '000000');
        $mrp   = $request->query('mrp', '0.00');
        $price = $request->query('price', '0.00');

        // Canvas: 0.5" x 2" (4:1 aspect ratio)
        $canvasW = 800;
        $canvasH = 240;
        $canvas = imagecreatetruecolor($canvasW, $canvasH);

        // Colors
        $white = imagecolorallocate($canvas, 255, 255, 255);
        $black = imagecolorallocate($canvas, 0, 0, 0);
        imagefill($canvas, 0, 0, $white);

        // Font
        $fontPath = base_path('vendor/dompdf/dompdf/lib/fonts/DejaVuSans-Bold.ttf');

        /*
        |--------------------------------------------------------------------------
        | 1. SKU (Top Center)
        |--------------------------------------------------------------------------
        */
        $skuFontSize = 45;
        $skuText = $code;

        $skuBox = imagettfbbox($skuFontSize, 0, $fontPath, $skuText);
        $skuWidth  = abs($skuBox[4] - $skuBox[0]);
        $skuHeight = abs($skuBox[5] - $skuBox[1]);

        $skuX = ($canvasW - $skuWidth) / 2;
        $skuY = 65;

        imagettftext($canvas, $skuFontSize, 0, $skuX, $skuY, $black, $fontPath, $skuText);

        // SKU bottom margin
        $skuMarginBottom = 25;

        // Start Y for prices section
        $contentStartY = $skuY + $skuHeight + $skuMarginBottom;

        /*
        |--------------------------------------------------------------------------
        | 2. Prices Section
        |--------------------------------------------------------------------------
        */
        $labelFontSize = 32;
        $priceFontSize = 45;

        // Bottom margin for price text
        $priceBottomMargin = 35;

        // Label Y
        $labelY = $contentStartY;

        // Measure price height (for descenders like 9, 4)
        $priceBoxSample = imagettfbbox($priceFontSize, 0, $fontPath, '9999');
        $priceHeight = abs($priceBoxSample[5] - $priceBoxSample[1]);

        // Desired spacing under label
        $desiredPriceY = $labelY + 60;

        // Clamp price baseline so text + margin stay inside canvas
        $priceY = min(
            $desiredPriceY,
            $canvasH - $priceBottomMargin
        );

        /*
        |--------------------------------------------------------------------------
        | Left Column — MRP
        |--------------------------------------------------------------------------
        */
        $mrpLabelText = 'MRP';
        $mrpPriceText = $mrp;

        $mrpLabelBox = imagettfbbox($labelFontSize, 0, $fontPath, $mrpLabelText);
        $mrpPriceBox = imagettfbbox($priceFontSize, 0, $fontPath, $mrpPriceText);

        $mrpLabelWidth = abs($mrpLabelBox[4] - $mrpLabelBox[0]);
        $mrpPriceWidth = abs($mrpPriceBox[4] - $mrpPriceBox[0]);

        $leftColumnCenter = $canvasW / 4;

        $mrpLabelX = $leftColumnCenter - ($mrpLabelWidth / 2);
        $mrpPriceX = $leftColumnCenter - ($mrpPriceWidth / 2);

        imagettftext($canvas, $labelFontSize, 0, $mrpLabelX, $labelY, $black, $fontPath, $mrpLabelText);
        imagettftext($canvas, $priceFontSize, 0, $mrpPriceX, $priceY, $black, $fontPath, $mrpPriceText);

        /*
        |--------------------------------------------------------------------------
        | Right Column — Cherry P
        |--------------------------------------------------------------------------
        */
        $cherryLabelText = 'Cherry P';
        $cherryPriceText = $price;

        $cherryLabelBox = imagettfbbox($labelFontSize, 0, $fontPath, $cherryLabelText);
        $cherryPriceBox = imagettfbbox($priceFontSize, 0, $fontPath, $cherryPriceText);

        $cherryLabelWidth = abs($cherryLabelBox[4] - $cherryLabelBox[0]);
        $cherryPriceWidth = abs($cherryPriceBox[4] - $cherryPriceBox[0]);

        $rightColumnCenter = ($canvasW * 3) / 4;

        $cherryLabelX = $rightColumnCenter - ($cherryLabelWidth / 2);
        $cherryPriceX = $rightColumnCenter - ($cherryPriceWidth / 2);

        imagettftext($canvas, $labelFontSize, 0, $cherryLabelX, $labelY, $black, $fontPath, $cherryLabelText);
        imagettftext($canvas, $priceFontSize, 0, $cherryPriceX, $priceY, $black, $fontPath, $cherryPriceText);

        /*
        |--------------------------------------------------------------------------
        | Output
        |--------------------------------------------------------------------------
        */
        ob_start();
        imagepng($canvas);
        $finalImage = ob_get_clean();
        imagedestroy($canvas);

        return response($finalImage)->header('Content-Type', 'image/png');
    }


}
