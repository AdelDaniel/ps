// https://leetcode.com/problems/3sum/
// Medium but Very Hard...
import 'package:test/test.dart';

void main(List<String> args) {
  final stopwatch = Stopwatch()..start();
  runTests();

  print(Solution().threeSum([-4, -2, -2, -2, 0, 1, 2, 2, 2, 3, 3, 4, 4, 6, 6]));

  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro s');
}

class Solution {
  ////! Success Submitted TC: O(n^2) + Sort TC (O(NLog(N)))
  ////! Enhance
  List<List<int>> threeSum(List<int> nums) {
    nums.sort();

    final List<List<int>> result = [];
    for (int i = 0; i < nums.length - 2; i++) {
      /// this line to break because we will not reach to target at the sorted array
      if (nums[i] > 0) break;

      /// To get rid of the duplicate So we will take the first number appeared in the list
      /// So if the number appears for the second time we will continue
      if (i != 0 && nums[i - 1] == nums[i]) continue;

      int target = 0 - nums[i];
      int left = i + 1;
      int right = nums.length - 1;

      while (left < right) {
        int sum = nums[right] + nums[left];
        if (sum == target) {
          result.add([nums[i], nums[left], nums[right]]);

          /// move to the next
          left++;
          right--;

          /// Skip all the left duplicates
          /// If the new left is the same as the old then
          while (left < right && nums[left] == nums[left - 1]) {
            left++;
          }

          /// Skip all the right duplicate
          while (left < right &&
              right < nums.length - 1 &&
              nums[right] == nums[right + 1]) {
            right--;
          }
        } else if (sum > target) {
          right--;
        } else {
          left++;
        }
      }
    }
    return result;
  }

  ////! Success Submitted TC: O(n^2) + Sort TC (O(NLog(N)))
  // List<List<int>> threeSum(List<int> nums) {
  //   nums.sort();

  //   final Map<String, List<int>> result = {};
  //   for (int i = 0; i < nums.length - 2; i++) {
  //     if (nums[i] > 0) break;
  //     int target = -1 * nums[i];
  //     int left = i + 1;
  //     int right = nums.length - 1;

  //     while (left < right) {
  //       int sum = nums[right] + nums[left];
  //       if (sum == target) {
  //         result.putIfAbsent(
  //           "${nums[i]}${nums[left]}${nums[right]}",
  //           () => [nums[i], nums[left], nums[right]],
  //         );
  //         right--;
  //         left++;
  //       } else if (sum > target) {
  //         right--;
  //       } else {
  //         left++;
  //       }
  //     }
  //   }
  //   return result.values.toList();
  // }

  ////! Time Limit Solution --> TC: O(n^3) + Sort TC
  //// ! Brute Force .
  // List<List<int>> threeSum(List<int> nums) {
  //   nums.sort();

  //   final Map<String, List<int>> result = {};
  //   for (int i = 0; i < nums.length - 2; i++) {
  //     if (nums[i] > 0) break;

  //     for (int j = i + 1; j < nums.length - 1; j++) {
  //       if (nums[i] + nums[j] > 0) break;

  //       for (int k = j + 1; k < nums.length; k++) {
  //         int sum = nums[i] + nums[j] + nums[k];

  //         if (sum == 0) {
  //           result.putIfAbsent(
  //             "${nums[i]}${nums[j]}${nums[k]}",
  //             () => [nums[i], nums[j], nums[k]],
  //           );
  //         } else if (sum > 0) {
  //           break;
  //         }
  //       }
  //     }
  //   }
  //   return result.values.toList();
  // }

  /// Wrong Solution
  /// Will make a duplicate
  // List<List<int>> threeSum(List<int> nums) {
  //   final List<List<int>> result = [];
  //   for (int i = 0; i < nums.length - 2; i++) {
  //     for (int j = i + 1; j < nums.length - 1; j++) {
  //       for (int k = j + 1; k < nums.length; k++) {
  //         if (nums[i] + nums[j] + nums[k] == 0) {
  //           result.add([nums[i], nums[j], nums[k]]);
  //         }
  //       }
  //     }
  //   }
  //   return result;
  // }
}

void runTests() {
  final Solution s = Solution();

  group('3Sum', () {
    // Basic examples from problem statement
    test('Example 1: [-1,0,1,2,-1,-4] → [[-1,-1,2],[-1,0,1]]', () {
      final result = s.threeSum([-1, 0, 1, 2, -1, -4]);
      expect(
          result,
          containsAllInOrder([
            [-1, -1, 2],
            [-1, 0, 1]
          ]));
    });

    test('Example 2: [0,1,1] → []', () {
      expect(s.threeSum([0, 1, 1]), equals([]));
    });

    test('Example 3: [0,0,0] → [[0,0,0]]', () {
      expect(
          s.threeSum([0, 0, 0]),
          equals([
            [0, 0, 0]
          ]));
    });

    test('No solution: [1,2,3] → []', () {
      expect(s.threeSum([1, 2, 3]), equals([]));
    });

    // Multiple zeros
    test('Two zeros: [0,0,1] → []', () {
      expect(s.threeSum([0, 0, 1]), equals([]));
    });

    test('Four zeros: [0,0,0,0] → [[0,0,0]]', () {
      expect(
          s.threeSum([0, 0, 0, 0]),
          equals([
            [0, 0, 0]
          ]));
    });

    // Positive and negative numbers
    test('All positives: [1,2,3,4] → []', () {
      expect(s.threeSum([1, 2, 3, 4]), equals([]));
    });

    test('All negatives: [-1,-2,-3,-4] → []', () {
      expect(s.threeSum([-1, -2, -3, -4]), equals([]));
    });

    // Duplicate triplets
    test('Duplicate triplets: [-1,0,1,2,-1,-4] → [[-1,-1,2],[-1,0,1]]', () {
      final result = s.threeSum([-1, 0, 1, 2, -1, -4]);
      expect(result, hasLength(2));
      expect(
          result,
          containsAllInOrder([
            [-1, -1, 2],
            [-1, 0, 1]
          ]));
    });

    // Large array
    test('Large array with multiple solutions', () {
      final nums = List.generate(1000, (i) => i - 500);
      final result = s.threeSum(nums);
      // Should find all triplets where a + b + c = 0
      expect(result.length, greaterThan(0));
      for (final triplet in result) {
        expect(triplet[0] + triplet[1] + triplet[2], equals(0));
      }
    });

    // Maximum constraints
    test('Maximum length array', () {
      final nums = List.generate(3000, (i) => (i % 200) - 100);
      final result = s.threeSum(nums);
      expect(result.length, greaterThan(0));
    });

    // Random cases
    test('Random case 1: [-2,0,1,1,2] → [[-2,0,2],[-2,1,1]]', () {
      final result = s.threeSum([-2, 0, 1, 1, 2]);
      expect(
          result,
          containsAllInOrder([
            [-2, 0, 2],
            [-2, 1, 1]
          ]));
    });

    test('Random case 2: [3,0,-2,-1,1,2] → [[-2,-1,3],[-2,0,2],[-1,0,1]]', () {
      final result = s.threeSum([3, 0, -2, -1, 1, 2]);
      expect(
          result,
          containsAllInOrder([
            [-2, -1, 3],
            [-2, 0, 2],
            [-1, 0, 1]
          ]));
    });

    // Special cases
    test('All same number except one: [1,1,1,1,1,-2] → [[1,1,-2]]', () {
      expect(
          s.threeSum([1, 1, 1, 1, 1, -2]),
          unorderedMatches([
            [1, 1, -2]..sort()
          ]));
    });

    test('Large range: [-100000,1,99999] → [[-100000,1,99999]]', () {
      expect(
          s.threeSum([-100000, 1, 99999]),
          equals([
            [-100000, 1, 99999]
          ]));
    });

    // Leet code New test case
    test(
        'Leet code: [-4,-2,-2,-2,0,1,2,2,2,3,3,4,4,6,6] → [[-4,-2,6],[-4,0,4],[-4,1,3],[-4,2,2],[-2,-2,4],[-2,0,2]]',
        () {
      final nums = [-4, -2, -2, -2, 0, 1, 2, 2, 2, 3, 3, 4, 4, 6, 6];
      final expected = [
        [-4, -2, 6],
        [-4, 0, 4],
        [-4, 1, 3],
        [-4, 2, 2],
        [-2, -2, 4],
        [-2, 0, 2]
      ];
      final result = s.threeSum(nums);

      expect(result, unorderedMatches(expected));

      // Verify no extra triplets are present
      expect(result.length, equals(expected.length));
    });
  });
}
