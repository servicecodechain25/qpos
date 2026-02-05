<?php

namespace App\Http\Controllers\Backend\Product;

use App\Http\Controllers\Controller;
use App\Models\Size;
use Illuminate\Http\Request;

class SizeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $sizes = Size::latest()->get();
        return view('backend.sizes.index', compact('sizes'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('backend.sizes.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255|unique:sizes,name',
            'status' => 'nullable|boolean',
        ]);

        Size::create([
            'name' => $request->name,
            'status' => $request->status ? 1 : 0,
        ]);

        return redirect()->route('backend.admin.sizes.index')->with('success', 'Size Created Successfully');
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Size $size)
    {
        return view('backend.sizes.edit', compact('size'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Size $size)
    {
        $request->validate([
            'name' => 'required|string|max:255|unique:sizes,name,' . $size->id,
            'status' => 'nullable|boolean',
        ]);

        $size->update([
            'name' => $request->name,
            'status' => $request->status ? 1 : 0,
        ]);

        return redirect()->route('backend.admin.sizes.index')->with('success', 'Size Updated Successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Size $size)
    {
        $size->delete();
        return redirect()->back()->with('success', 'Size Deleted Successfully');
    }
}
