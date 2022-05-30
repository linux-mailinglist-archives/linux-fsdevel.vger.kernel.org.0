Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718FD5376D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 10:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbiE3IR6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 May 2022 04:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiE3IR5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 May 2022 04:17:57 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAC711A0B
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 May 2022 01:17:53 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t5so12498170edc.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 May 2022 01:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=YSjVIXrz4aX1dpD91UET7Xaw2MPWafK4NrWr0v1gvIU=;
        b=EF2gtJoOMhhPECKiHY28H+iATlv2dq/o4/nOU3ygyYe/7wgW52995x891LTFHf2GDb
         NEY4/7Wl7kZPVhgFrDO5bWHPaQ2KcKmMaEFitbOqTLHrc0QbvJljDa74nlONPsC3vLmO
         e8PbDucVrkf96oq2id2sSF2If5k8zTyhL0Q/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=YSjVIXrz4aX1dpD91UET7Xaw2MPWafK4NrWr0v1gvIU=;
        b=FQhfFziDnAW/xXQxpQTK48GOfWaE9LdnDhYc1aCX55mU3QfpTgd1cWkpzeRdN7xFhc
         fYbtO6mhH/EHbm6NTX2JKswOAjRcYxVy/pz40Y+N2UYeUjjyrWCJG4NhQVbhRqAx8uvL
         EkyUbxU+xon/VkPI51Zt2qH+WVKG/+yPiwQpuDwyN6TFnkdkge57+5Z4ybMhKBwwkjNF
         Tx+SKG7pM5T3EmUnuVLkQyIV9VFf4fZ1YMy+eplczLn0nBXI14R0LSFqEZRqw2tA5ypT
         F8HBxmJdt6ltPIntUXTJjrVsBKgMnc9C1Rw+FkTiZj0pA8UzeDfUHDabpsfDn6rQl/aL
         /Lug==
X-Gm-Message-State: AOAM530/fAyoZqcYXEXTHFI2OLqoU8WA6aTCbmqnKtKXLu9lU6cemZAQ
        Mban18nrHj+18Pwp+es28Oy5gQ==
X-Google-Smtp-Source: ABdhPJyVWevsco2ThF7lWQUJr6+RGj1iLEFH43aT9ZE+5VZe50hGTKKueU6g9jvG0y8Oym2Aqp7DRw==
X-Received: by 2002:a05:6402:1113:b0:428:679e:f73f with SMTP id u19-20020a056402111300b00428679ef73fmr57733573edv.378.1653898672304;
        Mon, 30 May 2022 01:17:52 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-178-48-189-3.catv.fixed.vodafone.hu. [178.48.189.3])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090603c200b006fea59ef3a5sm3800929eja.32.2022.05.30.01.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 01:17:51 -0700 (PDT)
Date:   Mon, 30 May 2022 10:17:48 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs update for 5.19
Message-ID: <YpR9rJkjso7lXdFC@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-5.19

Support idmapped layers in overlayfs (Christian Brauner).  Add a fix to
exportfs that is relevant to open_by_handle_at(2) as well.  Also introduce
new lookup helpers that allow passing mnt_userns into inode_permission().

Thanks,
Miklos

---
Amir Goldstein (3):
      ovl: use wrappers to all vfs_*xattr() calls
      ovl: pass layer mnt to ovl_open_realfile()
      ovl: store lower path in ovl_inode

Christian Brauner (16):
      fs: add two trivial lookup helpers
      exportfs: support idmapped mounts
      ovl: pass ofs to creation operations
      ovl: add ovl_upper_mnt_userns() wrapper
      ovl: handle idmappings in creation operations
      ovl: pass ofs to setattr operations
      ovl: use ovl_do_notify_change() wrapper
      ovl: use ovl_lookup_upper() wrapper
      ovl: use ovl_path_getxattr() wrapper
      ovl: handle idmappings for layer fileattrs
      ovl: handle idmappings for layer lookup
      ovl: use ovl_copy_{real,upper}attr() wrappers
      ovl: handle idmappings in ovl_permission()
      ovl: handle idmappings in layer open helpers
      ovl: handle idmappings in ovl_xattr_{g,s}et()
      ovl: support idmapped layers

---
 fs/exportfs/expfs.c      |   5 +-
 fs/namei.c               |  70 ++++++++++++--
 fs/overlayfs/copy_up.c   |  90 +++++++++---------
 fs/overlayfs/dir.c       | 147 +++++++++++++++---------------
 fs/overlayfs/export.c    |   5 +
 fs/overlayfs/file.c      |  43 +++++----
 fs/overlayfs/inode.c     |  68 ++++++++------
 fs/overlayfs/namei.c     |  53 +++++++----
 fs/overlayfs/overlayfs.h | 232 +++++++++++++++++++++++++++++++++--------------
 fs/overlayfs/ovl_entry.h |   7 +-
 fs/overlayfs/readdir.c   |  48 +++++-----
 fs/overlayfs/super.c     |  57 ++++++------
 fs/overlayfs/util.c      | 103 ++++++++++++++++-----
 include/linux/namei.h    |   6 ++
 14 files changed, 598 insertions(+), 336 deletions(-)
