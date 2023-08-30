Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A1778D2F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 07:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbjH3F0x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 01:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjH3F0c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 01:26:32 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96676CD6;
        Tue, 29 Aug 2023 22:26:29 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52a4818db4aso6573070a12.2;
        Tue, 29 Aug 2023 22:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693373188; x=1693977988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oDZvkh1hF3aDS2iITfaL8ACcMeF68Nqg9pSmNA0vda4=;
        b=NPRNKBTEudi6JDWeS5FMZEuNrcaPB+yY14Hr44di/Ddyw3yT86znwna9O499HyJt56
         DRvvDyklFqQ/PVZOz0lHbGjFskD/6RSPgPSUMUPzqqKeI0W9F9JVZylP2jdhLBTjVIs9
         Ueud0dkDmTnYUcKF6gUDy9HxuyUNY3m0KE09f/1kW+Uq7N/27vA9G2FKGul0/uGlnAQm
         LcAb8zvzGnCOnDi0jOl2F+sJniz3NH+UAYOJ05yP2my74Tfis2oFjr2W8U4aJdbM6DJN
         5sAsUKdk06XS1tn4Bv4erirmaA/LXR8psIsMQ85QEgmBMA1Pav2h0yhV+xsknmmnXrDL
         ns+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693373188; x=1693977988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDZvkh1hF3aDS2iITfaL8ACcMeF68Nqg9pSmNA0vda4=;
        b=WxRWCN18Lm4Pa4fLfRjz441uMrjGp5UqzWNnel3lV8N+RqKsiaFCfYCQaPhTxuVBNM
         X/b7WMgSgdsnjr9O9EeNPoT7WRKYNCxSEJKxUfrSSPtqoukz6fejtAIbQK3l97pbxdnZ
         4/ywP9MiV+OF7VLwmaaKXTuNvOk2L2bIRqgB4VTmolP+pn6HCwxEeGZ0JqN0bTHiYPe8
         ZhQuJk4l73DEBS5j+n03jbrnWgXGnlbbC3h8VEZ9D7KGTKlLjHuPntgrzOR3xNUaL+I9
         /tbIO8a45qcSH+jBBwaBSzsbJfZohH+vU/vJjZCzzDtGmJkTS0FRGffyHaXhUm2OISjL
         yEIg==
X-Gm-Message-State: AOJu0YwEwhGcCpEhyA0l4NmIoFGulTHx0Baxfyk1XnL8usIoU7Gq3Q/Y
        PT9iQq70H1s1p0rYIa0ZtY8=
X-Google-Smtp-Source: AGHT+IGFHaxUNEsXsOwZkOtytkynv+7YLAJXj2psdvGLchpNZWA65vw/Xq21Lp1EDo5cqdPMgEfC6A==
X-Received: by 2002:aa7:d898:0:b0:52a:5848:c674 with SMTP id u24-20020aa7d898000000b0052a5848c674mr1142586edq.12.1693373187664;
        Tue, 29 Aug 2023 22:26:27 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id h12-20020aa7c94c000000b00528922bb53bsm6365472edt.76.2023.08.29.22.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 22:26:27 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs update for 6.6
Date:   Wed, 30 Aug 2023 08:26:22 +0300
Message-Id: <20230830052622.2334427-1-amir73il@gmail.com>
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

Resending the pull request with signed tag.

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

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-update-6.6

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
