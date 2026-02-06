@extends('backend.master')
@section('title', 'Receipt_'.$order->id)

@section('content')

<div class="receipt-container" id="printable-section">
    
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

@endsection

@push('style')
<style>
/* General receipt styles */
.receipt-container {
    background-color: #fff;
    padding: 2mm;
    font-family: 'Courier New', Courier, monospace;
    color: #000;
    line-height: 1.2;
    width: 100%;
    max-width: 50.8mm; /* Standard 2 inch width */
    margin: 0 auto;
    box-sizing: border-box;
}

/* Header */
.brand-name { font-weight: 900; font-size: 18px; margin: 0; text-transform: uppercase; }
.tagline { font-style: italic; font-size: 11px; margin-bottom: 3px; }
.dashed-line { border: none; border-top: 1px dashed #000; margin: 5px 0; }

/* Table */
.receipt-table { width: 100%; font-size: 11px; border-collapse: collapse; }
.receipt-table th { border-bottom: 1px dashed #000; padding-bottom: 3px; }

/* Footer */
.receipt-footer { font-size: 9px; margin-top: 5px; }

/* Summary */
.summary-section { font-size: 11px; margin-top: 3px; }
.summary-section .grand-total { font-weight: bold; font-size: 12px; }

/* PRINT STYLES */
@media print {
    body * { visibility: hidden; }
    #printable-section, #printable-section * { visibility: visible; }
    #printable-section {
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
        margin: 0 !important;
        padding: 0 !important;
    }

    body, .wrapper, .content-wrapper, .card {
        background: #fff !important;
        margin: 0 !important;
        padding: 0 !important;
        border: none !important;
        display: block !important;
        overflow: visible !important;
    }

    .no-print, .main-sidebar, .main-header, .main-footer {
        display: none !important;
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
