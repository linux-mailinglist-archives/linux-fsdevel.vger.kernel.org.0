Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2F9155AC4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 16:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgBGPeG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 10:34:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36865 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGPeG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 10:34:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id f129so3248726wmf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2020 07:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ubc3i5ioC2Mng+1ZCGgqSjrhQMsUN/k5l/kXQrpKbbE=;
        b=pNDfYKDmis0ZIoYPys46LJ3eBdCjoVxn/3v2EnQ5eEWQihKfa+ZrD8+lDIJelNtsNE
         zCo0dqacfo1f14irXeNginpPFf3515oPjUrcUERQz+lgH3XM4gqZDueiPG9dYdxnmXNM
         7EvdJylctaaygZHqEZLPF2Fo0khFqQ9PxyZfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ubc3i5ioC2Mng+1ZCGgqSjrhQMsUN/k5l/kXQrpKbbE=;
        b=GT8+gXiyHJsabzqmV0WIUUK3iHEm3hvqP90jQn5zSpZTTJ5r0X7R5WpR7AQQdRNIAD
         Rn7WD7N7l/Y5Kyojq2Q2nFwoAR43dMs/s6jtLvWrHvg/6U9MNMzzKJQw45NmglsFmUOl
         9rhSD4hUWrLvYwEvAlE+kSdnx8AqJ50nxgpc/WFFCMJ85C5fbemetTX+7aJ7DwbErlqn
         FdbCb2BNFhU+Wnm3yH3z10WSn4eRnPcpX7lzqQBsNbnYGqO7z+IbnEwrJg/DLKVJ2Poz
         B+BGrNM5zebDgyq4LOMZl6Hr2n0qADEIMZK+WoWtm3vTCPxq34+yKPKjIwj1WrHcGn/r
         /oig==
X-Gm-Message-State: APjAAAV7A+4CMdmppn/MyfT4FBptF9Z1/zoFIU3TrEMI1vNDFtm4kAu1
        qiExfpVbdASuUYpkd/6chwLgTQ==
X-Google-Smtp-Source: APXvYqy/NpI+jwi7ubi9A744y5HRTbyCjOoLff8EQAzbvpxGaSxGkf5a/khVgfzxuK6X4nsXyrH/yw==
X-Received: by 2002:a1c:9e89:: with SMTP id h131mr4922099wme.161.1581089644697;
        Fri, 07 Feb 2020 07:34:04 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id i16sm3983836wmb.36.2020.02.07.07.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 07:34:04 -0800 (PST)
Date:   Fri, 7 Feb 2020 16:34:01 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse fixes for 5.6-rc1
Message-ID: <20200207153401.GC7822@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.6-rc1

- Fix a regression introduced in v5.1 that triggers WARNINGs for some fuse
filesystems.

- Fix an xfstest failure.

- Allow overlayfs to be used on top of fuse/virtiofs.

- Code and documentation cleanups.

Thanks,
Miklos

----------------------------------------------------------------
Daniel W. S. Almeida (1):
      Documentation: filesystems: convert fuse to RST

Miklos Szeredi (2):
      fix up iter on short count in fuse_direct_io()
      fuse: don't overflow LLONG_MAX with end offset

Vivek Goyal (1):
      fuse: Support RENAME_WHITEOUT flag

zhengbin (1):
      fuse: use true,false for bool variable

---
 Documentation/filesystems/{fuse.txt => fuse.rst} | 163 ++++++++++-------------
 Documentation/filesystems/index.rst              |   1 +
 MAINTAINERS                                      |   2 +-
 fs/fuse/cuse.c                                   |   4 +-
 fs/fuse/dir.c                                    |   2 +-
 fs/fuse/file.c                                   |  21 ++-
 fs/fuse/inode.c                                  |  14 +-
 fs/fuse/readdir.c                                |   2 +-
 8 files changed, 104 insertions(+), 105 deletions(-)
 rename Documentation/filesystems/{fuse.txt => fuse.rst} (80%)
