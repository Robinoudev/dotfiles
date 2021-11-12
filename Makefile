USER    := robin
HOST    := katsumi
FLAGS   := --flake .\#$(HOST)


switch:
	@sudo nixos-rebuild $(FLAGS) switch

clean:
	@nix-collect-garbage
