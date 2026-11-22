# sergiomtzlosa/homebrew-tap

A personal Homebrew tap for macOS applications published through GitHub Releases. The tap stores only cask definitions, never application binaries. Every cask pins an explicit version and SHA-256 checksum.

These applications are **unsigned and not notarized**. They are provided for personal use and may be blocked by Gatekeeper. Do not disable SIP or Gatekeeper globally to work around that.

## Quick Start

Homebrew 7 requires third-party taps to be trusted before their casks can be loaded:

```bash
# Add the tap and trust it
brew tap sergiomtzlosa/tap
brew trust --tap sergiomtzlosa/tap

# Install a GUI application (cask)
brew install --cask sergiomtzlosa/tap/quantum-lab

# Install a command-line tool (formula)
brew install sergiomtzlosa/tap/matrix-effect-term
```

## Available Command-Line Tools (Formulas)

| Formula | Command | Description |
| --- | --- | --- |
| `matrix-effect-term` | `matrix` | Matrix digital rain effect for the terminal (arm64 only) |
| `neuro-vector` | `neuro-vector` | Command-line tool from neuro-vector (arm64 only, requires SDL2) |

Install with:
```bash
brew install sergiomtzlosa/tap/matrix-effect-term
brew install sergiomtzlosa/tap/neuro-vector
```

## Available Applications (30 Total)

### Physics & Scientific Simulations

| Cask | Application | Description |
| --- | --- | --- |
| `superkamiokande` | SuperKamiokande | Super-Kamiokande (Super-K) neutrino detector in 3D |
| `quantum-lab` | QuantumLab | An app for exploring two complementary pictures of quantum dynamics |
| `nv-center` | NV Spin Lab | Native macOS teaching application for nitrogen-vacancy (NV) center experiments in diamond |
| `bloch-sphere` | Bloch Sphere | A realistic Bloch sphere for macOS |
| `double-slit-experiment-simulator` | Double-Slit Lab | Simulator for the classic Young's double-slit |
| `cloud-chamber` | CloudChamber | An interactive 3D glass chamber with live particle tracks |
| `muon-detector-simulator` | Muon Detector Simulator | A three-tube cosmic-ray muon telescope |
| `dark-matter-detector` | Dark Matter Detector Simulator | Dual-phase liquid-xenon time projection chamber (TPC), inspired by LZ and XENONnT experiments |
| `lhc` | LHC Interactive | Explore the Large Hadron Collider |
| `drinking-bird` | Drinking Bird | Native macOS app that simulates the classic drinking bird (dippy bird) heat engine |

### Astronomy & Space

| Cask | Application | Description |
| --- | --- | --- |
| `skytrack` | SkyTrack | Native macOS planetarium |
| `iss-tracker` | ISS Tracker | Native macOS application that tracks the International Space Station |

### Microscopy & Lab Equipment

| Cask | Application | Description |
| --- | --- | --- |
| `fib-sem-simulator` | DualBeam Lab | A FIB/SEM training simulator |
| `sem-simulator` | SEM Simulator | Brand-free, late-1980s-style scanning electron microscope console simulator |
| `dilution-cryofree-simulator` | Dilution Cryofree Simulator | Native macOS application for exploring a modern cryogen-free dilution refrigerator |

### Chemistry & Elements

| Cask | Application | Description |
| --- | --- | --- |
| `periodic-table` | Periodic Table | Native macOS app for exploring all 118 chemical elements with properties, uses, history, and 3D molecular models |

### Computing History & Emulation

| Cask | Application | Description |
| --- | --- | --- |
| `programma101` | Programma101 | Native macOS emulator of the Olivetti Programma 101 (1965) |
| `turing-enigma` | Turing Enigma | Native macOS application that simulates a historically accurate Enigma machine and the Turing-Welchman Bombe |
| `hal9000` | HAL 9000 | HAL9000 fan-made desktop experience |

### Creative & Music

| Cask | Application | Description |
| --- | --- | --- |
| `chiptune-maker` | Chiptune Maker | A native macOS chiptune composer and tracker |
| `telesketch` | Telesketch | An aluminium drawing machine |
| `toybox` | Toybox | An Otamatone and a rubber chicken synthesized |
| `led-banner` | LED Banner | Native macOS app that renders scrolling text on a simulated LED matrix |

### Games & Entertainment

| Cask | Application | Description |
| --- | --- | --- |
| `wall-exploit` | Wall Exploit | Single-player Bomberman-style arcade game |
| `fruit-slice` | Fruit Slice | Slice the fruits like a ninja |
| `car-speedtrack` | Car Speedtrack | Colourful, top-down pixel-art arcade road trip |
| `car-racing-championship` | Apex Slot Racing | 3D slot-car championship |

### Utilities

| Cask | Application | Description |
| --- | --- | --- |
| `visual-saver` | Visual Saver | macOS utility that shows every screen saver this Mac knows about |
| `rubik-solver` | RubikSolver | Rubik's Cube solver |
| `new-file-creation-2` | New File Creation 2 | Create files from templates in Finder, from the menu bar, from a template library, or with the nfc command-line tool |

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

### Install command-line tools (formulas)

```bash
# Install a single formula
brew install sergiomtzlosa/tap/matrix-effect-term

# Install multiple formulas
brew install \
  sergiomtzlosa/tap/matrix-effect-term \
  sergiomtzlosa/tap/neuro-vector
```

### Install GUI applications (casks)

```bash
# Install a single cask
brew install --cask sergiomtzlosa/tap/quantum-lab
```

# Install multiple casks
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
