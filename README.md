# gentle_util
tools for interacting with json output of the Gentle Forced-Aligner

## Dependencies

- Python3
- Python module `pydub`
- `ffmpeg`
- `sox`

# Getting Started

The following commands should install missing Python dependency `pydub` and execute `listen.py` on file `lac01242016_19_31_21.wav`, producing one wav file per phone in `lac01242016_19_31_21.json`

```bash
pip install pydub
chmod 755 listen.py
./listen.py lac01242016_19_31_21.wav lac01242016_19_31_21.json
```
