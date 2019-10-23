Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA4F6E0EF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 02:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731712AbfJWALO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 20:11:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34536 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfJWALO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 20:11:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so14835533wrr.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2019 17:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rG4UrJSZZMZcs3+1+eRn5C1fhlHYzv3yeSpDmzRMqss=;
        b=lugq72yllaMSnDz193BsQFsTZA04OFtRGgD8YV8hFjrQ5lAdbYlzlNf6rtKLD/NgHo
         kml22MzvseyV6d7YLsdemQ7JdevnHARtvn3zAa4M7ZVj+FtAFyr9tLeizkyr5km+Bl0/
         LjhdHsOVDBkxbZCphlS2rLaaDV0pzXtsyOkybOODYw52v9eSy31erXyA1LBoXoWCzyoi
         rNxDzjiLgZ+BflGGRAZIGUFVUequblwD4Mv29YCEpxmmGw+Am/IwiR971+BNY9wI3ICz
         F+W6dWkfjJkQBi6X90Ru2qd3O7Mtuq5LiaNnlWO+x9qtFciKGvCrqff77w3T1/WTM5Fy
         jscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rG4UrJSZZMZcs3+1+eRn5C1fhlHYzv3yeSpDmzRMqss=;
        b=d+ezoInouZ1xYazG3T0MTkhxapUsA14NbpAxndGXMrb/jmU05K8lCMjIRP7oYjPAI/
         xiq4AUuru09oTc22+kE/MtQgGoOhVt5xWlvEsg/WSnjumhahrt+AhEumaHzbsEQMmnRb
         DkqJFxbs4CRZZVqcTnqNmheXXmYbwPbP7eT3ZkXT9Yl3jmAIUI8QxCj5RJPl2LnVvbp5
         ys5BDa7nt7wlbbYmfzRbdUHak7MQi/X5CMo/dCUfAij3CnEMS98uof5LVBGXFsweTgAF
         NCBMer6V0UiCnL6OghlS3Behw8CulyyfAAf1vGJe2yCYs7sblNzHf2jmI4hQxGjMt30b
         e2AA==
X-Gm-Message-State: APjAAAXE7TrTKP7Y/e66eU53gh8L8nre6KHQvYekp/aTT1LpUrPM3STL
        n12ytPCcs/Za+uAHmntj/zKadUiYEaYtSlSfzSuncw==
X-Google-Smtp-Source: APXvYqwF1Pb0eJceYgEKe3A/j0Bsh8zBK/47oRCzSZeuZR4zwy2vp2Auxd5h1dF+GSx74adQDm7DyOC9l+ae3Kwt1HM=
X-Received: by 2002:a5d:6246:: with SMTP id m6mr5899143wrv.262.1571789470190;
 Tue, 22 Oct 2019 17:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQ38W2r7Cuu5ieKRQizeKF0tf--3Z8yOJeeR+ZZ4S6CVQ@mail.gmail.com>
 <CAFLxGvxdPQdzBz1rc3ZC+q1gLNCs9sbn8FOS6G-E1XxXeybyog@mail.gmail.com> <20191022105413.pj6i3ydetnfgnkzh@pali>
In-Reply-To: <20191022105413.pj6i3ydetnfgnkzh@pali>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 23 Oct 2019 02:10:50 +0200
Message-ID: <CAJCQCtToPc5sZTzdxjoF305VBzuzAQ6K=RTpDtG6UjgbWp5E8g@mail.gmail.com>
Subject: Re: Is rename(2) atomic on FAT?
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        Chris Murphy <lists@colorremedies.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 22, 2019 at 12:54 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
>
> Hi Chris!
>
> The first question is what do you mean by "atomic". Either if is
> "atomic" at process level, that any process which access filesystem see
> consistent data at any time, or if by atomic you mean consistency of
> filesystem on underlying block device itself, or you mean atomicity at
> disk storage level.

Yeah, good question. It's a bit more complicated in reality, because
distros do things differently.

In the case of making kernel updates "atomic", it's to ensure only one
of two things happens: the old boot works or the new boot works. No
matter what, including a crash or power fail at any point during the
update. Possibly three or more files make up a "boot": kernel,
initramfs (could be more than one), and bootloader configuration. In
theory, the new kernel is written first, initramfs second, and only
once they are on stable media is the bootloader configuration file
modified, replaced, or newly written.

In the case of one kernel and initramfs, I'd have to believe no one is
doing a literal overwrite of those files (same inode). If there's a
crash or power fail, that kind of update almost certainly means an
unbootable system due to partial write of kernel or initramfs. So the
best practice for single kernel updating should be write out all new
files for kernel + initramfs, fsync, write out bootloader change to a
new file, fsync, then rename, fsync. (?)

For multiple kernels,  it doesn't matter if a crash happens anywhere
from new kernel being written to FAT, through initramfs, because the
old bootloader configuration still points to old kernel + initramfs.
But in multiple kernel distros, the bootloader configuration needs
modification or a new drop in scriptlet to point to the new
kernel+initramfs pair. And that needs to be completely atomic: write
new files to a tmp location, that way a crash won't matter. The tricky
part is to write out the bootloader configuration change such that it
can be an atomic operation.

a. write bootloader file to a temp location
b. fsync
c. mv temp final
d. fsync

if the crash happens anywhere from before a. to just after c. the old
configuration file is still present and old kernel+initramfs are used.
No problem. If the crash happens well after c. probably the new one is
in place, for sure after d. it's in place, and the new kernel+
initramfs are used.



> > According of my understanding of FAT rename() is not atomic at all.
> > It can downgrade to a hardlink. i.e. rename("foo", "bar") can result in=
 having
> > both "foo" and "bar."
> > ...or worse.
>
> Generally rename() may really cause that at some period of time both
> "foo" and "bar" may points to same inode. (But is this a really problem
> for your scenario?)

Probably not. Either the old boot works or the new boot works.

There is a goofy thing that can happen on journaled file systems, were
file (kernel, initramfs, journalcdt) journal is updated but not normal
file system metadata, then a crash happens. In that case the
bootloader file system code can't do journal replay, and might fail to
find either old or new file intact.



>
> But looking at vfat source code (file namei_vfat.c), both rename and
> lookup operation are locked by mutex, so during rename operation there
> should not be access to read directory and therefore race condition
> should not be there (which would cause reading inconsistent directory
> during rename operation).
>
> If you want atomic rename of two files independently of filesystem, you
> can use RENAME_EXCHANGE flag. It exchanges that two specified files
> atomically, so there would not be that race condition like in rename()
> that in some period of time both "foo" and "bar" would point to same
> inode.

I'm not sure how to test the following: write kernel and initramfs to
final locations. And bootloader configuration is written to a temp
path. Then at the decision moment, rename it so that it goes from temp
path to final path doing at most 1 sector change. 1 512 byte sector
is a reasonable number to assume can be completely atomic for a
system. I have no idea if FAT can do such a 'mv' event with only one
sector change



>
>
> But... if you are asking for consistency and atomicity at filesystem
> level (e.g. you turn off disk / power supply during rename operation)
> then this is not atomic and probably it cannot be implemented. When FAT
> filesystem is mounted (either by Windows or Linux kernel) it is marked
> by "dirty" flag and later when doing unmount, "dirty" flag is cleared.

Right. And at least on UEFI and arm boards, it's not the linux kernel
that needs to read it right after a crash. It's the firmware's FAT
driver. I have no idea how they react to the dirty flag. Most distros
set /etc/fstab FS_PASSNO to 2, maybe it should be a 1, but in any case
if we boot something far enough along to get to user space fsck, the
dirty flag is cleaned up.

>
> This is there to ensure that operations like rename were finished and
> were not stopped/killed in between. So future when you read from FAT
> filesystem you would know if it is in consistent state or not.

GRUB has an option to blindly overwrite the 1024 byte contents of
grubenv (no file system modification), that's pretty close to atomic.
Most devices have physical sector bigger than 512 bytes. This write is
done in the pre-boot environment for saving state like boot counts.

And add to the mix that I guess some UEFI firmware allow writing to
FAT in the pre-boot environment? I don't know if that's universally
true. How do firmware handle a dirty bit being set? It's bad if the
firmware writes to such a file system anyway. But also bad if it can't
save state, now it's not possible to save boot attempts for fallback
purposes.


--
Chris Murphy
