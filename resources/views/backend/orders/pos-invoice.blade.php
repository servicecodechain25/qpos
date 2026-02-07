@extends('backend.master')
@section('title', 'Receipt_'.$order->id)

@section('content')

<div class="pos-invoice-outer" id="printable-section">
    <div class="receipt-container">
    
    {{-- Header --}}
    <div class="text-center receipt-header">
        @if(readConfig('is_show_logo_invoice'))
            <img src="{{ assetImage(readConfig('site_logo')) }}" height="40" alt="Logo" class="mb-2">
        @endif
        <h1 class="brand-name">{{ readConfig('site_name') }}</h1>
        <p class="tagline">Fashion Gets Affordable</p>
        <div class="categories">
            Ladies Kurti | Kids Wear | Cord Sets | Bags | Shoes
        </div>
    </div>

    <hr class="dashed-line">

    {{-- Meta Info --}}
    <div class="receipt-meta">
        <div class="row">
            <div class="col-6 text-left">
                Insta: {{ readConfig('instagram_handle') ?? '@cherry_1323' }}
            </div>
            <div class="col-6 text-right">
                Date: {{ date('d/m/Y', strtotime($order->created_at)) }}<br>
                Bill No: {{ $order->id }}<br>
            </div>
            <div class="col-6 text-left">
                @if($order->customer)
                    Name: {{ $order->customer->name }}<br>
                @endif
                </div>
                <div class="col-6 text-right">
                @if($order->guest_phone)
                    Ph: {{ $order->guest_phone }}
                <!-- @elseif($order->customer && $order->customer->phone)
                    Ph: {{ $order->customer->phone }}
                @endif -->
            </div>
        </div>
    </div>

    <hr class="dashed-line">

    {{-- Product Table --}}
    <table class="receipt-table">
        <thead>
            <tr>
                <th class="text-left">Item</th>
                <th class="text-center">Qty*Price</th>
                <th class="text-right">Total</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($order->products as $item)
            <tr>
                <td class="text-left">
                    {{ $item->product->name }}
                    @if($item->color) ({{ $item->color }}) @endif
                </td>
                <td class="text-center">{{ $item->quantity }}*{{ $item->discounted_price}}</td>
                <td class="text-right">{{ number_format($item->total, 2, '.', '') }}</td>
            </tr>
            @endforeach
        </tbody>
    </table>

    {{-- Discount --}}
    @if($order->discount > 0)
    <div class="text-right">
        <small>DISCOUNT: -{{ number_format($order->discount, 2) }}</small>
    </div>
    @endif

    {{-- Totals --}}
    <div class="summary-section">
        <div class="d-flex justify-content-between">
            <span>SUBTOTAL:</span>
            <span>{{ number_format($order->sub_total, 2) }}</span>
        </div>
        <hr class="dashed-line">
        <div class="d-flex justify-content-between grand-total">
            <span>GRAND TOTAL:</span>
            <span>{{ number_format($order->total, 2) }}</span>
        </div>
    </div>

    <hr class="dashed-line">

    {{-- Footer --}}
    <div class="text-center receipt-footer">
        <p>THANK YOU FOR SHOPPING AT {{ strtoupper(readConfig('site_name')) }}!</p>
        <p>Follow us on Instagram for latest arrivals & offers.</p>
        <p class="policy">NO REFUND / NO EXCHANGE</p>
    </div>

    </div>
</div>

@endsection

@push('style')
<style>
/* Remove layout padding and hide page title so only the bill is visible and centered */
section.content:has(#printable-section),
section.content:has(#printable-section) .container-fluid {
    padding-left: 0 !important;
    padding-right: 0 !important;
    max-width: 100% !important;
}
body:has(#printable-section) .content-header {
    display: none !important;
}

/* Outer wrapper: full width, center bill horizontally and vertically on screen */
.pos-invoice-outer {
    width: 100%;
    min-height: 100vh;
    display: flex !important;
    justify-content: center !important;
    align-items: center !important;
    padding: 1rem;
    box-sizing: border-box;
}

/* Receipt: always visible, readable size, centered */
.receipt-container {
    background-color: #fff !important;
    color: #000 !important;
    padding: 10px 12px;
    font-family: 'Courier New', Courier, monospace;
    font-size: 15px;
    line-height: 1.35;
    box-sizing: border-box;
    width: 100%;
    max-width: 340px;
    min-width: 280px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.12);
    border: 1px solid #e0e0e0;
    visibility: visible !important;
    opacity: 1 !important;
}

/* Header */
.receipt-header .brand-name { font-weight: 900; font-size: 22px; margin: 0; text-transform: uppercase; color: #000; }
.receipt-header .tagline { font-style: italic; font-size: 14px; margin-bottom: 4px; color: #000; }
.receipt-header .categories { font-size: 12px; margin-top: 2px; color: #000; }
.dashed-line { border: none; border-top: 1px dashed #000; margin: 8px 0; }

/* Meta (date, bill no, name, phone) */
.receipt-meta { font-size: 14px; color: #000; }

/* Table */
.receipt-table { width: 100%; font-size: 14px; border-collapse: collapse; color: #000; }
.receipt-table th { border-bottom: 1px dashed #000; padding: 4px 0; font-size: 14px; color: #000; }
.receipt-table td { padding: 3px 0; color: #000; }

/* Footer */
.receipt-footer { font-size: 12px; margin-top: 8px; color: #000; }
.receipt-footer p { margin-bottom: 4px; color: #000; }

/* Summary */
.summary-section { font-size: 14px; margin-top: 6px; color: #000; }
.summary-section .grand-total { font-weight: bold; font-size: 16px; color: #000; }
.receipt-container .text-right small { font-size: 13px; color: #000; }

/* PRINT: hide only chrome, keep bill visible and centered */
@media print {
    .no-print,
    .main-sidebar,
    .main-header,
    .main-footer,
    .content-header {
        display: none !important;
        visibility: hidden !important;
    }

    body, .wrapper, .content-wrapper, .content, .container-fluid {
        margin: 0 !important;
        padding: 0 !important;
        background: #fff !important;
        display: block !important;
        visibility: visible !important;
    }

    .pos-invoice-outer {
        position: absolute !important;
        left: 0 !important;
        top: 0 !important;
        width: 100% !important;
        min-height: 100% !important;
        height: auto !important;
        margin: 0 !important;
        padding: 0 !important;
        display: flex !important;
        justify-content: center !important;
        align-items: center !important;
        background: #fff !important;
        visibility: visible !important;
    }

    .receipt-container {
        width: 50.8mm !important;
        max-width: 50.8mm !important;
        min-width: unset !important;
        box-shadow: none !important;
        border: none !important;
        visibility: visible !important;
        opacity: 1 !important;
    }

    @page {
        size: 50.8mm auto;
        margin: 2mm;
    }
}
</style>
@endpush

@push('script')
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Auto-print and close for POS
    window.print();
    setTimeout(() => window.close(), 1000);
});
</script>
@endpush
