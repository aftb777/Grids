# Grids

A powerful and flexible Swift-based library for creating and managing grid-based layouts and data structures.

## Table of Contents

- [Project Overview](#project-overview)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Examples](#examples)
- [Contributing](#contributing)
- [Support](#support)

## Project Overview

Grids is a modern Swift library designed to simplify the creation and manipulation of grid-based layouts and data structures. Whether you're building game boards, spreadsheet-like interfaces, data visualization tools, or any application requiring grid management, Grids provides a robust foundation with an intuitive API.

### Core Concept

The library implements efficient grid data structures that support:
- Dynamic resizing and modification
- Fast cell access and traversal
- Flexible coordinate systems
- Type-safe operations

### Why Grids?

- **Swift-Native**: Built from the ground up for Swift, leveraging modern language features
- **Performance-Oriented**: Optimized for large grids and frequent access patterns
- **Easy to Extend**: Clean architecture makes it simple to add custom functionality
- **Well-Tested**: Comprehensive test coverage ensures reliability

## Features

### Core Grid Operations
- ✅ Create grids of any dimension with generic type support
- ✅ Add, remove, and update grid cells
- ✅ Access cells using coordinates (row, column)
- ✅ Iterate over rows, columns, or the entire grid
- ✅ Query grid dimensions and metadata

### Advanced Functionality
- ✅ Grid transformations and rotations
- ✅ Neighbor cell queries (with customizable distance metrics)
- ✅ Region/area selection and manipulation
- ✅ Grid serialization and deserialization
- ✅ Custom coordinate system support

### Developer Experience
- ✅ Comprehensive documentation and inline comments
- ✅ Extensive example code
- ✅ Type-safe API design
- ✅ Descriptive error messages

## Installation

### Swift Package Manager

Add Grids to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/aftb777/Grids.git", from: "1.0.0")
]
```

Then add `Grids` to your target dependencies:

```swift
.target(
    name: "YourTarget",
    dependencies: ["Grids"]
)
```

### Manual Installation

1. Clone the repository:
```bash
git clone https://github.com/aftb777/Grids.git
```

2. Drag the `Sources/Grids` folder into your Xcode project
3. Ensure the files are added to your target

## Usage

### Basic Grid Creation

```swift
import Grids

// Create a 5x5 grid of integers
var grid = Grid<Int>(rows: 5, columns: 5, defaultValue: 0)

// Access and modify cells
grid[0, 0] = 42
let value = grid[1, 2]

// Check grid dimensions
print("Rows: \(grid.rows), Columns: \(grid.columns)")
```

### Iterating Over a Grid

```swift
// Iterate over all cells
for row in 0..<grid.rows {
    for col in 0..<grid.columns {
        let value = grid[row, col]
        // Process value
    }
}

// Iterate using forEach
grid.forEach { row, col, value in
    print("Cell [\(row), \(col)]: \(value)")
}
```

### Working with Regions

```swift
// Select a region
let region = grid.region(startRow: 1, startCol: 1, height: 3, width: 3)

// Fill a region with a value
grid.fill(value: 10, in: region)

// Modify all cells in a region
grid.transform(in: region) { value in
    return value * 2
}
```

### Finding Neighbors

```swift
// Get neighbors of a cell (4-connected: up, down, left, right)
let neighbors = grid.neighbors(row: 2, col: 2, includeDiagonals: false)

// Get neighbors including diagonals (8-connected)
let allNeighbors = grid.neighbors(row: 2, col: 2, includeDiagonals: true)

// Access neighbor values
for (row, col) in neighbors {
    let value = grid[row, col]
}
```

### Grid Transformations

```swift
// Rotate grid 90 degrees clockwise
let rotated = grid.rotatedClockwise()

// Rotate 90 degrees counter-clockwise
let rotated2 = grid.rotatedCounterClockwise()

// Flip horizontally
let flipped = grid.flippedHorizontally()

// Flip vertically
let flipped2 = grid.flippedVertically()
```

### Serialization

```swift
// Convert grid to array representation
let array = grid.toArray()

// Create grid from array
let newGrid = Grid<Int>(array: array)

// JSON encoding/decoding (if your type conforms to Codable)
let encoder = JSONEncoder()
let data = try encoder.encode(grid)
```


#### Initializers

```swift
// Create grid with default value
init(rows: Int, columns: Int, defaultValue: T)

// Create grid from 2D array
init(array: [[T]])
```

#### Properties

```swift
var rows: Int                    // Number of rows
var columns: Int                 // Number of columns
var isEmpty: Bool                // Whether grid has no cells
var count: Int                   // Total number of cells
```

#### Methods

```swift
// Access and modification
subscript(row: Int, col: Int) -> T { get set }

// Queries
func isValid(row: Int, col: Int) -> Bool
func neighbors(row: Int, col: Int, includeDiagonals: Bool) -> [(Int, Int)]
func region(startRow: Int, startCol: Int, height: Int, width: Int) -> GridRegion

// Operations
func fill(value: T, in region: GridRegion)
func transform(in region: GridRegion, _ transform: (T) -> T)
func forEach(_ block: (Int, Int, T) -> Void)

// Transformations
func rotatedClockwise() -> Grid<T> where T: Equatable
func rotatedCounterClockwise() -> Grid<T> where T: Equatable
func flippedHorizontally() -> Grid<T> where T: Equatable
func flippedVertically() -> Grid<T> where T: Equatable

// Serialization
func toArray() -> [[T]]
```

## Examples

### Game Board

```swift
enum TileType {
    case empty
    case wall
    case player
    case enemy
}

var gameBoard = Grid<TileType>(rows: 10, columns: 10, defaultValue: .empty)
gameBoard[5, 5] = .player
gameBoard[7, 3] = .enemy

// Find adjacent empty tiles for movement
let neighbors = gameBoard.neighbors(row: 5, col: 5, includeDiagonals: false)
let emptyNeighbors = neighbors.filter { gameBoard[$0, $1] == .empty }
```

### Cellular Automaton

```swift
var grid = Grid<Bool>(rows: 50, columns: 50, defaultValue: false)

// Initialize with some live cells
grid[25, 25] = true
grid[25, 26] = true
grid[26, 25] = true

// Implement Conway's Game of Life
func nextGeneration(_ current: Grid<Bool>) -> Grid<Bool> {
    var next = current
    
    for row in 0..<current.rows {
        for col in 0..<current.columns {
            let liveNeighbors = current.neighbors(row: row, col: col, includeDiagonals: true)
                .filter { current[$0, $1] }
                .count
            
            let isAlive = current[row, col]
            next[row, col] = (liveNeighbors == 3) || (isAlive && liveNeighbors == 2)
        }
    }
    
    return next
}
```

### Maze Generation

```swift
enum Cell {
    case wall
    case path
    case start
    case end
}

var maze = Grid<Cell>(rows: 21, columns: 21, defaultValue: .wall)

// Mark paths
maze[1, 1] = .start
maze[19, 19] = .end

// Create paths using your maze generation algorithm
for row in stride(from: 1, to: 20, by: 2) {
    for col in stride(from: 1, to: 20, by: 2) {
        maze[row, col] = .path
    }
}
```

## Contributing

We welcome contributions to the Grids project! Whether you're reporting bugs, suggesting features, or submitting code improvements, your input is valuable.

### Getting Started

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Make your changes
4. Write or update tests for your changes
5. Ensure all tests pass
6. Commit with clear, descriptive messages
7. Push to your fork
8. Submit a pull request

### Development Guidelines

- **Code Style**: Follow Swift naming conventions and the existing code style
- **Documentation**: Add documentation comments for public APIs
- **Testing**: Include unit tests for new features
- **Performance**: Consider performance implications for large grids
- **Backwards Compatibility**: Try to maintain API compatibility when possible

### Testing

Run the test suite:

```bash
swift test
```

Run tests with coverage:

```bash
swift test --enable-code-coverage
```

### Reporting Issues

When reporting bugs, please include:
- Description of the issue
- Steps to reproduce
- Expected behavior
- Actual behavior
- Environment (Swift version, OS, etc.)
- Relevant code snippets

### Feature Requests

For feature requests, please describe:
- The use case
- Expected behavior
- Why this feature would be valuable
- Any alternative solutions you've considered

### Code Review Process

All pull requests will be reviewed for:
- Code quality and style consistency
- Test coverage
- Documentation completeness
- Performance impact
- Backwards compatibility

## Support

### Documentation

- Check the [Wiki](https://github.com/aftb777/Grids/wiki) for additional guides
- Browse [Examples](Examples) folder for sample code
- Review inline documentation in the source code

### Getting Help

- Open an [Issue](https://github.com/aftb777/Grids/issues) for bugs or feature requests
- Check existing issues for similar problems
- Start a [Discussion](https://github.com/aftb777/Grids/discussions) for questions

### Community

- Contributions are always welcome
- Share your projects built with Grids
- Provide feedback on the library

---

**Last Updated**: 2025-12-11

For the latest version and updates, visit [https://github.com/aftb777/Grids](https://github.com/aftb777/Grids)
