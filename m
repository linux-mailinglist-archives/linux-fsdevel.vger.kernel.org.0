Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DE136FD32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 17:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhD3PCm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 11:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhD3PCl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 11:02:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13676C06138B
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 08:01:53 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u17so105830689ejk.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 08:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=5UHGpcaMx0Q3w6doXFhQM8OM6zsZAjfn7y0jg47ADsI=;
        b=fAgLtYs/1RcLvcplly/5At3yUZGCKdJek+xjcQPooAQjHnGfN6nc7AcCTRcKAtin/N
         1Lw4aKyb6kVP0V+Kg7s3+h7kNJWDdgik3ilxLwECgkjd9jiGhWX+cKYnh5hfYmWJPk+F
         6TQiXMKa7HCPL3BPNS67u7pjCxpEyNSl5i6fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=5UHGpcaMx0Q3w6doXFhQM8OM6zsZAjfn7y0jg47ADsI=;
        b=gq4HvPGXCBRITIQr8Q7xWy3ixWNjUYce5rIvctkD/GPARLQFEVCvgsimq7kcduylcY
         B+50XLo2lNxNgi1E2MGForWTDPYqsBTSuIppyXTMf5+mlr0k1auMNFTr7hv+JZAtPi99
         fOYqnGffG649p+MMMg4KNSnlWhr90XJeLAh23F995rIaybt80MdlMB7ikzkDnp3NT4io
         4/hNQgyE5doTz/slXnfTnUZM404Mo6sztPXNdN18gXr8LQDK3Vxj6tatfJErm0QYvZsJ
         Vacy2ij3FKxHxzIO4ykhRfVI3tkz89yIoWf7ny8Io94fhYXxsExUsqV+bSPtLgdLhSLi
         9EIQ==
X-Gm-Message-State: AOAM532g5ozMtfPpkChfQdKtBF2Np6uiDE0hE8UU6j05+j5de1U/S/rW
        vGOyZE9CMklVn05JfzZUGUsuVg==
X-Google-Smtp-Source: ABdhPJzC2Nllq5OSNyxBNmAA3UzXxNQ+PCqsvXOlHf6ikdPfQoLtYnBpQiimp7XTxb1vQizmiCn0SA==
X-Received: by 2002:a17:906:8390:: with SMTP id p16mr4694084ejx.430.1619794911863;
        Fri, 30 Apr 2021 08:01:51 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id um28sm1718043ejb.63.2021.04.30.08.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 08:01:51 -0700 (PDT)
Date:   Fri, 30 Apr 2021 17:01:49 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse update for 5.13
Message-ID: <YIwb3caM4c2Mi7AR@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.13

- Fix a page locking bug in write (introduced in 2.6.26).

- Allow sgid bit to be killed in setacl().

- Miscellaneous fixes and cleanups.

Thanks,
Miklos

---
Alessio Balsini (1):
      fuse: fix matching of FUSE_DEV_IOC_CLONE command

Bhaskar Chowdhury (1):
      fuse: fix a typo

Connor Kuehl (2):
      fuse: fix typo for fuse_conn.max_pages comment
      virtiofs: split requests that exceed virtqueue size

Jiapeng Chong (1):
      virtiofs: remove useless function

Luis Henriques (1):
      virtiofs: fix memory leak in virtio_fs_probe()

Miklos Szeredi (4):
      fuse: don't zero pages twice
      virtiofs: fix userns
      cuse: prevent clone
      cuse: simplify refcount

Vivek Goyal (4):
      fuse: fix write deadlock
      fuse: extend FUSE_SETXATTR request
      fuse: add a flag FUSE_SETXATTR_ACL_KILL_SGID to kill SGID
      fuse: invalidate attrs when page writeback completes

---
 fs/fuse/acl.c             |  7 ++++-
 fs/fuse/cuse.c            | 12 ++++----
 fs/fuse/dev.c             |  7 ++---
 fs/fuse/file.c            | 71 +++++++++++++++++++++++++++++------------------
 fs/fuse/fuse_i.h          | 13 +++++++--
 fs/fuse/inode.c           |  7 +++--
 fs/fuse/virtio_fs.c       | 28 +++++++++++++------
 fs/fuse/xattr.c           |  9 ++++--
 include/uapi/linux/fuse.h | 14 ++++++++++
 9 files changed, 111 insertions(+), 57 deletions(-)
