@extends('backend.master')

@section('title', 'Edit Color')

@section('content')
<div class="card">
  <div class="card-body">
    <form action="{{ route('backend.admin.colors.update', $color->id) }}" method="post" class="accountForm">
      @csrf
      @method('PUT')
      <div class="card-body">
        <div class="row">
          <div class="mb-3 col-md-6">
            <label for="name" class="form-label">
              Name
              <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" placeholder="Enter color name" name="name"
              value="{{ old('name', $color->name) }}" required>
          </div>
          <div class="mb-3 col-md-12">
            <div class="form-switch px-4">
              <input type="hidden" name="status" value="0">
              <input class="form-check-input" type="checkbox" name="status" id="active"
                value="1" {{ $color->status ? 'checked' : '' }}>
              <label class="form-check-label" for="active">
                Active
              </label>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6">
            <button type="submit" class="btn bg-gradient-primary">Update</button>
          </div>
        </div>
      </div>
    </form>
  </div>
</div>
@endsection
