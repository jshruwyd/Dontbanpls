qemu-system-x86_64 -machine q35 -m 3096 -smp cpus=1 -cpu qemu64 \
  -netdev user,id=n1,hostfwd=tcp::2222-:22 -device virtio-net,netdev=n1 \
  -cdrom alpine-virt-3.12.3-x86_64.iso \
  -nographic alpine.img
