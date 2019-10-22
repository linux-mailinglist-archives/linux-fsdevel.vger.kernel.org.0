Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA4BE0263
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 12:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbfJVKyT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 06:54:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52038 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbfJVKyT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 06:54:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id q70so9512936wme.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2019 03:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=W1aOYye0ojBwe8njCL8LfIlI8/AqUN+27yIRkfjj9xg=;
        b=sGIQAwDh5BHY1SRzapG7NUU5apoE53adcntV7VfT2Z/5WBEno58LSwTiky5pOOhHbD
         s3HbBrCHnKLaXqQotBhPMX77ohQTAYMEHqmOCBsLpgVjwudQvmvo7UgI8KHHC2c3dF20
         VBR7xznoaK86WASVGhKnJ3lWo50jUUHw7ZoyIMplh4/CmjXoC2RlS3aj15/Xq6+1nWO2
         +zgQQyPFEn4CNDkFyAOFup9BxtmTt9GhmIN3+Vgf6/FdB0AZT3SOLjzByJALt3Qyyawv
         niO7Ea+1wI7fq6Djbquiros3dbX+mnUiE56anrDWRPkM4Me7eb4DgfCOwBccLw0TYFK2
         qcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=W1aOYye0ojBwe8njCL8LfIlI8/AqUN+27yIRkfjj9xg=;
        b=UVkghoRVtbdSfM1Z77Bwonaf2d27ARTnJ2RboR0MJsH1S5JXWm26Xo/2QCdiIQsO+K
         GOLPlEYD6Csv5i9kdS4n8ZM5RaC5bZ5IsEkEMweTr05TNU+KbS5/INIrtZ44T0kO+Iy4
         cRPb4SY5zP9RXNMqr6EJkrauFvAYf6528ZDsJPzquVwMWgi/joKQzSov94ZkpgfYrCnR
         Y0/o7WC277RlkOjoVnfDkn0EoSP7Pu79Ngf0hNN+7s6wDalv5Qmy3diiSZegLKxNK3nt
         rp2HEx6+waVoiCTYoe4M5rdj8JF1CsW2ZvMS231ZzbGdOaJLcCnay17vbtChkWQe/3mv
         /z4w==
X-Gm-Message-State: APjAAAWhaq92AqF8IFHtxlCwklz46hy8hoYIHzVvs1IbCBcC6ZuyEywB
        vA99HFdeVOTZSzqzGY9kuXA=
X-Google-Smtp-Source: APXvYqzzmd7ooStIUJG2OdWIuzRJjZWPHG6sGclsdx6F8DbhqegJr8Gzkz/8E4wwvQDP3OF2EAIpQQ==
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr2449230wme.53.1571741656079;
        Tue, 22 Oct 2019 03:54:16 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id n187sm14909953wmb.47.2019.10.22.03.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Oct 2019 03:54:14 -0700 (PDT)
Date:   Tue, 22 Oct 2019 12:54:13 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: Is rename(2) atomic on FAT?
Message-ID: <20191022105413.pj6i3ydetnfgnkzh@pali>
References: <CAJCQCtQ38W2r7Cuu5ieKRQizeKF0tf--3Z8yOJeeR+ZZ4S6CVQ@mail.gmail.com>
 <CAFLxGvxdPQdzBz1rc3ZC+q1gLNCs9sbn8FOS6G-E1XxXeybyog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLxGvxdPQdzBz1rc3ZC+q1gLNCs9sbn8FOS6G-E1XxXeybyog@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Chris!

The first question is what do you mean by "atomic". Either if is
"atomic" at process level, that any process which access filesystem see
consistent data at any time, or if by atomic you mean consistency of
filesystem on underlying block device itself, or you mean atomicity at
disk storage level.

On Monday 21 October 2019 23:44:25 Richard Weinberger wrote:
> Chris,
> 
> [CC'ing fsdevel and Pali]
> 
> On Mon, Oct 21, 2019 at 9:59 PM Chris Murphy <lists@colorremedies.com> wrote:
> >
> > http://man7.org/linux/man-pages/man2/rename.2.html
> >
> > Use case is atomically updating bootloader configuration on EFI System
> > partitions. Some bootloader implementations have configuration files
> > bigger than 512 bytes, which could possibly be torn on write. But I'm
> > also not sure what write order FAT uses.
> >
> > 1.
> > FAT32 file system is mounted at /boot/efi
> >
> > 2.
> > # echo "hello" > /boot/efi/tmp/test.txt
> > # mv /boot/efi/tmp/test.txt /boot/efi/EFI/fedora/
> >
> > 3.
> > When I strace the above mv command I get these lines:
> > ioctl(0, TCGETS, {B38400 opost isig icanon echo ...}) = 0
> > renameat2(AT_FDCWD, "/boot/efi/tmp/test.txt", AT_FDCWD,
> > "/boot/efi/EFI/fedora/", RENAME_NOREPLACE) = -1 EEXIST (File exists)
> > stat("/boot/efi/EFI/fedora/", {st_mode=S_IFDIR|0700, st_size=1024, ...}) = 0
> > renameat2(AT_FDCWD, "/boot/efi/tmp/test.txt", AT_FDCWD,
> > "/boot/efi/EFI/fedora/test.txt", RENAME_NOREPLACE) = 0
> > lseek(0, 0, SEEK_CUR)                   = -1 ESPIPE (Illegal seek)
> > close(0)
> >
> > I can't tell from documentation if renameat2() with flag
> > RENAME_NOREPLACE is atomic, assuming the file doesn't exist at
> > destination.

RENAME_NOREPLACE is atomic at VFS level, independently of used
filesystem. There is no race condition when multiple processes access
that directory at same time.

> > 4.
> > Do it again exactly as before, small change
> > # echo "hello" > /boot/efi/tmp/test.txt
> > # mv /boot/efi/tmp/test.txt /boot/efi/EFI/fedora/
> >
> > 5.
> > The strace shows fallback to rename()
> >
> > ioctl(0, TCGETS, {B38400 opost isig icanon echo ...}) = 0
> > renameat2(AT_FDCWD, "/boot/efi/tmp/test.txt", AT_FDCWD,
> > "/boot/efi/EFI/fedora/", RENAME_NOREPLACE) = -1 EEXIST (File exists)
> > stat("/boot/efi/EFI/fedora/", {st_mode=S_IFDIR|0700, st_size=1024, ...}) = 0
> > renameat2(AT_FDCWD, "/boot/efi/tmp/test.txt", AT_FDCWD,
> > "/boot/efi/EFI/fedora/test.txt", RENAME_NOREPLACE) = -1 EEXIST (File
> > exists)
> > lstat("/boot/efi/tmp/test.txt", {st_mode=S_IFREG|0700, st_size=7, ...}) = 0
> > newfstatat(AT_FDCWD, "/boot/efi/EFI/fedora/test.txt",
> > {st_mode=S_IFREG|0700, st_size=6, ...}, AT_SYMLINK_NOFOLLOW) = 0
> > geteuid()                               = 0
> > rename("/boot/efi/tmp/test.txt", "/boot/efi/EFI/fedora/test.txt") = 0
> > lseek(0, 0, SEEK_CUR)                   = -1 ESPIPE (Illegal seek)
> > close(0)                                = 0
> >
> >
> > Per documentation that should be atomic. So the questions are, are
> > both atomic, or neither atomice, and if not what should be used to
> > ensure bootloader updates are atomic.

At VFS level both are atomic independently of filesystem.

> According of my understanding of FAT rename() is not atomic at all.
> It can downgrade to a hardlink. i.e. rename("foo", "bar") can result in having
> both "foo" and "bar."
> ...or worse.

Generally rename() may really cause that at some period of time both
"foo" and "bar" may points to same inode. (But is this a really problem
for your scenario?)

But looking at vfat source code (file namei_vfat.c), both rename and
lookup operation are locked by mutex, so during rename operation there
should not be access to read directory and therefore race condition
should not be there (which would cause reading inconsistent directory
during rename operation).

If you want atomic rename of two files independently of filesystem, you
can use RENAME_EXCHANGE flag. It exchanges that two specified files
atomically, so there would not be that race condition like in rename()
that in some period of time both "foo" and "bar" would point to same
inode.


But... if you are asking for consistency and atomicity at filesystem
level (e.g. you turn off disk / power supply during rename operation)
then this is not atomic and probably it cannot be implemented. When FAT
filesystem is mounted (either by Windows or Linux kernel) it is marked
by "dirty" flag and later when doing unmount, "dirty" flag is cleared.

This is there to ensure that operations like rename were finished and
were not stopped/killed in between. So future when you read from FAT
filesystem you would know if it is in consistent state or not.

> Pali has probably more input to share. :-)
> 
> > There are plausibly three kinds:
> >
> > A. write a new file with file name that doesn't previously exist
> > B. write a new file with a new file name, then do a rename stomping on
> > the old one
> > C. overwrite an existing file
> >
> > It seems C is risky. It probably isn't atomic and can't be made to be
> > atomic on FAT.

Option C is really risky. Overwriting file means following operations:

1. truncate file to zero size
2. write first N blocks
3. write second N blocks
...
4. write last M blocks


Option B is a common practise. IIRC also config files in KDE are updated
in this way.

> >
> > --
> > Chris Murphy
> 

-- 
Pali Rohár
pali.rohar@gmail.com
