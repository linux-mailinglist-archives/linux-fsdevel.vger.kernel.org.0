Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A97EE1956
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 13:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391132AbfJWLuG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 07:50:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46748 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733180AbfJWLuG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:50:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id n15so10950157wrw.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 04:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FNXOHOHAscJYBJaLyIPFHrZ5VNTRi8Fq3c4G/x3Je7s=;
        b=NfVTmM1iIDbXkr+6wsKUWEtJ0F9gy6AV8aeojpCDdxqIss+u3Xo6kE5Q65+OvJjcEm
         WhwkgZPlSJpnoZoApFMjdjZzM1YCQ5n3gX4WdT0jYybE26uTesdrJp9PFn7oJyC0FQBm
         Qaeywtiwqxchcd2pHFFmqGlW0ziMbrr233T2tgFxHNWndT8XARxQ5yVirmWZ7rcUEK3T
         WYzFFDg7NFzFSuJUSeUYpZlUjwCALcTStmb/J9U8HNjENPjpGWaF2HrmJK+Cb7hIkapW
         QVvr5LP0jrqgYLA0HlKGqM3vPrpDvviVG7gtQILxx3MgvmGnPrQ48EUeg9znaRW1doOT
         CPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FNXOHOHAscJYBJaLyIPFHrZ5VNTRi8Fq3c4G/x3Je7s=;
        b=DGDjw5UdgUvlUq/5yan1yT+DOaFU5WEK2zSKi0E3hhLsKWOk1YMP/tC+q57bV1unHS
         +ztf6YYYlOMEuMO402zuOvt/WeAT8vrdtLaiY5JoDUy5LqX3dwenLsvgCVWRO9E99FYq
         fDBDu6DPHsMbj+y3Y5lHGSGOh7WX646HyJ2DO9/3wN4sQ5KHoRKGiHfnr3uCh91XhFFI
         VaY6ZrhfCPEM5QswFn3F62qzhyfijVSHm4pd2KCUBXglnRNaXMs5vN/SbXR8k7ikbQIJ
         WlgK5mcRumjrcyA7kupX/MnZSbrtnnOa/wExlusGzIlulaFEnqBeLQl0Lx7BQOIvNeCL
         AEkA==
X-Gm-Message-State: APjAAAUj4wFE1nQfcVkf94/gjq8hDIiH+kSZiqj6PwiSZfaHa888REdI
        X8i++v6nDlBNdj52ccr1Hwo=
X-Google-Smtp-Source: APXvYqzzZDG8CZ6rYNw1+/x3n+klmzIClsgACMfc3KyLpNHdJ7k07vJ3N/QanIyQAXXkyCZ5ENuMWA==
X-Received: by 2002:a5d:49cf:: with SMTP id t15mr7958665wrs.63.1571831403749;
        Wed, 23 Oct 2019 04:50:03 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id y13sm32084177wrg.8.2019.10.23.04.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Oct 2019 04:50:02 -0700 (PDT)
Date:   Wed, 23 Oct 2019 13:50:01 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: Is rename(2) atomic on FAT?
Message-ID: <20191023115001.vp4woh56k33b6hiq@pali>
References: <CAJCQCtQ38W2r7Cuu5ieKRQizeKF0tf--3Z8yOJeeR+ZZ4S6CVQ@mail.gmail.com>
 <CAFLxGvxdPQdzBz1rc3ZC+q1gLNCs9sbn8FOS6G-E1XxXeybyog@mail.gmail.com>
 <20191022105413.pj6i3ydetnfgnkzh@pali>
 <CAJCQCtToPc5sZTzdxjoF305VBzuzAQ6K=RTpDtG6UjgbWp5E8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJCQCtToPc5sZTzdxjoF305VBzuzAQ6K=RTpDtG6UjgbWp5E8g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

On Wednesday 23 October 2019 02:10:50 Chris Murphy wrote:
> a. write bootloader file to a temp location
> b. fsync
> c. mv temp final
> d. fsync
> 
> if the crash happens anywhere from before a. to just after c. the old
> configuration file is still present and old kernel+initramfs are used.
> No problem. If the crash happens well after c. probably the new one is
> in place, for sure after d. it's in place, and the new kernel+
> initramfs are used.

I do not think that kernel guarantee for any filesystem that rename
operation would be atomic on underlying disk storage.

But somebody else should confirm it.

So if kernel crashes in the middle of c or between c and d you need to
repair filesystem externally prior trying to boot from such disk.

> 
> > But looking at vfat source code (file namei_vfat.c), both rename and
> > lookup operation are locked by mutex, so during rename operation there
> > should not be access to read directory and therefore race condition
> > should not be there (which would cause reading inconsistent directory
> > during rename operation).
> >
> > If you want atomic rename of two files independently of filesystem, you
> > can use RENAME_EXCHANGE flag. It exchanges that two specified files
> > atomically, so there would not be that race condition like in rename()
> > that in some period of time both "foo" and "bar" would point to same
> > inode.
> 
> I'm not sure how to test the following: write kernel and initramfs to
> final locations. And bootloader configuration is written to a temp
> path. Then at the decision moment, rename it so that it goes from temp
> path to final path doing at most 1 sector change. 1 512 byte sector
> is a reasonable number to assume can be completely atomic for a
> system. I have no idea if FAT can do such a 'mv' event with only one
> sector change

Theoretically it could be possible to implement it for FAT (with more
restrictions), but I doubt that general purpose implementation of any
filesystem in kernel can do such thing. So no practically.

> >
> >
> > But... if you are asking for consistency and atomicity at filesystem
> > level (e.g. you turn off disk / power supply during rename operation)
> > then this is not atomic and probably it cannot be implemented. When FAT
> > filesystem is mounted (either by Windows or Linux kernel) it is marked
> > by "dirty" flag and later when doing unmount, "dirty" flag is cleared.
> 
> Right. And at least on UEFI and arm boards, it's not the linux kernel
> that needs to read it right after a crash. It's the firmware's FAT
> driver. I have no idea how they react to the dirty flag.

Those bootloader firmwares which just load & run bootloader practically
do not write anything to that FAT filesystem. In most cases their
implementation of FAT is read-only and very stupid. I doubt that there
is check for dirty flag.

I saw lot of commercial devices of different kind which can read & write
(backup) data to (FAT) SD card. And lot of time they were not able to
read FAT filesystem formatted by other tool, only by their (or by
in-device FAT formatted).

So such firmwares can be full of bugs and it really is not a good idea
to try booting bootloader from inconsistent FAT filesystem.

> Most distros
> set /etc/fstab FS_PASSNO to 2, maybe it should be a 1, but in any case
> if we boot something far enough along to get to user space fsck, the
> dirty flag is cleaned up.

fs_passno set to 2 should be fine. You need to set it to 1 only for root
device, on which is running linux system. All other disks which are not
needed for running linux system can have fs_passno set to 2.

> > This is there to ensure that operations like rename were finished and
> > were not stopped/killed in between. So future when you read from FAT
> > filesystem you would know if it is in consistent state or not.
> 
> GRUB has an option to blindly overwrite the 1024 byte contents of
> grubenv (no file system modification), that's pretty close to atomic.
> Most devices have physical sector bigger than 512 bytes. This write is
> done in the pre-boot environment for saving state like boot counts.

This depends on grub's FAT implementation. As said I would be very
careful about such "atomic" writes. There are also some caches, include
hardware on-disk, etc...

> And add to the mix that I guess some UEFI firmware allow writing to
> FAT in the pre-boot environment?

Yes, UEFI API allows you to write to disk devices. And UEFI fileystem
implementation can also supports writing to FAT fs.

> I don't know if that's universally true. How do firmware handle a dirty bit being set?

Bad implementation would ignore it. This is something which you should
expect.

> It's bad if the
> firmware writes to such a file system anyway. But also bad if it can't
> save state, now it's not possible to save boot attempts for fallback
> purposes.

The best is to always have fragile filesystem in consistent state. And
if it goes broken, repair it on external system prior trying to write to
it by some untrusted/broken/bad filesystem driver. This would prevent
data damage.

-- 
Pali Rohár
pali.rohar@gmail.com
