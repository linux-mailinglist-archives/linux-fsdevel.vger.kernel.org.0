Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D3B44F713
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Nov 2021 08:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhKNHJV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Nov 2021 02:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhKNHJM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Nov 2021 02:09:12 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71925C061570;
        Sat, 13 Nov 2021 23:06:14 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id r4so8882244edy.12;
        Sat, 13 Nov 2021 23:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=lTAWwzCDf/mzTJzs3+RMQBARAQp9pv2hNSSRu5s7rGk=;
        b=NGPyaC4HyGyzJ1rKSXlYLIF3VYW8ANrzasd9imWyXZqYrXhBJ7DUUlveK95P0k2VYN
         P6IIViIwJUInUM9i0uuZFCtD/JGcYvtDsPeEUs2htU8GOq7tLuhx4WXXbIpXVTTPXITd
         UlxWBBACwBl4C//AQzbFtgJ2VZd22A29zTs+CrmeXKhtKOBinlr4oaFSlUvEsxYaMsE7
         dPkLTtufvXehyY4S/ac91T0E29V/PyoQh6Yesbf1jvhsH8vEwdmTH4soage/Vbg+8BNz
         ehINbCd8WTPOyqtHlqEIKQYYKvbJXkLNKjpc5xDruwC8WlGboho6HoMyPjadDbQ21nmx
         63zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=lTAWwzCDf/mzTJzs3+RMQBARAQp9pv2hNSSRu5s7rGk=;
        b=6lItKKDm0TPQlw8NJx4tutF9U9TeMjWJpMveoDf7wUXRrAGNJTfs4vyOWMZa7WU33G
         Q4zfiHw8XiJMK2jJ+Kh1jWWHt7GRRcfxwNmY+tU0l93hH0E3IMLf9Z0jnnfex5Ftpj+C
         r/TrT0fFkMUsLhl62QtuUeRvLTRv1YnyXWK0freII7acZKIF9slw1OFCuoVnF+Zjgm1W
         FZPoda6eaGLkuYN2a2o2spGbVgOBSSFu7FHcWHXkdJ7eqOhtEN/Ymwfe233tip1P3Vp1
         Au8UVG0S8GupQeyGEcNYj/TpgEt8uMjGlLvpkgtNOI5xMIWUeXNrOY3E4Z+yywcbDwqu
         jHaQ==
X-Gm-Message-State: AOAM533Ow04PlzDppIaVgCbKQtcmvPyqAPXuBkpC0qSr47gEPKm/Xm31
        PNzav3E1Wnuy/lcctciCNVYZ97rrALPxFFQ7Sj6FwCPx
X-Google-Smtp-Source: ABdhPJz6F7eb7ZlPz+uZ1ryBjKV5MJY+6g8VTzYPNDQv8d/IMiyQJel1uICTBXlYxhNSBRKxb1cJsAgM4Rtiu1G511Y=
X-Received: by 2002:a17:906:b084:: with SMTP id x4mr35926642ejy.214.1636873572801;
 Sat, 13 Nov 2021 23:06:12 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLinoW5Cx=xbUcT-DB4RiQkAPpe=9hsc-Rkch0LxD0mh+Q@mail.gmail.com>
 <CAOuPNLgquwOJg85kDcf67+4kTYP9N=45FvV+VDTJr6txYi5-wg@mail.gmail.com>
 <CAOuPNLjFtS7ftg=+-K3S+0ndyNYmUNqXo7SHkyV4zK4G9bZ4Og@mail.gmail.com> <CAOuPNLg_YwyhK6iPZZbRWe57Kkr1d8LjJaDniCvvOqk4t2-Sog@mail.gmail.com>
In-Reply-To: <CAOuPNLg_YwyhK6iPZZbRWe57Kkr1d8LjJaDniCvvOqk4t2-Sog@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Sun, 14 Nov 2021 12:36:01 +0530
Message-ID: <CAOuPNLgYhm=goOiABjUFsAvRW+s2NqHjHYdm5MA9PvoUAMxOpg@mail.gmail.com>
Subject: Re: Kernel-4.14: With ubuntu-18.04 building rootfs images and booting
 gives SQUASHFS error: xz decompression failed, data probably corrupt
To:     open list <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        dm-devel@redhat.com, Phillip Lougher <phillip@squashfs.org.uk>,
        Mikulas Patocka <mpatocka@redhat.com>,
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

+ Adding squashfs-devel to get opinion from squashfs side.

On Fri, 12 Nov 2021 at 12:48, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> Hi,
>
> On Tue, 9 Nov 2021 at 21:04, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> > > > We only get these squashfs errors flooded in the boot logs:
> > > > {{{
> > > > ....
> > > > [    5.153479] device-mapper: init: dm-0 is ready
> > > > [    5.334282] VFS: Mounted root (squashfs filesystem) readonly on device 253:0.
> > > > ....
> > > > [    8.954120] SQUASHFS error: xz decompression failed, data probably corrupt
> > > > [    8.954153] SQUASHFS error: squashfs_read_data failed to read block 0x1106
> > > > [    8.970316] SQUASHFS error: Unable to read data cache entry [1106]
> > > > [    8.970349] SQUASHFS error: Unable to read page, block 1106, size 776c
> > > > [    8.980298] SQUASHFS error: Unable to read data cache entry [1106]
> > > > [    8.981911] SQUASHFS error: Unable to read page, block 1106, size 776c
> > > > [    8.988280] SQUASHFS error: Unable to read data cache entry [1106]
> > > > ....
> > > > }}}
> > > >
>
> One more observation:
> When I disable FEC flag in bootloader, I see the below error:
> [    8.360791] device-mapper: verity: 253:0: data block 2 is corrupted
> [    8.361134] device-mapper: verity: 253:0: data block 3 is corrupted
> [    8.366016] SQUASHFS error: squashfs_read_data failed to read block 0x1106
> [    8.379652] SQUASHFS error: Unable to read data cache entry [1106]
> [    8.379680] SQUASHFS error: Unable to read page, block 1106, size 7770
>
> Also, now I see that the decompress error is gone, but the read error
> is still there.
>
> This seems to me that dm-verity detects some corrupted blocks but with
> FEC it auto corrects itself, how when dm-verity auto corrects itself,
> the squashfs decompression algorithm somehow could not understand it.
>
> So, it seems like there is some mis-match between the way FEC
> correction and the squashfs decompression happens ?
>
> Is this issue seen by anybody else here ?
>

The squashfs version used by Kernel:
[    0.355958] squashfs: version 4.0 (2009/01/31) Phillip Lougher

The squashfs version available on Ubuntu:
mksquashfs version 4.3-git (2014/06/09)

The squashfs version used by Yocto 2.6:
squashfs-tools/0001-squashfs-tools-Allow-setting-selinux-xattrs-through-.patch:61:
   printf("mksquashfs version 4.3-git (2014/09/12)\n");

We create dm-verity squashfs image using version 4.3 whereas, the
kernel uses 4.0 version to decompress it.
Is there something missing here?

When FEC (Forward Error Correction) comes into picture, then squashfs
decompress fails.
When we remove FEC flag from dm-verity then decompress works but read
error still occurs.
This seems as if something is missing either in FEC handling or either
in squashfs decompress logic.

Just wanted to know if there are any fixes already available in the
mainline for this ?


Thanks,
Pintu
