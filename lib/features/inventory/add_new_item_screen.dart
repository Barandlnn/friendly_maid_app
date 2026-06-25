import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:friendly_maid_app/features/alerts/notifications_screen.dart';

class AddNewItemScreen extends StatefulWidget {
  const AddNewItemScreen({super.key});

  @override
  State<AddNewItemScreen> createState() => _AddNewItemScreenState();
}

class _AddNewItemScreenState extends State<AddNewItemScreen> {
  static const double figmaWidth = 375;
  static const double figmaHeight = 812;

  bool isCategoryOpen = false;
  bool isDatePickerOpen = false;
  bool isQuantityOpen = false;
  bool isScanMode = false;
  bool isScanResult = false;

  bool setAlertEnabled = false;
  bool expiryReminderEnabled = false;

  String? selectedCategory;
  String? selectedExpirationDate;
  String? selectedQuantityUnit;
  String? selectedItemName;
  String? selectedQuantityAmount;
  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 800),
      ),
    );
  }

  void _openManualMode() {
    setState(() {
      isScanMode = false;
      isScanResult = false;
      isCategoryOpen = false;
      isDatePickerOpen = false;
      isQuantityOpen = false;
    });
  }

  void _openScanMode() {
    setState(() {
      isScanMode = true;
      isScanResult = false;
      isCategoryOpen = false;
      isDatePickerOpen = false;
      isQuantityOpen = false;
    });
  }

  void _completeScan() {
    setState(() {
      isScanMode = true;
      isScanResult = true;

      isCategoryOpen = false;
      isDatePickerOpen = false;
      isQuantityOpen = false;

      selectedCategory = '🥛 Dairy Products';
      selectedItemName = 'Milk';
      selectedExpirationDate = '20-02-2025';
      selectedQuantityAmount = '2 L';
      selectedQuantityUnit = 'Liters (L)';

      setAlertEnabled = true;
      expiryReminderEnabled = true;
    });
  }

  void _openCategoryDropdown() {
    setState(() {
      isCategoryOpen = true;
      selectedCategory = '🥦 Fresh Produce (Fruits & Vegetables)';
      setAlertEnabled = true;
      expiryReminderEnabled = true;
    });
  }

  void _closeCategoryDropdown() {
    setState(() {
      isCategoryOpen = false;
    });
  }

  void _selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void _openDatePicker() {
    setState(() {
      isDatePickerOpen = true;
      isCategoryOpen = false;
      setAlertEnabled = true;
      expiryReminderEnabled = true;
    });
  }

  void _closeDatePicker() {
    setState(() {
      isDatePickerOpen = false;
    });
  }

  void _confirmDatePicker() {
    setState(() {
      selectedExpirationDate = '02/15/2024';
      isDatePickerOpen = false;
    });
  }

  void _openQuantityDropdown() {
    setState(() {
      isQuantityOpen = true;
      isCategoryOpen = false;
      isDatePickerOpen = false;

      selectedCategory ??= '🥦 Fresh Produce (Fruits & Vegetables)';
      selectedQuantityUnit ??= 'Kilograms (kg)';

      setAlertEnabled = true;
      expiryReminderEnabled = true;
    });
  }

  void _closeQuantityDropdown() {
    setState(() {
      isQuantityOpen = false;
    });
  }

  void _selectQuantityUnit(String unit) {
    setState(() {
      selectedQuantityUnit = unit;
      isQuantityOpen = false;

      selectedCategory ??= '🥦 Fresh Produce (Fruits & Vegetables)';
      setAlertEnabled = true;
      expiryReminderEnabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: figmaWidth,
            height: isQuantityOpen ? 1033 : figmaHeight,
            child: Stack(
              children: [
                const _StatusBar(),

                _TopNavigation(
                  onBack: () {
                    Navigator.maybePop(context);
                  },
                ),

                _SegmentedTabs(
                  isScanMode: isScanMode,
                  onManualTap: _openManualMode,
                  onScanTap: _openScanMode,
                ),
                if (isScanMode && isScanResult)
                  _ScanResultArea(
                    selectedCategory: selectedCategory ?? '🥛 Dairy Products',
                    selectedItemName: selectedItemName ?? 'Milk',
                    selectedExpirationDate:
                        selectedExpirationDate ?? '20-02-2025',
                    selectedQuantityAmount: selectedQuantityAmount ?? '2 L',
                    selectedQuantityUnit: selectedQuantityUnit ?? 'Liters (L)',
                    setAlertEnabled: setAlertEnabled,
                    expiryReminderEnabled: expiryReminderEnabled,
                    onCategoryTap: () {
                      _showMessage(context, 'Category clicked');
                    },
                    onItemNameTap: () {
                      _showMessage(context, 'Item name clicked');
                    },
                    onDateTap: () {
                      _showMessage(context, 'Expiration date clicked');
                    },
                    onQuantityTap: () {
                      _showMessage(context, 'Quantity clicked');
                    },
                    onSetAlertTap: () {
                      setState(() {
                        setAlertEnabled = !setAlertEnabled;
                      });
                    },
                    onExpiryReminderTap: () {
                      setState(() {
                        expiryReminderEnabled = !expiryReminderEnabled;
                      });
                    },
                    onSaveTap: () {
                      _showMessage(context, 'Item saved');
                    },
                  )
                else if (isScanMode)
                  _ScanArea(onScanTap: _completeScan)
                else if (isCategoryOpen)
                  if (isCategoryOpen)
                    _CategoryOpenFormArea(
                      selectedCategory: selectedCategory,
                      onHeaderTap: _closeCategoryDropdown,
                      onCategoryTap: _selectCategory,
                      setAlertEnabled: setAlertEnabled,
                      expiryReminderEnabled: expiryReminderEnabled,
                      onSetAlertTap: () {
                        setState(() {
                          setAlertEnabled = !setAlertEnabled;
                        });
                      },
                      onExpiryReminderTap: () {
                        setState(() {
                          expiryReminderEnabled = !expiryReminderEnabled;
                        });
                      },
                    )
                  else if (isDatePickerOpen)
                    _DatePickerOpenFormArea(
                      selectedCategory: selectedCategory,
                      onCategoryTap: _openCategoryDropdown,
                      onItemNameTap: () {
                        _showMessage(context, 'Item name clicked');
                      },
                      onCancelTap: _closeDatePicker,
                      onOkTap: _confirmDatePicker,
                      setAlertEnabled: setAlertEnabled,
                      expiryReminderEnabled: expiryReminderEnabled,
                      onSetAlertTap: () {
                        setState(() {
                          setAlertEnabled = !setAlertEnabled;
                        });
                      },
                      onExpiryReminderTap: () {
                        setState(() {
                          expiryReminderEnabled = !expiryReminderEnabled;
                        });
                      },
                    )
                  else if (isQuantityOpen)
                    _QuantityOpenFormArea(
                      selectedCategory: selectedCategory,
                      selectedExpirationDate: selectedExpirationDate,
                      selectedQuantityUnit:
                          selectedQuantityUnit ?? 'Kilograms (kg)',
                      onCategoryTap: _openCategoryDropdown,
                      onItemNameTap: () {
                        _showMessage(context, 'Item name clicked');
                      },
                      onDateTap: _openDatePicker,
                      onHeaderTap: _closeQuantityDropdown,
                      onUnitTap: _selectQuantityUnit,
                    )
                  else
                    _FormArea(
                      selectedCategory: selectedCategory,
                      selectedExpirationDate: selectedExpirationDate,
                      selectedQuantityUnit: selectedQuantityUnit,
                      setAlertEnabled: setAlertEnabled,
                      expiryReminderEnabled: expiryReminderEnabled,
                      onCategoryTap: _openCategoryDropdown,
                      onItemNameTap: () {
                        _showMessage(context, 'Item name clicked');
                      },
                      onDateTap: _openDatePicker,
                      onQuantityTap: _openQuantityDropdown,
                      onSetAlertTap: () {
                        setState(() {
                          setAlertEnabled = !setAlertEnabled;
                        });
                      },
                      onExpiryReminderTap: () {
                        setState(() {
                          expiryReminderEnabled = !expiryReminderEnabled;
                        });
                      },
                    ),

                if (!isScanMode &&
                    !isCategoryOpen &&
                    !isDatePickerOpen &&
                    !isQuantityOpen)
                  _BottomNavBar(
                    onHomeTap: () {
                      Navigator.maybePop(context);
                    },
                    onInventoryTap: () {
                      _showMessage(context, 'Already on Inventory');
                    },
                    onAlertsTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NotificationsScreen(),
                        ),
                      );
                    },
                    onMenuTap: () {
                      _showMessage(context, 'Menu clicked');
                    },
                  ),
                _HomeIndicator(top: isQuantityOpen ? 1005 : 804),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ScanResultArea extends StatelessWidget {
  const _ScanResultArea({
    required this.selectedCategory,
    required this.selectedItemName,
    required this.selectedExpirationDate,
    required this.selectedQuantityAmount,
    required this.selectedQuantityUnit,
    required this.setAlertEnabled,
    required this.expiryReminderEnabled,
    required this.onCategoryTap,
    required this.onItemNameTap,
    required this.onDateTap,
    required this.onQuantityTap,
    required this.onSetAlertTap,
    required this.onExpiryReminderTap,
    required this.onSaveTap,
  });

  final String selectedCategory;
  final String selectedItemName;
  final String selectedExpirationDate;
  final String selectedQuantityAmount;
  final String selectedQuantityUnit;

  final bool setAlertEnabled;
  final bool expiryReminderEnabled;

  final VoidCallback onCategoryTap;
  final VoidCallback onItemNameTap;
  final VoidCallback onDateTap;
  final VoidCallback onQuantityTap;
  final VoidCallback onSetAlertTap;
  final VoidCallback onExpiryReminderTap;
  final VoidCallback onSaveTap;

  static const Color green = Color.fromRGBO(76, 175, 80, 1);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 16,
          top: 163,
          width: 343,
          height: 558,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              _LabeledInput(
                top: 0,
                label: 'Category',
                hint: selectedCategory,
                isSelectedValue: true,
                onTap: onCategoryTap,
              ),

              _LabeledInput(
                top: 85,
                label: 'Item name',
                hint: selectedItemName,
                isSelectedValue: true,
                onTap: onItemNameTap,
              ),

              _LabeledInput(
                top: 170,
                label: 'Expiration Date',
                hint: selectedExpirationDate,
                isSelectedValue: true,
                onTap: onDateTap,
              ),

              _ScannedQuantityInput(
                top: 255,
                quantityAmount: selectedQuantityAmount,
                selectedUnit: selectedQuantityUnit,
                onTap: onQuantityTap,
              ),

              _ScanToggleSection(
                top: 340,
                title: 'Set alert',
                description:
                    'Send me a notification when the product\ndrops below 10% of the main amount.',
                enabled: setAlertEnabled,
                onTap: onSetAlertTap,
              ),

              _ScanToggleSection(
                top: 430,
                title: 'Expiry Reminder',
                description:
                    'Send me a notification when the product\nis about to expire.',
                enabled: expiryReminderEnabled,
                onTap: onExpiryReminderTap,
              ),
            ],
          ),
        ),

        Positioned(
          left: 16,
          top: 737,
          width: 343,
          height: 44,
          child: _Clickable(
            onTap: onSaveTap,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: green,
                borderRadius: BorderRadius.circular(23),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(121, 121, 121, 0.5),
                    blurRadius: 12,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                'Save',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Clickable extends StatelessWidget {
  const _Clickable({required this.onTap, required this.child});

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: child,
      ),
    );
  }
}

class _StatusBar extends StatelessWidget {
  const _StatusBar();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 0,
      width: 375,
      height: 44,
      child: Padding(
        padding: const EdgeInsets.only(left: 32, right: 24, top: 10),
        child: Row(
          children: [
            Text(
              '9:41',
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            const Icon(Icons.signal_cellular_alt_rounded, size: 16),
            const SizedBox(width: 4),
            const Icon(Icons.wifi_rounded, size: 16),
            const SizedBox(width: 6),
            Container(
              width: 20,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopNavigation extends StatelessWidget {
  const _TopNavigation({required this.onBack});

  final VoidCallback onBack;

  static const Color darkText = Color.fromRGBO(17, 24, 39, 1);
  static const Color borderGrey = Color.fromRGBO(228, 231, 236, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 44,
      width: 375,
      height: 53,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: borderGrey, width: 1)),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 16,
              top: 0,
              width: 48,
              height: 53,
              child: _Clickable(
                onTap: onBack,
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: darkText,
                  size: 24,
                ),
              ),
            ),

            Center(
              child: Text(
                'Add a new item',
                style: GoogleFonts.montserrat(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SegmentedTabs extends StatelessWidget {
  const _SegmentedTabs({
    required this.isScanMode,
    required this.onManualTap,
    required this.onScanTap,
  });

  final bool isScanMode;
  final VoidCallback onManualTap;
  final VoidCallback onScanTap;

  static const Color lightGrey = Color.fromRGBO(239, 241, 244, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      top: 112,
      width: 343,
      height: 40,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: lightGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            _SegmentButton(
              label: 'Add Manually',
              selected: !isScanMode,
              onTap: onManualTap,
            ),

            _SegmentButton(
              label: 'By Scan',
              selected: isScanMode,
              onTap: onScanTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  static const Color darkText = Color.fromRGBO(17, 24, 39, 1);
  static const Color placeholderGrey = Color.fromRGBO(156, 163, 175, 1);
  static const Color borderGrey = Color.fromRGBO(228, 231, 236, 1);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: _Clickable(
        onTap: onTap,
        child: Container(
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
            border: selected ? Border.all(color: borderGrey, width: 1) : null,
          ),
          child: Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: selected ? darkText : placeholderGrey,
            ),
          ),
        ),
      ),
    );
  }
}

class _ScanArea extends StatelessWidget {
  const _ScanArea({required this.onScanTap});

  final VoidCallback onScanTap;

  static const Color green = Color.fromRGBO(76, 175, 80, 1);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 38,
          top: 256,
          width: 300,
          height: 300,
          child: Image.asset('assets/scan_barcode.png', fit: BoxFit.contain),
        ),

        Positioned(
          left: 16,
          top: 625,
          width: 343,
          height: 44,
          child: _Clickable(
            onTap: onScanTap,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: green,
                borderRadius: BorderRadius.circular(23),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(121, 121, 121, 0.5),
                    blurRadius: 12,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                'Scan Product Now',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FormArea extends StatelessWidget {
  const _FormArea({
    required this.selectedCategory,
    required this.selectedExpirationDate,
    required this.selectedQuantityUnit,
    required this.setAlertEnabled,
    required this.expiryReminderEnabled,
    required this.onCategoryTap,
    required this.onItemNameTap,
    required this.onDateTap,
    required this.onQuantityTap,
    required this.onSetAlertTap,
    required this.onExpiryReminderTap,
  });

  final String? selectedCategory;
  final String? selectedExpirationDate;
  final bool setAlertEnabled;
  final bool expiryReminderEnabled;
  final String? selectedQuantityUnit;

  final VoidCallback onCategoryTap;
  final VoidCallback onItemNameTap;
  final VoidCallback onDateTap;
  final VoidCallback onQuantityTap;
  final VoidCallback onSetAlertTap;
  final VoidCallback onExpiryReminderTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      top: 163,
      width: 343,
      height: 558,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _LabeledInput(
            top: 0,
            label: 'Category',
            hint: selectedCategory ?? 'Search',
            isSelectedValue: selectedCategory != null,
            onTap: onCategoryTap,
          ),

          _LabeledInput(
            top: 85,
            label: 'Item name',
            hint: 'Search',
            isSelectedValue: false,
            onTap: onItemNameTap,
          ),

          _LabeledInput(
            top: 170,
            label: 'Expiration Date',
            hint: selectedExpirationDate ?? 'Enter',
            isSelectedValue: selectedExpirationDate != null,
            onTap: onDateTap,
          ),

          _QuantityInput(
            top: 255,
            selectedUnit: selectedQuantityUnit,
            onTap: onQuantityTap,
          ),

          _AlertSection(
            top: 372,
            title: 'Set alert',
            description:
                'Send me a notification when the product\ndrops below 10% of the main amount.',
            enabled: setAlertEnabled,
            onSwitchTap: onSetAlertTap,
          ),

          _AlertSection(
            top: 461,
            title: 'Expiry Reminder',
            description:
                'Send me a notification when the product\nis about to expire.',
            enabled: expiryReminderEnabled,
            onSwitchTap: onExpiryReminderTap,
          ),
        ],
      ),
    );
  }
}

class _CategoryOpenFormArea extends StatelessWidget {
  const _CategoryOpenFormArea({
    required this.selectedCategory,
    required this.onHeaderTap,
    required this.onCategoryTap,
    required this.setAlertEnabled,
    required this.expiryReminderEnabled,
    required this.onSetAlertTap,
    required this.onExpiryReminderTap,
  });

  final String? selectedCategory;
  final VoidCallback onHeaderTap;
  final ValueChanged<String> onCategoryTap;

  final bool setAlertEnabled;
  final bool expiryReminderEnabled;
  final VoidCallback onSetAlertTap;
  final VoidCallback onExpiryReminderTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      top: 163,
      width: 343,
      height: 620,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _CategoryDropdown(
            selectedCategory:
                selectedCategory ?? '🥦 Fresh Produce (Fruits & Vegetables)',
            onHeaderTap: onHeaderTap,
            onCategoryTap: onCategoryTap,
          ),

          _AlertSection(
            top: 426,
            title: 'Set alert',
            description:
                'Send me a notification when the product\ndrops below 10% of the main amount.',
            enabled: setAlertEnabled,
            onSwitchTap: onSetAlertTap,
          ),

          _AlertSection(
            top: 515,
            title: 'Expiry Reminder',
            description:
                'Send me a notification when the product\nis about to expire.',
            enabled: expiryReminderEnabled,
            onSwitchTap: onExpiryReminderTap,
          ),
        ],
      ),
    );
  }
}

class _DatePickerOpenFormArea extends StatelessWidget {
  const _DatePickerOpenFormArea({
    required this.selectedCategory,
    required this.onCategoryTap,
    required this.onItemNameTap,
    required this.onCancelTap,
    required this.onOkTap,
    required this.setAlertEnabled,
    required this.expiryReminderEnabled,
    required this.onSetAlertTap,
    required this.onExpiryReminderTap,
  });

  final String? selectedCategory;
  final VoidCallback onCategoryTap;
  final VoidCallback onItemNameTap;
  final VoidCallback onCancelTap;
  final VoidCallback onOkTap;

  final bool setAlertEnabled;
  final bool expiryReminderEnabled;
  final VoidCallback onSetAlertTap;
  final VoidCallback onExpiryReminderTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      top: 163,
      width: 343,
      height: 620,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _LabeledInput(
            top: 0,
            label: 'Category',
            hint: selectedCategory ?? 'Search',
            isSelectedValue: selectedCategory != null,
            onTap: onCategoryTap,
          ),

          _LabeledInput(
            top: 85,
            label: 'Item name',
            hint: 'Search',
            isSelectedValue: false,
            onTap: onItemNameTap,
          ),

          _DatePickerBox(top: 170, onCancelTap: onCancelTap, onOkTap: onOkTap),

          _AlertSection(
            top: 426,
            title: 'Set alert',
            description:
                'Send me a notification when the product\ndrops below 10% of the main amount.',
            enabled: setAlertEnabled,
            onSwitchTap: onSetAlertTap,
          ),

          _AlertSection(
            top: 515,
            title: 'Expiry Reminder',
            description:
                'Send me a notification when the product\nis about to expire.',
            enabled: expiryReminderEnabled,
            onSwitchTap: onExpiryReminderTap,
          ),
        ],
      ),
    );
  }
}

class _DatePickerBox extends StatelessWidget {
  const _DatePickerBox({
    required this.top,
    required this.onCancelTap,
    required this.onOkTap,
  });

  final double top;
  final VoidCallback onCancelTap;
  final VoidCallback onOkTap;

  static const Color greyText = Color.fromRGBO(75, 85, 99, 1);
  static const Color darkText = Color.fromRGBO(17, 24, 39, 1);
  static const Color borderGrey = Color.fromRGBO(228, 231, 236, 1);
  static const Color headerGrey = Color.fromRGBO(239, 241, 244, 1);
  static const Color green = Color.fromRGBO(76, 175, 80, 1);
  static const Color red = Color.fromRGBO(239, 68, 68, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: top,
      width: 343,
      height: 214,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Text(
              'Expiration Date',
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: greyText,
              ),
            ),
          ),

          Positioned(
            left: 0,
            top: 24,
            width: 343,
            height: 190,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: borderGrey, width: 1),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(17, 24, 39, 0.06),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Container(
                    width: 343,
                    height: 44,
                    padding: const EdgeInsets.only(left: 14, right: 9),
                    decoration: const BoxDecoration(
                      color: headerGrey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Select date',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: greyText,
                          ),
                        ),

                        const Spacer(),

                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: darkText,
                          size: 24,
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    left: 25,
                    top: 67,
                    child: Text(
                      'Enter date',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: darkText,
                      ),
                    ),
                  ),

                  const Positioned(
                    right: 25,
                    top: 65,
                    child: Icon(
                      Icons.calendar_today_outlined,
                      size: 19,
                      color: darkText,
                    ),
                  ),

                  Positioned(
                    left: 27,
                    top: 110,
                    width: 278,
                    height: 52,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 13),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: green, width: 1.5),
                      ),
                      child: Text(
                        'mm/dd/yyyy',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: darkText,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 34,
                    top: 101,
                    height: 16,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      color: Colors.white,
                      child: Text(
                        'Date',
                        style: GoogleFonts.montserrat(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: green,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    right: 70,
                    bottom: 8,
                    child: _Clickable(
                      onTap: onCancelTap,
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: red,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    right: 25,
                    bottom: 8,
                    child: _Clickable(
                      onTap: onOkTap,
                      child: Text(
                        'OK',
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: green,
                        ),
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
}

class _CategoryDropdown extends StatelessWidget {
  const _CategoryDropdown({
    required this.selectedCategory,
    required this.onHeaderTap,
    required this.onCategoryTap,
  });

  final String selectedCategory;
  final VoidCallback onHeaderTap;
  final ValueChanged<String> onCategoryTap;

  static const Color greyText = Color.fromRGBO(75, 85, 99, 1);
  static const Color darkText = Color.fromRGBO(17, 24, 39, 1);
  static const Color borderGrey = Color.fromRGBO(228, 231, 236, 1);
  static const Color headerGrey = Color.fromRGBO(239, 241, 244, 1);

  static const List<String> categories = [
    '🥦 Fresh Produce (Fruits & Vegetables)',
    '🍗 Meat, Poultry & Seafood',
    '🥛 Dairy Products',
    '🍞 Baked Goods & Grains',
    '🥫 Canned & Packaged Foods',
    '🥤 Beverages',
    '💊 Medications & Supplements',
    '🧂 Condiments & Spices',
  ];

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 0,
      width: 343,
      height: 418,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Category',
            style: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: greyText,
            ),
          ),

          const SizedBox(height: 10),

          Container(
            width: 343,
            height: 383,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(11),
              border: Border.all(color: borderGrey, width: 1),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(17, 24, 39, 0.06),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                _Clickable(
                  onTap: onHeaderTap,
                  child: Container(
                    width: 343,
                    height: 44,
                    padding: const EdgeInsets.only(left: 14, right: 9),
                    decoration: const BoxDecoration(
                      color: headerGrey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(11),
                        topRight: Radius.circular(11),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Select',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: greyText,
                          ),
                        ),

                        const Spacer(),

                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 24,
                          color: darkText,
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Column(
                      children: categories.map((category) {
                        final bool isSelected = category == selectedCategory;

                        return _CategoryOption(
                          text: category,
                          selected: isSelected,
                          onTap: () {
                            onCategoryTap(category);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryOption extends StatelessWidget {
  const _CategoryOption({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  final String text;
  final bool selected;
  final VoidCallback onTap;

  static const Color darkText = Color.fromRGBO(17, 24, 39, 1);
  static const Color borderGrey = Color.fromRGBO(228, 231, 236, 1);
  static const Color green = Color.fromRGBO(76, 175, 80, 1);

  @override
  Widget build(BuildContext context) {
    return _Clickable(
      onTap: onTap,
      child: SizedBox(
        width: 343,
        height: 40,
        child: Padding(
          padding: const EdgeInsets.only(left: 14, right: 20),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: darkText,
                  ),
                ),
              ),

              Container(
                width: 19,
                height: 19,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected ? green : Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: selected ? green : borderGrey,
                    width: 1,
                  ),
                ),
                child: selected
                    ? const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 15,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LabeledInput extends StatelessWidget {
  const _LabeledInput({
    required this.top,
    required this.label,
    required this.hint,
    required this.isSelectedValue,
    required this.onTap,
  });

  final double top;
  final String label;
  final String hint;
  final bool isSelectedValue;
  final VoidCallback onTap;

  static const Color greyText = Color.fromRGBO(75, 85, 99, 1);
  static const Color placeholderGrey = Color.fromRGBO(156, 163, 175, 1);
  static const Color borderGrey = Color.fromRGBO(228, 231, 236, 1);
  static const Color circleGrey = Color.fromRGBO(243, 244, 246, 1);
  static const Color darkText = Color.fromRGBO(17, 24, 39, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: top,
      width: 343,
      height: 76,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: greyText,
            ),
          ),

          const SizedBox(height: 7),

          _Clickable(
            onTap: onTap,
            child: Container(
              width: 343,
              height: 44,
              padding: const EdgeInsets.only(left: 14, right: 7),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11),
                border: Border.all(color: borderGrey, width: 1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      hint,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: isSelectedValue ? darkText : placeholderGrey,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Container(
                    width: 31,
                    height: 31,
                    decoration: const BoxDecoration(
                      color: circleGrey,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: darkText,
                      size: 24,
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
}

class _QuantityInput extends StatelessWidget {
  const _QuantityInput({
    required this.top,
    required this.selectedUnit,
    required this.onTap,
  });

  final double top;
  final String? selectedUnit;
  final VoidCallback onTap;

  String _shortUnitLabel(String unit) {
    switch (unit) {
      case 'Kilograms (kg)':
        return 'KG';
      case 'Pounds (lb)':
        return 'LB';
      case 'Ounces (oz)':
        return 'OZ';
      case 'Liters (L)':
        return 'L';
      case 'Cups':
        return 'Cups';
      case 'Pieces':
        return 'Pcs';
      case 'Pack':
        return 'Pack';
      case 'Slices':
        return 'Slices';
      case 'Dozen':
        return 'Dozen';
      default:
        return unit;
    }
  }

  static const Color greyText = Color.fromRGBO(75, 85, 99, 1);
  static const Color placeholderGrey = Color.fromRGBO(156, 163, 175, 1);
  static const Color borderGrey = Color.fromRGBO(228, 231, 236, 1);
  static const Color pillGrey = Color.fromRGBO(243, 244, 246, 1);
  static const Color darkText = Color.fromRGBO(17, 24, 39, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: top,
      width: 343,
      height: 76,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quantity',
            style: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: greyText,
            ),
          ),

          const SizedBox(height: 7),

          _Clickable(
            onTap: onTap,
            child: Container(
              width: 343,
              height: 44,
              padding: const EdgeInsets.only(left: 14, right: 7),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11),
                border: Border.all(color: borderGrey, width: 1),
              ),
              child: Row(
                children: [
                  Text(
                    'Enter',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: placeholderGrey,
                    ),
                  ),

                  const Spacer(),

                  Container(
                    height: 31,
                    padding: const EdgeInsets.only(left: 12, right: 7),
                    decoration: BoxDecoration(
                      color: pillGrey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Text(
                          selectedUnit == null
                              ? 'Choose'
                              : _shortUnitLabel(selectedUnit!),
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: greyText,
                          ),
                        ),
                        const SizedBox(width: 3),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: darkText,
                          size: 22,
                        ),
                      ],
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
}

class _QuantityOpenFormArea extends StatelessWidget {
  const _QuantityOpenFormArea({
    required this.selectedCategory,
    required this.selectedExpirationDate,
    required this.selectedQuantityUnit,
    required this.onCategoryTap,
    required this.onItemNameTap,
    required this.onDateTap,
    required this.onHeaderTap,
    required this.onUnitTap,
  });

  final String? selectedCategory;
  final String? selectedExpirationDate;
  final String selectedQuantityUnit;

  final VoidCallback onCategoryTap;
  final VoidCallback onItemNameTap;
  final VoidCallback onDateTap;
  final VoidCallback onHeaderTap;
  final ValueChanged<String> onUnitTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      top: 163,
      width: 343,
      height: 832,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _LabeledInput(
            top: 0,
            label: 'Category',
            hint: selectedCategory ?? '🥦 Fresh Produce (Fruits & Vegetables)',
            isSelectedValue: true,
            onTap: onCategoryTap,
          ),

          _LabeledInput(
            top: 85,
            label: 'Item name',
            hint: 'Search',
            isSelectedValue: false,
            onTap: onItemNameTap,
          ),

          _LabeledInput(
            top: 170,
            label: 'Expiration Date',
            hint: selectedExpirationDate ?? 'Enter',
            isSelectedValue: selectedExpirationDate != null,
            onTap: onDateTap,
          ),

          _QuantityDropdownBox(
            top: 255,
            selectedUnit: selectedQuantityUnit,
            onHeaderTap: onHeaderTap,
            onUnitTap: onUnitTap,
          ),
        ],
      ),
    );
  }
}

class _QuantityDropdownBox extends StatelessWidget {
  const _QuantityDropdownBox({
    required this.top,
    required this.selectedUnit,
    required this.onHeaderTap,
    required this.onUnitTap,
  });

  final double top;
  final String selectedUnit;
  final VoidCallback onHeaderTap;
  final ValueChanged<String> onUnitTap;

  static const Color greyText = Color.fromRGBO(75, 85, 99, 1);
  static const Color darkText = Color.fromRGBO(17, 24, 39, 1);
  static const Color borderGrey = Color.fromRGBO(239, 241, 245, 1);
  static const Color headerGrey = Color.fromRGBO(239, 241, 244, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: top,
      width: 343,
      height: 505,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Text(
              'Quantity',
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: greyText,
              ),
            ),
          ),

          Positioned(
            left: 0,
            top: 24,
            width: 343,
            height: 481,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: borderGrey, width: 2),
              ),
              child: Stack(
                children: [
                  _Clickable(
                    onTap: onHeaderTap,
                    child: Container(
                      width: 343,
                      height: 44,
                      padding: const EdgeInsets.only(left: 14, right: 9),
                      decoration: const BoxDecoration(
                        color: headerGrey,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Choose',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: greyText,
                            ),
                          ),

                          const Spacer(),

                          const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: darkText,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    left: 14,
                    top: 54,
                    child: _QuantitySectionTitle(text: 'Weight'),
                  ),

                  _QuantityOption(
                    top: 82,
                    text: 'Kilograms (kg)',
                    selected: selectedUnit == 'Kilograms (kg)',
                    onTap: () => onUnitTap('Kilograms (kg)'),
                  ),

                  _QuantityOption(
                    top: 121,
                    text: 'Pounds (lb)',
                    selected: selectedUnit == 'Pounds (lb)',
                    onTap: () => onUnitTap('Pounds (lb)'),
                  ),

                  _QuantityOption(
                    top: 160,
                    text: 'Ounces (oz)',
                    selected: selectedUnit == 'Ounces (oz)',
                    onTap: () => onUnitTap('Ounces (oz)'),
                  ),

                  Positioned(
                    left: 14,
                    top: 199,
                    child: _QuantitySectionTitle(text: 'Volume'),
                  ),

                  _QuantityOption(
                    top: 227,
                    text: 'Liters (L)',
                    selected: selectedUnit == 'Liters (L)',
                    onTap: () => onUnitTap('Liters (L)'),
                  ),

                  _QuantityOption(
                    top: 266,
                    text: 'Cups',
                    selected: selectedUnit == 'Cups',
                    onTap: () => onUnitTap('Cups'),
                  ),

                  Positioned(
                    left: 14,
                    top: 305,
                    child: _QuantitySectionTitle(text: 'Count'),
                  ),

                  _QuantityOption(
                    top: 333,
                    text: 'Pieces',
                    selected: selectedUnit == 'Pieces',
                    onTap: () => onUnitTap('Pieces'),
                  ),

                  _QuantityOption(
                    top: 372,
                    text: 'Pack',
                    selected: selectedUnit == 'Pack',
                    onTap: () => onUnitTap('Pack'),
                  ),

                  Positioned(
                    left: 14,
                    top: 411,
                    child: _QuantitySectionTitle(text: 'Specialized'),
                  ),

                  _QuantityOption(
                    top: 439,
                    text: 'Slices',
                    selected: selectedUnit == 'Slices',
                    onTap: () => onUnitTap('Slices'),
                  ),

                  _QuantityOption(
                    top: 478,
                    text: 'Dozen',
                    selected: selectedUnit == 'Dozen',
                    onTap: () => onUnitTap('Dozen'),
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

class _QuantitySectionTitle extends StatelessWidget {
  const _QuantitySectionTitle({required this.text});

  final String text;

  static const Color darkText = Color.fromRGBO(17, 24, 39, 1);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: darkText,
      ),
    );
  }
}

class _QuantityOption extends StatelessWidget {
  const _QuantityOption({
    required this.top,
    required this.text,
    required this.selected,
    required this.onTap,
  });

  final double top;
  final String text;
  final bool selected;
  final VoidCallback onTap;

  static const Color darkText = Color.fromRGBO(17, 24, 39, 1);
  static const Color green = Color.fromRGBO(76, 175, 80, 1);
  static const Color borderGrey = Color.fromRGBO(228, 231, 236, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 14,
      right: 16,
      top: top,
      height: 30,
      child: _Clickable(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: darkText,
                ),
              ),
            ),

            Container(
              width: 19,
              height: 19,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? green : borderGrey,
                  width: selected ? 2 : 1.5,
                ),
              ),
              child: selected
                  ? Container(
                      width: 9,
                      height: 9,
                      decoration: const BoxDecoration(
                        color: green,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _AlertSection extends StatelessWidget {
  const _AlertSection({
    required this.top,
    required this.title,
    required this.description,
    required this.enabled,
    required this.onSwitchTap,
  });

  final double top;
  final String title;
  final String description;
  final bool enabled;
  final VoidCallback onSwitchTap;

  static const Color navy = Color.fromRGBO(30, 58, 95, 1);
  static const Color greyText = Color.fromRGBO(75, 85, 99, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: top,
      width: 343,
      height: 78,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: navy,
              ),
            ),
          ),

          Positioned(
            left: 0,
            top: 27,
            width: 285,
            child: Text(
              description,
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                height: 1.35,
                color: greyText,
              ),
            ),
          ),

          Positioned(
            right: 0,
            top: 0,
            child: _Clickable(
              onTap: onSwitchTap,
              child: _SmallSwitch(enabled: enabled),
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallSwitch extends StatelessWidget {
  const _SmallSwitch({required this.enabled});

  final bool enabled;

  static const Color green = Color.fromRGBO(76, 175, 80, 1);
  static const Color disabledGrey = Color.fromRGBO(209, 213, 219, 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 31,
      height: 19,
      decoration: BoxDecoration(
        color: enabled ? green : disabledGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Align(
        alignment: enabled ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 15,
          height: 15,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({
    required this.onHomeTap,
    required this.onInventoryTap,
    required this.onAlertsTap,
    required this.onMenuTap,
  });

  final VoidCallback onHomeTap;
  final VoidCallback onInventoryTap;
  final VoidCallback onAlertsTap;
  final VoidCallback onMenuTap;

  static const Color borderGrey = Color.fromRGBO(228, 231, 236, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 721,
      width: 375,
      height: 81,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: borderGrey, width: 1)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 11),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_rounded,
                label: 'Home',
                selected: false,
                onTap: onHomeTap,
              ),
              _NavItem(
                icon: Icons.inventory_2_rounded,
                label: 'Inventory',
                selected: true,
                onTap: onInventoryTap,
              ),
              _NavItem(
                icon: Icons.notifications_rounded,
                label: 'Alerts',
                selected: false,
                badge: '3',
                onTap: onAlertsTap,
              ),
              _NavItem(
                icon: Icons.menu_rounded,
                label: 'Menu',
                selected: false,
                onTap: onMenuTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.badge,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final String? badge;

  static const Color green = Color.fromRGBO(76, 175, 80, 1);
  static const Color greyText = Color.fromRGBO(107, 114, 128, 1);
  static const Color red = Color.fromRGBO(239, 68, 68, 1);

  @override
  Widget build(BuildContext context) {
    final Color activeColor = selected ? green : greyText;

    return _Clickable(
      onTap: onTap,
      child: SizedBox(
        width: 72,
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, color: activeColor, size: 25),

                if (badge != null)
                  Positioned(
                    right: -8,
                    top: -9,
                    child: Container(
                      width: 17,
                      height: 17,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        badge!,
                        style: GoogleFonts.montserrat(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 5),

            Text(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: activeColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeIndicator extends StatelessWidget {
  const _HomeIndicator({required this.top});

  final double top;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 125,
      top: top,
      width: 125,
      height: 5,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}

class _ScannedQuantityInput extends StatelessWidget {
  const _ScannedQuantityInput({
    required this.top,
    required this.quantityAmount,
    required this.selectedUnit,
    required this.onTap,
  });

  final double top;
  final String quantityAmount;
  final String selectedUnit;
  final VoidCallback onTap;

  static const Color greyText = Color.fromRGBO(75, 85, 99, 1);
  static const Color darkText = Color.fromRGBO(17, 24, 39, 1);
  static const Color borderGrey = Color.fromRGBO(228, 231, 236, 1);
  static const Color pillGrey = Color.fromRGBO(243, 244, 246, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: top,
      width: 343,
      height: 76,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quantity',
            style: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: greyText,
            ),
          ),

          const SizedBox(height: 7),

          _Clickable(
            onTap: onTap,
            child: Container(
              width: 343,
              height: 44,
              padding: const EdgeInsets.only(left: 14, right: 7),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11),
                border: Border.all(color: borderGrey, width: 1),
              ),
              child: Row(
                children: [
                  Text(
                    quantityAmount,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: darkText,
                    ),
                  ),

                  const Spacer(),

                  Container(
                    height: 31,
                    padding: const EdgeInsets.only(left: 12, right: 7),
                    decoration: BoxDecoration(
                      color: pillGrey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Text(
                          selectedUnit,
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: darkText,
                          ),
                        ),
                        const SizedBox(width: 3),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: darkText,
                          size: 22,
                        ),
                      ],
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
}

class _ScanToggleSection extends StatelessWidget {
  const _ScanToggleSection({
    required this.top,
    required this.title,
    required this.description,
    required this.enabled,
    required this.onTap,
  });

  final double top;
  final String title;
  final String description;
  final bool enabled;
  final VoidCallback onTap;

  static const Color titleBlue = Color.fromRGBO(37, 65, 96, 1);
  static const Color greyText = Color.fromRGBO(75, 85, 99, 1);
  static const Color green = Color.fromRGBO(76, 175, 80, 1);
  static const Color switchGrey = Color.fromRGBO(209, 213, 219, 1);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: top,
      width: 343,
      height: 78,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: titleBlue,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  description,
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    height: 1.35,
                    color: greyText,
                  ),
                ),
              ],
            ),
          ),

          _Clickable(
            onTap: onTap,
            child: Container(
              width: 28,
              height: 18,
              margin: const EdgeInsets.only(top: 0),
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: enabled ? green : switchGrey,
                borderRadius: BorderRadius.circular(100),
              ),
              alignment: enabled ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
