import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import '../../providers/providers.dart';

class RecordDetailScreen extends StatefulWidget {
  final CustomRecord record;

  const RecordDetailScreen({required this.record, super.key});

  @override
  State<RecordDetailScreen> createState() => _RecordDetailScreenState();
}

class _RecordDetailScreenState extends State<RecordDetailScreen> {
  late final _recordProvider = context.read<RecordProvider>();
  late final _theme = Theme.of(context);

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('기록 상세'),
        actions: [
          IconButton(
            onPressed: () {
              if (!_key.currentState!.validate()) {
                return;
              }

              _key.currentState!.save();
              _recordProvider.updateOne(widget.record);

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
                  TextFormField(
                    initialValue: widget.record.pcd.toString(),
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    onSaved: (v) => widget.record.pcd = double.parse(v!),
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
                  TextFormField(
                    initialValue: widget.record.ptbd.toString(),
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    onSaved: (v) => widget.record.ptbd = double.parse(v!),
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
                  TextFormField(
                    initialValue: widget.record.weight.toString(),
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    onSaved: (v) => widget.record.weight = double.parse(v!),
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
                      color: widget.record.isBpMaxAbnormal
                          ? _theme.colorScheme.error
                          : null,
                    ),
                    initialValue: widget.record.bpMax.toString(),
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    onSaved: (v) => widget.record.bpMax = double.parse(v!),
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
                      color: widget.record.isBpMinAbnormal
                          ? _theme.colorScheme.error
                          : null,
                    ),
                    initialValue: widget.record.bpMin.toString(),
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    onSaved: (v) => widget.record.bpMin = double.parse(v!),
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
                      color: widget.record.isTempAbnormal
                          ? _theme.colorScheme.error
                          : null,
                    ),
                    initialValue: widget.record.temp.toString(),
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    onSaved: (v) => widget.record.temp = double.parse(v!),
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
                    initialValue: widget.record.memo.toString(),
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    onSaved: (v) => widget.record.memo = v!,
                    decoration: const InputDecoration(labelText: '메모'),
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
