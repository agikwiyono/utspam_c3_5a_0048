import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/user_model.dart';
import '../models/rental_model.dart';
import '../database/database_helper.dart';
import 'rental_detail_page.dart';

class HistoryPage extends StatefulWidget {
  final UserModel user;

  const HistoryPage({super.key, required this.user});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<RentalModel> _rentals = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRentals();
  }

  Future<void> _loadRentals() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final rentals = await DatabaseHelper.instance.getRentalsByUserId(
        widget.user.id!,
      );
      setState(() {
        _rentals = rentals;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'completed':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1e1e1e),
        elevation: 0,
        title: const Text(
          'Rental History',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFba1e43)),
            )
          : _rentals.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No rental history yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey[400]),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              color: const Color(0xFFba1e43),
              onRefresh: _loadRentals,
              child: ListView.builder(
                padding: const EdgeInsets.all(24),
                itemCount: _rentals.length,
                itemBuilder: (context, index) {
                  final rental = _rentals[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildRentalCard(rental),
                  );
                },
              ),
            ),
    );
  }

  Widget _buildRentalCard(RentalModel rental) {
    final startDate = DateTime.parse(rental.startDate);
    final formattedDate = DateFormat('dd MMM yyyy').format(startDate);

    return Material(
      color: const Color(0xFF1e1e1e),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RentalDetailPage(rental: rental),
            ),
          );

          if (result == true) {
            _loadRentals();
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[800]!),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.grey[850],
                  child: Image.network(
                    rental.carImageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.directions_car,
                          size: 50,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            rental.carName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(
                              rental.status,
                            ).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            rental.status.toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: _getStatusColor(rental.status),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.business, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          '${rental.carBrand} • ${rental.carType}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2a2a2a),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person_outline,
                                size: 16,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  rental.renterName,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.event,
                                size: 16,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '$formattedDate • ${rental.rentalDays} days',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[300],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Cost',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        Text(
                          'Rp${rental.totalCost.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFba1e43),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
