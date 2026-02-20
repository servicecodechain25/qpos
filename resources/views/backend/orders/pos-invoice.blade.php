@extends('backend.master')
@section('title', 'Receipt_'.$order->id)

@section('content')

<div class="pos-invoice-outer" id="printable-section">
    <div class="receipt-container">
    
    {{-- Header --}}
    <div class="text-center receipt-header">
        @if(readConfig('is_show_logo_invoice'))
            <img src="{{ asset('/assets/images/logo/logo.jpeg') }}" height="35" alt="Logo" class="mb-1">
        @endif
        <h1 class="brand-name">{{ readConfig('site_name') }}</h1>
        <p class="tagline">Fashion Gets Affordable</p>
        <div class="categories">
            Ladies Kurti | Kids Wear | Cord Sets | Bags | Shoes
        </div>
        <p class="phone">+91 7972880129</p>
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
                Bill No: {{ $order->id }}
            </div>
            @if($order->customer || $order->guest_phone)
            <div class="col-6 text-left">
                @if($order->customer)
                    Name: {{ $order->customer->name }}
                @endif
            </div>
            <div class="col-6 text-right">
                @if($order->guest_phone)
                    Ph: {{ $order->guest_phone }}
                @endif
            </div>
            @endif
        </div>
    </div>

    <hr class="dashed-line">

    {{-- Product Table --}}
    <table class="receipt-table">
        <thead>
            <tr>
                <th class="text-left">Item</th>
                <th class="text-center">Qty x Price</th>
                <th class="text-right">Total</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($order->products as $item)
            <tr>
                <td class="text-left">
                    {{ $item->product->name }}
                    @if($item->color)({{ $item->color }})@endif
                </td>
                <td class="text-center">{{ $item->quantity }} x {{ $item->discounted_price }}</td>
                <td class="text-right">{{ number_format($item->total, 2, '.', '') }}</td>
            </tr>
            @endforeach
        </tbody>
    </table>

    {{-- Discount --}}
    @if($order->discount > 0)
    <div class="text-right discount-line">
        DISCOUNT: -{{ number_format($order->discount, 2) }}
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
        <p>THANK YOU FOR SHOPPING AT<br>{{ strtoupper(readConfig('site_name')) }}!</p>
        <p>Follow us on Instagram for latest arrivals & offers.</p>
        <p class="policy">NO REFUND / NO EXCHANGE</p>
    </div>

    </div>
</div>

@endsection

@push('style')
<style>
/* Hide page chrome */
section.content:has(#printable-section),
section.content:has(#printable-section) .container-fluid {
    padding-left: 0 !important;
    padding-right: 0 !important;
    max-width: 100% !important;
}
body:has(#printable-section) .content-header {
    display: none !important;
}

/* Screen: center the bill */
.pos-invoice-outer {
    width: 100%;
    min-height: 100vh;
    display: flex !important;
    justify-content: center !important;
    align-items: center !important;
    padding: 1rem;
    box-sizing: border-box;
}

.receipt-container {
    background-color: #fff !important;
    color: #000 !important;
    padding: 10px 12px;
    font-family: 'Courier New', Courier, monospace;
    font-size: 13px;
    line-height: 1.3;
    box-sizing: border-box;
    width: 100%;
    max-width: 320px;
    min-width: 260px;
    /* box-shadow: 0 4px 20px rgba(0,0,0,0.12); */
    font-weight: 600;
    border: 1px solid #e0e0e0;
}

/* Header */
.receipt-header .brand-name {
    font-weight: 900;
    font-size: 20px;
    margin: 0;
    text-transform: uppercase;
    color: #000;
    letter-spacing: 1px;
}
.receipt-header .tagline {
    font-style: italic;
    font-size: 12px;
    margin: 2px 0;
    color: #000;
}
.receipt-header .categories {
    font-size: 10px;
    margin-top: 2px;
    color: #000;
    word-break: break-word;
}
.phone {
    font-size: 10px;
    margin-bottom: 2px;
    color: #000;
}
.dashed-line {
    border: none;
    border-top: 1px dashed #000;
    margin: 6px 0;
}

/* Meta */
.receipt-meta {
    font-size: 12px;
    color: #000;
}

/* Table */
.receipt-table {
    width: 100%;
    font-size: 12px;
    border-collapse: collapse;
    color: #000;
    table-layout: fixed;
}
.receipt-table th {
    border-bottom: 1px dashed #000;
    padding: 3px 0;
    font-size: 12px;
    color: #000;
}
.receipt-table td {
    padding: 2px 0;
    color: #000;
    word-break: break-word;
}
/* Column widths: item gets most space */
.receipt-table th:nth-child(1),
.receipt-table td:nth-child(1) { width: 42%; }
.receipt-table th:nth-child(2),
.receipt-table td:nth-child(2) { width: 34%; }
.receipt-table th:nth-child(3),
.receipt-table td:nth-child(3) { width: 24%; }

/* Discount */
.discount-line {
    font-size: 12px;
    color: #000;
    text-align: right;
    margin-top: 2px;
}

/* Summary */
.summary-section {
    font-size: 13px;
    margin-top: 4px;
    color: #000;
}
.summary-section .grand-total {
    font-weight: bold;
    font-size: 15px;
    color: #000;
}

/* Footer */
.receipt-footer {
    font-size: 11px;
    margin-top: 6px;
    color: #000;
}
.receipt-footer p {
    margin-bottom: 3px;
    color: #000;
}
.receipt-footer .policy {
    font-weight: bold;
    font-size: 12px;
    margin-top: 4px;
    letter-spacing: 0.5px;
}

@media all {
    .pos-invoice-outer { display: none; }
}

@media print {
    @page {
        size: 80mm auto;
        margin: 0;
    }

    /* Hide EVERYTHING else in your backend dashboard */
    body * { visibility: hidden; }
    #printable-section, #printable-section * { visibility: visible; }
    #printable-section { 
        position: absolute; 
        left: 0; 
        top: 0; 
        width: 80mm !important; 
        display: block !important;
    }

    body {
        background-color: #fff !important;
        margin: 0;
        padding: 0;
        width: 80mm;
    }
}

/* Receipt Styling */
.receipt-container {
    width: 72mm; /* Safe zone for TM-T82X-II */
    margin: 0 auto;
    padding: 10px 0;
    font-family: 'Courier New', Courier, monospace;
    font-size: 12px;
    line-height: 1.2;
    -webkit-font-smoothing: none; /* Disables font smoothing which causes "gray" edges */
    -moz-osx-font-smoothing: grayscale;
    text-rendering: optimizeLegibility;
    color: #000!important;
}

.text-center { text-align: center; }
.text-right { text-align: right; }
.text-left { text-align: left; }

.brand-name { font-size: 18px; font-weight: bold; margin: 0; }
.tagline { font-size: 11px; margin-bottom: 5px; }
.categories { font-size: 9px; line-height: 1; }

.dashed-line {
    border: none;
    border-top: 1px dashed #000;
    margin: 5px 0;
}

.meta-row, .summary-row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 2px;
}

.receipt-table {
    width: 100%;
    border-collapse: collapse;
    margin: 5px 0;
}
.receipt-table th { border-bottom: 1px dashed #000; padding: 4px 0; }
.receipt-table td { padding: 3px 0; vertical-align: top; }

.grand-total {
    font-size: 15px;
    font-weight: bold;
    margin-top: 5px;
    padding-top: 5px;
    border-top: 1px solid #000;
}

.receipt-footer { font-size: 10px; margin-top: 10px; }
.policy { font-weight: bold; font-size: 11px; margin-top: 5px; }
</style>
@endpush

@push('script')
<script>
document.addEventListener('DOMContentLoaded', function() {
    window.print();
    setTimeout(() => window.close(), 1000);
});
</script>
@endpush