Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F051144A9FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 10:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244630AbhKIJF5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 04:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244641AbhKIJD6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 04:03:58 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB67C061766
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Nov 2021 01:00:27 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id j21so73586063edt.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Nov 2021 01:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=y5IblQg565u0sn/A0euU0qgQIbVILf7I5YUNUBoW6tM=;
        b=NI6gI2WdJ2MeYuHFVw98u0WK1/Ov6zC6EVIj1F5ZIL5DogNGAaZ5KriD88F9zznJvK
         M7HoNqHXW/q7nhkobp79yMWipkBsHzh2oQh2wDeJbOGntSheBBFkWT0LEh4UCTj/HBIN
         stI7r40FusMDvwq3rkQfDr0aENqIMUsq4vBMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=y5IblQg565u0sn/A0euU0qgQIbVILf7I5YUNUBoW6tM=;
        b=OvHETmH4tGzN+XvgP+RgQZxC0jdK4/O5ncIiibwmm94dliiLRCFd0rGlxQnHFUBLZy
         xWUTCFaNADwAEbTD13EbGwRmUE9Z54Vo/aRPiogFTGdlnDdeNbakfJyCOcBWprw2n08G
         As8ew2tUm+mdrU81lOlEYbBCRFq7iHaeElNk5fmbvjChoifj8GbZB8M6hmj+mVjCBCPB
         5EL/ybVkiCC6aaaGw1JEDWMBMMGNL4+xqRr8AntAH95H7nl7WFozGk3cWcjYALVvrhkU
         7VDRIGTDlJMCHBmoeUJZNbtT9yqc74x9g12gYOUhro/3oyTSVGVJp/0rc6gQJuAb7NeK
         LFJQ==
X-Gm-Message-State: AOAM533fb4XM6uVx1my+Qw1IxXtuWUAhx4tlzt2C3XZWL1ODKBWoy+Dv
        IgG/+bBcHtdjJz6ypzo3b+OV2uigsv8swA==
X-Google-Smtp-Source: ABdhPJxmeNH+YsO+kk0AFwWhw/AkhY4ZTqp9CHL6Ordx1zz3wXzPqD3iaTSKLH/wH/p9UkQ1MQDrSQ==
X-Received: by 2002:a05:6402:51cc:: with SMTP id r12mr8329478edd.64.1636448425473;
        Tue, 09 Nov 2021 01:00:25 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-178-48-189-3.catv.broadband.hu. [178.48.189.3])
        by smtp.gmail.com with ESMTPSA id ji14sm3163376ejc.89.2021.11.09.01.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 01:00:25 -0800 (PST)
Date:   Tue, 9 Nov 2021 10:00:23 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse update for 5.16
Message-ID: <YYo4pwtSVE12qsLN@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.16

 - Fix a possible of deadlock in case inode writeback is in progress during
   dentry reclaim.

 - Fix a crash in case of page stealing.

 - Selectively invalidate cached attributes, possibly improving performance.

 - Allow filesystems to disable data flushing from ->flush().

 - Misc fixes and cleanups.

Thanks,
Miklos

---
Amir Goldstein (1):
      fuse: add FOPEN_NOFLUSH

Miklos Szeredi (20):
      fuse: make sure reclaim doesn't write the inode
      fuse: write inode in fuse_vma_close() instead of fuse_release()
      fuse: annotate lock in fuse_reverse_inval_entry()
      fuse: move fuse_invalidate_attr() into fuse_update_ctime()
      fuse: simplify __fuse_write_file_get()
      fuse: decrement nlink on overwriting rename
      fuse: don't increment nlink in link()
      fuse: selective attribute invalidation
      fuse: don't bump attr_version in cached write
      fuse: rename fuse_write_update_size()
      fuse: always invalidate attributes after writes
      fuse: fix attr version comparison in fuse_read_update_size()
      fuse: cleanup code conditional on fc->writeback_cache
      fuse: simplify local variables holding writeback cache state
      fuse: move reverting attributes to fuse_change_attributes()
      fuse: add cache_mask
      fuse: take cache_mask into account in getattr
      fuse: only update necessary attributes
      virtiofs: use strscpy for copying the queue name
      fuse: fix page stealing

Peng Hao (2):
      fuse: use kmap_local_page()
      fuse: delete redundant code

---
 fs/fuse/dax.c             |   5 +-
 fs/fuse/dev.c             |  24 ++++++---
 fs/fuse/dir.c             | 128 ++++++++++++++++++++++------------------------
 fs/fuse/file.c            | 106 ++++++++++++++++++++------------------
 fs/fuse/fuse_i.h          |  17 ++++--
 fs/fuse/inode.c           |  45 +++++++++++++---
 fs/fuse/ioctl.c           |   4 +-
 fs/fuse/readdir.c         |   6 +--
 fs/fuse/virtio_fs.c       |   2 +-
 fs/fuse/xattr.c           |  10 ++--
 include/uapi/linux/fuse.h |   7 ++-
 11 files changed, 203 insertions(+), 151 deletions(-)
