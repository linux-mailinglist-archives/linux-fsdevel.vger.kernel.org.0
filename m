Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECA373EB22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 21:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjFZTTA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 15:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjFZTS6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 15:18:58 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D866E74;
        Mon, 26 Jun 2023 12:18:57 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so5070565a12.0;
        Mon, 26 Jun 2023 12:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687807136; x=1690399136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Kg1nZ4hOeDAaIXBqRDce7e5K0dOQDg1Un37VI6tUwo=;
        b=ltKsuubU2obGbd9SXpTrjS1TRaGJUAXgVjtGBHzl2yvthVjj7q87q+4gTI0L+pj8mt
         CuLTa5EHJQA3cWNZlG0b5uMdGNUBqZQ+nzoGuTRL/vDtUH0F5dfOs1PaC8At3wFIFyng
         MQMHtoP/BxnXux31FJTgt7BJxsDcVfktl8di6liaAf3Oy1lqtwR9yvndaUlgPDiBg+aM
         MaCvHSJ6i3RyendPmDZz2uwFgmoM6UkZ/ZNNYqWXT4WM7CgoyIWqp840hK0/x25iXpmW
         GJUb3MGmgubmSE+OghGkrEssjizwLQaRKrPErDdGIOUnm4T8+ltKUVCkoSGnRwGooNbU
         hCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687807136; x=1690399136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Kg1nZ4hOeDAaIXBqRDce7e5K0dOQDg1Un37VI6tUwo=;
        b=BkN8lZsMMc/mXr2XrIBz19oXxLFsEANKi+IsyAJCcET9W9g7zzXjK7EaUMxXV20e0p
         h2wknC7Qr3ujhighB7BRn/mjihxi6F+zBLUjPsh10HwzauLPtqZ6Q9jns0Dt/5cdWXM3
         JvZ8js+bZh3K2B1eouLWz0eQ1ttwSlqidmELUlX0+mgIDNK5GldZTz9Tjex0k444miZo
         N8TMEhgOkNAKsqksVKuwKpUVo1hsG3iBG8JpOqDbw9MLqRbYkoqc/fDPMQnqlLnDnkDp
         VrwP0Do8oZBEZYdDFirxWREpUY0PSZp2GdKPvfVDN5QzuPRaVFWkCPxjBbqhzaV+nC4Z
         PqRg==
X-Gm-Message-State: AC+VfDzU8avkDUt7sm5Pyl+nB0rKpFZSg6JR+d0kKXt0Uj0r52nrjT6h
        Y7VUVfnHjDjES588GPufRUTLp/CaDNU=
X-Google-Smtp-Source: ACHHUZ4dsfofHJ3Irjc3LkUL0ZcMTu/qeYpOtT+2gChf6nm7c9kA4R+XQl6QKvBCG6X71uHgaB4iiQ==
X-Received: by 2002:a05:6402:689:b0:51d:a238:abb2 with SMTP id f9-20020a056402068900b0051da238abb2mr2006013edy.5.1687807135656;
        Mon, 26 Jun 2023 12:18:55 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id k19-20020a05640212d300b0051d988bd64bsm1517201edx.97.2023.06.26.12.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 12:18:55 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs update for 6.5
Date:   Mon, 26 Jun 2023 22:18:49 +0300
Message-Id: <20230626191849.3451873-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

I am joining Miklos in the maintanance of overlayfs kernel code.
This is my first pull request, so I hope I got everything in order.

This branch has been sitting in linux-next for over a week and it
has gone through all the usual overlayfs test routines.
It merges cleanly with master branch of the moment.

FYI, there is an overlayfs related vfs change (struct backing_file) [6]
that was just merged via Christain's vfs tree [7].
That change is independent of the overlayfs changes in this pull request.
Nevertheless, the changes in this pull request have been tested together
with that vfs change.

Please refer to details about contained patch sets below.

Thanks,
Amir.

----------------------------------------------------------------

The following changes since commit 858fd168a95c5b9669aac8db6c14a9aeab446375:

  Linux 6.4-rc6 (2023-06-11 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git tags/ovl-update-6.5

for you to fetch changes up to 62149a745eee03194f025021640c80b84353089b:

  ovl: add Amir as co-maintainer (2023-06-20 18:29:12 +0300)

----------------------------------------------------------------
overlayfs update for 6.5

Contains the following patch sets:

- Zhihao Cheng investigated and fixed two NULL pointer deref bugs
  [1] ovl: Fix null ptr dereference at realinode in rcu-walk

- Added support for "data-only" lower layers destined to be used by composefs
  [2] Overlayfs lazy lookup of lowerdata

- Christian Brauner ported overlayfs to the new mount api
  [3] Prep patches for porting overlayfs to new mount api
  [4] ovl: port to new mount api & updated layer parsing
  [5] ovl: reserve ability to reconfigure mount options with new mount api

[1] https://lore.kernel.org/r/20230516141619.2160800-1-chengzhihao1@huawei.com
[2] https://lore.kernel.org/r/20230427130539.2798797-1-amir73il@gmail.com
[3] https://lore.kernel.org/r/20230617084702.2468470-1-amir73il@gmail.com
[4] https://lore.kernel.org/r/20230605-fs-overlayfs-mount_api-v3-0-730d9646b27d@kernel.org
[5] https://lore.kernel.org/r/20230620-fs-overlayfs-mount-api-remount-v1-1-6dfcb89088e3@kernel.org
[6] https://lore.kernel.org/r/20230615112229.2143178-1-amir73il@gmail.com
[7] https://lore.kernel.org/r/20230623-waldarbeiten-normung-c160bb98bf10@brauner

----------------------------------------------------------------
Amir Goldstein (18):
      ovl: update of dentry revalidate flags after copy up
      ovl: use OVL_E() and OVL_E_FLAGS() accessors
      ovl: use ovl_numlower() and ovl_lowerstack() accessors
      ovl: factor out ovl_free_entry() and ovl_stack_*() helpers
      ovl: move ovl_entry into ovl_inode
      ovl: deduplicate lowerpath and lowerstack[]
      ovl: deduplicate lowerdata and lowerstack[]
      ovl: remove unneeded goto instructions
      ovl: introduce data-only lower layers
      ovl: implement lookup in data-only layers
      ovl: prepare to store lowerdata redirect for lazy lowerdata lookup
      ovl: prepare for lazy lookup of lowerdata inode
      ovl: implement lazy lookup of lowerdata in data-only layers
      ovl: negate the ofs->share_whiteout boolean
      ovl: clarify ovl_get_root() semantics
      ovl: pass ovl_fs to xino helpers
      ovl: store enum redirect_mode in config instead of a string
      ovl: factor out ovl_parse_options() helper

Christian Brauner (4):
      ovl: check type and offset of struct vfsmount in ovl_entry
      ovl: port to new mount api
      ovl: modify layer parameter parsing
      ovl: reserve ability to reconfigure mount options with new mount api

Miklos Szeredi (1):
      ovl: add Amir as co-maintainer

Zhihao Cheng (3):
      ovl: let helper ovl_i_path_real() return the realinode
      ovl: fix null pointer dereference in ovl_permission()
      ovl: fix null pointer dereference in ovl_get_acl_rcu()

 Documentation/filesystems/overlayfs.rst |  44 +-
 MAINTAINERS                             |   1 +
 fs/overlayfs/Makefile                   |   2 +-
 fs/overlayfs/copy_up.c                  |  11 +
 fs/overlayfs/dir.c                      |   9 +-
 fs/overlayfs/export.c                   |  41 +-
 fs/overlayfs/file.c                     |  21 +-
 fs/overlayfs/inode.c                    |  73 +--
 fs/overlayfs/namei.c                    | 201 +++++--
 fs/overlayfs/overlayfs.h                | 106 +++-
 fs/overlayfs/ovl_entry.h                |  91 +++-
 fs/overlayfs/params.c                   | 389 ++++++++++++++
 fs/overlayfs/readdir.c                  |  19 +-
 fs/overlayfs/super.c                    | 907 +++++++++++++++-----------------
 fs/overlayfs/util.c                     | 179 +++++--
 15 files changed, 1390 insertions(+), 704 deletions(-)
 create mode 100644 fs/overlayfs/params.c
