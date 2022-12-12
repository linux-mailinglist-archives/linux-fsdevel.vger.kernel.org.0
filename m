Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFC6649D42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 12:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiLLLQp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 06:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiLLLQP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:16:15 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923E325D1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Dec 2022 03:10:47 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z92so12342298ede.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Dec 2022 03:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HbiaofHLZH1+eQ/j4x6PD7S/EmzHQlSBaHqxNP+0CDo=;
        b=l/e3VS2HZH8V2QZz1gkSxfenk5xukl2LbbBznedchdh+vHPVoKS7g4MWV1tlUo5T/z
         bvhVfU+h3dOe72zuMllXhSe2rqus76AmKwj7r1D41ek87ETd6x23AS5op1vCHYhK5Vkh
         7r4uXHx2GaBXJQISaTODPnP/D0TOaTDaDkA+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HbiaofHLZH1+eQ/j4x6PD7S/EmzHQlSBaHqxNP+0CDo=;
        b=X/I8SGLFeMUZCt9uNhSvMK2aaVQ7SMIuMvO/OLg6FmsN19v5JiqW9ZcqdDWLHDqBX6
         HKRqOD0pC0j3EfRnbplN1N6eiz1ULPgJ8KpCuJxf/9VwqNgcY16YifOviactexgOkN3C
         zQ1sLDJrT6fAbW3xpNHftUrZ8A0ikhIKbbeSGiE2toaWO/5P9SFyINHtgeM5HKm3SKa9
         EPEAm1CsZ0lIMi61nNqZxHUHrDj4tjLefxmhqCOLn2BFYzHhuEwOO6VTiIRnj3QuyGOz
         o3dYg0KjdqGsyvCL/yG7IlHSg2sEsF9Svd/qAW473dyova2UOGVt608TP+HJtav4Bm61
         nUyg==
X-Gm-Message-State: ANoB5pmRcvsuaOEL2dHBVlqrOL9KfE4y8+EsI7ozeeSwjCidrJacbmTd
        +nRElNLxm6SPFbjxVpRoEEia06kY+fRzsUfy
X-Google-Smtp-Source: AA0mqf5aAYhJ+ruuk796oKOJn5zMAafDXY9TP7vhsuckREguq08mio1/nxtl1oFRTDrd2O5LXHAACQ==
X-Received: by 2002:a05:6402:380a:b0:467:7b2e:88a2 with SMTP id es10-20020a056402380a00b004677b2e88a2mr13010236edb.19.1670843446183;
        Mon, 12 Dec 2022 03:10:46 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (193-226-215-206.pool.digikabel.hu. [193.226.215.206])
        by smtp.gmail.com with ESMTPSA id d9-20020aa7d5c9000000b004611c230bd0sm3683035eds.37.2022.12.12.03.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 03:10:45 -0800 (PST)
Date:   Mon, 12 Dec 2022 12:10:44 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse update for 6.2
Message-ID: <Y5cMNDpL5digt1rJ@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.2

 - Allow some write requests to proceed in parallel

 - Fix a performance problem with allow_sys_admin_access

 - Add a special kind of invalidation that doesn't immediately purge
   submounts

 - On revalidation treat the target of rename(RENAME_NOREPLACE) the same as
   open(O_EXCL)

 - Use type safe helpers for some mnt_userns transformations

 - Misc cleanups


Thanks,
Miklos

---
Christian Brauner (1):
      fuse: port to vfs{g,u}id_t and associated helpers

Dave Marchevsky (1):
      fuse: Rearrange fuse_allow_current_process checks

Dharmendra Singh (1):
      fuse: allow non-extending parallel direct writes on the same file

Fabio M. De Francesco (1):
      fs/fuse: Replace kmap() with kmap_local_page()

Jann Horn (1):
      fuse: Remove user_ns check for FUSE_DEV_IOC_CLONE

Jiachen Zhang (1):
      fuse: always revalidate rename target dentry

Miklos Szeredi (1):
      fuse: add "expire only" mode to FUSE_NOTIFY_INVAL_ENTRY

ye xingchen (1):
      fuse: remove the unneeded result variable

---
 fs/fuse/acl.c             |  2 +-
 fs/fuse/cuse.c            |  5 +----
 fs/fuse/dev.c             |  7 +++----
 fs/fuse/dir.c             | 43 +++++++++++++++++++++++++------------------
 fs/fuse/file.c            | 43 ++++++++++++++++++++++++++++++++++++++++---
 fs/fuse/fuse_i.h          |  4 ++--
 fs/fuse/readdir.c         |  4 ++--
 include/uapi/linux/fuse.h | 16 ++++++++++++++--
 8 files changed, 88 insertions(+), 36 deletions(-)
