String _dua(int n) => n.toString().padLeft(2, '0');

String formatTanggal(DateTime d) =>
    '${_dua(d.day)}/${_dua(d.month)}/${d.year} ${_dua(d.hour)}:${_dua(d.minute)}';

String formatJarak(double meter) => meter < 1000
    ? '${meter.toStringAsFixed(0)} m'
    : '${(meter / 1000).toStringAsFixed(1)} km';
