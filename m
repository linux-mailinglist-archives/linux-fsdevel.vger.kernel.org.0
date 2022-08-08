Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F7C58C844
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Aug 2022 14:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242420AbiHHMUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Aug 2022 08:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiHHMUQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:20:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A7D1C4
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Aug 2022 05:20:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z16so10625465wrh.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Aug 2022 05:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=EGJh6H4Q+/4Jo4xNeP066GXEwQs4C4KMootOF9X7m5E=;
        b=m0qzJA/eP/VqrChusdQ4L8wxmlBRjqB1YRFbmJndfdkiQbKMoJKc+AEViatMKM3Png
         9E3SiqQXL6dLmfKG65A9rBnCsuEipXMZ7mmzY6C0vA0prs4C+YMj+qBIVJDr1oAZgNGi
         OmrhFHKz7YCVGe6CNhJzWTUM0EQVbEWv6FMS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=EGJh6H4Q+/4Jo4xNeP066GXEwQs4C4KMootOF9X7m5E=;
        b=KPuUlRcNA8270F0z1HjcQyXS5MUqUG4zp+UeaYcF6Smz4CO6Al3iYhJUuQIuWFodTA
         rD4+l+oIiKxBnalfpsnz+6BdlSk/yPWm9c0phhsdq78OIYl3VYX5rpEYZsq5T1lxIQry
         lnO38Le9CyAB6qS3I9J1jE5Ndcs9DSJrARRaW6eqIIx3C7rjQjON0+I+Z0qblvHXMfVO
         1OwC3+FeolUK0f34VcSo+HmhX7sxfTiNPsAv10nMGXZCxdx5O9b1aQ5zyUs8+vvfcl5h
         rrEJ92lzBipHHlDfez8akVaPIU3E/LnaJ4HOLMQaD/WtedWi8/fi22lob7SLjvTlb3w+
         uDWA==
X-Gm-Message-State: ACgBeo3dZl/lTNb8icfkpkfo/sK3qFhXeXnKCjqJhfX4ditDE+wMi3ys
        hosVC+F1fX8LuQUC6R0RwrspwA==
X-Google-Smtp-Source: AA6agR60elkz35zB7183HO8LE91+Te3/f/Ds1v/OD1bLTXqK+UVHlZSUlbrlcejfmICbANVtDEPA3A==
X-Received: by 2002:adf:fc47:0:b0:220:5f01:6a10 with SMTP id e7-20020adffc47000000b002205f016a10mr11672087wrs.7.1659961210759;
        Mon, 08 Aug 2022 05:20:10 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (87-97-117-187.pool.digikabel.hu. [87.97.117.187])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d6647000000b002217aed23b4sm8150586wrw.12.2022.08.08.05.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 05:20:09 -0700 (PDT)
Date:   Mon, 8 Aug 2022 14:20:02 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs update for 6.0
Message-ID: <YvD/cnBLsE8P8sWS@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-6.0

This is just a small update.

There's a merge conflict with the mnt-userns series from Christian.  This should
be resolved by moving the "#ifdef CONFIG_FS_POSIX_ACL" up, to include the newly
introduced ovl_idmap_posix_acl() helper.

Thanks,
Miklos

---
Jiachen Zhang (1):
      ovl: drop WARN_ON() dentry is NULL in ovl_encode_fh()

Miklos Szeredi (1):
      ovl: warn if trusted xattr creation fails

William Dean (1):
      ovl: fix spelling mistakes

Yang Li (1):
      ovl: fix some kernel-doc comments

Yang Xu (1):
      ovl: improve ovl_get_acl() if POSIX ACL support is off

---
 fs/overlayfs/export.c    |  2 +-
 fs/overlayfs/inode.c     |  4 +++-
 fs/overlayfs/namei.c     |  4 ++--
 fs/overlayfs/overlayfs.h |  6 ++++++
 fs/overlayfs/super.c     | 13 +++++++++----
 5 files changed, 21 insertions(+), 8 deletions(-)
