Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BB91F4850
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 22:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgFIUvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 16:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgFIUvW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 16:51:22 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D9EC05BD1E
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2020 13:51:22 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l1so17454315ede.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2020 13:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=/y9dYR6ipsrXxfQFlRgDb6aikKjjg5AsYUdNwg7G6sQ=;
        b=EddfEhvE3n6EoBqklkZnoc3heML5SxW0Q+mXWNhL0spxNvhg+HnsGT4LuyMyfjrX5u
         2EWLmDb4lNZ8mrhJqqRlntEmD9wqscmDdaO16IHTpi+PfAZZ/nBnxyHzxSrlQ98XtCQL
         irOToCGfike8Wke7l6PzOZ8RkntnqqLlAazfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/y9dYR6ipsrXxfQFlRgDb6aikKjjg5AsYUdNwg7G6sQ=;
        b=ZpJb1Kw3WqENMbCUs2EXFmTamGnVRm+VcYUM5RMVvJ0kRK1WnsQ0PJi0v96AKGhroK
         hijW7MpjJoOXop1c10KwigXJFpCmZtn/UsQP6TRKSJlRDO4jkADGJOM9NSYSM/RA55tr
         0xkMoclO0rqxB5DsY0zKPrDPVDUV2UacT0MH3voAnYX49HKFW5I9y4aSqh/X+p1+AvF7
         THMrcEHj4Wr4AJoBoErMhQG/z8ylMHKrlW7VsoZxillbXezK8pAxUmLG5SIgkZR8a5kP
         wuKMhuv8N3CGzI7FhNV9dfo+GqhrtTbtLoiCFpIhTFoAihLWvtqvWuRNKzegBdJdDGY2
         1HyA==
X-Gm-Message-State: AOAM532S95mhXdZf8j1nNC1y7AceRk7yM0GXpIQMVKFNEAzBuqabGvib
        QIeA7/+22w8itGI74+8h1liR+Q==
X-Google-Smtp-Source: ABdhPJw5eBUufWX6FXjVIySHAIIRUYEWfyi9EQ8br9v22WGMqbnAyfy1SGFbOSqFLStqfonzwBmX4Q==
X-Received: by 2002:a50:cd17:: with SMTP id z23mr27695991edi.326.1591735880762;
        Tue, 09 Jun 2020 13:51:20 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id j11sm13805170ejk.67.2020.06.09.13.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 13:51:20 -0700 (PDT)
Date:   Tue, 9 Jun 2020 22:51:18 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse update for 5.8
Message-ID: <20200609205118.GC6171@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.8

 - Fix a rare deadlock in virtiofs.

 - Fix st_blocks in writeback cache mode.

 - Fix wrong checks in splice move causing spurious warnings.

 - Fix a race between a GETATTR request and a FUSE_NOTIFY_INVAL_INODE
   notification.

 - Use rb-tree instead of linear search for pages currently under writeout by
   userspace.

 - Fix copy_file_range() inconsistencies.

Thanks,
Miklos

---
Eryu Guan (1):
      fuse: invalidate inode attr in writeback cache mode

Kirill Tkhai (1):
      fuse: Update stale comment in queue_interrupt()

Masayoshi Mizuma (1):
      virtiofs: Add mount option and atime behavior to the doc

Maxim Patlasov (1):
      fuse: optimize writepages search

Miklos Szeredi (8):
      fuse: always flush dirty data on close(2)
      fuse: always allow query of st_dev
      fuse: use dump_page
      fuse: fix weird page warning
      fuse: don't check refcount after stealing page
      fuse: update attr_version counter on fuse_notify_inval_inode()
      fuse: fix copy_file_range cache issues
      fuse: copy_file_range should truncate cache

Vasily Averin (1):
      fuse: BUG_ON correction in fuse_dev_splice_write()

Vivek Goyal (2):
      virtiofs: schedule blocking async replies in separate worker
      virtiofs: do not use fuse_fill_super_common() for device installation

---
 Documentation/filesystems/virtiofs.rst |  14 ++++
 fs/fuse/dev.c                          |  14 ++--
 fs/fuse/dir.c                          |  12 +++-
 fs/fuse/file.c                         | 120 +++++++++++++++++++++++++--------
 fs/fuse/fuse_i.h                       |   3 +-
 fs/fuse/inode.c                        |  26 +++++--
 fs/fuse/virtio_fs.c                    | 115 ++++++++++++++++++++-----------
 7 files changed, 219 insertions(+), 85 deletions(-)
