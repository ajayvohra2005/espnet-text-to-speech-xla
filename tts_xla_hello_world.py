import os
import warnings
import soundfile
from espnet2.bin.tts_inference import Text2Speech
import nltk

nltk.download('averaged_perceptron_tagger_eng')

try:
    import torch_xla.core.xla_model as xm
    import torch_xla.runtime as xr
    import torch_xla.distributed.xla_backend as xb

    compiler_cache_path = os.getenv("XLA_CACHE_DIR", "./cache")
    os.makedirs(compiler_cache_path, exist_ok=True)
    try:
        xr.initialize_cache(compiler_cache_path, readonly=False)
    except AttributeError as e:
        warnings.warn(f"can not set XLA cache dir: {e}")
    
except ImportError:
    xm = None
    xr = None
    xb = None

device = "xla" if xm else "cuda"
# device = "cuda"  # force cuda use for comparison if desired

print(f"TTS generation using: {device.upper()}")

# Prepare the model
text2speech = Text2Speech.from_pretrained("kan-bayashi/ljspeech_vits", device=device)

# Run the model
speech = text2speech("Hello world! How are you?")["wav"]

# Save the output audio
os.makedirs("out", exist_ok=True)
soundfile.write(f"out/hello_world_{device}.wav", speech.detach().cpu().numpy(), text2speech.fs, "PCM_16")