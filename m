Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A729EDF794
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 23:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbfJUVok (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 17:44:40 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:36343 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbfJUVok (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 17:44:40 -0400
Received: by mail-wm1-f47.google.com with SMTP id c22so5093492wmd.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2019 14:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o0Hy5iF+XJDCKnLCYMKOboWp7enx4N3UG6jRMPwizt0=;
        b=JCqt+7Bx3zYSO7fJ9utCZP2SqyDDacZu5iOvq3vbAJn5kvz7KoAAkYArpCzLdQkUf8
         gHEDSI8dF1O55BWSaTuMGnBGGCwiwS18+l2ErEBnuUh4AbjU092Hjp+JPTlIf92avlsZ
         PtF196/WBLWB80HmBowBr0WsGG6JICXBB3TVlbtZuCPdEbe+Xxf9ebeC/pMJaLVWgHFL
         UubZ8InIOgKKSlaLFogAvMXVWXfoCiruhjg+6vsZWkXrmLGcv0DvPLyILn+Xq9MwRE8O
         VFcT2iUwvbD1CxlcnIQeAnoZmv3W4qdab7zs5nj075EOJcvwnpYkmHJcy9OrIL+0SwhV
         VUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o0Hy5iF+XJDCKnLCYMKOboWp7enx4N3UG6jRMPwizt0=;
        b=VEptgHe1V6N5XnSomL5MbhdwNR3f0OdBGNpZGkWmM8do+2Vf6G1xD4ADpL7CyQu4Iu
         pAdXFH/FQJYG7x2zLQ/diDyDtEBmD+8d+lYNKRWesVZWvaP+To8lv5R95J4TY06oN9xf
         yFYD/E8aRBb6zjhFVi7+XldynY1aCH0N+kD+CqfA91iBuThmSSN7Uj2BurdOK9CmTCkl
         gY+kECal+9SKO2h1AMagTleWmhzHUQN1IHc6i3rEq3DoL9JlwVAIJftP27cy2NNq+PD6
         Ad9XPvx27t50/xP7bAIhjxEi4X+BaFfKTIiAaUKuLGcoZBNzC529eLZWjSb4VFvQrmqV
         bk/A==
X-Gm-Message-State: APjAAAWjY1RJ+lHlk5BM73OThp1T7qiDbeWvrupL56o/Omwy3Zeaw5ol
        /gZBrt0SYub5Hv7PaCyl1JYrX2Hz0DnEiWxGX1Q=
X-Google-Smtp-Source: APXvYqy37yE5x3qf2YC5S0VRJaXSA/fEYdenkerYUneeOWtkSSUrxV4NBFQ9wKwNAQ4FnHxg9GJ4Flj9pCenfGQ+i8w=
X-Received: by 2002:a05:600c:1009:: with SMTP id c9mr55223wmc.109.1571694277950;
 Mon, 21 Oct 2019 14:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQ38W2r7Cuu5ieKRQizeKF0tf--3Z8yOJeeR+ZZ4S6CVQ@mail.gmail.com>
In-Reply-To: <CAJCQCtQ38W2r7Cuu5ieKRQizeKF0tf--3Z8yOJeeR+ZZ4S6CVQ@mail.gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 21 Oct 2019 23:44:25 +0200
Message-ID: <CAFLxGvxdPQdzBz1rc3ZC+q1gLNCs9sbn8FOS6G-E1XxXeybyog@mail.gmail.com>
Subject: Re: Is rename(2) atomic on FAT?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Chris,

[CC'ing fsdevel and Pali]

On Mon, Oct 21, 2019 at 9:59 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> http://man7.org/linux/man-pages/man2/rename.2.html
>
> Use case is atomically updating bootloader configuration on EFI System
> partitions. Some bootloader implementations have configuration files
> bigger than 512 bytes, which could possibly be torn on write. But I'm
> also not sure what write order FAT uses.
>
> 1.
> FAT32 file system is mounted at /boot/efi
>
> 2.
> # echo "hello" > /boot/efi/tmp/test.txt
> # mv /boot/efi/tmp/test.txt /boot/efi/EFI/fedora/
>
> 3.
> When I strace the above mv command I get these lines:
> ioctl(0, TCGETS, {B38400 opost isig icanon echo ...}) = 0
> renameat2(AT_FDCWD, "/boot/efi/tmp/test.txt", AT_FDCWD,
> "/boot/efi/EFI/fedora/", RENAME_NOREPLACE) = -1 EEXIST (File exists)
> stat("/boot/efi/EFI/fedora/", {st_mode=S_IFDIR|0700, st_size=1024, ...}) = 0
> renameat2(AT_FDCWD, "/boot/efi/tmp/test.txt", AT_FDCWD,
> "/boot/efi/EFI/fedora/test.txt", RENAME_NOREPLACE) = 0
> lseek(0, 0, SEEK_CUR)                   = -1 ESPIPE (Illegal seek)
> close(0)
>
> I can't tell from documentation if renameat2() with flag
> RENAME_NOREPLACE is atomic, assuming the file doesn't exist at
> destination.
>
> 4.
> Do it again exactly as before, small change
> # echo "hello" > /boot/efi/tmp/test.txt
> # mv /boot/efi/tmp/test.txt /boot/efi/EFI/fedora/
>
> 5.
> The strace shows fallback to rename()
>
> ioctl(0, TCGETS, {B38400 opost isig icanon echo ...}) = 0
> renameat2(AT_FDCWD, "/boot/efi/tmp/test.txt", AT_FDCWD,
> "/boot/efi/EFI/fedora/", RENAME_NOREPLACE) = -1 EEXIST (File exists)
> stat("/boot/efi/EFI/fedora/", {st_mode=S_IFDIR|0700, st_size=1024, ...}) = 0
> renameat2(AT_FDCWD, "/boot/efi/tmp/test.txt", AT_FDCWD,
> "/boot/efi/EFI/fedora/test.txt", RENAME_NOREPLACE) = -1 EEXIST (File
> exists)
> lstat("/boot/efi/tmp/test.txt", {st_mode=S_IFREG|0700, st_size=7, ...}) = 0
> newfstatat(AT_FDCWD, "/boot/efi/EFI/fedora/test.txt",
> {st_mode=S_IFREG|0700, st_size=6, ...}, AT_SYMLINK_NOFOLLOW) = 0
> geteuid()                               = 0
> rename("/boot/efi/tmp/test.txt", "/boot/efi/EFI/fedora/test.txt") = 0
> lseek(0, 0, SEEK_CUR)                   = -1 ESPIPE (Illegal seek)
> close(0)                                = 0
>
>
> Per documentation that should be atomic. So the questions are, are
> both atomic, or neither atomice, and if not what should be used to
> ensure bootloader updates are atomic.

According of my understanding of FAT rename() is not atomic at all.
It can downgrade to a hardlink. i.e. rename("foo", "bar") can result in having
both "foo" and "bar."
...or worse.

Pali has probably more input to share. :-)

> There are plausibly three kinds:
>
> A. write a new file with file name that doesn't previously exist
> B. write a new file with a new file name, then do a rename stomping on
> the old one
> C. overwrite an existing file
>
> It seems C is risky. It probably isn't atomic and can't be made to be
> atomic on FAT.
>
>
> --
> Chris Murphy

-- 
Thanks,
//richard
