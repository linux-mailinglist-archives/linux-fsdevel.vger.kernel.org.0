Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AE836B9AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 21:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239932AbhDZTHH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 15:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239934AbhDZTHF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 15:07:05 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF50C06175F
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Apr 2021 12:06:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o16so15859256plg.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Apr 2021 12:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OU5tybw4mESEMIXeoznpaz+xCHTTr+47vinGE0EXY4M=;
        b=Ajf2fir0E6Atcw05WsKjIq++A8IECg/TEJJLqY5CZGB/p8G56nbK7EHACvIuSHHlje
         IFbaYVfNd4NZQRmz5+xlPyH4Q/srfMpEuKx6JLSZN6620iK/xfCKN3NzCORMZc54OX8C
         YE09HV8G7nLuVzy0W+RccL91vYqQyOUH4I9Wntgwo3gVrTwf+IGVxb7sDPbdcTrcEDSU
         kvNcgxLy20Bf7N4NDKokOwEJDRpeFnfczZrei/dT0V9QU7vDTektqTRWpBGow+R8N30t
         jaCfK/o1Qv1NIu+RtcB5uPN8GIBocgS97RTak3WPnyx/Q5R6HXk/OSS7+pCg7eZxiZEd
         EYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OU5tybw4mESEMIXeoznpaz+xCHTTr+47vinGE0EXY4M=;
        b=mEVryRCCy9LPhVM45UrIzEmia8897TIZptG+QLb6SsMiynP7/ErVIV/pmvURhxMSAD
         3KXlfkKaJp6zhCRIA8rSLq4mLhQUPWxId6WJJuo3u8x4KNkG+mYN6LlPwj80JCDOo8mW
         eiskxU95vOTWuZ9JkeIK3pKF7ilO84y/Q6jZbC7cLXOobk08khScURNezmR/xXiUETYc
         xIkw4Xx4aRP9BwTtMYCA21Ac7psPZVRb0lMAOUcajYY9duf8UcvRjPyyRLlh0V8RviNz
         KgC5qI9XmnfFavL0YmsvJuC2M3fSuzDyBUFFYZaEgrSJfe3OD6ySjPMOlDV6rsC2YPTU
         B0xA==
X-Gm-Message-State: AOAM530aLytQLmGP+z03RyohrnJuGowZirzTzTRvkhvtkKi7JiGYqt7A
        rQVMoxbVe5AUC5Dp9IhcFTsWCgHpH1NxxA==
X-Google-Smtp-Source: ABdhPJzTuIQ9Xvd6pY2cEtm8mjBa+SVjlyfLTdikPyrQ7jjAYzg4iiNsdObHk0rdVLG1c//4wDuVVA==
X-Received: by 2002:a17:902:b10d:b029:ec:b5c2:5724 with SMTP id q13-20020a170902b10db02900ecb5c25724mr20011000plr.2.1619463980887;
        Mon, 26 Apr 2021 12:06:20 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:f06a])
        by smtp.gmail.com with ESMTPSA id lx11sm331745pjb.27.2021.04.26.12.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 12:06:20 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH RESEND v9 0/9] fs: interface for directly reading/writing compressed data
Date:   Mon, 26 Apr 2021 12:06:03 -0700
Message-Id: <cover.1619463858.git.osandov@fb.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This series adds an API for reading compressed data on a filesystem
without decompressing it as well as support for writing compressed data
directly to the filesystem. I have test cases (including fsstress
support) and example programs which I'll send up once the dust settles
[1].

The main use-case is Btrfs send/receive: currently, when sending data
from one compressed filesystem to another, the sending side decompresses
the data and the receiving side recompresses it before writing it out.
This is wasteful and can be avoided if we can just send and write
compressed extents. The patches implementing the send/receive support
were sent with the last submission of this series [2].

Patches 1-3 add the VFS support, UAPI, and documentation. Patches 4-7
are Btrfs prep patches. Patch 8 adds Btrfs encoded read support and
patch 9 adds Btrfs encoded write support.

These patches are based on Dave Sterba's Btrfs misc-next branch [3],
which is in turn currently based on v5.12-rc8.

This is a resend of v9 [4], rebased on the latest kdave/misc-next
branch.

Omar Sandoval (9):
  iov_iter: add copy_struct_from_iter()
  fs: add O_ALLOW_ENCODED open flag
  fs: add RWF_ENCODED for reading/writing compressed data
  btrfs: don't advance offset for compressed bios in
    btrfs_csum_one_bio()
  btrfs: add ram_bytes and offset to btrfs_ordered_extent
  btrfs: support different disk extent size for delalloc
  btrfs: optionally extend i_size in cow_file_range_inline()
  btrfs: implement RWF_ENCODED reads
  btrfs: implement RWF_ENCODED writes

1: https://github.com/osandov/xfstests/tree/rwf-encoded
2: https://lore.kernel.org/linux-btrfs/cover.1615922753.git.osandov@fb.com/
3: https://github.com/kdave/btrfs-devel/tree/misc-next
4: https://lore.kernel.org/linux-btrfs/cover.1617258892.git.osandov@fb.com/

Omar Sandoval (9):
  iov_iter: add copy_struct_from_iter()
  fs: add O_ALLOW_ENCODED open flag
  fs: add RWF_ENCODED for reading/writing compressed data
  btrfs: don't advance offset for compressed bios in
    btrfs_csum_one_bio()
  btrfs: add ram_bytes and offset to btrfs_ordered_extent
  btrfs: support different disk extent size for delalloc
  btrfs: optionally extend i_size in cow_file_range_inline()
  btrfs: implement RWF_ENCODED reads
  btrfs: implement RWF_ENCODED writes

 Documentation/filesystems/encoded_io.rst | 240 ++++++
 Documentation/filesystems/index.rst      |   1 +
 arch/alpha/include/uapi/asm/fcntl.h      |   1 +
 arch/parisc/include/uapi/asm/fcntl.h     |   1 +
 arch/sparc/include/uapi/asm/fcntl.h      |   1 +
 fs/btrfs/compression.c                   |  12 +-
 fs/btrfs/compression.h                   |   6 +-
 fs/btrfs/ctree.h                         |   9 +-
 fs/btrfs/delalloc-space.c                |  18 +-
 fs/btrfs/file-item.c                     |  35 +-
 fs/btrfs/file.c                          |  46 +-
 fs/btrfs/inode.c                         | 929 +++++++++++++++++++++--
 fs/btrfs/ordered-data.c                  | 124 +--
 fs/btrfs/ordered-data.h                  |  25 +-
 fs/btrfs/relocation.c                    |   4 +-
 fs/fcntl.c                               |  10 +-
 fs/namei.c                               |   4 +
 fs/read_write.c                          | 168 +++-
 include/linux/encoded_io.h               |  17 +
 include/linux/fcntl.h                    |   2 +-
 include/linux/fs.h                       |  13 +
 include/linux/uio.h                      |   1 +
 include/uapi/asm-generic/fcntl.h         |   4 +
 include/uapi/linux/encoded_io.h          |  30 +
 include/uapi/linux/fs.h                  |   5 +-
 lib/iov_iter.c                           |  91 +++
 26 files changed, 1563 insertions(+), 234 deletions(-)
 create mode 100644 Documentation/filesystems/encoded_io.rst
 create mode 100644 include/linux/encoded_io.h
 create mode 100644 include/uapi/linux/encoded_io.h

-- 
2.31.1

