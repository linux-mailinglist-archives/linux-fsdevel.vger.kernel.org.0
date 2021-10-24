Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B69C43885A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Oct 2021 12:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhJXKpm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Oct 2021 06:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhJXKpl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Oct 2021 06:45:41 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06E5C061764;
        Sun, 24 Oct 2021 03:43:20 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bp15so4980393lfb.4;
        Sun, 24 Oct 2021 03:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/PS4HUoWODbfm53gN6ZbE+5Fa7xRlCBIs5XoCCtnGv0=;
        b=TYJcga+Uw6wwBd+n7s+ZgnDbMxgXivieJ0EbY0cKUU6GQkIUYUcC3NhvLwbDDKstoU
         7NplfkIWBtkNgdvOd6Td6wFLrxPgvtE/76t470Lm+XfxRy1t7EEjRhBDCT2001TCyTl5
         H0Bt5DH3NQDQI1POsIPrMclvsXXmZKgarkG5sg8hBBlphPrU1YKxcLk2R/Q743zAAtlX
         tAYtxYTfqixp6Ocm/jYehOGqCp0nucZX69JEyUb70aGwdQG9wdN+bJe+qrwicmH9vPPb
         /g+0zPbtIWgDsHAfJSMqvcoaf57JStWQlvNoKzvLlxihn2/giuL5dfDgygHGY/GlQPa2
         Vx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/PS4HUoWODbfm53gN6ZbE+5Fa7xRlCBIs5XoCCtnGv0=;
        b=4Fde0T8OxAco5GJJM0ooS5jGKS3ZXr6YgCLg9LiivAg9Kc01pRk5dhhkprDC4uEWRh
         7CUlcHb0smXJa9cZE3L3KNkhkjK5s/NZkzhoqr4Wf88APJFLxST/upiDRzyLZDPNKHSw
         /xDaePf6JnHXPMhuDZzz4Mm8zbqCcs2CDtlu6HnbnbGyPawbeyOqzk5OBFNhuzIUqewj
         WEX8JINyHosHz5f1b01LJbXK3fDq/rMlbJPwQt0m2H/srtStH1W1t44MwdVLy8IqK0D7
         jLHpz9+EjmpCy0bItOMEtDhORKNXxYVFVla7jkHQUT/mGtmb+pOrdgiRrhBQ/XSq28p9
         g9Lg==
X-Gm-Message-State: AOAM531bwuwxXaANUyZ2RH23PwpR7KVL3/gDg/KPCSbXudXhVIXnQ0sr
        dQqTRtBLQgO9SswPFvvIA9A=
X-Google-Smtp-Source: ABdhPJySpeMU1i/IZRzUlnsn9daQL08cAm8SgcyzLqPkfScsgppTJEG0W9uzzLbC9n0FXBtq+Cc3dw==
X-Received: by 2002:a05:6512:1106:: with SMTP id l6mr10587629lfg.454.1635072198557;
        Sun, 24 Oct 2021 03:43:18 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id 189sm1389892ljj.113.2021.10.24.03.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 03:43:17 -0700 (PDT)
Date:   Sun, 24 Oct 2021 13:43:15 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Ganapathi Kamath <hgkamath@hotmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/4] fs/ntfs3: Keep preallocated only if option prealloc
 enabled
Message-ID: <20211024104315.qb3fb6rxbibpk23g@kari-VirtualBox>
References: <09b42386-3e6d-df23-12c2-23c2718f766b@paragon-software.com>
 <aaf41f35-b702-b391-1cff-de4688b3bb65@paragon-software.com>
 <20211023095559.ythxb2z2ptdrlr5s@kari-VirtualBox>
 <DM6PR04MB49385E765EF33EF4E0B5FF32DA829@DM6PR04MB4938.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR04MB49385E765EF33EF4E0B5FF32DA829@DM6PR04MB4938.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 24, 2021 at 08:35:57AM +0000, Ganapathi Kamath wrote:
> Hellom 
> 
> While compiling, first time around, I got the below.

Yeah. Patch was meant for ntfs3/master...

> fs/ntfs3/file.c: In function 'ntfs_truncate': 
> fs/ntfs3/file.c:498:60: error: invalid type argument of '->' (have 'struct ntfs_mount_options')
>   498 |                             &new_valid, ni->mi.sbi->options->prealloc, NULL);
>       |                                                            ^~
> make[2]: *** [scripts/Makefile.build:277: fs/ntfs3/file.o] Error 1
> make[1]: *** [scripts/Makefile.build:540: fs/ntfs3] Error 2
> 
> So, in the file
>     fs/ntfs3/file.c
> I changed 
>     ni->mi.sbi->options->prealloc
> to
>     ni->mi.sbi->options.prealloc

but with your change it also applies to rc3. Your change was correct and
it was totally ok to test top of rc3.

> I don't really follow/understand the code, to understand what exactly
> the logic is, except that you are trying to set boolean
> 'keep_prealloc' call-argument for attr_set_size() by using the
> ntfs_mount_option bit-field 'prealloc' which is to "Preallocate space
> when file is growing", prototyped in the file fs/ntfs3/ntfs_fs.h
> 
> * Built new 5.15.0-0.rc3.20211001git4de593fb965f.30.fc35.x86_64
> kernel. (4 hrs on my machine)

I do not know if you used -j flag when making. Just if you did not know
about it use:

  make -j8

This will example use 8 threads for compiling. You choose number based
on how many threads you have in your processor.

> * I was able to include patch into rpmbuild of kernel src patch, with
> aforementioned correction * first reconfirmed/verified bug on old
> kernel
> * installed newly built kernel
> * attempt reproduction no success meaning bug not present on new
> kernel, patch/fix makes file size on overwrite to be as expected.
> 
> note, I am not an expert, and as a user, I don't know 100% what
> correct behavior should be, only what seems reasonable expected
> behavior, But  you are experts, so please excuse me for reiterating
> what you know. NTFS is a filesystem that was designed by microsoft for
> windows, and the way its fs-driver must update is so that on-disk
> structures is suitable for windows in-kernel structures. A kernel
> driver for linux, only adapts on disk-ntfs structures to something
> suitable for linux in-kernel structures, but must update the on disk
> structures the way Windows expects/designed it to.

Ntfs file structure allows actually many things which even Windows does
not understand. This is new driver and it will be evolving that user can
decide what he wants. We will also have to define good defaults so that
user get good experience.

> So if you defended old behavior, I wouldn't know.  So its your call,
> to decide if it is a bug, and whether your patch fixes.  On my side,
> my machine is one I work on. patch seems to fix claimed bug. So I hope
> there is no side effect, nothing corrupts or becomes unstable. 

This was bug. Thanks for reporting and testing it.  We really appriciate
it. This is new driver and there will be bugs so early users who report
bugs and are even willing to test patches are gold mine for us.

We will also add tags to patch:
Reported-by: Ganapathi Kamath <hgkamath@hotmail.com>
Tested-by: Ganapathi Kamath <hgkamath@hotmail.com>

if it ok to you. This way if you report new bugs to kernel people will
know you are good reporter as you have also tested what you have
reported. If you wanna know more about these tags see [1].

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

  Argillander

> That was fast fix. congrats. 
> 
> Log:
> [root@sirius gana]#
> [root@sirius gana]# mount -t ntfs3 /dev/sda17 /mnt/a17/
> [root@sirius gana]#
> [root@sirius gana]# rm -f /mnt/a17/test1.bin /mnt/a17/test2.bin
> [root@sirius gana]# dd if=/dev/zero of=/mnt/a17/test2.bin bs=1M count=3000
> 3000+0 records in
> 3000+0 records out
> 3145728000 bytes (3.1 GB, 2.9 GiB) copied, 5.40015 s, 583 MB/s
> [root@sirius gana]# dd if=/dev/zero of=/mnt/a17/test1.bin bs=1M count=6000
> 6000+0 records in
> 6000+0 records out
> 6291456000 bytes (6.3 GB, 5.9 GiB) copied, 16.1809 s, 389 MB/s
> [root@sirius gana]# ls -ls /mnt/a17/test1.bin /mnt/a17/test2.bin
> 6144000 -rw-r--r--. 1 root root 6291456000 Oct 24 13:42 /mnt/a17/test1.bin
> 3072000 -rw-r--r--. 1 root root 3145728000 Oct 24 13:41 /mnt/a17/test2.bin
> [root@sirius gana]# cp /mnt/a17/test2.bin /mnt/a17/test1.bin
> cp: overwrite '/mnt/a17/test1.bin'? y
> [root@sirius gana]# ls -ls /mnt/a17/test1.bin /mnt/a17/test2.bin
> 3072000 -rw-r--r--. 1 root root 3145728000 Oct 24 13:42 /mnt/a17/test1.bin
> 3072000 -rw-r--r--. 1 root root 3145728000 Oct 24 13:41 /mnt/a17/test2.bin
> [root@sirius gana]#  stat /mnt/a17/test1.bin
>   File: /mnt/a17/test1.bin
>   Size: 3145728000      Blocks: 6144000    IO Block: 4096   regular file
> Device: 10301h/66305d   Inode: 44          Links: 1
> Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
> Context: system_u:object_r:unlabeled_t:s0
> Access: 2021-10-24 13:41:59.265503300 +0530
> Modify: 2021-10-24 13:42:44.738904000 +0530
> Change: 2021-10-24 13:42:44.738904000 +0530
>  Birth: 2021-10-24 13:41:59.265503300 +0530
> [root@sirius gana]#  stat /mnt/a17/test2.bin
>   File: /mnt/a17/test2.bin
>   Size: 3145728000      Blocks: 6144000    IO Block: 4096   regular file
> Device: 10301h/66305d   Inode: 43          Links: 1
> Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
> Context: system_u:object_r:unlabeled_t:s0
> Access: 2021-10-24 13:42:40.610776900 +0530
> Modify: 2021-10-24 13:41:52.684315600 +0530
> Change: 2021-10-24 13:41:52.684315600 +0530
>  Birth: 2021-10-24 13:41:47.284266100 +0530
