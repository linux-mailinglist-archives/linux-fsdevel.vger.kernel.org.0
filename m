Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3576E1F4833
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 22:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgFIUh2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 16:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgFIUhX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 16:37:23 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1ABC08C5C2
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2020 13:37:22 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id x1so60725ejd.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2020 13:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=7ZVlejTC0YuKPGpcteISk746OUPvuY4hgSWC1f7OLtQ=;
        b=nXo4e1lLm4NTrTzkokAa+id+fdgD1MXyvH4cDPWBQT70BhQJfREqivfXZvDNiAiWWp
         c2ZgYsbA7T54ZHViJGcdK9qb7pLw/TvBE50mRCbzGyvTHRb6i4uKOatrKuK4p4dbglQ5
         gHYpv3YUmO16neCN6MlZVyzyaKpZp13cG71oE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7ZVlejTC0YuKPGpcteISk746OUPvuY4hgSWC1f7OLtQ=;
        b=H6NiH7BWiMfsoThe1WV3pQ5ECHZDcp1EhgobRA7IykUxGKMK+cPbKcsOD7uO5BQQFS
         xB10bIL5/OtGxSlXmwbYMs3960Cw6bJlxWgrmktZBg4/g2vmp/uuJsyxGdHLucY6gMGc
         qLuFDt99tE8P3p1cA3JSwvgu7rL3HMfeCsJ4i3N2z2hZgM78DbAPRWBbO7w9zjo1jpYv
         KgVZjqq8B4hjye6fjOHU9OlInyyElW2gNHHXQ03csYskC5mewnpUj2VzTWwzNqwDIjsO
         asDU2o/rXa7rU9hYiDMZvZfu+k6BaMorSpn++n5oMMCDY2mgtQu3PhQhVnWAWq5w799H
         lhUA==
X-Gm-Message-State: AOAM530pbooytcOR7XVhx7R2/PodE2QzBFpvKfxopSF8Ye84w0ccGe7L
        PO5mirtnZcbKN65U4zWnVtDbrhYU0LttDA==
X-Google-Smtp-Source: ABdhPJxpLOFautN81ZbcwIflxRmD4RRnfFtwTTRy8WEhlMS3Jc+pUiOH22RYN5xOgRBrM91Xj7MOhw==
X-Received: by 2002:a17:906:6156:: with SMTP id p22mr152434ejl.329.1591735041107;
        Tue, 09 Jun 2020 13:37:21 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id v12sm16508347eda.39.2020.06.09.13.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 13:37:20 -0700 (PDT)
Date:   Tue, 9 Jun 2020 22:37:18 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs update for 5.8
Message-ID: <20200609203718.GB6171@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-5.8

There are some changes outside of the overlayfs tree; clone_private_mount()
was reviewed by Al, the rest are trivial.  No other filesystems are
affected by these.

Fixes:

 - Resolve mount option conflicts consistently.

 - Sync before remount R/O.

 - Fix file handle encoding corner cases.

 - Fix metacopy related issues.

 - Fix an unintialized return value.

 - Add missing permission checks for underlying layers.

Optimizations:

 - Allow multipe whiteouts to share an inode.

 - Optimize small writes by inheriting SB_NOSEC from upper layer.

 - Do not call ->syncfs() multiple times for sync(2).

 - Do not cache negative lookups on upper layer.

 - Make private internal mounts longterm.

Thanks,
Miklos

---
Amir Goldstein (5):
      ovl: resolve more conflicting mount options
      ovl: cleanup non-empty directories in ovl_indexdir_cleanup()
      ovl: prepare to copy up without workdir
      ovl: index dir act as work dir
      ovl: fix out of bounds access warning in ovl_check_fb_len()

Chengguang Xu (3):
      ovl: whiteout inode sharing
      ovl: sync dirty data when remounting to ro mode
      ovl: drop negative dentry in upper layer

Jeffle Xu (1):
      ovl: inherit SB_NOSEC flag from upperdir

Konstantin Khlebnikov (1):
      ovl: skip overlayfs superblocks at global sync

Lubos Dolezel (1):
      ovl: return required buffer size for file handles

Miklos Szeredi (10):
      ovl: pass correct flags for opening real directory
      ovl: switch to mounter creds in readdir
      ovl: verify permissions in ovl_path_open()
      ovl: call secutiry hook in ovl_real_ioctl()
      ovl: check permission to open real file
      ovl: add accessor for ofs->upper_mnt
      ovl: get rid of redundant members in struct ovl_fs
      ovl: make private mounts longterm
      ovl: only pass ->ki_flags to ovl_iocb_to_rwf()
      ovl: make oip->index bool

Vivek Goyal (4):
      ovl: simplify setting of origin for index lookup
      ovl: use only uppermetacopy state in ovl_lookup()
      ovl: initialize OVL_UPPERDATA in ovl_lookup()
      ovl: fix redirect traversal on metacopy dentries

Yuxuan Shui (1):
      ovl: initialize error in ovl_copy_xattr

youngjun (1):
      ovl: remove unnecessary lock check

---
 Documentation/filesystems/overlayfs.rst |   7 +-
 Documentation/filesystems/porting.rst   |   7 +
 fs/namespace.c                          |  16 +++
 fs/overlayfs/copy_up.c                  |   9 +-
 fs/overlayfs/dir.c                      |  51 +++++--
 fs/overlayfs/export.c                   |  24 ++--
 fs/overlayfs/file.c                     |  28 +++-
 fs/overlayfs/inode.c                    |  17 +--
 fs/overlayfs/namei.c                    | 138 ++++++++++--------
 fs/overlayfs/overlayfs.h                |  11 +-
 fs/overlayfs/ovl_entry.h                |  10 +-
 fs/overlayfs/readdir.c                  |  57 ++++++--
 fs/overlayfs/super.c                    | 243 +++++++++++++++++++++-----------
 fs/overlayfs/util.c                     |  36 ++++-
 fs/sync.c                               |   3 +-
 include/linux/fs.h                      |   2 +
 include/linux/mount.h                   |   2 +
 security/security.c                     |   1 +
 18 files changed, 440 insertions(+), 222 deletions(-)
