resource "aws_ebs_volume" "volume" {
  availability_zone = var.ebs_availability_zone
  size              = var.volume_size
  tags = var.tags
}

resource "aws_volume_attachment" "disk_mount" {
  instance_id                    = var.instance_id
  volume_id                      = aws_ebs_volume.volume.id
  device_name                    = "/dev/sdf"
  stop_instance_before_detaching = true
}

resource "aws_ssm_document" "disk_mount" {
  name          = "${var.instance_id}-${replace(var.mount_point, "/", "_")}-mount"
  document_type = "Command"
  content = jsonencode({
    schemaVersion = "2.2"
    description   = "Mount the db disk"
    parameters = {
      mountPath = {
        type = "String"
      }
      mountTarget = {
        type = "String"
      }
      completionFlag = {
        type = "String"
      }
    }
    mainSteps = [
      {
        action = "aws:runShellScript"
        name   = "mount"
        inputs = {
          runCommand = [
            file("${path.module}/mount_storage.sh")
          ]
        }
      }
    ]
  })
}

resource "aws_ssm_association" "disk_mount" {

  depends_on = [
    aws_volume_attachment.disk_mount
  ]

  name = aws_ssm_document.disk_mount.name
  targets {
    key = "InstanceIds"
    values = [
      var.instance_id
    ]
  }
  parameters = {
    mountPath  = aws_volume_attachment.disk_mount.device_name
    mountTarget = var.mount_point
    completionFlag = var.completion_flag_name
  }
}

