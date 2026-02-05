<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('colors', function (Blueprint $table) {
            if (!Schema::hasColumn('colors', 'name')) {
                $table->string('name')->after('id');
            }
            if (!Schema::hasColumn('colors', 'status')) {
                $table->tinyInteger('status')->default(1)->after('name');
            }
        });

        Schema::table('sizes', function (Blueprint $table) {
            if (!Schema::hasColumn('sizes', 'name')) {
                $table->string('name')->after('id');
            }
            if (!Schema::hasColumn('sizes', 'status')) {
                $table->tinyInteger('status')->default(1)->after('name');
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('colors', function (Blueprint $table) {
            $table->dropColumn(['name', 'status']);
        });

        Schema::table('sizes', function (Blueprint $table) {
            $table->dropColumn(['name', 'status']);
        });
    }
};
