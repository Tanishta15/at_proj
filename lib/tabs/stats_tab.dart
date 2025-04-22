import 'package:flutter/material.dart';

class StatsTab extends StatelessWidget {
  const StatsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          _buildHeaderSection(),
          const SizedBox(height: 20),

          // Main Statistics Cards
          Row(
            children: [
              Expanded(child: _buildStatCard("Books Owned", "46")),
              const SizedBox(width: 16),
              Expanded(child: _buildStatCard("Total Books Read", "16")),
              const SizedBox(width: 16),
              Expanded(child: _buildStatCard("Most Read Month", "July")),
            ],
          ),
          const SizedBox(height: 20),

          // Secondary Statistics Cards
          Row(
            children: [
              Expanded(child: _buildStatCard("On Hold", "2")),
              const SizedBox(width: 16),
              Expanded(child: _buildStatCard("Total Books Left", "34")),
              const SizedBox(width: 16),
              Expanded(child: _buildStatCard("Average Days To Finished", "2.63")),
              const SizedBox(width: 16),
              Expanded(child: _buildStatCard("Total Pages Read", "8129")),
            ],
          ),
          const SizedBox(height: 20),

          // Books Read Per Month Table
          _buildBooksReadPerMonthTable(),

          const SizedBox(height: 20),

          // Favorite Quotes Section
          _buildFavoriteQuotesSection(),

          const SizedBox(height: 20),

          // Books Wishlist Section
          _buildBooksWishlistSection(),
        ],
      ),
    );
  }

  // Header Section
  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "DASHBOARD",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.pinkAccent,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.pink[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Today's Date",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.pink[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Reading Goal This Year",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.pink[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Currently Reading",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.pink[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "50",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Stat Card
  Widget _buildStatCard(String title, String value) {
    return Card(
      color: Colors.pink[50],
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Books Read Per Month Table
  Widget _buildBooksReadPerMonthTable() {
    return Card(
      color: Colors.pink[50],
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Books read per month",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            DataTable(
              columns: const [
                DataColumn(label: Text("Month")),
                DataColumn(label: Text("Goal")),
                DataColumn(label: Text("Completed")),
              ],
              rows: List.generate(12, (index) {
                final months = [
                  "January",
                  "February",
                  "March",
                  "April",
                  "May",
                  "June",
                  "July",
                  "August",
                  "September",
                  "October",
                  "November",
                  "December"
                ];
                return DataRow(
                  cells: [
                    DataCell(Text(months[index])),
                    DataCell(Text("5")),
                    DataCell(Text("0")),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // Favorite Quotes Section
  Widget _buildFavoriteQuotesSection() {
    return Card(
      color: Colors.pink[50],
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Favorite Quotes",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "\"The only limit to our realization of tomorrow is our doubts of today.\" – Franklin D. Roosevelt",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  // Books Wishlist Section
  Widget _buildBooksWishlistSection() {
    return Card(
      color: Colors.pink[50],
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Books Wishlist",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "1. The Silent Patient by Alex Michaelides\n2. Where the Crawdads Sing by Delia Owens",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}