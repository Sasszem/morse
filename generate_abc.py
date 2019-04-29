
# The morse alphabet stored as a dict
alphabet = {
  "a": ".-",
  "b": "-...",
  "c": "-.-.",
  "d": "-..",
  "e": ".",
  "f": "..-.",
  "g": "--.",
  "h": "....",
  "i": "..",
  "j": ".---",
  "k": "-.-",
  "l": ".-..",
  "m": "--",
  "n": "-.",
  "o": "---",
  "p": ".--.",
  "q": "--.-",
  "r": ".-.",
  "s": "...",
  "t": "-",
  "u": "..-",
  "v": "...-",
  "w": ".--",
  "x": "-..-",
  "y": "-.--",
  "z": "--..",
  "0": "-----",
  "1": ".----",
  "2": "..---",
  "3": "...--",
  "4": "....-",
  "5": ".....",
  "6": "-....",
  "7": "--...",
  "8": "---..",
  "9": "----.",
  "!": "-.-.--",
  "\"": ".-..-.",
  "$": "...-..-",
  "'": ".----.",
  ")": "-.--.-",
  "(": "-.--.",
  ",": "--..--",
  "-": "-....-",
  "+": ".-.-.",
  ".": ".-.-.-",
  "/": "-..-.",
  ":": "---...",
  ";": "-.-.-.",
  "=": "-...-",
  "?": "..--..",
  "@": ".--.-.",
  "_": "..--.-",
  "*": "-..-",
  " ": "|",
  "&": ".-..."
}

# All the character codes we care about
chars = [chr(x) for x in range(128)]


def strings():
    """Return NASM constant string definitions of each letter"""
    base = ""
    for c in chars:
        if c in alphabet:
            base += "   _LETTER_{} DB '{}'\n".format(hex(ord(c)), repr(alphabet[c.lower()]).strip("'"))
    return base

def lengths():
    """Return NASM word array definition of letter lengths"""
    base = ""
    for c in chars:
        base += "   DW {}; \t{}\n".format(len(alphabet.get(c.lower(),"")), repr(c))
    return base

def starts():
    """Return NASM double word array definition of letters start address"""
    base = ""
    for c in chars:
        base += "   DD {}; \t{}\n".format("_LETTER_{}".format(hex(ord(c.lower()))) if c.lower() in alphabet else 0, repr(c))
        
    return base

print("align 4")

print("alphabet:")
print(strings())

print("lengths:")
print(lengths())

print("starts:")
print(starts())