import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/res/app_assets.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/sight_search_screen.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';
import 'package:places/ui/screen/widgets/sight_appbar.dart';
import 'package:places/ui/screen/widgets/sight_card.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SightListScreen();
}

class _SightListScreen extends State<SightListScreen> {
  List<Sight>? mocksWithFilters = mocks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SightAppBar(
        leading: null,
        bottom: SearchBar(
          readOnly: true,
          onChanged: (value) {},
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<SightSearchScreen>(
                builder: (context) => SightSearchScreen(
                  mocksWithFilters: mocksWithFilters!,
                ),
              ),
            );
          },
          suffixIcon: IconButton(
            icon: ImageIcon(
              const AssetImage(AppAssets.filterAsset),
              color: AppColors.planButtonColor,
            ),
            onPressed: () async {
              mocksWithFilters = await Navigator.push(
                context,
                MaterialPageRoute<List<Sight>>(
                  builder: (context) => const FiltersScreen(),
                ),
              );
            },
          ),
          controller: null,
        ),
      ),
      floatingActionButton: _AddNewSightButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView.builder(
        physics: Platform.isAndroid
            ? const ClampingScrollPhysics()
            : const BouncingScrollPhysics(),
        itemCount: mocks.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: SightCard(mocks[index]),
          );
        },
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}

class _AddNewSightButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 177,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            AppColors.gradientStartColor,
            AppColors.planButtonColor,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<AddSightScreen>(
              builder: (context) => const AddSightScreen(),
            ),
          );
        },
        child: Center(
          child: Row(
            children: const [
              Icon(Icons.add),
              Text(
                AppStrings.newSightText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
