import 'package:flutter/material.dart';
import 'package:manager_projects_app/ui/utils/theme/skeleton.dart';

class LoaderProject extends StatelessWidget {
  const LoaderProject({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> listSkeleton = [1,2,3,4]; 
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Skeleton(height: 50,width: double.infinity),
          const SizedBox(height: 20),
          ...listSkeleton.map((e) => const Skeleton(height: 100,width: double.infinity)).toList()
        ],
      ),
    );
  }
}

class LoaderListProject extends StatelessWidget {
  const LoaderListProject({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> listSkeleton = [1,2,3,4,5,6]; 
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
            const SizedBox(height: 20),
          ...listSkeleton.map((e) => const Skeleton(height: 100,width: double.infinity)).toList()
        ],
      ),
    );
  }
}