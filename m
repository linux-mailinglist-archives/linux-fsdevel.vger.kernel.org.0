Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94B4BE1E00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 16:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389394AbfJWOVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 10:21:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34011 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfJWOVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 10:21:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id v3so6449278wmh.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 07:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ODpoyHBs/388aPBDSjJFh617nubfZ3doqOO+IrHrAs4=;
        b=MqWFfUQbQh5fMEhG7UyxtoUY6hIzKvZMk0TlOpJMvy8cCDxiATzgq0feQrrztueFEr
         p/RHBvzanXvHZxaSFE75DptUayx8unclNzx78SNW0YB65c+iMxaPs4TR4BMBGRXEfkJa
         XDIr0O99F8UwylXm46GKK3dmuGVRT6UjJyhayaorLN5H/RZoQWBZmir9tNFSHxc6eWdc
         Oq3wZK2koI2SHoqonCZ0dLOCk2yg+2G9HkB7ES5oWtbZDcvFDLgN4B2GTklZPrlW/UIO
         xd6WtOCTDrILfGsuXRPTKoryRUh5RbrfYGudV7JaSNk6luQXH7pOp5jutJLOlywu+AxB
         b2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ODpoyHBs/388aPBDSjJFh617nubfZ3doqOO+IrHrAs4=;
        b=NlfMk2L0Lz/TV5K8UO6vP63dSFgxYlII/WllTU+x66lxtdFZ91MAmNJ2wE+IFR3Obn
         Zh33hlEQbTRHMncwEZqHmOolX65lkaJBd+xVE6/yIAj6CMu5mDeDnNaJIfWRpJ8u+5uY
         YEWVB68kNH2lk72k570lhrIehHUL1zOePfV3VHgFXXT3MXS1dcgY7DYm6l7gXlBDCtVh
         Z9spnmsRHZlYaQkZU73LlnL5u/VR8CCgD6w6bs0wftS4oxL8IdF7MTFPDAEOVyMd7lye
         LuGip3DHhJ43p7RvWFg7+F+AUcopWAjx4MkVS/uOgH8vIBgOTqUpIuFJpTnD/n7qteJz
         /+Og==
X-Gm-Message-State: APjAAAVAbFEiO0nz8mCnI5X+S7caDt1miiyQYJyqys4jul8f4/cqciJQ
        lmRPlQmSUf4bnwJ5cxiawFXIv2atNzo9ZzLWrVJNXg==
X-Google-Smtp-Source: APXvYqx7RDEO9yzxX4F3hbLuBUZIFP8dvjuJQ1+arAHTI/NhCca4oZb8BSEVvJXM9hS6igkkGytAf09+aykdP9klbtc=
X-Received: by 2002:a7b:cbc5:: with SMTP id n5mr135444wmi.65.1571840499083;
 Wed, 23 Oct 2019 07:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQ38W2r7Cuu5ieKRQizeKF0tf--3Z8yOJeeR+ZZ4S6CVQ@mail.gmail.com>
 <CAFLxGvxdPQdzBz1rc3ZC+q1gLNCs9sbn8FOS6G-E1XxXeybyog@mail.gmail.com>
 <20191022105413.pj6i3ydetnfgnkzh@pali> <CAJCQCtToPc5sZTzdxjoF305VBzuzAQ6K=RTpDtG6UjgbWp5E8g@mail.gmail.com>
 <20191023115001.vp4woh56k33b6hiq@pali>
In-Reply-To: <20191023115001.vp4woh56k33b6hiq@pali>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 23 Oct 2019 16:21:19 +0200
Message-ID: <CAJCQCtTZRoDKWj2j6S+_iWJzA+rejZx41zwM=VKgG90fyZhX6w@mail.gmail.com>
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

On Wed, Oct 23, 2019 at 1:50 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> Hi!
>
> On Wednesday 23 October 2019 02:10:50 Chris Murphy wrote:
> > a. write bootloader file to a temp location
> > b. fsync
> > c. mv temp final
> > d. fsync
> >
> > if the crash happens anywhere from before a. to just after c. the old
> > configuration file is still present and old kernel+initramfs are used.
> > No problem. If the crash happens well after c. probably the new one is
> > in place, for sure after d. it's in place, and the new kernel+
> > initramfs are used.
>
> I do not think that kernel guarantee for any filesystem that rename
> operation would be atomic on underlying disk storage.
>
> But somebody else should confirm it.

I don't know either or how to confirm it. But, being ignorant about a
great many things, my instinct is literal fsync (flush buffer to disk)
should go away at the application level, and fsync should only be used
to indicate write order and what is part of a "commit" that is to be
atomic (completely succeeds or fails). And of course that can only be
guaranteed as far as the kernel is concerned, it doesn't guarantee
anything about how the hardware block device actually behaves (warts
bugs and all).

Anyway it made me think of this:
https://lwn.net/Articles/789600/


> So if kernel crashes in the middle of c or between c and d you need to
> repair filesystem externally prior trying to boot from such disk.

Nice in theory, but in practice the user simply reboots, and screams
WTF outloud if the system face plants. And people wonder why things
are still broken 20 years later with all the same kinds of problems
and prescriptions to boot off some rescue media instead of it being
fail safe by design. It's definitely not fail safe to have a kernel
update that could possibly result in an unbootable system. I can't
think of any ordinary server, cloud, desktop, mobile user who wants to
have to boot from rescue media to do a simple repair. Of course they
all just want to reboot and have the right thing always happen no
matter what, otherwise they get so nervous about doing updates that
they postpone them longer than they should.

> > I'm not sure how to test the following: write kernel and initramfs to
> > final locations. And bootloader configuration is written to a temp
> > path. Then at the decision moment, rename it so that it goes from temp
> > path to final path doing at most 1 sector change. 1 512 byte sector
> > is a reasonable number to assume can be completely atomic for a
> > system. I have no idea if FAT can do such a 'mv' event with only one
> > sector change
>
> Theoretically it could be possible to implement it for FAT (with more
> restrictions), but I doubt that general purpose implementation of any
> filesystem in kernel can do such thing. So no practically.

Now I'm wondering what the UEFI spec says about this, and whether this
problem was anticipated, and how surprised I should be if it wasn't
anticipated.


>
> > >
> > >
> > > But... if you are asking for consistency and atomicity at filesystem
> > > level (e.g. you turn off disk / power supply during rename operation)
> > > then this is not atomic and probably it cannot be implemented. When F=
AT
> > > filesystem is mounted (either by Windows or Linux kernel) it is marke=
d
> > > by "dirty" flag and later when doing unmount, "dirty" flag is cleared=
.
> >
> > Right. And at least on UEFI and arm boards, it's not the linux kernel
> > that needs to read it right after a crash. It's the firmware's FAT
> > driver. I have no idea how they react to the dirty flag.
>
> Those bootloader firmwares which just load & run bootloader practically
> do not write anything to that FAT filesystem. In most cases their
> implementation of FAT is read-only and very stupid. I doubt that there
> is check for dirty flag.
>
> I saw lot of commercial devices of different kind which can read & write
> (backup) data to (FAT) SD card. And lot of time they were not able to
> read FAT filesystem formatted by other tool, only by their (or by
> in-device FAT formatted).
>
> So such firmwares can be full of bugs and it really is not a good idea
> to try booting bootloader from inconsistent FAT filesystem.

Right. I've had quite a bit of experience with this too, but lately I
think my experience is actually chock full of noisy data and what I
thought I was seeing, might not actually be what I was seeing.

Since ancient times in digital photography and video, it's been
considered widely that the camera firmware's FAT driver is crap, and
often corrupts the flash media, in particular when doing things like
individual image file deletes, or exchanging cards between unlike
cameras (make or model). As it turns out, this narrative is mostly
pushed by the flash media vendors.

Fast forward to the advent of cheap ARM boards and even Intel NUC type
computers, and people experiencing various kinds of corruption with
consumer name brand SD cards. The more generic, the more likely the
card goes suddenly read only forever. But even the name brand cards
I've used in an Intel NUC have had this happen, being replaced without
complaint by the manufacturer under warranty, yet it still keeps on
happening. Then found HN threads about this and people saying, yeah
you have to use industrial flash cards for this purpose, totally
solves the problem. And voila, there's enough anecdotal data out there
that really it's consumer flash being super sensitive to power cuts.

It may in fact have never had a thing to do with crap file system drivers.


> > GRUB has an option to blindly overwrite the 1024 byte contents of
> > grubenv (no file system modification), that's pretty close to atomic.
> > Most devices have physical sector bigger than 512 bytes. This write is
> > done in the pre-boot environment for saving state like boot counts.
>
> This depends on grub's FAT implementation. As said I would be very
> careful about such "atomic" writes. There are also some caches, include
> hardware on-disk, etc...

GRUB doesn't use any file system driver for writes, ever. It uses a
file system driver only to find out what two LBAs the "grubenv"
occupies, and then blindly overwrites those two sectors to save state.
There is no file system metadata update at all.


>
> > And add to the mix that I guess some UEFI firmware allow writing to
> > FAT in the pre-boot environment?
>
> Yes, UEFI API allows you to write to disk devices. And UEFI fileystem
> implementation can also supports writing to FAT fs.
>
> > I don't know if that's universally true. How do firmware handle a dirty=
 bit being set?
>
> Bad implementation would ignore it. This is something which you should
> expect.

Maybe a project for someone is to bake xfstests into an EFI program so
we can start testing these firmware FAT drivers and see what we learn
about how bad they are?

--=20
Chris Murphy
