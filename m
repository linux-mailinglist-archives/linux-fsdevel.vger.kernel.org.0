Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFEA11E83A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 17:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfLMQ0X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 11:26:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55611 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbfLMQ0W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:26:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so184016wmj.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2019 08:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=51qjue+Lhz7PmDgRPAGTCZbzojtbIVXyxCeZE2aMNjE=;
        b=iDxyPlsfMu31u66hSyVq5/bWBnE7w3FIEEQNFRIns/gD+2id91qJulDC35PNWGQW4M
         z15Av5sU9HBPXQkZIi0XTiOwMRCAnvKFQI8CQUibQ9lR8fRJutqnU0J2l0CaDTPsvuU2
         VahVlDApeiudV1fsYUDYuISFHXK15w/eB582g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=51qjue+Lhz7PmDgRPAGTCZbzojtbIVXyxCeZE2aMNjE=;
        b=PLArSlEuQDvHQmO1zvS6vrQMNFh0kITkngFLCIqJMwrWZqCWs/ApX0SzWtmVBXzWPF
         OOdLA4seiJ/3gDpS4DMNkb2gAiLgphwu7FbnogGp/b/0L+zQVORzeh9HLeaksTj79r9e
         qwdTqwvFde1zRiaoD+05ewMpuU1z9c3aXlHcDnZso4xl52HxKTLY06Cbfmac3tCY/PcZ
         7lvSOufAiYEEx6R5hpatuwrWEC+THd3oTcJzWjUyQO92JvAJNV/pKz+PZkB38H6RPFbO
         e4olxWNX0lkH/BiildQobY32v/PqoXHKvyxmrXTFMrHrnwp7P9zoYtEylw81/IX3aizN
         AG6w==
X-Gm-Message-State: APjAAAWuw6In0RGq2ztYGFheaI2Cn1KMbVPA/5gnI/rIk08HU4xvS/R3
        xBEh6qCQ+CJ7ySJPEbRz8LBh5JWZz7g=
X-Google-Smtp-Source: APXvYqzEJhQMLHR7HkP0qIFqLDe3n+JnIup+iSc+paWffU2Gi1zxfwx8kUgouUgm/GEu8xXHbSQkQg==
X-Received: by 2002:a7b:c246:: with SMTP id b6mr14182508wmj.75.1576254380923;
        Fri, 13 Dec 2019 08:26:20 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id a184sm11056008wmf.29.2019.12.13.08.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 08:26:20 -0800 (PST)
Date:   Fri, 13 Dec 2019 17:26:12 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 5.5-rc2
Message-ID: <20191213162612.GA5081@miu.piliscsaba.redhat.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.5-rc2

Fix some bugs and documentation.

Thanks,
Miklos

----------------------------------------------------------------
Amir Goldstein (7):
      ovl: fix lookup failure on multi lower squashfs
      ovl: make sure that real fid is 32bit aligned in memory
      ovl: don't use a temp buf for encoding real fh
      ovl: fix corner case of non-unique st_dev;st_ino
      ovl: relax WARN_ON() on rename to self
      docs: filesystems: overlayfs: Rename overlayfs.txt to .rst
      docs: filesystems: overlayfs: Fix restview warnings

---
 .../filesystems/{overlayfs.txt => overlayfs.rst}   | 10 +--
 MAINTAINERS                                        |  2 +-
 fs/overlayfs/copy_up.c                             | 53 +++++++-------
 fs/overlayfs/dir.c                                 |  2 +-
 fs/overlayfs/export.c                              | 80 +++++++++++++---------
 fs/overlayfs/inode.c                               |  8 ++-
 fs/overlayfs/namei.c                               | 52 ++++++++------
 fs/overlayfs/overlayfs.h                           | 34 +++++++--
 fs/overlayfs/ovl_entry.h                           |  2 +
 fs/overlayfs/super.c                               | 24 +++++--
 10 files changed, 166 insertions(+), 101 deletions(-)
 rename Documentation/filesystems/{overlayfs.txt => overlayfs.rst} (99%)
