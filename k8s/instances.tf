resource "google_compute_instance" "bastion" {
  name = "k8s-bastion"
  machine_type = "${var.bastion_machine_type}" // smallest (CPU &amp; RAM) available instance
  zone         = "${var.region_zone}"
  tags         = ["k8s-node"]
  disk {
    image = "${var.image}" // the operative system (and Linux flavour) that your machine will run
    size  = 15
  }
 
  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP - leaving this block empty will generate a new external IP and assign it to the machine
    }
  }
    metadata {
    ssh-keys = "root:${file("${var.public_key_path}")}"
  }

 provisioner "file" {
    source      = "${var.install_script_src_path}"
    destination = "${var.install_script_dest_path}"

    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file("${var.private_key_path}")}"
      agent       = false
    }
 }

    provisioner "remote-exec" {
        inline = [
          "chmod +x ${var.install_script_dest_path}",
          "${var.install_script_dest_path}"
        ]
    }
    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file("${var.private_key_path}")}"
      agent       = false
    }



}

