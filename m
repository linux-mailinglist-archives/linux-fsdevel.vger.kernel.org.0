Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C977B9E62
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 16:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjJEOFy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 10:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjJEOEM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:04:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ACD2755A;
        Thu,  5 Oct 2023 06:17:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-325e9cd483eso958992f8f.2;
        Thu, 05 Oct 2023 06:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696511842; x=1697116642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WXlipJ5qHf8e9WzUIEs4uK8a+42CDw8ODZV/LpXLiL4=;
        b=IF0b2SjaMzzCsgWmVj3AtXcx2CMEUysJkfnEGYEfOJ+tKcJXkmveIeTvgdDIRSGKUJ
         0CiGMGwgNCD96lkQSKf7b8bO2Us2VxnxjXiw7DtPCbRTrsgaiCax4zj7Q0kO5XHZFmhF
         JVPyivfwS4APQDYQADCif43xa9o8Xzj/BN0oG7ZKGBL8Zq0yoj92T55Y4cBizoP0kHIU
         NK4t0SP/o1Cx2iI3WOlrLJzSMtUefStGZUwMFImQvRKyXzox/wRrVOVNw9CKW60yTMAr
         xzLyzxg+dOoY7pEUujO//wtZcK/ViQfSm7V3mnxvG15GxrdNimRsz3m3NI2ce9jNvsmy
         8jcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696511842; x=1697116642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXlipJ5qHf8e9WzUIEs4uK8a+42CDw8ODZV/LpXLiL4=;
        b=V49zuU2fAqwFHawcTrlml9mKIm/y+3xjxy+3F+kFENks2LrorfR2g77EkOLPKqxcYS
         E/NaCgPbZ0ts8uGc2obe3Yqvc3p7OeXfjV/mrYmNobPKfiHXo31wf4uNwaCpi11pTkU/
         2TrXL0SoEtSnpk2EbskEbV3wjM8+Y+ZFuWGFlAAGVDRfuJv+VI+/itUvhXpXdIc/Xovo
         GVKM6BmgKkutZwyne2LLQF3poeOVNMhoYGSLJC9ttNAxvA5v1DmZyUS+CoG+lQ4sX+TQ
         dGzDH9Z/jzD/H/UoVezvJjqBjpj0Dh2tqS8Fbl7sbaj4LjDdNakg11gT6UmYSKjx5lUu
         b/LA==
X-Gm-Message-State: AOJu0YwbArR5SoPpy2EVnO/eJK13hKPKavsNccRtKcsm8nuEXrserar3
        jI3vVtFhiObZ6G0IkzKqSibVjraDvjo=
X-Google-Smtp-Source: AGHT+IEUVLYwY4LlX80eXxxgob1v9hgV4vJIQsGoUZs0H1UUoMKsIwxyGfugC8SCaot2oWvzkKyceQ==
X-Received: by 2002:a5d:4a05:0:b0:31f:a277:4cde with SMTP id m5-20020a5d4a05000000b0031fa2774cdemr5183667wrq.43.1696511841724;
        Thu, 05 Oct 2023 06:17:21 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id c3-20020adfed83000000b003250aec5e97sm1799762wro.4.2023.10.05.06.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 06:17:21 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 6.6-rc5
Date:   Thu,  5 Oct 2023 16:17:17 +0300
Message-Id: <20231005131717.1311531-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull overlayfs fixes for 6.6-rc5.

This branch has been sitting in linux-next for a couple of days and
it has gone through the usual overlayfs test routines.

The branch merges cleanly with master branch of the moment.

Thanks,
Amir.

----------------------------------------------------------------
The following changes since commit 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa:

  Linux 6.6-rc4 (2023-10-01 14:15:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-6.6-rc5

for you to fetch changes up to c7242a45cb8cad5b6cd840fd4661315b45b1e841:

  ovl: fix NULL pointer defer when encoding non-decodable lower fid (2023-10-03 09:24:11 +0300)

----------------------------------------------------------------
overlayfs fixes for 6.6-rc5:

- Fix for file reference leak regression from v6.6-rc2

- Fix for NULL pointer deref regression from v6.6-rc1

- Fixes for RCU-walk race regressions from v6.5:

   Two of the fixes were taken from Al's RCU pathwalk race fixes series
   with his concent [1].

   Note that unlike most of Al's series, these two patches are not about
   racing with ->kill_sb() and they are also very recent regressions from
   v6.5, so I think it's worth getting them into v6.5.y.

   There is also a fix for an RCU pathwalk race with ->kill_sb(), which
   may have been solved in vfs generic code as you suggested, but it also
   rids overlayfs from a nasty hack, so I think it's worth anyway.

[1] https://lore.kernel.org/linux-fsdevel/20231003204749.GA800259@ZenIV/

----------------------------------------------------------------
Al Viro (2):
      ovl: move freeing ovl_entry past rcu delay
      ovl: fetch inode once in ovl_dentry_revalidate_common()

Amir Goldstein (3):
      ovl: fix file reference leak when submitting aio
      ovl: make use of ->layers safe in rcu pathwalk
      ovl: fix NULL pointer defer when encoding non-decodable lower fid

 fs/overlayfs/export.c    |  2 +-
 fs/overlayfs/file.c      |  2 --
 fs/overlayfs/ovl_entry.h | 10 +---------
 fs/overlayfs/params.c    | 17 +++++++++--------
 fs/overlayfs/super.c     | 27 +++++++++++++++++----------
 5 files changed, 28 insertions(+), 30 deletions(-)
