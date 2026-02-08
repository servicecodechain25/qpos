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
        $code = $request->query('code', '000000');
        $mrp = $request->query('mrp', '0.00');
        $price = $request->query('price', '0.00');
        
        $generator = new BarcodeGeneratorPNG();
        
        // 1. Generate core barcode image (SCALE 4, HEIGHT 100 for higher resolution)
        $barcodeData = $generator->getBarcode($code, $generator::TYPE_CODE_128, 4, 80);
        $barcodeImg = imagecreatefromstring($barcodeData);
        
        $bw = imagesx($barcodeImg);
        $bh = imagesy($barcodeImg);
        
        // 2. Create Canvas (Fixed width/height for label size at higher resolution)
        $canvasW = 350; 
        $canvasH = 250;
        $canvas = imagecreatetruecolor($canvasW, $canvasH);
        
        // Colors
        $white = imagecolorallocate($canvas, 255, 255, 255);
        $black = imagecolorallocate($canvas, 0, 0, 0);
        
        imagefill($canvas, 0, 0, $white);
        
        // 3. Center and Draw Barcode (Higher on the canvas)
        $bx = ($canvasW - $bw) / 2;
        $by = 20;
        imagecopy($canvas, $barcodeImg, $bx, $by, 0, 0, $bw, $bh);
        imagedestroy($barcodeImg);
        
        // 4. SKU Text (Centered below barcode)
        $fontPath = base_path('vendor/dompdf/dompdf/lib/fonts/DejaVuSans-Bold.ttf');
        $skuFontSize = 24; // PT size
        
        $skuText = $code;
        $skuBox = imagettfbbox($skuFontSize, 0, $fontPath, $skuText);
        $skuWidth = abs($skuBox[4] - $skuBox[0]);
        
        $tx = ($canvasW - $skuWidth) / 2;
        $ty = $by + $bh + 45; 
        imagettftext($canvas, $skuFontSize, 0, $tx, $ty, $black, $fontPath, $skuText);
        
        // 5. Drawing Line (Thickened)
        $lx1 = 20;
        $lx2 = $canvasW - 20;
        $ly = $ty + 20;
        imageline($canvas, $lx1, $ly, $lx2, $ly, $black);
        imageline($canvas, $lx1, $ly + 1, $lx2, $ly + 1, $black);
        imageline($canvas, $lx1, $ly + 2, $lx2, $ly + 2, $black);
        
        // 6. Prices (Column layout: labels on top, prices below)
        $labelFontSize = 16;
        $priceFontSize = 24;
        
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
        
        $labelY = $ly + 30;
        $priceY = $labelY + 35;
        
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
        $code = $request->query('code', '000000');
        $mrp = $request->query('mrp', '0.00');
        $price = $request->query('price', '0.00');
        
        // Create Canvas for 0.75" x 2" label (narrower than barcode labels)
        // 2:1 aspect ratio, so 400x150 maintains proper proportions
        $canvasW = 400; 
        $canvasH = 150;
        $canvas = imagecreatetruecolor($canvasW, $canvasH);
        
        // Colors
        $white = imagecolorallocate($canvas, 255, 255, 255);
        $black = imagecolorallocate($canvas, 0, 0, 0);
        
        imagefill($canvas, 0, 0, $white);
        
        // Font setup
        $fontPath = base_path('vendor/dompdf/dompdf/lib/fonts/DejaVuSans-Bold.ttf');
        
        // 1. SKU at the top (Large font)
        $skuFontSize = 24;
        $skuText = $code;
        $skuBox = imagettfbbox($skuFontSize, 0, $fontPath, $skuText);
        $skuWidth = abs($skuBox[4] - $skuBox[0]);
        $skuHeight = abs($skuBox[5] - $skuBox[1]);
        
        $skuX = ($canvasW - $skuWidth) / 2;
        $skuY = 35;
        imagettftext($canvas, $skuFontSize, 0, $skuX, $skuY, $black, $fontPath, $skuText);
        
        
        // 2. Prices in column layout (same as barcode mode)
        $labelFontSize = 14;
        $priceFontSize = 20;
        
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
        
        $labelY = $skuY + 45;
        $priceY = $labelY + 30;
        
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
        
        // Output PNG
        ob_start();
        imagepng($canvas);
        $finalImage = ob_get_clean();
        imagedestroy($canvas);
        
        return response($finalImage)->header('Content-Type', 'image/png');
    }
}
