@extends('backend.master')

@section('title', 'Colors')

@section('content')
<div class="card">
  <div class="mt-n5 mb-3 d-flex justify-content-end">
    <a href="{{ route('backend.admin.colors.create') }}" class="btn bg-gradient-primary">
      <i class="fas fa-plus-circle"></i>
      Add New
    </a>
  </div>
  <div class="card-body p-2 p-md-4 pt-0">
    <div class="row g-4">
      <div class="col-md-12">
        <div class="card-body table-responsive p-0">
          <table class="table table-hover">
            <thead>
              <tr>
                <th>#</th>
                <th>Name</th>
                <th>Status</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
              @foreach($colors as $color)
              <tr>
                <td>{{ $loop->iteration }}</td>
                <td>{{ $color->name }}</td>
                <td>
                  @if($color->status)
                  <span class="badge bg-primary">Active</span>
                  @else
                  <span class="badge bg-danger">Inactive</span>
                  @endif
                </td>
                <td>
                  <div class="btn-group">
                      <a href="{{ route('backend.admin.colors.edit', $color->id) }}" class="btn btn-sm btn-info">
                        <i class="fas fa-edit"></i> Edit
                      </a>
                      <form action="{{ route('backend.admin.colors.destroy', $color->id) }}" method="POST" style="display:inline;">
                        @csrf
                        @method('DELETE')
                        <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')">
                          <i class="fas fa-trash"></i> Delete
                        </button>
                      </form>
                  </div>
                </td>
              </tr>
              @endforeach
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>
@endsection
