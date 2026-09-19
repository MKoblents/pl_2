set -e
echo "Running unit tests..."
./build/test_dict
echo ""
echo "Running integration tests..."
echo "third word" | ./build/main
echo "second word" | ./build/main
echo "first word" | ./build/main
echo "nonexistent" | ./build/main || true
echo "" | ./build/main || true
echo "All tests completed!"