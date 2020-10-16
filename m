Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3266290CC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 22:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403813AbgJPUfB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 16:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403789AbgJPUfA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 16:35:00 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A49C061755
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 13:35:00 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id u8so5054535ejg.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 13:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=DrXe8nq7zyAh3znAJW55dJ/CbHSN9L+XiHjQd4hlZAM=;
        b=D+XL7zi/imriCBN1SpjcLu/xKgegulfNfgFK+KfZ5wbr0Chb8jkEZ7O0vduKjKEUQG
         LV7Udv+2XbaRqdDwnhwNUWEXI534TV2/wM4c451yn/cZRX3IBaSXSj/UJFZnS2mib0z+
         lXAoCVR34oXDcPQTJq5RfTKar5uGuAbvU14hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=DrXe8nq7zyAh3znAJW55dJ/CbHSN9L+XiHjQd4hlZAM=;
        b=cbsSzqKY2+nS8hQNBPLSHhHoPMp1fp4PG64UrFaLnMYEiOGO7gomJwpwrDK6NNZS2s
         zYRHV5jJMziij25mkyOPUtXOHhpWPLxdS0djciQQ0RYDM8ipA5y8ctQG402v+I6fK0D6
         3FsrV632E7tHy0IqNaBBF6DCO7k3QTNPh9cmroJfiGoNDR05AEjZRUQmZzc2lPVuBPkj
         SxtbQLtZx0NDpWw/3imw3IT8VG+r3PK8bRcLJrDwzj62a0Lc+EYM7ynNYQEVxsuQldfu
         GZVM/a0zd/Wrd2ClsDewr3v8VQTda1I8tP+RVSelkgBX+gsV1DnsFp70GOjpjXcil15K
         nWIw==
X-Gm-Message-State: AOAM5335Fyvfo6zpuuWatDt80V7y02XzXQDZSgf7GxDlc0hYwmvr7b6P
        049jJiPJ+IlpZBdAKXjO7boO+hSpYVPZwg==
X-Google-Smtp-Source: ABdhPJyXuyCrMa43ja+v85kezMDo1vHd8ckKW5wKN2039mqfQMTw6UnE3QxXZ080eLM5I4/uOsCYRA==
X-Received: by 2002:a17:906:6dc6:: with SMTP id j6mr5917255ejt.354.1602880499257;
        Fri, 16 Oct 2020 13:34:59 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id j5sm2741679ejt.52.2020.10.16.13.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 13:34:58 -0700 (PDT)
Date:   Fri, 16 Oct 2020 22:34:53 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs update for 5.10
Message-ID: <20201016203453.GA327006@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-5.10

- Improve performance for certain container setups by introducing a "volatile"
  mode.

- Ioctl improvements.

- Continue preparation for unprivileged overlay mounts.

Thanks,
Miklos

---
Amir Goldstein (3):
      ovl: check for incompatible features in work dir
      ovl: support [S|G]ETFLAGS and FS[S|G]ETXATTR ioctls for directories
      ovl: use generic vfs_ioc_setflags_prepare() helper

Miklos Szeredi (9):
      duplicate ovl_getxattr()
      ovl: clean up ovl_getxattr() in copy_up.c
      ovl: fold ovl_getxattr() into ovl_get_redirect_xattr()
      ovl: use ovl_do_getxattr() for private xattr
      ovl: adhere to the vfs_ vs. ovl_do_ conventions for xattrs
      ovl: drop flags argument from ovl_do_setxattr()
      ovl: pass ovl_fs down to functions accessing private xattrs
      ovl: enumerate private xattrs
      ovl: rearrange ovl_can_list()

Vivek Goyal (1):
      ovl: provide a mount option "volatile"

---
 Documentation/filesystems/overlayfs.rst |  19 ++++++
 fs/overlayfs/copy_up.c                  |  59 ++++++++++++----
 fs/overlayfs/dir.c                      |   2 +-
 fs/overlayfs/export.c                   |   2 +-
 fs/overlayfs/file.c                     |  88 ++++++++++++++----------
 fs/overlayfs/inode.c                    |  32 +++++----
 fs/overlayfs/namei.c                    |  57 ++++++++--------
 fs/overlayfs/overlayfs.h                |  92 ++++++++++++++++---------
 fs/overlayfs/ovl_entry.h                |   6 ++
 fs/overlayfs/readdir.c                  |  76 ++++++++++++++++++---
 fs/overlayfs/super.c                    | 117 +++++++++++++++++++++++++++-----
 fs/overlayfs/util.c                     |  96 +++++++++++++-------------
 12 files changed, 446 insertions(+), 200 deletions(-)
