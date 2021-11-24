USER    ?= robin
HOST    ?= katsumi
FLAGS   ?= --flake .\#$(HOST)


switch:
	@sudo nixos-rebuild $(FLAGS) switch

clean:
	@nix-collect-garbage

build-vm:
	@sudo nixos-rebuild $(FLAGS) --impure build-vm

run-vm:
	QEMU_NET_OPTS="hostfwd=tcp::2222-:22" ./result/bin/run-*-vm
