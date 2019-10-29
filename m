Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2290E88A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2019 13:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387979AbfJ2Mr2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Oct 2019 08:47:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38004 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387960AbfJ2Mr1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:47:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id v9so13500384wrq.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2019 05:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=6VqIj3BTfFgV4L15YGzzwv6yyFmVnbm7JQmLRtMKsic=;
        b=CfxPPaDekZp7Q3u2GYPK2Du+jE1BNYcTQSKcDF5cLZnsRZZwbwlKGn0v6Lag4uMheH
         pr6at2+zXWlfkIVglgv3gVRED3ewZjIBNRcJdFSK/UMybQo2xr7hrahVXBrn3ff9P6wZ
         bFNSTFOjxn/qUDPxzBiLa0a/JuFbX9XODa7q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6VqIj3BTfFgV4L15YGzzwv6yyFmVnbm7JQmLRtMKsic=;
        b=ID6POelMhp4uP6yvjVhzyiMhlEAaVUNt8oIHAwj3g85Gnw9QlmVPumUzyOa9QRWW+S
         NIWNPG43/DrOG4yAB245Kw1axznes7gCCw9N+9ax2yyZvkqGQ6ocBySAwE0pEYPjtptm
         TJ1jc2ucHt40KbWK5P5CHQzvIOs+sombb1yuwbVdLZCeIGc6KKvcFjMynMMm/i0iDpj0
         k2QUEr7L2LC1goyq/Nnel4HC8xMiI2SfaIdkAg9BnxK4w1eaKPQ0LwfRmaFVYgqCSPOt
         NJOH0iZFN2QFTM/CEkQgWcVAtuKIIa+SSLk/uuwpAVSGBb6ZpMMIaueiXrHDXdgp2nnP
         65Gw==
X-Gm-Message-State: APjAAAUZS8jFTbLYcqgZt4uM7ygKjiXfoLpmUJwu7NMurn6BMNmxSf4+
        2B/OsG48C2nbc/vVMTyfufuw1w==
X-Google-Smtp-Source: APXvYqxP32WsuIeX0uHdKVMlzu2T3N+gMRJC+9wtmoLuOudI6BOZebwGZYeFObYe4CxYzxOkt41AhA==
X-Received: by 2002:a5d:4142:: with SMTP id c2mr18809312wrq.208.1572353244608;
        Tue, 29 Oct 2019 05:47:24 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id l4sm1953002wml.33.2019.10.29.05.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 05:47:23 -0700 (PDT)
Date:   Tue, 29 Oct 2019 13:47:17 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse fixes for 5.4-rc6
Message-ID: <20191029124717.GA7805@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.4-rc6

Mostly virtiofs fixes, but also fixes a regression and couple of
longstanding data/metadata writeback ordering issues.

Thanks,
Miklos

----------------------------------------------------------------
Alan Somers (1):
      fuse: Add changelog entries for protocols 7.1 - 7.8

Miklos Szeredi (5):
      virtio-fs: don't show mount options
      fuse: don't dereference req->args on finished request
      fuse: don't advise readdirplus for negative lookup
      fuse: flush dirty data/metadata before non-truncate setattr
      fuse: truncate pending writes on O_TRUNC

Vasily Averin (1):
      fuse: redundant get_fuse_inode() calls in fuse_writepages_fill()

Vivek Goyal (6):
      virtio-fs: Change module name to virtiofs.ko
      virtiofs: Do not end request in submission context
      virtiofs: No need to check fpq->connected state
      virtiofs: Set FR_SENT flag only after request has been sent
      virtiofs: Count pending forgets as in_flight forgets
      virtiofs: Retry request submission from worker context

zhengbin (1):
      virtiofs: Remove set but not used variable 'fc'

---
 fs/fuse/Makefile          |   3 +-
 fs/fuse/dev.c             |   4 +-
 fs/fuse/dir.c             |  16 ++++-
 fs/fuse/file.c            |  14 ++--
 fs/fuse/fuse_i.h          |   4 ++
 fs/fuse/inode.c           |   4 ++
 fs/fuse/virtio_fs.c       | 169 +++++++++++++++++++++++++++++++---------------
 include/uapi/linux/fuse.h |  37 ++++++++++
 8 files changed, 186 insertions(+), 65 deletions(-)
