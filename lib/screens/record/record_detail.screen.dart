import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';

class RecordDetailScreen extends StatefulWidget {
  final int recordId;

  const RecordDetailScreen({required this.recordId, super.key});

  @override
  State<RecordDetailScreen> createState() => _RecordDetailScreenState();
}

class _RecordDetailScreenState extends State<RecordDetailScreen> {
  late final _theme = Theme.of(context);
  late final _recordProvider = context.watch<RecordDetailProvider>();

  CustomRecord? get _record => _recordProvider.resources.firstOrNull;

  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final recordProvider = context.read<RecordDetailProvider>();
      recordProvider.getOne(id: widget.recordId);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_record == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final record = _record!;
    DateTime createdAt = record.createdAt;
    final comparePcd = _recordProvider.comparePcd(record);
    final comparePtbd = _recordProvider.comparePtbd(record);

    return Scaffold(
      appBar: AppBar(
        title: const Text('기록 상세'),
        actions: [
          IconButton(
            onPressed: () async {
              if (!_key.currentState!.validate()) {
                return;
              }

              _key.currentState!.save();
              record.createdAt = createdAt;

              final recordProvider = context.read<RecordDetailProvider>();
              await recordProvider.updateOne(record);

              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.date_range),
                    onPressed: () async {
                      final DateTime? result = await showDatePicker(
                        context: context,
                        initialDate: createdAt,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(3000),
                      );

                      if (result != null) {
                        createdAt = result;
                      }
                    },
                    label: const Text('날짜 변경'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(
                            color: record.isPcdAbnormal
                                ? _theme.colorScheme.error
                                : null,
                          ),
                          initialValue: record.pcd.toString(),
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
                          onSaved: (v) => record.pcd = double.parse(v!),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'PCD',
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return '필수 항목입니다';
                            }
                            return null;
                          },
                        ),
                      ),
                      if (comparePcd != null) ...{
                        Icon(transformIntToIcon(comparePcd)),
                      },
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(
                            color: record.isPtbdAbnormal
                                ? _theme.colorScheme.error
                                : null,
                          ),
                          initialValue: record.ptbd.toString(),
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
                          onSaved: (v) => record.ptbd = double.parse(v!),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'PTBD',
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return '필수 항목입니다';
                            }
                            return null;
                          },
                        ),
                      ),
                      if (comparePtbd != null) ...{
                        Icon(transformIntToIcon(comparePtbd)),
                      },
                    ],
                  ),
                  TextFormField(
                    initialValue: record.weight.toString(),
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    onSaved: (v) => record.weight = double.parse(v!),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '몸무게',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return '필수 항목입니다';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    style: TextStyle(
                      color: record.isBpMaxAbnormal
                          ? _theme.colorScheme.error
                          : null,
                    ),
                    initialValue: record.bpMax.toString(),
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    onSaved: (v) => record.bpMax = double.parse(v!),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '최고혈압',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return '필수 항목입니다';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    style: TextStyle(
                      color: record.isBpMinAbnormal
                          ? _theme.colorScheme.error
                          : null,
                    ),
                    initialValue: record.bpMin.toString(),
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    onSaved: (v) => record.bpMin = double.parse(v!),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '최저혈압',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return '필수 항목입니다';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    style: TextStyle(
                      color: record.isTempAbnormal
                          ? _theme.colorScheme.error
                          : null,
                    ),
                    initialValue: record.temp.toString(),
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    onSaved: (v) => record.temp = double.parse(v!),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '체온',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return '필수 항목입니다';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    style: TextStyle(color: _theme.colorScheme.primary),
                    initialValue: record.memo.toString(),
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    onSaved: (v) => record.memo = v!,
                    decoration: const InputDecoration(labelText: '메모'),
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                  ),
                  TextButton.icon(
                    icon: Icon(
                      Icons.delete_outline,
                      color: _theme.colorScheme.error,
                    ),
                    onPressed: () => _handleDeleteDialogOpen(record),
                    label: Text(
                      '삭제',
                      style: TextStyle(
                        color: _theme.colorScheme.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleDeleteDialogOpen(CustomRecord record) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('기록 삭제'),
          content: const Text(
            '기록을 삭제하시겠습니까?\n'
            '한번 삭제한 기록은 복구가 불가합니다.\n',
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                '삭제',
                style: TextStyle(
                  color: _theme.colorScheme.error,
                ),
              ),
              onPressed: () {
                final recordProvider = context.read<RecordDetailProvider>();
                recordProvider.deleteOne(record);

                if (context.mounted) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },
            ),
            TextButton(
              child: const Text('취소'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
