Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A53848C748
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 16:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354634AbiALPgx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 10:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354632AbiALPgx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:36:53 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3BFC061751
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jan 2022 07:36:52 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id u21so11525187edd.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jan 2022 07:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=pFQlRwVs64l+mhGnFgsqy5BuLBon+B2tD/h1013B7pA=;
        b=QzqyPaQ29wk/535/mqu2iWnjEbZEvV5DPaoeeXxkQ+LF4iriofj5ZloKOQPaEo8mq1
         4Ok2uSRIvsJ1dpLerR+PqrvemFbeiGCdrtYeRlA8w2gc80/B5dKsMyNMY4KhXc5tp2cR
         znG9K0aUnnYZJlWFanPSZuUIfaCNvZzvhe8Ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=pFQlRwVs64l+mhGnFgsqy5BuLBon+B2tD/h1013B7pA=;
        b=FHztGFhSzT0BXteIRKHhUhxwgVgP9uK4QVZaAXtOHytk8+kidepHYiTOWitOQXl8q2
         f+z+c68BwXQ4LUb4m5mdRZgLxKs0vOw92OTrj5OQWkrZG/eGMbKXZcJGYBZkT5gtBXUn
         NjRtThoifZv2zabYPZUCNTr2xWTigDAOphlMpYQcD26hQm486Ja3WsstUdVSnjUn/rhZ
         Xrq4sAZFr6zEG8raqb1evsLuqmuXpOwxMk/iwF1OdO843uh6E7WQKlfb0Qj/XC+DPXvK
         DhXdhq04qdThTsaBG2llF7X3ELZCjMyL/gozFsRRiVpRq+OscFNXN45BAinJPHPYj9Xt
         k80w==
X-Gm-Message-State: AOAM532TUeTi+lwfv7zJeoPS7NuMYBy4YnIuOOQBgVKTz0ULMQhz4SOf
        6FoSBH4kXouZRE002UKKdCKYbQ==
X-Google-Smtp-Source: ABdhPJyhR2ASi9+GtKBfKy+OT8soYwXQEidXwNi5BGuIk/eoLc5gqe3YWIlj8uA/tAbZc4ODk8QK9Q==
X-Received: by 2002:a05:6402:51cc:: with SMTP id r12mr172836edd.239.1642001811228;
        Wed, 12 Jan 2022 07:36:51 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-178-48-189-3.catv.broadband.hu. [178.48.189.3])
        by smtp.gmail.com with ESMTPSA id l10sm18542ejh.102.2022.01.12.07.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 07:36:50 -0800 (PST)
Date:   Wed, 12 Jan 2022 16:36:43 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse update for 5.17
Message-ID: <Yd71i1Yul3rPO2Lp@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.17

- Fix a regression introduced in 5.15.

- Extend the size of the FUSE_INIT request to accommodate for more flags.
  There's a slight possibility of a regression for obscure fuse servers; if
  this happens, then more complexity will need to be added to the protocol.

- Allow the DAX property to be controlled by the server on a per-inode
  basis in virtiofs.

- Allow sending security context to the server when creating a file or
  directory.

Thanks,
Miklos

---
Jeffle Xu (7):
      fuse: add fuse_should_enable_dax() helper
      fuse: make DAX mount option a tri-state
      fuse: support per inode DAX in fuse protocol
      fuse: enable per inode DAX
      fuse: negotiate per inode DAX in FUSE_INIT
      fuse: mark inode DONT_CACHE when per inode DAX hint changes
      Documentation/filesystem/dax: DAX on virtiofs

Miklos Szeredi (1):
      fuse: extend init flags

Vivek Goyal (1):
      fuse: send security context of inode on file

Xie Yongji (1):
      fuse: Pass correct lend value to filemap_write_and_wait_range()

---
 Documentation/filesystems/dax.rst | 20 ++++++++-
 fs/fuse/dax.c                     | 36 +++++++++++++++-
 fs/fuse/dir.c                     | 91 +++++++++++++++++++++++++++++++++++++++
 fs/fuse/file.c                    |  6 +--
 fs/fuse/fuse_i.h                  | 31 +++++++++++--
 fs/fuse/inode.c                   | 89 +++++++++++++++++++++++---------------
 fs/fuse/virtio_fs.c               | 18 ++++++--
 include/uapi/linux/fuse.h         | 55 +++++++++++++++++++++--
 8 files changed, 294 insertions(+), 52 deletions(-)
