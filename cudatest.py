import torch
def main():
    if not torch.cuda.is_available():
        print("cuda is not available")
    else:
        print("cuda is available")

if __name__ == "__main__":
    main()