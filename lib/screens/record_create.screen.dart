import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/providers.dart';

class RecordCreateScreen extends StatefulWidget {
  const RecordCreateScreen({super.key});

  @override
  State<RecordCreateScreen> createState() => _RecordCreateScreenState();
}

class _RecordCreateScreenState extends State<RecordCreateScreen> {
  late final _recordProvider = context.read<RecordProvider>();

  final _record = CustomRecord();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('새 기록 생성'),
        actions: [
          IconButton(
            onPressed: () {
              if (!_key.currentState!.validate()) {
                return;
              }
              
              _key.currentState!.save();
              _recordProvider.createOne(_record);

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
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    onSaved: (v) => _record.pcd = double.parse(v!),
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
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    onSaved: (v) => _record.ptbd = double.parse(v!),
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
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    onSaved: (v) => _record.weight = double.parse(v!),
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
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    onSaved: (v) => _record.bp = double.parse(v!),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '혈압',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return '필수 항목입니다';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    onSaved: (v) => _record.temp = double.parse(v!),
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
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    onSaved: (v) => _record.memo = v!,
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
