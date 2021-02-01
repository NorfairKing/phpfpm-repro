{ pkgs ? import <nixpkgs> { } }:
let
  configuration = import ./configuration.nix;

in
  pkgs.nixosTest ({ lib, pkgs, ... }: { 
    name = "phpfpm-pool-repro";
    machine = import ./configuration.nix;
    testScript = ''
      from shlex import quote

      machine.start()
      machine.wait_for_unit("multi-user.target")

      machine.wait_for_open_port(80)
      machine.wait_for_unit("nginx.service")
      machine.wait_for_unit("phpfpm.slice")
      machine.wait_for_unit("phpfpm.target")
      machine.wait_for_unit("phpfpm-phpdemo1.service")
      machine.wait_for_unit("phpfpm-phpdemo2.service")


      def su(user, cmd):
          return f"su - {user} -c {quote(cmd)}"


      output = machine.succeed(su("root", "ps aux | grep php-fpm:master | wc -l"))

      print(output)

      # The output will show both the grep process and the phpfpm master processes.
      # We should find two: one grep process and one phpfpm master process
      assert output == "2\n"
    '';
})
