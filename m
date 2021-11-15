Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8299344FE93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 07:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhKOGJa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 01:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhKOGJ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 01:09:26 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5872DC061746;
        Sun, 14 Nov 2021 22:06:29 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z5so6887678edd.3;
        Sun, 14 Nov 2021 22:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WJyGtaduRtIJa/ZtDrFpN3oGhSX1GbTvjUgEHPLUCMg=;
        b=SWMkJ9v6DUYEK3HiLAjMV80gRSTeXHyZclo63eHyu0x98VtMwyz3kiFOu7yEXR3XO4
         c1US89xzKDsZEz0LE73Kyh/FgOH0+Suu21hr84btmpjC3KaUlhnahiEjYtGlCLkTB1mz
         Phc8WXeTNKW6jsEVUapPS406bYuyUqPbsppPbo3hdFd8Vtr2IJg1RryZg+Y/fArcLX5U
         KyfjSYfCqJXm1Q71LxXIsNJR5zwEXxaGKWlRPA7gkVLq2Nj41ohHJfqqN5egLEU967A0
         q+Mge6Wo0TSBhYYCIVCyxpMPTP+fxaldBLyM33VmbDv2bGrF8HqBQ3i1Om5S9IHZFFDP
         hKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WJyGtaduRtIJa/ZtDrFpN3oGhSX1GbTvjUgEHPLUCMg=;
        b=ZKKBhYPYEBUTTY48mldQV8VXWp7KnBivtp7EF1l8YvPdOBwMgLpKvIdejHxnpZaY9S
         WQecUuSOSd6VgEhkaPqk1myTn87ojZmfGRAeCVFK1hrEi6T24jevsNj+4424XhyKQxXY
         +oZ7T6SnsxP5WzoHHF64ADHPl7hiTqB5iLZeQIFeChzo8qCkNLmYw5JTcrzdZaibuyiK
         HshcvJA6c111d3NCBCztUglKpaw6mgJrjhqcDBOOOXIIwSe0H80cM0Oz5vtLN68K7hOR
         DT3mPBZf7Rpt8WcdxpZ+KNI15UOLp1fxn+nhliZg6yajmVTcm/8QutF8+oOHT8VBejbY
         hDmg==
X-Gm-Message-State: AOAM533XAZNZA7ILNG/kKl9BOvVn96ADtKTKpl6JDytn5KO0FcdWiWvn
        GHxWfbx79deFBrVCj00OfY6Rotr+fkhqHbOpEwFUk9YN
X-Google-Smtp-Source: ABdhPJz5iujEF0gRIOihMaP1aSj04ay9mLJHtbI3Soyz1R6lWjRspvRUCY8gecc7utX0rH6lPACQni3RuU+0WhQtFOU=
X-Received: by 2002:aa7:cd8a:: with SMTP id x10mr51748057edv.3.1636956387892;
 Sun, 14 Nov 2021 22:06:27 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLinoW5Cx=xbUcT-DB4RiQkAPpe=9hsc-Rkch0LxD0mh+Q@mail.gmail.com>
 <CAOuPNLgquwOJg85kDcf67+4kTYP9N=45FvV+VDTJr6txYi5-wg@mail.gmail.com>
 <CAOuPNLjFtS7ftg=+-K3S+0ndyNYmUNqXo7SHkyV4zK4G9bZ4Og@mail.gmail.com>
 <CAOuPNLg_YwyhK6iPZZbRWe57Kkr1d8LjJaDniCvvOqk4t2-Sog@mail.gmail.com>
 <CAOuPNLgYhm=goOiABjUFsAvRW+s2NqHjHYdm5MA9PvoUAMxOpg@mail.gmail.com> <4b99139a-802a-8255-adf5-2d3f9d0ccf7c@squashfs.org.uk>
In-Reply-To: <4b99139a-802a-8255-adf5-2d3f9d0ccf7c@squashfs.org.uk>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Mon, 15 Nov 2021 11:36:16 +0530
Message-ID: <CAOuPNLg3Te_QwNaUq25TVQ5zav_ER78tM6gakdGLtEVqWL2+AA@mail.gmail.com>
Subject: Re: Kernel-4.14: With ubuntu-18.04 building rootfs images and booting
 gives SQUASHFS error: xz decompression failed, data probably corrupt
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        dm-devel@redhat.com, Mikulas Patocka <mpatocka@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Daniel Rosenberg <drosen@google.com>, astrachan@google.com,
        speed.eom@samsung.com, Sami Tolvanen <samitolvanen@google.com>,
        snitzer@redhat.com, squashfs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 15 Nov 2021 at 00:40, Phillip Lougher <phillip@squashfs.org.uk> wrote:
>
> On 14/11/2021 07:06, Pintu Agarwal wrote:
> > + Adding squashfs-devel to get opinion from squashfs side.
> >
> > On Fri, 12 Nov 2021 at 12:48, Pintu Agarwal <pintu.ping@gmail.com> wrote:
> >>
> >> Hi,
> >>
> >> On Tue, 9 Nov 2021 at 21:04, Pintu Agarwal <pintu.ping@gmail.com> wrote:
> >>
> >>>>> We only get these squashfs errors flooded in the boot logs:
> >>>>> {{{
> >>>>> ....
> >>>>> [    5.153479] device-mapper: init: dm-0 is ready
> >>>>> [    5.334282] VFS: Mounted root (squashfs filesystem) readonly on device 253:0.
> >>>>> ....
> >>>>> [    8.954120] SQUASHFS error: xz decompression failed, data probably corrupt
> >>>>> [    8.954153] SQUASHFS error: squashfs_read_data failed to read block 0x1106
> >>>>> [    8.970316] SQUASHFS error: Unable to read data cache entry [1106]
> >>>>> [    8.970349] SQUASHFS error: Unable to read page, block 1106, size 776c
> >>>>> [    8.980298] SQUASHFS error: Unable to read data cache entry [1106]
> >>>>> [    8.981911] SQUASHFS error: Unable to read page, block 1106, size 776c
> >>>>> [    8.988280] SQUASHFS error: Unable to read data cache entry [1106]
> >>>>> ....
> >>>>> }}}
> >>>>>
> >>
> >> One more observation:
> >> When I disable FEC flag in bootloader, I see the below error:
> >> [    8.360791] device-mapper: verity: 253:0: data block 2 is corrupted
> >> [    8.361134] device-mapper: verity: 253:0: data block 3 is corrupted
> >> [    8.366016] SQUASHFS error: squashfs_read_data failed to read block 0x1106
> >> [    8.379652] SQUASHFS error: Unable to read data cache entry [1106]
> >> [    8.379680] SQUASHFS error: Unable to read page, block 1106, size 7770
> >>
> >> Also, now I see that the decompress error is gone, but the read error
> >> is still there.
> >>
> >> This seems to me that dm-verity detects some corrupted blocks but with
> >> FEC it auto corrects itself, how when dm-verity auto corrects itself,
> >> the squashfs decompression algorithm somehow could not understand it.
> >>
> >> So, it seems like there is some mis-match between the way FEC
> >> correction and the squashfs decompression happens ?
> >>
> >> Is this issue seen by anybody else here ?
> >>
> >
> > The squashfs version used by Kernel:
> > [    0.355958] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> >
> > The squashfs version available on Ubuntu:
> > mksquashfs version 4.3-git (2014/06/09)
> >
> > The squashfs version used by Yocto 2.6:
> > squashfs-tools/0001-squashfs-tools-Allow-setting-selinux-xattrs-through-.patch:61:
> >     printf("mksquashfs version 4.3-git (2014/09/12)\n");
> >
> > We create dm-verity squashfs image using version 4.3 whereas, the
> > kernel uses 4.0 version to decompress it.
> > Is there something missing here?
> >
> > When FEC (Forward Error Correction) comes into picture, then squashfs
> > decompress fails.
> > When we remove FEC flag from dm-verity then decompress works but read
> > error still occurs.
> > This seems as if something is missing either in FEC handling or either
> > in squashfs decompress logic.
> >
> > Just wanted to know if there are any fixes already available in the
> > mainline for this ?
> >
> >
>
> As Squashfs maintainer I want you to stop randomly blaming anything and
> everything here.  You won't fix anything doing that.
>
> In a previous email you stated
>
>
> >
> > One quick observation:
> > This issue is seen only when we enable dm-verity in our bootloader and
> > cross-building the bootloader/kernel (with Yocto 2.6 toolchain
> > arm-oe-linux-gnueabi-) on Ubuntu 18.04.
> > The issue is *NOT* seen (on the same device) when building the
> > dm-verity enabled kernel on Ubuntu 16.04.
> >
> > Is it something to do with the cross-toolchain difference between
> > Ubuntu 16 and 18 ?
> >
>
> If that is the case, then it is not an issue with Squashfs or any
> kernel code, it is a build time issue and *that* is where you should
> be concentrating your efforts.  Find out what differences are there.
>
> You don't seem to understand that a Squashfs filesystem generated
> by any Mksquashfs 4.X is mountable *without* errors on any kernel
> since 2.6.29 (January 2009).  Looking for mismatches between
> Mksquashfs and/or kernel version and blaming that for the above
> different behaviour is a complete waste of time.
>

I am sorry, but I am not blaming anybody here.
I am just trying to put my observation here and trying to understand
if someone else have seen a similar issue.
Toolchain side also, it seems the same as it comes from Yocto itself.

It seems there is some relation between dm-verity FEC correction and
squashfs decompression.
So I was looking for some clues from both sides.

Anyways, thank you so much for your suggestion.
Yes, we are analysing the Yocto side build difference as well between
Ubuntu 16 and 18.

Thank you!
Pintu
