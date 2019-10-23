Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B43CE2338
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 21:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390002AbfJWTSs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 15:18:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50426 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732232AbfJWTSr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 15:18:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id q13so161124wmj.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 12:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=snIXD5c8KCf1cfKQ/WwlBDuuF54wgIOxLoQeyjusNg4=;
        b=QcB2CjQkXdXGJaJRF8yoOOMkXeh5XR6xEeqB4Zg2EI+VtbTFPZrh/FW2zOHy43/qsC
         0HM0OaaaiTeE2RdrOU8OMpzG9VfNuppeUZrXdv59BgqfIi0T8LiAQL84jyTJkR9DdUGY
         tEHE6efJ1b7d89nf15a7cTlkckw3i7fO6tzjE4SXbk35L/vhaniJa8MdGjmtNHl7cBNc
         nvdNPVacls5XFX1dks/1QZV7EcgdXsvtu+6+5w3B5AIJPQjVuestCeb5bH9+V9t46n3+
         /qVgwtjxU2uLIREDG6mgquBvLI9IWYmbN+ZhBfA3gaMU/np0qWOQHRPUcREjLzOxYF37
         fybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=snIXD5c8KCf1cfKQ/WwlBDuuF54wgIOxLoQeyjusNg4=;
        b=aZwfGtb+oIdqt5QwggQ7s4gX91gXdWSFss4zlhA+1Mv+HExwSSIRVUBfbjEWdmIWLF
         G7ETZXBSGFC0HrANnvGPMOhFNq1yu0xuzoS8ZNiqcRIrieRIpOacDoMkZJeaxH8tfCNU
         qNE4/f7NnuxW2sBcdYH5l7fxWlCwRH3Kk7IuvXowd+2LwmXHZiIDYqzzPdJcx+ISeUm3
         wqDoCYSbaUcymeUroclLRsBMxW09eg/B3918sew+NEYP6BI74scoMEh+iPiW4B/ZB/x/
         lib+PP3vbzCtNt1J6NbeE1rrNKmkPNAMMo80TopY3qvgPkk0sUsDGioXiEzX11f4sVYr
         vgfg==
X-Gm-Message-State: APjAAAUZIQsB7DpXo9aBcMsMrwRTJzfPPPuB/mbXWGbclHCDsz5/EiAv
        Mz20y1dOf6F7H07FZJdOFt7jfZ7vyfLFozZIUvirNA==
X-Google-Smtp-Source: APXvYqx7lIQSm1CcxeZQb1fTNcMLnJhhhv7jN30wlP+OORvAoj6hyL6Y+i21jx9OAD2AN+7FDCNqLhUEy1+ikj52JBc=
X-Received: by 2002:a05:600c:34b:: with SMTP id u11mr1346962wmd.176.1571858325163;
 Wed, 23 Oct 2019 12:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQ38W2r7Cuu5ieKRQizeKF0tf--3Z8yOJeeR+ZZ4S6CVQ@mail.gmail.com>
 <CAFLxGvxdPQdzBz1rc3ZC+q1gLNCs9sbn8FOS6G-E1XxXeybyog@mail.gmail.com>
 <20191022105413.pj6i3ydetnfgnkzh@pali> <CAJCQCtToPc5sZTzdxjoF305VBzuzAQ6K=RTpDtG6UjgbWp5E8g@mail.gmail.com>
 <20191023115001.vp4woh56k33b6hiq@pali> <CAJCQCtTZRoDKWj2j6S+_iWJzA+rejZx41zwM=VKgG90fyZhX6w@mail.gmail.com>
 <20191023171611.qfcwfce2roe3k3qw@pali>
In-Reply-To: <20191023171611.qfcwfce2roe3k3qw@pali>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 23 Oct 2019 21:18:25 +0200
Message-ID: <CAJCQCtRehgz2ULj+qpfGaQ8Uq7huemd_RMG+4EiYggo=zoY64A@mail.gmail.com>
Subject: Re: Is rename(2) atomic on FAT?
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 23, 2019 at 7:16 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
> On Wednesday 23 October 2019 16:21:19 Chris Murphy wrote:

> > I don't know either or how to confirm it.
>
> Somebody who is watching linuxfs-devel and has deep knowledge in this
> area... could provide more information.

Maybe dm-log-writes can do this? Just log all the writes, and
hopefully it's straightforward to match the 'mv' rename command with
the resulting writes.


> > Nice in theory, but in practice the user simply reboots, and screams
> > WTF outloud if the system face plants. And people wonder why things
> > are still broken 20 years later with all the same kinds of problems
> > and prescriptions to boot off some rescue media instead of it being
> > fail safe by design. It's definitely not fail safe to have a kernel
> > update that could possibly result in an unbootable system. I can't
> > think of any ordinary server, cloud, desktop, mobile user who wants to
> > have to boot from rescue media to do a simple repair. Of course they
> > all just want to reboot and have the right thing always happen no
> > matter what, otherwise they get so nervous about doing updates that
> > they postpone them longer than they should.
>
> Still, in any time when you improperly unmount filesystem you should
> check for error, if you do not want to loose your data.

Perhaps, but it's archaic. The user usually has no idea what went
wrong, and all kinds of factors strongly disincentivize doing an
offline fsck, and incentivize just rebooting and seeing what happens.
If they get past the bootloader, systemd/init is going to run an fsck
on all volumes that need it or kernel code does log replay to make
them up to date.

> And critical area should have some "recovery" mechanism to repair broken
> bootloader / kernel image.
>
> Anyway, chance that kernel crashes at step when replacing old kernel
> disk image by new one is low. So it should not be such big issue to need
> to do external recovery.

'strace -D -ff -o' on grub2-mkconfig causes over 1800 PID files to be
generated. Filtering for lines containing grub.cfg...

# grep grub.cfg *
grub.12167:execve("/usr/sbin/grub2-mkconfig", ["grub2-mkconfig", "-o",
"/boot/efi/EFI/fedora/grub.cfg"], 0x7ffc68054470 /* 24 vars */) =3D 0
grub.12167:read(3, "/boot/efi/EFI/fedora/grub.cfg\n", 128) =3D 30
grub.12167:openat(AT_FDCWD, "/boot/efi/EFI/fedora/grub.cfg.new",
O_WRONLY|O_CREAT|O_TRUNC, 0666) =3D 3
grub.12167:read(255, "\nif test \"x${grub_cfg}\" !=3D \"x\" ;"..., 8192) =
=3D 567
grub.12174:write(1, "/boot/efi/EFI/fedora/grub.cfg\n", 30) =3D 30
grub.12349:execve("/usr/bin/rm", ["rm", "-f",
"/boot/efi/EFI/fedora/grub.cfg.ne"...], 0x55c599fde980 /* 48 vars */)
=3D 0
grub.12349:newfstatat(AT_FDCWD, "/boot/efi/EFI/fedora/grub.cfg.new",
0x556be17d9758, AT_SYMLINK_NOFOLLOW) =3D -1 ENOENT (No such file or
directory)
grub.12349:unlinkat(AT_FDCWD, "/boot/efi/EFI/fedora/grub.cfg.new", 0)
=3D -1 ENOENT (No such file or directory)
grub.14064:execve("/usr/bin/grub2-script-check",
["/usr/bin/grub2-script-check",
"/boot/efi/EFI/fedora/grub.cfg.ne"...], 0x55c599fde980 /* 48 vars */)
=3D 0
grub.14064:openat(AT_FDCWD, "/boot/efi/EFI/fedora/grub.cfg.new", O_RDONLY) =
=3D 3
grub.14065:openat(AT_FDCWD, "/boot/efi/EFI/fedora/grub.cfg",
O_WRONLY|O_CREAT|O_TRUNC, 0666) =3D 3
grub.14065:execve("/usr/bin/cat", ["cat",
"/boot/efi/EFI/fedora/grub.cfg.ne"...], 0x55c599fde980 /* 48 vars */)
=3D 0
grub.14065:openat(AT_FDCWD, "/boot/efi/EFI/fedora/grub.cfg.new", O_RDONLY) =
=3D 3
grub.14066:execve("/usr/bin/rm", ["rm", "-f",
"/boot/efi/EFI/fedora/grub.cfg.ne"...], 0x55c599fde980 /* 48 vars */)
=3D 0
grub.14066:newfstatat(AT_FDCWD, "/boot/efi/EFI/fedora/grub.cfg.new",
{st_mode=3DS_IFREG|0700, st_size=3D6080, ...}, AT_SYMLINK_NOFOLLOW) =3D 0
grub.14066:unlinkat(AT_FDCWD, "/boot/efi/EFI/fedora/grub.cfg.new", 0) =3D 0

I'm not able to parse this. My best guess is it's writing out an all
new file, grub.cfg.new, and then doesn't rename it. Instead it uses
cat to copy the contents of the new file and overwrites the old one?
Yeah, the inode stays the same, as does access time. Is this fragile?

Android and ChromeOS and some others, have A and B kernel partitions
which are just blobs. They use some other form of hint to indicate
which partition is actually used at one time, meaning they can
reliably ensure a failsafe update of the other partition, and sanity
testing it, before committing the switch. Crude but effective.

Apple goes so far as to get all of their product firmware the ability
to natively read APFS, which contains the kernel and early boot files.

I have no idea how Windows does kernel or bootloader updates, except
they don't keep the EFI system partition persistently mounted all day
long, like virtually all Linux distributions today, at /boot/efi -
that does seem guaranteed to result in many dirty flag FAT file system
cleanups. I know I've seen such fix ups in my journal files.




> > > > I'm not sure how to test the following: write kernel and initramfs =
to
> > > > final locations. And bootloader configuration is written to a temp
> > > > path. Then at the decision moment, rename it so that it goes from t=
emp
> > > > path to final path doing at most 1 sector change. 1 512 byte sector
> > > > is a reasonable number to assume can be completely atomic for a
> > > > system. I have no idea if FAT can do such a 'mv' event with only on=
e
> > > > sector change
> > >
> > > Theoretically it could be possible to implement it for FAT (with more
> > > restrictions), but I doubt that general purpose implementation of any
> > > filesystem in kernel can do such thing. So no practically.
> >
> > Now I'm wondering what the UEFI spec says about this, and whether this
> > problem was anticipated, and how surprised I should be if it wasn't
> > anticipated.
>
> I know that UEFI spec has reference for FAT filesystems to MS
> specification (fagen103.doc). I do not know if it says anything about
> filesystem details, but I guess it specify requirements, that
> implementations must be compatible with FAT12, FAT16 and FAT32 according
> to specification.

My understanding of the UEFI spec is the file system is called the
'EFI file system' and was intended to be predicated on FAT12, FAT16,
FAT32 at a specific moment in time, bugs and warts and all. By now
probably around 20 years ago. And then not ever changed. In practice
it seems there is no such separate thing as the EFI file system. No
separate mkfs flag, or mount options, to make sure this is *the*
canonical EFI file system, rather than just today's latest bug fixed
and feature enhanced FAT file system as supported by Linux.

So god only knows what bugs might arise from that discrepancy one day.

> Also UEFI allows you to write our own UEFI filesystem drivers which
> other UEFI programs and bootloaders can use.

I'm not finding it this second but someone basically did this work
already, but wrapping existing GRUB file system modules into EFI file
system drivers.

OK so plausibly on UEFI, it could be handed a better FAT driver very
soon after POST to avoid firmware FAT bugs. Or for that matter, create
"A" and "B" EFI system partitions, containing identical static boot
data, that merely points to a purpose built $BOOT volume that can host
early boot files and supports atomic updates. That'd be clever, but
also not generic. It's UEFI specific.

It'd be neat to have a superset implementation that can work anywhere.
But then allow for optimizations. But the problem with the generic
solution? Who will follow it? The Bootloaderspec pretty much fell on
deaf ears. The GRUB folks don't care to upstream it, nor sysliux, nor
uboot near as I can tell. Simple 1 page spec. Fedora's GRUB carries
patches for it, and now uses them by default. Son hilariously Fedora
is maybe the first distribution to actively support three
substantially different bootloader update mechanisms: grub-mkconfig,
grubby, and bootloaderspec.

--=20
Chris Murphy
