Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CB03A2F70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 17:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhFJPhx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 11:37:53 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:38535 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhFJPhw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:37:52 -0400
Received: by mail-ed1-f44.google.com with SMTP id d13so20043420edt.5;
        Thu, 10 Jun 2021 08:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uAK+m3Pb64IW/t5OyzZyrSx3CkM27j+d+i398SdgIow=;
        b=Tj9VW0xPBMQKFOHR6Qc8vMbIyjB4i0t9DLJGMcke0HvUCjCVbnUJjhnZPKgwQHiDwp
         OEWIZudf3MP82hyGOgIQIFQJoKiZ/LLxMFDbF7nkekEqLI5T4F4EoXoc5rYamSx1Gw+I
         XmSCUOqsJqsr9Q3qIJQa2ONziwS5W7a/7ThfdVXK107MrDu8ht2ZYwQ5ymR4DUQFlm0e
         SPC8KNz1cJsiKY+tfXc/eG+Pfo3vsx+dH/8g47FiGwyIrT1HotvLcbaA9HDbxtzzV4XQ
         ETt/J08GKQwkzOyBbAWlK6lM2cBUIZijz98nr17nH6iCLoLfVK97dI4gZgOHWJODXkS4
         HDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uAK+m3Pb64IW/t5OyzZyrSx3CkM27j+d+i398SdgIow=;
        b=syMfb6Itl6XFN3UVZ7iUaqK+dZTckjWnalgrGzxR/+6F7Ihm1UxvjMJYjoD4+rm/ja
         01p02wqttMGHAdMcVYBQCwQvAuHmCHKuij4Monb6PjtoX3JOmePG5BncmymhXyzwIj6F
         ZD3K7WxmRpv+66JCudM210pjdzRJ+gJ0Kj9qwnCLk6zb3TQYUgwb+OqMxJYLxzr6nqva
         m+bVBezbdlmzx8FrdheP7QgP4XQJhtrIR8Z5vOz7IkUXon2N2yoqYORVnOvu73tjCESD
         Zt+gZ1YipXn+oK63SSZuIlhKGWvFc6xfST75JJTF8TplkVB7OAEzgarnlqLsbah+GbWX
         ZkHA==
X-Gm-Message-State: AOAM53044tfK9+1irPD2kMPp4nZ9p+M9wlkS8TG0ZqeamR5ztI2wxaih
        FiGpHMsBDCqvFk97qsANKlnvgx4LuvHYilDW9Bc=
X-Google-Smtp-Source: ABdhPJx5dVDbvX7eNFd+7rFh7ulxngOK6Lqu3UqQQOb46FIQcdONBfUlcCySppcDmNWXsC0pK5Bmdxlk/+CO7mgRSCI=
X-Received: by 2002:a05:6402:368:: with SMTP id s8mr13769edw.129.1623339295136;
 Thu, 10 Jun 2021 08:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLiRDZ9M4n3uh=i6FpHXoVEWMHpt0At8YaydrOM=LvSvdg@mail.gmail.com>
 <295072107.94766.1623262940865.JavaMail.zimbra@nod.at> <CAOuPNLhPiVgi5Q343VP-p7vwBtA1-A5jt8Ow4_2eF4ZwsiA+eQ@mail.gmail.com>
 <361047717.98543.1623333152629.JavaMail.zimbra@nod.at>
In-Reply-To: <361047717.98543.1623333152629.JavaMail.zimbra@nod.at>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Thu, 10 Jun 2021 21:04:43 +0530
Message-ID: <CAOuPNLguWzOPfoiutMy=zLYfH1-67=i0e-SL_MyhDgdYE70vQg@mail.gmail.com>
Subject: Re: qemu: arm: mounting ubifs using nandsim on busybox
To:     Richard Weinberger <richard@nod.at>,
        edk2-devel <edk2-devel@lists.01.org>, devel@edk2.groups.io,
        qemu-block@nongnu.org, qemu-devel@nongnu.org,
        Laszlo Ersek <lersek@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 10 Jun 2021 at 19:22, Richard Weinberger <richard@nod.at> wrote:
>
> Pintu,
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Pintu Agarwal" <pintu.ping@gmail.com>
> >> nandsim works as expected. It creates a new and *erased* NAND for you.
> >> So you have no UBI volumes. Therfore UBIFS cannot be mounted.
> >> I suggest creating a tiny initramfs that creates UBI volumes before mo=
unting
> >> UBIFS on
> >> one of the freshly created (and empty) volumes.
> >>
> > oh sorry I forgot to mention this.
> > I am able to create and update volumes manually after booting the
> > system with initramfs.
> > {{{
> > Creating rootfs volume:
> > mknod /dev/ubi0 c 250 0
> > mknod /dev/ubi0_0 c 250 1
> > ubiattach /dev/ubi_ctrl -m 2
> > ubimkvol /dev/ubi0 -N rootfs -m
> > ubiupdatevol /dev/ubi0_0 ubifs-rootfs.img
> > mount -t ubifs ubi0:rootfs ubi-root/
> > }}}
> >
> > But I wanted to do all these automatically during boot time itself.
> > Also I wanted to use ubinize.cfg as is from the original system and
> > simulate everything using qemu and nadsim (if possible)
> > So I thought it must be possible by setting some parameters in qemu suc=
h as:
> > mtdparts=3Dnand:,
> > -device nand,chip_id=3D0x39,drive=3Dmtd0,
> > -drive if=3Dmtd,file=3D./ubi-boot.img,id=3Dmtd0,
> > anything else ?
>
> Well, this has nothing to do with nandsim.
> If qemu can emulate a NAND chip (plus a controller) all you need is a dri=
ver on the Linux side.
Okay let me add qemu guys here.
I am not sure which driver is required from Linux side. I thought it
is nandsim only.
Is it some existing driver, or we need to develop a new driver on our own ?
I think it is not able to find the required driver..
I see in the boot log that it is detecting Toshiba nand driver:
=3D=3D=3D> nand: Toshiba NAND 128MiB 1,8V 8-bit

Also the root volume seems empty.
=3D=3D=3D> ubi0: empty MTD device detected
How to fill the root volume at boot time ?


These are the commands I am using:
$ mkfs.ubifs -r _install -m 512 -e 15872 -c 5000 -o ubifs-rootfs.img
$ ubinize -o ubi-boot.img -m 512 -p 16KiB -s 256 ubiconfig.cfg
$ qemu-system-arm -M vexpress-a9 -m 512M -kernel
linux/arch/arm/boot/zImage -dtb
linux/arch/arm/boot/dts/vexpress-v2p-ca9.dtb -append
"console=3DttyAMA0,115200 ubi.mtd=3D2 root=3D/dev/mtdblock2 rootfstype=3Dub=
ifs
mtdparts=3Dnand:-(rootfs)" -device nand,chip_id=3D0x39,drive=3Dmtd0 -drive
if=3Dmtd,file=3D./ubi-boot.img,id=3Dmtd0 -nographic -smp 4

Any corrections here ?

$ cat ubiconfig.cfg
[rootfs]
mode=3Dubi
image=3D./ubifs-rootfs.img
vol_id=3D0
vol_type=3Ddynamic
vol_name=3Drootfs
vol_alignment=3D1
vol_flags=3Dautoresize


But I am still getting this error:
{{{
List of all partitions:
1f00          131072 mtdblock0
 (driver?)
1f01           32768 mtdblock1
 (driver?)
1f02          131072 mtdblock2
 (driver?)
No filesystem could mount root, tried:
 ubifs
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(3=
1,2)
[...]
}}}

Some log references below:
[....]
Using buffer write method
Concatenating MTD devices:
(0): "40000000.flash"
(1): "40000000.flash"
into device "40000000.flash"
physmap-flash 48000000.psram: physmap platform flash device: [mem
0x48000000-0x49ffffff]
[nandsim] warning: read_byte: unexpected data output cycle, state is
STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is
STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is
STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is
STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is
STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is
STATE_READY return 0x0
nand: device found, Manufacturer ID: 0x98, Chip ID: 0x39
nand: Toshiba NAND 128MiB 1,8V 8-bit
nand: 128 MiB, SLC, erase size: 16 KiB, page size: 512, OOB size: 16
flash size: 128 MiB
page size: 512 bytes
OOB area size: 16 bytes
sector size: 16 KiB
pages number: 262144
pages per sector: 32
bus width: 8
bits in sector size: 14
bits in page size: 9
bits in OOB size: 4
flash size with OOB: 135168 KiB
page address bytes: 4
sector address bytes: 3
options: 0x42
Scanning device for bad blocks
Creating 1 MTD partitions on "NAND 128MiB 1,8V 8-bit":
0x000000000000-0x000008000000 : "NAND simulator partition 0"
[nandsim] warning: CONFIG_MTD_PARTITIONED_MASTER must be enabled to
expose debugfs stuff
[....]
ubi0: attaching mtd2
ubi0: scanning is finished
ubi0: empty MTD device detected
ubi0: attached mtd2 (name "NAND simulator partition 0", size 128 MiB)
ubi0: PEB size: 16384 bytes (16 KiB), LEB size: 15872 bytes
ubi0: min./max. I/O unit sizes: 512/512, sub-page size 256
ubi0: VID header offset: 256 (aligned 256), data offset: 512
ubi0: good PEBs: 8192, bad PEBs: 0, corrupted PEBs: 0
ubi0: user volume: 0, internal volumes: 1, max. volumes count: 92
ubi0: max/mean erase counter: 0/0, WL threshold: 4096, image sequence
number: 2149713893
ubi0: available PEBs: 8028, total reserved PEBs: 164, PEBs reserved
for bad PEB handling: 160
[...]

Thanks,
Pintu
