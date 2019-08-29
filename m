Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A667A1035
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 06:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbfH2EMu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 00:12:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38109 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfH2EMu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 00:12:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id e11so865592pga.5;
        Wed, 28 Aug 2019 21:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EG/nlMo9sP7VIjxFB1Sc+6BPesxcZGuG6xPJe080Aa8=;
        b=awUmS8TKKZhEUsvBd30XL7dJi4TMlyAAY7XI9O7APgENcrczkLZ3Yj6LPYuGSFOjv4
         L/kGCkvyzsWvnugiO5mWNgJP0tOMZNyd4lR99mKOcJqZoiYZbQtR+uutIkNF4oL4KM1J
         4NiFiNwBRwozz7OtQEyK2kxShtFmS3Jfd9tXeXrSav99Xz2QHwm0rm2xwvVeXED8HbXK
         Am0PYpF4baGkg/a83iE0R4g0SabBbqedlp/GJeWz6TczkPVfRflacv1XF8PyDZo2/D0q
         VJM9TqbaOINQqSY2iG9qvoIrQyUV8RKZo3ayDrzNkN1WnwQxDuMYQW8wRBqsmUPWa8G5
         z4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EG/nlMo9sP7VIjxFB1Sc+6BPesxcZGuG6xPJe080Aa8=;
        b=p34k4B035qXqq6bDHxitt5/EkRtErjl+q27Ksu52twfyVdYqTD2rXc7ma//iC8mhqv
         cYmvDGkMmOqFm3NRJnTHNkyvDaTCLv3LybOELBLtc4xqFgmftMvaQ59ZloqYZGOZYVTb
         gp0vCWpPjODhqGUdFDXemk38CHH4ro3DpT8NTIM7c2ISdBqUBvOxFVWj9kjkZCDOGNNU
         LOgJND8/uu6YE0p5SdN8Gkw3yzfyERYw8X+pEhKqBvLnpvTegeb9fVgcS2RRwrYR1xZN
         jXkTgIBLoLYuvSH2uLKOzk6J77V76lAMVsMHeKIFljyL/C1zH8+/mpLsKg6ZAKY652LG
         AsFg==
X-Gm-Message-State: APjAAAXJaQ8S3ze2VpknQ6upiVqeCRSX1Dr9C2bn0j+5qcS8DzIv47bu
        pcLLWe6NjRxMqoofR340Y/A=
X-Google-Smtp-Source: APXvYqypUAO0QBmHyf7wnf18+BInWWfbWlIbmCzRMZSSur5w4VberObekUlJWy9ZznjXWHl7E7459g==
X-Received: by 2002:aa7:8585:: with SMTP id w5mr8602574pfn.1.1567051969706;
        Wed, 28 Aug 2019 21:12:49 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id g3sm1017689pfm.179.2019.08.28.21.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 21:12:48 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, arnd@arndb.de
Cc:     adilger@dilger.ca, aivazian.tigran@gmail.com,
        darrick.wong@oracle.com, dsterba@suse.com,
        gregkh@linuxfoundation.org, jlayton@kernel.org,
        keescook@chromium.org, me@bobcopeland.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        y2038@lists.linaro.org
Subject: [GIT PULL] vfs: Add support for timestamp limits
Date:   Wed, 28 Aug 2019 21:11:32 -0700
Message-Id: <20190829041132.26677-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al, Arnd,

This is a pull request for filling in min and max timestamps for filesystems.
I've added all the acks, and dropped the adfs patch. That will be merged through
Russell's tree.

Thanks,
Deepa

The following changes since commit 5d18cb62218608a1388858880ad3ec76d6cb0d3b:

  Add linux-next specific files for 20190828 (2019-08-28 19:59:14 +1000)

are available in the Git repository at:

  https://github.com/deepa-hub/vfs limits

for you to fetch changes up to f0f216afa4c7e4dee9121fde52ccf57f76119188:

  isofs: Initialize filesystem timestamp ranges (2019-08-28 19:19:36 -0700)

----------------------------------------------------------------
Deepa Dinamani (19):
      vfs: Add file timestamp range support
      vfs: Add timestamp_truncate() api
      timestamp_truncate: Replace users of timespec64_trunc
      mount: Add mount warning for impending timestamp expiry
      utimes: Clamp the timestamps before update
      fs: Fill in max and min timestamps in superblock
      9p: Fill min and max timestamps in sb
      ext4: Initialize timestamps limits
      fs: nfs: Initialize filesystem timestamp ranges
      fs: cifs: Initialize filesystem timestamp ranges
      fs: fat: Initialize filesystem timestamp ranges
      fs: affs: Initialize filesystem timestamp ranges
      fs: sysv: Initialize filesystem timestamp ranges
      fs: ceph: Initialize filesystem timestamp ranges
      fs: orangefs: Initialize filesystem timestamp ranges
      fs: hpfs: Initialize filesystem timestamp ranges
      fs: omfs: Initialize filesystem timestamp ranges
      pstore: fs superblock limits
      isofs: Initialize filesystem timestamp ranges

 fs/9p/vfs_super.c        |  6 +++++-
 fs/affs/amigaffs.c       |  2 +-
 fs/affs/amigaffs.h       |  3 +++
 fs/affs/inode.c          |  4 ++--
 fs/affs/super.c          |  4 ++++
 fs/attr.c                | 21 ++++++++++++---------
 fs/befs/linuxvfs.c       |  2 ++
 fs/bfs/inode.c           |  2 ++
 fs/ceph/super.c          |  2 ++
 fs/cifs/cifsfs.c         | 22 ++++++++++++++++++++++
 fs/cifs/netmisc.c        | 14 +++++++-------
 fs/coda/inode.c          |  3 +++
 fs/configfs/inode.c      | 12 ++++++------
 fs/cramfs/inode.c        |  2 ++
 fs/efs/super.c           |  2 ++
 fs/ext2/super.c          |  2 ++
 fs/ext4/ext4.h           | 10 +++++++++-
 fs/ext4/super.c          | 17 +++++++++++++++--
 fs/f2fs/file.c           | 21 ++++++++++++---------
 fs/fat/inode.c           | 12 ++++++++++++
 fs/freevxfs/vxfs_super.c |  2 ++
 fs/hpfs/hpfs_fn.h        |  6 ++----
 fs/hpfs/super.c          |  2 ++
 fs/inode.c               | 33 ++++++++++++++++++++++++++++++++-
 fs/isofs/inode.c         |  7 +++++++
 fs/jffs2/fs.c            |  3 +++
 fs/jfs/super.c           |  2 ++
 fs/kernfs/inode.c        |  7 +++----
 fs/minix/inode.c         |  2 ++
 fs/namespace.c           | 33 ++++++++++++++++++++++++++++++++-
 fs/nfs/super.c           | 20 +++++++++++++++++++-
 fs/ntfs/inode.c          | 21 ++++++++++++---------
 fs/omfs/inode.c          |  4 ++++
 fs/orangefs/super.c      |  2 ++
 fs/pstore/ram.c          |  2 ++
 fs/qnx4/inode.c          |  2 ++
 fs/qnx6/inode.c          |  2 ++
 fs/reiserfs/super.c      |  3 +++
 fs/romfs/super.c         |  2 ++
 fs/squashfs/super.c      |  2 ++
 fs/super.c               |  2 ++
 fs/sysv/super.c          |  5 ++++-
 fs/ubifs/file.c          | 21 ++++++++++++---------
 fs/ufs/super.c           |  7 +++++++
 fs/utimes.c              |  6 ++----
 fs/xfs/xfs_super.c       |  2 ++
 include/linux/fs.h       |  5 +++++
 include/linux/time64.h   |  2 ++
 48 files changed, 298 insertions(+), 72 deletions(-)
