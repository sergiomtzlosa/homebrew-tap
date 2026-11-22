# sergiomtzlosa/homebrew-tap

A personal Homebrew tap for macOS applications published through GitHub Releases. The tap stores only cask definitions, never application binaries. Every cask pins an explicit version and SHA-256 checksum.

These applications are **unsigned and not notarized**. They are provided for personal use and may be blocked by Gatekeeper. Do not disable SIP or Gatekeeper globally to work around that.

## Quick Start

Homebrew 7 requires third-party taps to be trusted before their casks can be loaded:

```bash
# Add the tap and trust it
brew tap sergiomtzlosa/tap
brew trust --tap sergiomtzlosa/tap

# Install an application
brew install --cask sergiomtzlosa/tap/quantum-lab
```

## Available Applications

### Physics & Scientific Simulations

| Cask | Application | Description |
| --- | --- | --- |
| `superkamiokande` | SuperKamiokande | Super-Kamiokande neutrino detector in 3D |
| `quantum-lab` | QuantumLab | Explore two complementary pictures of quantum dynamics |
| `nv-center` | NV Spin Lab | Teaching app for nitrogen-vacancy center experiments in diamond |
| `bloch-sphere` | Bloch Sphere | A realistic Bloch sphere for macOS |
| `double-slit-experiment-simulator` | Double-Slit Lab | Simulator for the classic Young's double-slit experiment |
| `cloud-chamber` | CloudChamber | Interactive 3D glass chamber with live particle tracks |
| `muon-detector-simulator` | Muon Detector Simulator | Three-tube cosmic-ray muon telescope |
| `dark-matter-detector` | Dark Matter Detector | Dual-phase liquid-xenon TPC (LZ and XENONnT experiments) |
| `lhc` | LHC Interactive | Explore the Large Hadron Collider |
| `drinking-bird` | Drinking Bird | Classic drinking bird (dippy bird) heat engine simulator |

### Astronomy & Space

| Cask | Application | Description |
| --- | --- | --- |
| `skytrack` | SkyTrack | Native macOS planetarium |
| `iss-tracker` | ISS Tracker | Track the International Space Station |

### Microscopy & Lab Equipment

| Cask | Application | Description |
| --- | --- | --- |
| `fib-sem-simulator` | DualBeam Lab | FIB/SEM training simulator |
| `sem-simulator` | SEM Simulator | Late-1980s-style scanning electron microscope console |
| `dilution-cryofree-simulator` | Dilution Cryofree Simulator | Explore a modern cryogen-free dilution refrigerator |

### Chemistry & Elements

| Cask | Application | Description |
| --- | --- | --- |
| `periodic-table` | Periodic Table | Explore all 118 chemical elements with 3D molecules |

### Computing History & Emulation

| Cask | Application | Description |
| --- | --- | --- |
| `programma101` | Programma101 | Olivetti Programma 101 (1965) emulator |
| `turing-enigma` | Turing Enigma | Historically accurate Enigma machine and Turing-Welchman Bombe |
| `hal9000` | HAL 9000 | HAL 9000 fan-made desktop experience |

### Creative & Music

| Cask | Application | Description |
| --- | --- | --- |
| `chiptune-maker` | Chiptune Maker | Native macOS chiptune composer and tracker |
| `telesketch` | Telesketch | An aluminium drawing machine |
| `toybox` | Toybox | Otamatone and rubber chicken synthesizer |
| `led-banner` | LED Banner | Scrolling text on a simulated LED matrix |

### Games & Entertainment

| Cask | Application | Description |
| --- | --- | --- |
| `wall-exploit` | Wall Exploit | Single-player Bomberman-style arcade game |
| `fruit-slice` | Fruit Slice | Slice fruits like a ninja |
| `car-speedtrack` | Car Speedtrack | Colorful, top-down pixel-art arcade road trip |
| `car-racing-championship` | Apex Slot Racing | 3D slot-car championship |

### Utilities

| Cask | Application | Description |
| --- | --- | --- |
| `visual-saver` | Visual Saver | Show every screen saver this Mac knows about |
| `rubik-solver` | RubikSolver | Rubik's Cube solver |
| `new-file-creation-2` | New File Creation 2 | Create files from templates in Finder or command line |

## Command-Line Tools

### neuro-vector

Command-line tool from [sergiomtzlosa/neuro-vector](https://github.com/sergiomtzlosa/neuro-vector). Available as a formula (not a cask), arm64 only, and depends on Homebrew's `sdl2`:

```bash
brew install sergiomtzlosa/tap/neuro-vector
```

The binary links against Homebrew's SDL2 at runtime, so run it with:

```bash
DYLD_LIBRARY_PATH="$(brew --prefix sdl2)/lib" neuro-vector
```

## Installation Examples

### Install a single application

```bash
brew install --cask sergiomtzlosa/tap/quantum-lab
```

### Install multiple applications

```bash
brew install --cask \
  sergiomtzlosa/tap/skytrack \
  sergiomtzlosa/tap/periodic-table \
  sergiomtzlosa/tap/chiptune-maker
```

### Get information about an app

```bash
brew info --cask sergiomtzlosa/tap/superkamiokande
```

### Upgrade an installed app

```bash
brew upgrade --cask sergiomtzlosa/tap/quantum-lab
```

### Uninstall an app

```bash
brew uninstall --cask sergiomtzlosa/tap/quantum-lab
```
