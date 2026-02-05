<?php

namespace App\Http\Controllers\Backend\Product;

use App\Http\Controllers\Controller;
use App\Models\Color;
use Illuminate\Http\Request;

class ColorController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $colors = Color::latest()->get();
        return view('backend.colors.index', compact('colors'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('backend.colors.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255|unique:colors,name',
            'status' => 'nullable|boolean',
        ]);

        Color::create([
            'name' => $request->name,
            'status' => $request->status ? 1 : 0,
        ]);

        return redirect()->route('backend.admin.colors.index')->with('success', 'Color Created Successfully');
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Color $color)
    {
        return view('backend.colors.edit', compact('color'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Color $color)
    {
        $request->validate([
            'name' => 'required|string|max:255|unique:colors,name,' . $color->id,
            'status' => 'nullable|boolean',
        ]);

        $color->update([
            'name' => $request->name,
            'status' => $request->status ? 1 : 0,
        ]);

        return redirect()->route('backend.admin.colors.index')->with('success', 'Color Updated Successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Color $color)
    {
        $color->delete();
        return redirect()->back()->with('success', 'Color Deleted Successfully');
    }
}
