Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F16E73D5F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 04:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjFZCjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Jun 2023 22:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjFZCjP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Jun 2023 22:39:15 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616F6E55
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jun 2023 19:38:56 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b5466bc5f8so4085475ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jun 2023 19:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687747136; x=1690339136;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6QMf5QrwEgx53gYkrHQJk/Oxe88JWhNQBmRK1nNjic=;
        b=eZ/OzEuSP1va8h9QynhzU5yYHQ+k5Y44vcY6mDCRpd4uYok8zZ0DNFzXXnv6chCTYP
         QaRIKfdgmFRh/edlNhyGENHn1THsId493uC6amGUGRdcRuxbkMLPiJMRjAOYwJw9LqHd
         ZQ0SY7GKWzUu1O3YaFtUQNEBM4xzXhQLbezCChMFsas34TXstatRTV4SSYMLOJoUaFA5
         fMxFJ4cyTrL1NbZtL1Q786hkMFMxC+l+zlS7V1ShzmcH/PcXv8FBtl/uwD5n/VLxd8KW
         Mu58l6JbZC5S58nd5OcU0/e8Luyt6E1bikfVXZ7sk+r3AjTGfEJH6jXn8vLJade6UXCa
         /ADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687747136; x=1690339136;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q6QMf5QrwEgx53gYkrHQJk/Oxe88JWhNQBmRK1nNjic=;
        b=aL0jbjP8xt4Irg3a4NMyw/eT5UNBWtoe/cGS8OcxKSWsChtzy1bjKJMsF41HoZH7zz
         NbZoRta0FPizNK8sPcM4FWo1br3gGxzZkXfLNhasnDk/CiRKlbTDL3DXBSMEAQTH/6av
         MeTLpWnz+WmPp3djAIXQ5izA4zVHaCkJBUkOY1+PeBDLhvetfLtEPwlJFM5bubHI5LAy
         4lcW9bPxBj36zBtiS+9lzwqiNxgKnfG90PdKyB3TquT0tZFH1QYXcokMmnnG7z9O1OZ9
         vwzAuEGYCPgYKguDdIxfYHEAK/W4RX5rSJcXwPNY8i8q/u1Md7yB/tXj08sBfV5VhG+L
         m/kg==
X-Gm-Message-State: AC+VfDzv6vRM/SQhuNATvKyH1NDzyS1ZPDsjoaGL1qiAHa4ig4AGqqn9
        unQp430FvtENbRTTewbjVhmr+ixJJJJ0bxwnXmE=
X-Google-Smtp-Source: ACHHUZ5cnxjR8kxjgCBaymXFtJf7f9vFBanQVBDoxVSmWNORp94cGU11uDWag+IdMCR/84Alk/3kmw==
X-Received: by 2002:a17:903:230c:b0:1b3:ec39:f42c with SMTP id d12-20020a170903230c00b001b3ec39f42cmr34736346plh.5.1687747135730;
        Sun, 25 Jun 2023 19:38:55 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jk17-20020a170903331100b001b54cf5186csm497986plb.126.2023.06.25.19.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 19:38:54 -0700 (PDT)
Message-ID: <81469b33-44cf-8b42-a024-25aa22f9c2a0@kernel.dk>
Date:   Sun, 25 Jun 2023 20:38:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Splice updates for 6.5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

First batch of splice updates via David, the block side depends on these
and will be going out after this one. In David's words:

This patchset kills off ITER_PIPE to avoid a race between truncate,
iov_iter_revert() on the pipe and an as-yet incomplete DMA to a bio with
unpinned/unref'ed pages from an O_DIRECT splice read.  This causes memory
corruption[2].  Instead, we use filemap_splice_read(), which invokes the
buffered file reading code and splices from the pagecache into the pipe;
copy_splice_read(), which bulk-allocates a buffer, reads into it and then
pushes the filled pages into the pipe; or handle it in filesystem-specific
code.

 (1) Rename direct_splice_read() to copy_splice_read().

 (2) Simplify the calculations for the number of pages to be reclaimed in
     copy_splice_read().

 (3) Turn do_splice_to() into a helper, vfs_splice_read(), so that it can
     be used by overlayfs and coda to perform the checks on the lower fs.

 (4) Make vfs_splice_read() jump to copy_splice_read() to handle direct-I/O
     and DAX.

 (5) Provide shmem with its own splice_read to handle non-existent pages
     in the pagecache.  We don't want a ->read_folio() as we don't want to
     populate holes, but filemap_get_pages() requires it.

 (6) Provide overlayfs with its own splice_read to call down to a lower
     layer as overlayfs doesn't provide ->read_folio().

 (7) Provide coda with its own splice_read to call down to a lower layer as
     coda doesn't provide ->read_folio().

 (8) Direct ->splice_read to copy_splice_read() in tty, procfs, kernfs
     and random files as they just copy to the output buffer and don't
     splice pages.

 (9) Provide wrappers for afs, ceph, ecryptfs, ext4, f2fs, nfs, ntfs3,
     ocfs2, orangefs, xfs and zonefs to do locking and/or revalidation.

(10) Make cifs use filemap_splice_read().

(11) Replace pointers to generic_file_splice_read() with pointers to
     filemap_splice_read() as DIO and DAX are handled in the caller;
     filesystems can still provide their own alternate ->splice_read() op.

(12) Remove generic_file_splice_read().

(13) Remove ITER_PIPE and its paraphernalia as generic_file_splice_read()
     was the only user.

Please pull!


The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/for-6.5/splice-2023-06-23

for you to fetch changes up to 9eee8bd81421c5e961cbb1a3c3fa1a06fad545e8:

  splice: kdoc for filemap_splice_read() and copy_splice_read() (2023-05-24 08:42:17 -0600)

----------------------------------------------------------------
for-6.5/splice-2023-06-23

----------------------------------------------------------------
David Howells (31):
      splice: Fix filemap_splice_read() to use the correct inode
      splice: Make filemap_splice_read() check s_maxbytes
      splice: Rename direct_splice_read() to copy_splice_read()
      splice: Clean up copy_splice_read() a bit
      splice: Make do_splice_to() generic and export it
      splice: Check for zero count in vfs_splice_read()
      splice: Make splice from an O_DIRECT fd use copy_splice_read()
      splice: Make splice from a DAX file use copy_splice_read()
      shmem: Implement splice-read
      overlayfs: Implement splice-read
      coda: Implement splice-read
      tty, proc, kernfs, random: Use copy_splice_read()
      net: Make sock_splice_read() use copy_splice_read() by default
      9p: Add splice_read wrapper
      afs: Provide a splice-read wrapper
      ceph: Provide a splice-read wrapper
      ecryptfs: Provide a splice-read wrapper
      ext4: Provide a splice-read wrapper
      f2fs: Provide a splice-read wrapper
      nfs: Provide a splice-read wrapper
      ntfs3: Provide a splice-read wrapper
      ocfs2: Provide a splice-read wrapper
      orangefs: Provide a splice-read wrapper
      xfs: Provide a splice-read wrapper
      zonefs: Provide a splice-read wrapper
      trace: Convert trace/seq to use copy_splice_read()
      cifs: Use filemap_splice_read()
      splice: Use filemap_splice_read() instead of generic_file_splice_read()
      splice: Remove generic_file_splice_read()
      iov_iter: Kill ITER_PIPE
      splice: kdoc for filemap_splice_read() and copy_splice_read()

 block/fops.c            |   2 +-
 drivers/char/random.c   |   4 +-
 drivers/tty/tty_io.c    |   4 +-
 fs/9p/vfs_file.c        |  26 ++-
 fs/adfs/file.c          |   2 +-
 fs/affs/file.c          |   2 +-
 fs/afs/file.c           |  20 ++-
 fs/bfs/file.c           |   2 +-
 fs/btrfs/file.c         |   2 +-
 fs/ceph/file.c          |  65 +++++++-
 fs/cifs/cifsfs.c        |  12 +-
 fs/cifs/cifsfs.h        |   3 -
 fs/cifs/file.c          |  16 --
 fs/coda/file.c          |  29 +++-
 fs/cramfs/inode.c       |   2 +-
 fs/ecryptfs/file.c      |  27 ++-
 fs/erofs/data.c         |   2 +-
 fs/exfat/file.c         |   2 +-
 fs/ext2/file.c          |   2 +-
 fs/ext4/file.c          |  13 +-
 fs/f2fs/file.c          |  43 ++++-
 fs/fat/file.c           |   2 +-
 fs/fuse/file.c          |   2 +-
 fs/gfs2/file.c          |   4 +-
 fs/hfs/inode.c          |   2 +-
 fs/hfsplus/inode.c      |   2 +-
 fs/hostfs/hostfs_kern.c |   2 +-
 fs/hpfs/file.c          |   2 +-
 fs/jffs2/file.c         |   2 +-
 fs/jfs/file.c           |   2 +-
 fs/kernfs/file.c        |   2 +-
 fs/minix/file.c         |   2 +-
 fs/nfs/file.c           |  23 ++-
 fs/nfs/internal.h       |   2 +
 fs/nfs/nfs4file.c       |   2 +-
 fs/nilfs2/file.c        |   2 +-
 fs/ntfs/file.c          |   2 +-
 fs/ntfs3/file.c         |  31 +++-
 fs/ocfs2/file.c         |  43 ++++-
 fs/ocfs2/ocfs2_trace.h  |   3 +
 fs/omfs/file.c          |   2 +-
 fs/orangefs/file.c      |  22 ++-
 fs/overlayfs/file.c     |  23 ++-
 fs/proc/inode.c         |   4 +-
 fs/proc/proc_sysctl.c   |   2 +-
 fs/proc_namespace.c     |   6 +-
 fs/ramfs/file-mmu.c     |   2 +-
 fs/ramfs/file-nommu.c   |   2 +-
 fs/read_write.c         |   2 +-
 fs/reiserfs/file.c      |   2 +-
 fs/romfs/mmap-nommu.c   |   2 +-
 fs/splice.c             | 127 +++++++-------
 fs/sysv/file.c          |   2 +-
 fs/ubifs/file.c         |   2 +-
 fs/udf/file.c           |   2 +-
 fs/ufs/file.c           |   2 +-
 fs/vboxsf/file.c        |   2 +-
 fs/xfs/xfs_file.c       |  30 +++-
 fs/xfs/xfs_trace.h      |   2 +-
 fs/zonefs/file.c        |  40 ++++-
 include/linux/fs.h      |   8 +-
 include/linux/splice.h  |   3 +
 include/linux/uio.h     |  14 --
 kernel/trace/trace.c    |   2 +-
 lib/iov_iter.c          | 431 +-----------------------------------------------
 mm/filemap.c            |  31 +++-
 mm/shmem.c              | 134 ++++++++++++++-
 net/socket.c            |   2 +-
 68 files changed, 694 insertions(+), 621 deletions(-)

-- 
Jens Axboe

