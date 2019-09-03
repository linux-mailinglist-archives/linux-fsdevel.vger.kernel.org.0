Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05734A7600
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 23:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfICVNm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 17:13:42 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:44285 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfICVNm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 17:13:42 -0400
Received: by mail-qt1-f179.google.com with SMTP id u40so13223559qth.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 14:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jnl/m8TXoOotHWDOnj1qBzvcERm07JKi+F3CfQzw2js=;
        b=ndBNDIivbuLYyTCd7EJ2jU7WpGS8fuwvFdFLihFHvaRiYrY6NoM2UNoQ2UIcoJob6M
         Gj9oyNeOjzVT7tF80mxULimWGlDerjfhdHUCf8/aAvPJ0wTU2mScUvrTzbK2tehQOQVE
         mFvBf8l6j0BWFLHAe3mui7s+hRpsNM/umQWj6UqeSlkW4gTT4wAQUfPOdwK3+mPe0vMg
         PcaPsUktxEqcExjBJoGrwbORsMhgmG0kRz6GwJBOe8M+efSYHjbJg2gvEfDMV0nY7GqY
         +NVQD2E/9NVVWBQ+XhSng7qrM0n6+NQPDRdQrKcbtrZUzkHdTQh2XlK73uuiwRBB/z4p
         tOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jnl/m8TXoOotHWDOnj1qBzvcERm07JKi+F3CfQzw2js=;
        b=g2DuyTGfCIZXkHdF1vXRUXVdbICbqfbkOgPV++euJTW84u9emYF8eF+5XoTfcdSd8Z
         MY8csFDNLuS4r9OFDAGaxPUaj6zWrmWzam/A7DVL/98OP7kFTMHFSIKmUim65Kouc/6m
         JXNkQbhhENRaUROIIT3Jm5E+gjPXTBf8/PrR8KuJMEGxGwEmxmrA6cUbK1pFMDVr38UR
         +X1NG/jUKzEG4RTQkxmc8tcYXGnm0k1CoWFe5O3iZtTVbW1nn54uubnMBLVf4hHBSroK
         b3SwfobWjW562UZ8DaPqiafBtp47nOO0WG9gKcMCczjzeB0v3yoxukngvIgEPH+S5RD6
         3GRw==
X-Gm-Message-State: APjAAAU+oqgF2D5b2u4k3SGYnG4hNXFkcdw7IEsgDW5xH2ZLvaO0OVRS
        UOJcEB212h++QwLevT6uZ18MvQ==
X-Google-Smtp-Source: APXvYqy41p17kftMw+o3sX9TP7VjpmgEb51xudEyvUtef56+owEq15L2WS8U3bi7v0yk/tthhfXEKQ==
X-Received: by 2002:a0c:d4d0:: with SMTP id y16mr23107610qvh.191.1567545221037;
        Tue, 03 Sep 2019 14:13:41 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q13sm8878141qkm.120.2019.09.03.14.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 14:13:40 -0700 (PDT)
Message-ID: <1567545218.5576.66.camel@lca.pw>
Subject: Re: "beyond 2038" warnings from loopback mount is noisy
From:   Qian Cai <cai@lca.pw>
To:     Arnd Bergmann <arnd@arndb.de>, Andreas Dilger <adilger@dilger.ca>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Date:   Tue, 03 Sep 2019 17:13:38 -0400
In-Reply-To: <CAK8P3a19PNVv0tEd8h93F9iszcCC-AmeqZ=pFkuSAyxAfhaQ-Q@mail.gmail.com>
References: <1567523922.5576.57.camel@lca.pw>
         <CABeXuvoPdAbDr-ELxNqUPg5n84fubZJZKiryERrXdHeuLhBQjQ@mail.gmail.com>
         <CABeXuvq7n+ZW7-HOiur+cyQXBjYKKWw1nRgFTJXTBZ9JNusPeg@mail.gmail.com>
         <1567534549.5576.62.camel@lca.pw>
         <82F89AEA-994B-44B5-93E7-CD339E4F78F6@dilger.ca>
         <CAK8P3a19PNVv0tEd8h93F9iszcCC-AmeqZ=pFkuSAyxAfhaQ-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2019-09-03 at 21:50 +0200, Arnd Bergmann wrote:
> On Tue, Sep 3, 2019 at 9:39 PM Andreas Dilger <adilger@dilger.ca> wrote:
> > 
> > On Sep 3, 2019, at 12:15 PM, Qian Cai <cai@lca.pw> wrote:
> > > 
> > > On Tue, 2019-09-03 at 09:36 -0700, Deepa Dinamani wrote:
> > > > We might also want to consider updating the file system the LTP is
> > > > being run on here.
> > > 
> > > It simply format (mkfs.ext4) a loop back device on ext4 with the kernel.
> > > 
> > > CONFIG_EXT4_FS=m
> > > # CONFIG_EXT4_USE_FOR_EXT2 is not set
> > > # CONFIG_EXT4_FS_POSIX_ACL is not set
> > > # CONFIG_EXT4_FS_SECURITY is not set
> > > # CONFIG_EXT4_DEBUG is not set
> > > 
> > > using e2fsprogs-1.44.6. Do you mean people now need to update the kernel
> > > to
> > > enable additional config to avoid the spam of warnings now?
> > 
> > Strange.  The defaults for mkfs.ext4 _should_ default to use options that
> > allow enough space for the extra timestamps.
> > 
> > Can you please provide "dumpe2fs -h" output for your filesystem, and the
> > formatting options that you used when creating this filesystem.
> 
> According to the man page,
> 
>         "The default inode size is controlled by the mke2fs.conf(5)
> file.  In the
>          mke2fs.conf file shipped with  e2fsprogs, the default inode size is
> 256
>          bytes for most file systems, except for small file systems
> where the inode
>          size will be 128 bytes."
> 
> If this (small file systems) is the problem, then I think we need to
> do two things:
> 
> 1. Change the per-inode warning to not warn if the inode size for the
>     file system is less than 256. We already get a mount-time warning
>     in that case.
> 
> 2. Change the mkfs.ext4 defaults to never pick a 128 byte inode unless
>     the user really wants this (maybe not even then).

Indeed.

# dd if=/dev/zero of=small bs=1M count=50
50+0 records in
50+0 records out
52428800 bytes (52 MB, 50 MiB) copied, 0.0168322 s, 3.1 GB/s

# losetup -f small

# mkfs.ext4 /dev/loop0

# dumpe2fs -h /dev/loop0 
dumpe2fs 1.44.6 (5-Mar-2019)
Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          8cd1b7f1-dec9-45fc-807b-26cceedcdaa7
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index filetype
extent 64bit flex_bg sparse_super large_file huge_file dir_nlink extra_isize
metadata_csum
Filesystem flags:         unsigned_directory_hash 
Default mount options:    user_xattr acl
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              12824
Block count:              51200
Reserved block count:     2560
Free blocks:              44440
Free inodes:              12813
First block:              1
Block size:               1024
Fragment size:            1024
Group descriptor size:    64
Reserved GDT blocks:      256
Blocks per group:         8192
Fragments per group:      8192
Inodes per group:         1832
Inode blocks per group:   229
Flex block group size:    16
Filesystem created:       Tue Sep  3 16:10:35 2019
Last mount time:          Tue Sep  3 16:10:42 2019
Last write time:          Tue Sep  3 16:10:48 2019
Mount count:              1
Maximum mount count:      -1
Last checked:             Tue Sep  3 16:10:35 2019
Check interval:           0 (<none>)
Lifetime writes:          6050 kB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:	          128
Journal inode:            8
Default directory hash:   half_md4
Directory Hash Seed:      6507a815-ee3a-4573-99c8-2f9103061dec
Journal backup:           inode blocks
Checksum type:            crc32c
Checksum:                 0x4b0ec46e
Journal features:         journal_64bit journal_checksum_v3
Journal size:             4096k
Journal length:           4096
Journal sequence:         0x00000004
Journal start:            0
Journal checksum type:    crc32c
Journal checksum:         0x23f8be20
