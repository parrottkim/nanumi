import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/search/controller/search_controller.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final area = ref.watch(areaProvider);
    final domain = ref.watch(domainProvider);

    return LayoutBuilder(
      builder: (context, constraints) => ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: constraints.maxHeight,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '지역별 보기',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 8.0),
              Wrap(
                direction: Axis.horizontal,
                spacing: 4.0,
                runSpacing: 8.0,
                children: List.generate(
                  area.length,
                  (index) => InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(12.0),
                    child: Ink(
                      padding:
                          EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Text(
                        area[index],
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                '사업별 보기',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 8.0),
              Wrap(
                direction: Axis.horizontal,
                spacing: 4.0,
                runSpacing: 8.0,
                children: List.generate(
                  domain.length,
                  (index) => InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(12.0),
                    child: Ink(
                      padding:
                          EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Text(
                        domain[index],
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
