Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB143BD95A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jul 2021 17:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhGFPHY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jul 2021 11:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhGFPHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jul 2021 11:07:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4CAC06178A
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jul 2021 08:04:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i8so13574308wrp.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jul 2021 08:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=JCBMF9vHR/Rrjh5BrR+kMlczFWACyGKUHset9TNb2Zk=;
        b=ELLUQ3fuq0cj/exlOl0M3y+CWWAtqQYzs0TPqxhInL2IZQylEw5X6bBu7flm6JozP3
         ZRfn1JBS1RxtXe7wm3ib2OpSO1UakQe6+nlHzbYaRFE4q2daDZQIFGQ1fc+sbBPq5toU
         r0qz5zs+OKZCokpsm7fWWp6Tubbcn69diWK0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=JCBMF9vHR/Rrjh5BrR+kMlczFWACyGKUHset9TNb2Zk=;
        b=jkIwado+3eNDU54emd09RWlNlmQwBYgyZYIbeJvFJh1NU6scR7G97ZD70bFpsa5/jc
         +9J/Gcd367Vk1kkvCSsbBXajuLJBjNe7Kz7oU1LcTRvruQu4SFWYbLOL3artraNTKcOW
         ynCS2KNPc5Ld6LYRwQMu1tH/wcm4wABlZjxhxBU2DkfosNq7+hSBrzKBY5PwBWmLr7NN
         ICnpezDsS1CgMoLo+8b7kqtRKUWZ0UgOOSbSS2rDAaPfog62g1O79/EID9oU4cTa/S+G
         wDRYX2cPBNnCQVYu6Ym7zkjiD/y1XsX5y9SpqTidLjybU/61YEvf6NlFbKY0NBCXqzog
         Xs2g==
X-Gm-Message-State: AOAM532IBJVVWTQic2L4yTJekovC3x7LPoqpeLJcmaueRgyMwz5nk40F
        MUMeY7cWKIzbFU/QRfip1N3Lag==
X-Google-Smtp-Source: ABdhPJwkBKOJn9nMEw8deIdTSXyDiTErmXI4RJQ4JASn+VY6niIGSxa/y0Qo+GW9fgNfhmTRNKNkVw==
X-Received: by 2002:a05:6000:1acb:: with SMTP id i11mr22026300wry.120.1625583883741;
        Tue, 06 Jul 2021 08:04:43 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id 12sm3425491wme.28.2021.07.06.08.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 08:04:43 -0700 (PDT)
Date:   Tue, 6 Jul 2021 17:04:35 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse update for 5.14
Message-ID: <YORxA9+DVLqNlH99@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.14

- Fixes for virtiofs submounts

- Misc fixes and cleanups

Thanks,
Miklos

---
Amir Goldstein (1):
      fuse: fix illegal access to inode with reused nodeid

Greg Kurz (8):
      fuse: Fix crash in fuse_dentry_automount() error path
      fuse: Fix crash if superblock of submount gets killed early
      fuse: Fix infinite loop in sget_fc()
      virtiofs: propagate sync() to file server
      fuse: add dedicated filesystem context ops for submounts
      fuse: Call vfs_get_tree() for submounts
      fuse: Switch to fc_mount() for submounts
      fuse: Make fuse_fill_super_submount() static

Miklos Szeredi (3):
      fuse: ignore PG_workingset after stealing
      fuse: check connected before queueing on fpq->io
      fuse: reject internal errno

Richard W.M. Jones (1):
      fuse: allow fallocate(FALLOC_FL_ZERO_RANGE)

Wu Bo (1):
      fuse: use DIV_ROUND_UP helper macro for calculations

Zheng Yongjun (1):
      virtiofs: Fix spelling mistakes

---
 fs/fuse/dax.c             |   6 +--
 fs/fuse/dev.c             |  14 ++++++-
 fs/fuse/dir.c             |  63 +++++------------------------
 fs/fuse/file.c            |  14 ++++---
 fs/fuse/fuse_i.h          |  24 ++++++-----
 fs/fuse/inode.c           | 100 ++++++++++++++++++++++++++++++++++++++++++++--
 fs/fuse/readdir.c         |   7 +++-
 fs/fuse/virtio_fs.c       |   4 ++
 include/uapi/linux/fuse.h |  10 ++++-
 9 files changed, 161 insertions(+), 81 deletions(-)
