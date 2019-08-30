Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF59CA3AE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 17:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfH3Psg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 11:48:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40743 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfH3Psg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:48:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so3745662pgj.7;
        Fri, 30 Aug 2019 08:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4oHQ/J6gD7m5a2hZJIzg30k30/iTJHkHY5qB+o+D4cE=;
        b=h7oWCY6wHIupyilklhVw3zKKmS4N6rNYStKFd6M4mXY2zoBod9UZ8VCkDGXpvOwPEx
         y0aASnlb2KjG+wF+/aUT2biKn+NEObcgE8m7DGPrZYueZa0oebuiKl0kXOBZW/YvAFgG
         wiNfxFX1BU+QMvruLmfNr9RwuUgTVgZhni7EzWpQBGg9w69s5GjxRS3CR8rDUkEmFDvX
         StbzvePxJ6JAeogsEcWDy1lOLEazKGBM7XSWMidYvC4oTqL+OIaD7n27qxye/p6T0bld
         MAh4tx6oguKUb4RPv6qhdVfxJi3jyYGLfFoX32P7ntEtN8+5CPxBMCDh7sUKz71y0419
         8ZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4oHQ/J6gD7m5a2hZJIzg30k30/iTJHkHY5qB+o+D4cE=;
        b=Rz2IvZhXVmR270TP1rqP+bsFbqlAzUFU+ogsw0a3zcwY73Ays/M2RoDIJGwjPEAIqb
         VYIwMfiipdHXcn9UC5yDpmbdtlCxpSodv34k2jMbhAMUb4I1D1yTK97Vu+tKBIsc37s8
         GSCCNIKpF+abp2YA7U7eDhepIydRU1+LGf+acYScrkZkAfI3Hsr9G0xmS6leWTO9GV1P
         qKDUHC9/gYZhX6lYFYRG/Xe02tstyg3JDXt3BT27nS1ahs9QQ9wMYFFB/h96WRjXfAq2
         cbwSTh8hXhQ9zOW+8zNECzDG6byv/+l0qNgvc+1tAE4pTmC0mHYePB1ZZAf5EqhfCUie
         a90g==
X-Gm-Message-State: APjAAAW5HNQUG6kwZYONGxLATMVAklsEp4QxQYDrVtQ9vXyJEDMlefx4
        CC+IzJtV3xgw4tuO/Q2bDZk=
X-Google-Smtp-Source: APXvYqw+TTjvl6C13mK+Kx+U+c7BoLzOucbYEU3GqDfQjm5bxaW7IFfh1q/TNPR40tNdaKG3mocNEw==
X-Received: by 2002:a17:90a:c386:: with SMTP id h6mr16090687pjt.122.1567180114546;
        Fri, 30 Aug 2019 08:48:34 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id z28sm8093085pfj.74.2019.08.30.08.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 08:48:33 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     arnd@arndb.de, viro@zeniv.linux.org.uk
Cc:     adilger@dilger.ca, aivazian.tigran@gmail.com,
        darrick.wong@oracle.com, deepa.kernel@gmail.com, dsterba@suse.com,
        gregkh@linuxfoundation.org, jlayton@kernel.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        me@bobcopeland.com, y2038@lists.linaro.org,
        adrian.hunter@intel.com, al@alarsen.net, anna.schumaker@netapp.com,
        anton@enomsg.org, asmadeus@codewreck.org, ccross@android.com,
        ceph-devel@vger.kernel.org, coda@cs.cmu.edu,
        codalist@coda.cs.cmu.edu, dedekind1@gmail.com,
        devel@lists.orangefs.org, dushistov@mail.ru, dwmw2@infradead.org,
        ericvh@gmail.com, hch@infradead.org, hch@lst.de,
        hirofumi@mail.parknet.co.jp, hubcap@omnibond.com,
        idryomov@gmail.com, jack@suse.com, jaegeuk@kernel.org,
        jaharkes@cs.cmu.edu, jfs-discussion@lists.sourceforge.net,
        jlbec@evilplan.org, linux-cifs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-karma-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        lucho@ionkov.net, luisbg@kernel.org, martin@omnibond.com,
        mikulas@artax.karlin.mff.cuni.cz, nico@fluxnic.net,
        phillip@squashfs.org.uk, reiserfs-devel@vger.kernel.org,
        richard@nod.at, sage@redhat.com, salah.triki@gmail.com,
        sfrench@samba.org, shaggy@kernel.org, tj@kernel.org,
        tony.luck@intel.com, trond.myklebust@hammerspace.com,
        tytso@mit.edu, v9fs-developer@lists.sourceforge.net,
        yuchao0@huawei.com, zyan@redhat.com
Subject: [GIT PULL RESEND] vfs: Add support for timestamp limits
Date:   Fri, 30 Aug 2019 08:47:44 -0700
Message-Id: <20190830154744.4868-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAK8P3a1XjOMpuS12Xao1xqOLFOuz1Jb8dTAfrhLcE643sSkC5g@mail.gmail.com>
References: <CAK8P3a1XjOMpuS12Xao1xqOLFOuz1Jb8dTAfrhLcE643sSkC5g@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[resending, rebased onto linux v5.3-rc6, and dropped orangefs patch from the series]

Hi Al, Arnd,

This is a pull request for filling in min and max timestamps for filesystems.
I've added all the acks, and dropped the adfs patch. That will be merged through
Russell's tree.

Dropped orangefs until the maintainers decide what its limits should be.

The following changes since commit a55aa89aab90fae7c815b0551b07be37db359d76:

  Linux 5.3-rc6 (2019-08-25 12:01:23 -0700)

are available in the Git repository at:

  https://github.com/deepa-hub/vfs limits

for you to fetch changes up to 5ad32b3acded06183f40806f76b030c3143017bb:

  isofs: Initialize filesystem timestamp ranges (2019-08-30 08:11:25 -0700)

----------------------------------------------------------------

- Deepa

Deepa Dinamani (18):
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
 47 files changed, 296 insertions(+), 72 deletions(-)
