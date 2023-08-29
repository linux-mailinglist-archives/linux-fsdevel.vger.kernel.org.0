Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6349F78C258
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 12:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbjH2Kfb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 06:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbjH2KfZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:35:25 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7A219A;
        Tue, 29 Aug 2023 03:35:21 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31aeef88a55so3470403f8f.2;
        Tue, 29 Aug 2023 03:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693305319; x=1693910119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BUbeRqeh9uNIjLySiGI5zkMUywv5IH9VIu1bjik05/Y=;
        b=KmW09QY5lB3y14ciY4LmuGK5Fa5z0SSRSvCPNNuY/4m1V9jiJgCcCIK3dLTSaRDxwl
         mQgMW2sXdaneX12U+V9tFEXKhrMUxJW5YJ7HaAoJyoS65DJ2WRKpk0VcERDJ6lmf5eMW
         qsBv4RHwQfJ+XYJ3kv4m1IM3/8OJ4l1JFsCLei02BbIY4ZxQ6xVJ8M9g99LqcsiQ5+ZM
         7qXdcgBXZz7SMnCQI9TZg4THx1QL+EXVJIZvSPlWOsqPiSftAwAAF5RLXZ770WBtiqWo
         521DK10adbeg1er42c28VJg/MvoGmGKshLu3IQqLSk176i4jKZt6vBEO/0K/Ei59p6OF
         vrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693305319; x=1693910119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BUbeRqeh9uNIjLySiGI5zkMUywv5IH9VIu1bjik05/Y=;
        b=G1fuFvSFXZXQZriPRrEdSXve16gQHnpm/VAbKsAZszcaBcvG4o1bYKy8At8onfFfWU
         0ZqO+3aAyNrJrEJkKBdjyCHx7YpEIrtakb+FnH7qeQC6tvULSRg4TXN+nRkm5phG+PsN
         MIidub5qXCYuGqImwccB4F0hPizYOG5AgSeCU0x5Altz1Sk/uDfjyh0ma4fAbXXgkcaX
         UBZNUXqBeqMgMBcGcuJNBisb+NajRDdeWo28uanhIiGlihwD0AbWvnREgtx/LnsMB7XB
         3rp0n/YlaWS7VRTbJ3NzpqBfzHL7LfGFc/kmtHOWBucK9l+a9jXgkHcsB9No63VZcmBE
         LzAA==
X-Gm-Message-State: AOJu0YwT4oOKb9WdqPg4cfHY38JblsugUwp6l3+yD5N33PUtJc1uxgxW
        +aN67UDqlu07m2HRJGzKrh+oR/b31Jc=
X-Google-Smtp-Source: AGHT+IFhi/cF5MH7ZYKdSkQgLJ415vkaILp3GEY8mGQq9JwMIOPTKqsR4ZhNYEo9VLt1WGVCu5bVsA==
X-Received: by 2002:adf:f892:0:b0:317:6c19:6445 with SMTP id u18-20020adff892000000b003176c196445mr21725890wrp.39.1693305319344;
        Tue, 29 Aug 2023 03:35:19 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id a12-20020adfe5cc000000b0030ada01ca78sm13350849wrn.10.2023.08.29.03.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 03:35:18 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs update for 6.6
Date:   Tue, 29 Aug 2023 13:35:12 +0300
Message-Id: <20230829103512.2245736-1-amir73il@gmail.com>
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

This branch has been sitting in linux-next for several weeks and it
has gone through all the usual overlayfs test routines.

The branch has also been tested together with the changes in
Christain's vfs tree, which have been merged to master yesterday.

The branch merges cleanly with master branch of the moment.

Please refer to details about contained patch sets below.

Thanks,
Amir.

----------------------------------------------------------------

The following changes since commit 52a93d39b17dc7eb98b6aa3edb93943248e03b2f:

  Linux 6.5-rc5 (2023-08-06 15:07:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git overlayfs-next

for you to fetch changes up to adcd459ff805ce5e11956cfa1e9aa85471b6ae8d:

  ovl: validate superblock in OVL_FS() (2023-08-12 19:02:54 +0300)

----------------------------------------------------------------

Overlayfs update for 6.6

Contains the following patch sets:

Alexander Larsson added the verification feature needed by composefs
- [1] Add support for fs-verity checking of lowerdata

Amir Goldstein improved integration of overlayfs and fanotify
- [2] Report overlayfs file ids with fanotify

Andrea Righi fortified some overlayfs code
- [3] overlayfs: debugging check for valid superblock

[1] https://lore.kernel.org/r/cover.1687345663.git.alexl@redhat.com
[2] https://lore.kernel.org/r/20230713120344.1422468-1-amir73il@gmail.com
[3] https://lore.kernel.org/r/20230521082813.17025-1-andrea.righi@canonical.com

----------------------------------------------------------------
Alexander Larsson (4):
      ovl: Add framework for verity support
      ovl: Add versioned header for overlay.metacopy xattr
      ovl: Validate verity xattr when resolving lowerdata
      ovl: Handle verity during copy-up

Amir Goldstein (4):
      ovl: support encoding non-decodable file handles
      ovl: add support for unique fsid per instance
      ovl: store persistent uuid/fsid with uuid=on
      ovl: auto generate uuid for new overlay filesystems

Andrea Righi (3):
      ovl: Kconfig: introduce CONFIG_OVERLAY_FS_DEBUG
      ovl: make consistent use of OVL_FS()
      ovl: validate superblock in OVL_FS()

 Documentation/filesystems/fsverity.rst  |   2 +
 Documentation/filesystems/overlayfs.rst |  72 ++++++++++
 fs/overlayfs/Kconfig                    |   9 ++
 fs/overlayfs/copy_up.c                  |  54 +++++++-
 fs/overlayfs/export.c                   |  36 +++--
 fs/overlayfs/file.c                     |   8 +-
 fs/overlayfs/inode.c                    |   8 +-
 fs/overlayfs/namei.c                    |  89 ++++++++++--
 fs/overlayfs/overlayfs.h                |  66 ++++++++-
 fs/overlayfs/ovl_entry.h                |   9 +-
 fs/overlayfs/params.c                   |  96 +++++++++++--
 fs/overlayfs/super.c                    |  40 ++++--
 fs/overlayfs/util.c                     | 233 ++++++++++++++++++++++++++++++--
 13 files changed, 654 insertions(+), 68 deletions(-)
