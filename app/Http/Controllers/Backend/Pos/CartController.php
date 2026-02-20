<?php

namespace App\Http\Controllers\Backend\Pos;

use App\Http\Controllers\Controller;
use App\Http\Resources\ProductResource;
use App\Models\PosCart;
use App\Models\Product;
use Illuminate\Http\Request;

class CartController extends Controller
{
    public function index(Request $request)
    {
        if ($request->wantsJson()) {
            $cartItems = PosCart::where('user_id', auth()->id())
                ->with(['product.unit', 'product.color', 'product.size'])
                ->latest('created_at')
                ->get()
                ->map(function ($item) {
                    // Calculate row total for each item
                    $item->row_total = round(($item->quantity * $item->product->discounted_price),2);
                    return $item;
                });
            $total = $cartItems->sum('row_total');
            return response()->json([
                'carts' => $cartItems,
                'total' => round($total, 2)
            ]);
        }
        // clear cart
        PosCart::where('user_id', auth()->id())->delete();
        return view('backend.cart.index');
    }
    public function getProducts(Request $request)
    {
        $products = Product::query()
            ->active()
            ->stocked()

            // Search by name
            ->when($request->filled('search'), function ($query) use ($request) {
                $query->where('name', 'LIKE', '%' . $request->search . '%');
            })

            // Search by barcode (sku)
            ->when($request->filled('barcode'), function ($query) use ($request) {
                $query->where('sku', 'LIKE', '%' . $request->barcode . '%');
            })

            ->with(['unit', 'color', 'size'])
            ->latest()
            ->paginate(200);

        return response()->json($products);
    }


    public function store(Request $request)
    {
        // Validate request input
        $request->validate([
            'id' => 'required|exists:products,id',
        ]);

        $product_id = $request->id;

        // Fetch the product
        $product = Product::findOrFail($product_id);

        // Check if the product is active and has sufficient stock
        if (!$product->status) {
            return response()->json(['message' => 'Product is not available'], 400);
        }

        if ($product->quantity <= 0) {
            return response()->json(['message' => 'Insufficient stock available'], 400);
        }

        // Use updateOrCreate to handle both create and update logic
        $cartItem = PosCart::where('user_id', auth()->id())
            ->where('product_id', $product_id)
            ->first();

        if ($cartItem) {
            if ($cartItem->quantity < $product->quantity) {
                 $cartItem->increment('quantity');
                 return response()->json(['message' => 'Quantity updated', 'quantity' => $cartItem->quantity], 200);
            }
             return response()->json(['message' => 'Cannot add more, stock limit reached'], 400);
        }

        PosCart::create([
            'user_id' => auth()->id(),
            'product_id' => $product_id,
            'quantity' => 1
        ]);
        return response()->json(['message' => 'Product added to cart', 'quantity' => 1], 201);
    }

    public function increment(Request $request)
    {
        $request->validate([
            'id' => 'required|integer|exists:pos_carts,id'
        ]);

        $cart = PosCart::with('product')->findOrFail($request->id);
        if ($cart->product->quantity <= 0) {
            return response()->json(['message' => 'Insufficient stock available'], 400);
        }
        if ($cart->quantity == $cart->product->quantity) {
            return response()->json(['message' => 'Cannot add more, stock limit reached'], 400);
        }
        $cart->quantity = $cart->quantity + 1;
        $cart->save();
        return response()->json(['message' => 'Cart Updated successfully'], 200);
    }
    public function decrement(Request $request)
    {
        $request->validate([
            'id' => 'required|integer|exists:pos_carts,id'
        ]);
        $cart = PosCart::findOrFail($request->id);
        if ($cart->quantity <= 1) {
            return response()->json(['message' => 'Quantity cannot be less than 1.'], 400);
        }
        $cart->quantity = $cart->quantity - 1;
        $cart->save();
        return response()->json(['message' => 'Cart Updated successfully'], 200);
    }
    public function delete(Request $request)
    {
        $request->validate([
            'id' => 'required|integer|exists:pos_carts,id'
        ]);

        $cart = PosCart::findOrFail($request->id);
        $cart->delete();

        return response()->json(['message' => 'Item successfully deleted'], 200);
    }
    public function empty()
    {
        $deletedCount = PosCart::where('user_id', auth()->id())->delete();

        if ($deletedCount > 0) {
            return response()->json(['message' => 'Cart successfully cleared'], 200);
        }

        return response()->json(['message' => 'Cart is already empty'], 204);
    }
}
