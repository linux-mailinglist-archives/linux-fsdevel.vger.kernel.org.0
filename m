Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C102349C1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 23:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhCYWIR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 18:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhCYWHy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 18:07:54 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685BAC06174A
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 15:07:54 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so3467913otk.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 15:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v6OKtVcub91dYSaPvyVsAKXW46SJTqq4WnXTgmnLs34=;
        b=0PUwv+2PWVwlpW2aY6aHp8veUSgV1FbtZZmbXE8kWXLn6kdy+7rzbDa/+V5mmbbrEt
         AOfEBoXrka87yEaZQHFnCsejLWkmne27iK3YLpqywus5zS0wwZT3nS3UTuhbfGMWgRWD
         m842yD6gV5XIpagYVFfqPb41gFq7J29Ge846sZxrnQQ0e4FDdz6AP7wfz4O8dUSYHLH2
         iQtz+2YubiPAf24waYs4pSWRZe/pxj/U0pzHRmWTw9tV3jEfAS5l6mGtJvONwwAWiGI5
         a9gE4rDA9kjwIfdDvyxIcV3O8DwaYgxGf60S4SbNvbJ2AqY6JH7zsg1Iw2PHlXqPKvRf
         sGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v6OKtVcub91dYSaPvyVsAKXW46SJTqq4WnXTgmnLs34=;
        b=bWnt9Ep6bC76utxFaWxiDiypdOinh89hPXI0sYZe/pTFPrvqKbXWqHtbhqWgSU1ygk
         EIfUrBei7rUe2w//g/xXf4aStAC6ZmAQdYAmssBK3QWvp76tnZZE93A6WnwfOk2oZLje
         xGaN65TCki8aLWOucIdsrXYYWgpVYvwCZVMuPTzj7CxZ0OrgKPfy6ENqUGkQR5C2euIM
         tLnWO9k1dHonNQqK9Yy4tPLz3C88SMHO1KF+6U2r6GPBMvh6FnOqeYccJsUcOALCaGf6
         YTAUXIL2I204bUXCSEbAByLz4+7UzFOsQNdgrn0BEFpVzK6ipGJtOakRq/xdCfAkvfD9
         R5pw==
X-Gm-Message-State: AOAM533p/1yB+HUQ8UPaYEsbroqgwiSmwkzx79OXXZK7+7o7521MenqC
        6MRGRz5LBd0mwpJ7i4A5ppBeMn7IVeAm5LFd5DaXEg==
X-Google-Smtp-Source: ABdhPJwK306fhpDZcWKAG8rYKhHVg0IIoH9R6ksOA+8ZuRcYlXWpw3NJPAgdIg8RbLTcf3DIrF7UYdDXEy1jeHcm71I=
X-Received: by 2002:a9d:ef1:: with SMTP id 104mr8984223otj.180.1616710073626;
 Thu, 25 Mar 2021 15:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210325193755.294925-1-mszeredi@redhat.com>
In-Reply-To: <20210325193755.294925-1-mszeredi@redhat.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Thu, 25 Mar 2021 18:07:42 -0400
Message-ID: <CAOg9mSQ+D2UwzuQFCivyvfQ-uRgZ2i7tKcpNR-nSivkNLSwR8Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/18] new kAPI for FS_IOC_[GS]ETFLAGS/FS_IOC_FS[GS]ETXATTR
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        David Sterba <dsterba@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biggers <ebiggers@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos...

While you were sending out v3, I was running xfstests on v2...
no orangefs problems with your changes.

-Mike

On Thu, Mar 25, 2021 at 3:38 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> Thanks for the feedback, I think all comments are addressed.  Seems
> "fileattr" has won a small majority of bikesheders' preference, so
> switching over to that.
>
> Changes since v2:
>
>  - renaming, most notably miscattr -> fileattr
>  - use memset instead of structure initialization
>  - drop gratuitous use of file_dentry()
>  - kerneldoc, comments, spelling improvements
>  - xfs: enable getting/setting FS_PROJINHERIT_FL and other tweaks
>  - btrfs: patch logistics
>
> Changes since v1:
>
>  - rebased on 5.12-rc1 (mnt_userns churn)
>  - fixed LSM hook on overlayfs
>
> Git tree is available here:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git#fileattr_v3
>
>
> Miklos Szeredi (18):
>   vfs: add fileattr ops
>   ecryptfs: stack fileattr ops
>   ovl: stack fileattr ops
>   btrfs: convert to fileattr
>   ext2: convert to fileattr
>   ext4: convert to fileattr
>   f2fs: convert to fileattr
>   gfs2: convert to fileattr
>   orangefs: convert to fileattr
>   xfs: convert to fileattr
>   efivars: convert to fileattr
>   hfsplus: convert to fileattr
>   jfs: convert to fileattr
>   nilfs2: convert to fileattr
>   ocfs2: convert to fileattr
>   reiserfs: convert to fileattr
>   ubifs: convert to fileattr
>   vfs: remove unused ioctl helpers
>
>  Documentation/filesystems/locking.rst |   5 +
>  Documentation/filesystems/vfs.rst     |  15 ++
>  fs/btrfs/ctree.h                      |   3 +
>  fs/btrfs/inode.c                      |   4 +
>  fs/btrfs/ioctl.c                      | 226 +++---------------
>  fs/ecryptfs/inode.c                   |  22 ++
>  fs/efivarfs/file.c                    |  77 ------
>  fs/efivarfs/inode.c                   |  44 ++++
>  fs/ext2/ext2.h                        |   7 +-
>  fs/ext2/file.c                        |   2 +
>  fs/ext2/ioctl.c                       |  88 +++----
>  fs/ext2/namei.c                       |   2 +
>  fs/ext4/ext4.h                        |  12 +-
>  fs/ext4/file.c                        |   2 +
>  fs/ext4/ioctl.c                       | 208 ++++------------
>  fs/ext4/namei.c                       |   2 +
>  fs/f2fs/f2fs.h                        |   3 +
>  fs/f2fs/file.c                        | 216 +++--------------
>  fs/f2fs/namei.c                       |   2 +
>  fs/gfs2/file.c                        |  57 ++---
>  fs/gfs2/inode.c                       |   4 +
>  fs/gfs2/inode.h                       |   3 +
>  fs/hfsplus/dir.c                      |   2 +
>  fs/hfsplus/hfsplus_fs.h               |  14 +-
>  fs/hfsplus/inode.c                    |  54 +++++
>  fs/hfsplus/ioctl.c                    |  84 -------
>  fs/inode.c                            |  87 -------
>  fs/ioctl.c                            | 331 ++++++++++++++++++++++++++
>  fs/jfs/file.c                         |   6 +-
>  fs/jfs/ioctl.c                        | 105 +++-----
>  fs/jfs/jfs_dinode.h                   |   7 -
>  fs/jfs/jfs_inode.h                    |   4 +-
>  fs/jfs/namei.c                        |   6 +-
>  fs/nilfs2/file.c                      |   2 +
>  fs/nilfs2/ioctl.c                     |  61 ++---
>  fs/nilfs2/namei.c                     |   2 +
>  fs/nilfs2/nilfs.h                     |   3 +
>  fs/ocfs2/file.c                       |   2 +
>  fs/ocfs2/ioctl.c                      |  59 ++---
>  fs/ocfs2/ioctl.h                      |   3 +
>  fs/ocfs2/namei.c                      |   3 +
>  fs/ocfs2/ocfs2_ioctl.h                |   8 -
>  fs/orangefs/file.c                    |  79 ------
>  fs/orangefs/inode.c                   |  50 ++++
>  fs/overlayfs/dir.c                    |   2 +
>  fs/overlayfs/inode.c                  |  77 ++++++
>  fs/overlayfs/overlayfs.h              |   3 +
>  fs/reiserfs/file.c                    |   2 +
>  fs/reiserfs/ioctl.c                   | 121 +++++-----
>  fs/reiserfs/namei.c                   |   2 +
>  fs/reiserfs/reiserfs.h                |   7 +-
>  fs/reiserfs/super.c                   |   2 +-
>  fs/ubifs/dir.c                        |   2 +
>  fs/ubifs/file.c                       |   2 +
>  fs/ubifs/ioctl.c                      |  74 +++---
>  fs/ubifs/ubifs.h                      |   3 +
>  fs/xfs/libxfs/xfs_fs.h                |   4 -
>  fs/xfs/xfs_ioctl.c                    | 252 +++++---------------
>  fs/xfs/xfs_ioctl.h                    |  11 +
>  fs/xfs/xfs_ioctl32.c                  |   2 -
>  fs/xfs/xfs_ioctl32.h                  |   2 -
>  fs/xfs/xfs_iops.c                     |   7 +
>  include/linux/fileattr.h              |  59 +++++
>  include/linux/fs.h                    |  16 +-
>  64 files changed, 1136 insertions(+), 1490 deletions(-)
>  create mode 100644 include/linux/fileattr.h
>
> --
> 2.30.2
>
