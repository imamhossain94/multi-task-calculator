import 'package:flutter/material.dart';

import '../services/history_service.dart';
import '../utils/extensions.dart';
import '../utils/app_color.dart';
import '../components/app_surface.dart';

/// Saved calculation history.
///
/// The General Calculator's history button used to just show a "Coming soon"
/// toast; this is the real implementation.
class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<CalculationRecord> _records = const <CalculationRecord>[];

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    setState(() => _records = HistoryService.load());
  }

  Future<void> _clearAll() async {
    final bool confirmed = await onDeletePressed(context);
    if (!confirmed) return;
    await HistoryService.clear();
    if (!mounted) return;
    _load();
    showMessage(context, null, 'History cleared');
  }

  Future<void> _deleteOne(CalculationRecord record) async {
    await HistoryService.remove(record.id);
    if (!mounted) return;
    _load();
  }

  /// Re-open the calculator this record came from.
  void _reopen(CalculationRecord record) {
    if (record.toolRoute.isEmpty) return;
    Navigator.of(context)
      ..pop()
      ..pushNamed(record.toolRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        actions: <Widget>[
          if (_records.isNotEmpty)
            IconButton(
              onPressed: _clearAll,
              tooltip: 'Clear all',
              icon: const Icon(Icons.delete_sweep_rounded),
            ),
        ],
      ),
      body: _records.isEmpty
          ? _EmptyState()
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
              physics: const BouncingScrollPhysics(),
              itemCount: _records.length,
              itemBuilder: (BuildContext context, int index) {
                final CalculationRecord record = _records[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _HistoryCard(
                    record: record,
                    onTap: () => _reopen(record),
                    onDelete: () => _deleteOne(record),
                  ),
                );
              },
            ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 92,
              height: 92,
              decoration: BoxDecoration(
                color: AppPalettes.history.accent,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.history_rounded,
                  size: 44, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              'No calculations yet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Run any calculator and it will be saved here automatically.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({
    required this.record,
    required this.onTap,
    required this.onDelete,
  });

  final CalculationRecord record;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  static IconData _iconFor(String tool) {
    switch (tool) {
      case 'General':
        return Icons.calculate_rounded;
      case 'Tip':
        return Icons.receipt_rounded;
      case 'Loan':
        return Icons.account_balance_rounded;
      case 'Savings':
        return Icons.savings_rounded;
      case 'Health':
        return Icons.favorite_rounded;
      case 'Fuel Cost':
        return Icons.local_gas_station_rounded;
      case 'Fuel Efficiency':
        return Icons.eco_rounded;
      case 'Date':
        return Icons.event_rounded;
      case 'Unit Price':
        return Icons.balance_rounded;
      case 'Number Base':
        return Icons.tag_rounded;
      default:
        return Icons.calculate_rounded;
    }
  }

  static String _formatDate(DateTime date) {
    final DateTime now = DateTime.now();
    final Duration diff = now.difference(date);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final ToolPalette palette = AppPalettes.of(
      record.toolRoute.isEmpty ? '' : record.toolRoute,
    );

    return AppCard(
      padding: const EdgeInsets.fromLTRB(12, 12, 6, 12),
      child: Row(
        children: <Widget>[
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: palette.accent,
              borderRadius: AppRadii.allMd,
            ),
            child: Icon(_iconFor(record.tool), color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: InkWell(
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    record.tool,
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    record.summary,
                    style: TextStyle(
                      fontSize: 12.5,
                      height: 1.35,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    _formatDate(record.createdAt),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: onDelete,
            tooltip: 'Delete entry',
            icon: const Icon(Icons.close_rounded, size: 19),
          ),
        ],
      ),
    );
  }
}
