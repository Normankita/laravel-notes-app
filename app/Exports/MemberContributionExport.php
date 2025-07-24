<?php

use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\FromQuery;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Maatwebsite\Excel\Concerns\WithChunkReading;

class MemberContributionExport implements FromQuery, WithHeadings, WithMapping, WithChunkReading
{
    use \Maatwebsite\Excel\Concerns\Exportable;

    public function query()
    {
        return DB::table('contribution')
            ->join('member', 'contribution.NATIONAL_ID', '=', 'member.NATIONAL_ID')
            ->select([
                'member.CHNO',
                'member.OWNER_NO',
                'member.NATIONAL_ID',
                'member.DATE_OF_BIRTH',
                'member.DATE_OF_JOINING',
                DB::raw("MIN(contribution.SALYEAR || '-' || LPAD(contribution.SALMONTH, 2, '0')) AS first_contribution"),
                DB::raw("MAX(contribution.SALYEAR || '-' || LPAD(contribution.SALMONTH, 2, '0')) AS last_contribution"),
                DB::raw("MAX(contribution.SALAMOUNT) KEEP (DENSE_RANK LAST ORDER BY contribution.SALYEAR, contribution.SALMONTH) AS last_reconciled_amount"),
                DB::raw("MAX(contribution.SALYEAR) AS last_reconciled_year"),
                'member.STATUS',
            ])
            ->where('contribution.STATUS', 'ACTIVE')
            ->where('member.STATUS', 'ACTIVE')
            ->groupBy(
                'member.CHNO',
                'member.OWNER_NO',
                'member.NATIONAL_ID',
                'member.DATE_OF_BIRTH',
                'member.DATE_OF_JOINING',
                'member.STATUS'
            );
    }

    public function headings(): array
    {
        return [
            'Check Number',
            'Owner Number',
            'National ID',
            'Date of Birth',
            'Date of Joining',
            'First Contribution',
            'Last Contribution',
            'Last Reconciled Amount',
            'Last Reconciled Year',
            'Status',
        ];
    }

    public function map($row): array
    {
        return [
            $row->CHNO,
            $row->OWNER_NO,
            $row->NATIONAL_ID,
            $row->DATE_OF_BIRTH,
            $row->DATE_OF_JOINING,
            $row->first_contribution,
            $row->last_contribution,
            $row->last_reconciled_amount,
            $row->last_reconciled_year,
            $row->STATUS,
        ];
    }

    public function chunkSize(): int
    {
        return 1000;
    }
}
