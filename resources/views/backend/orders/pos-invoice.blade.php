@extends('backend.master')
@section('title', 'Receipt_'.$order->id)
@section('content')

<div class="card border-0">
  <div class="receipt-container mt-0 mx-auto" id="printable-section" style="max-width: {{ $maxWidth ?? '380px' }};">
    
    <div class="text-center receipt-header">
      @if(readConfig('is_show_logo_invoice'))
        <img src="{{ assetImage(readconfig('site_logo')) }}" height="40" alt="Logo" class="mb-2">
      @endif
      
      <h1 class="brand-name">{{ readConfig('site_name') }}</h1>
      <p class="tagline">Fashion Gets Affordable</p>
      
      <div class="categories">
        Ladies Kurti | Kids Wear | Cord Sets | Bags | Shoes
      </div>
    </div>

    <hr class="dashed-line">

    <div class="receipt-meta">
      <div class="row">
        <div class="col-6 text-left">
          Insta: {{ readConfig('instagram_handle') ?? '@cherry_1323' }}
        </div>
        <div class="col-6 text-right">
          Date: {{ date('d/m/Y', strtotime($order->created_at)) }}<br>
          Bill No: {{ $order->id }}
        </div>
      </div>
    </div>

    <hr class="dashed-line">

    <table class="receipt-table">
      <thead>
        <tr>
          <th class="text-left">Item Name</th>
          <th class="text-center">Price</th>
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

    <div class="text-right">
       @if($order->discount > 0)
        <small>DISCOUNT: -{{ number_format($order->discount, 2) }}</small>
       @endif
    </div>

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

    <div class="text-center receipt-footer">
      <p>THANK YOU FOR SHOPPING AT {{ strtoupper(readConfig('site_name')) }}!</p>
      <p>Follow us on Instagram for latest<br>arrivals & offers.</p>
      <p class="policy">NO REFUND / NO EXCHANGE</p>
    </div>
  </div>

  <div class="text-center mt-3 no-print pb-3">
    <button type="button" onclick="window.print()" class="btn btn-dark"><i class="fas fa-print"></i> Print Receipt</button>
  </div>
</div>
@endsection

@push('style')
<style>
  /* Screen styles */
  .receipt-container {
    background-color: #fff;
    padding: 20px;
    font-family: 'Courier New', Courier, monospace;
    color: #000;
    line-height: 1.2;
    border: 1px solid #eee; /* Light border on screen */
  }

  .brand-name { font-weight: 900; font-size: 32px; margin: 0; text-transform: uppercase; }
  .tagline { font-style: italic; font-size: 16px; margin-bottom: 5px; }
  .dashed-line { border: none; border-top: 1px dashed #000; margin: 8px 0; opacity: 1; }
  .receipt-table { width: 100%; font-size: 13px; border-collapse: collapse; }
  .receipt-table th { border-bottom: 1px dashed #000; padding-bottom: 5px; }

  /* PRINT LOGIC - This fixes the blank page issue */
  @media print {
    /* 1. Hide EVERYTHING on the page */
    body * {
      visibility: hidden;
    }

    /* 2. Show ONLY the receipt container and its children */
    #printable-section, #printable-section * {
      visibility: visible;
    }

    /* 3. Reset the position so it starts at the top left of the paper */
    #printable-section {
      position: absolute;
      left: 0;
      top: 0;
      width: 100%;
      max-width: 100% !important;
      margin: 0 !important;
      padding: 0 !important;
      border: none !important;
    }

    /* 4. Strip away background colors/shadows from parent containers */
    body, .wrapper, .content-wrapper, .content, .container-fluid, .card {
      background: #fff !important;
      margin: 0 !important;
      padding: 0 !important;
      border: none !important;
      display: block !important; /* Fixes flexbox/grid issues */
      overflow: visible !important;
    }

    /* 5. Hide the print button and any dashboard elements */
    .no-print, .main-sidebar, .main-header, .main-footer {
      display: none !important;
    }

    @page {
      margin: 0.5cm; /* Small margin for thermal printers */
    }
  }
</style>
@endpush

@push('script')
<script>
  // Optional: Auto-print on load
  // window.print();
</script>
@endpush