Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BFD69D426
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 20:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjBTTiV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 14:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjBTTiR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:38:17 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9630E9775
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 11:38:13 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 51F8E3F20F
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 19:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676921890;
        bh=jW91GFwHa0q+MwWu64cv8oJoKWfJC8HOCJGt4MYrAGA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=k53De/kHoO50vIgo8RG2gNL6HaUSZ4yQVLOEIk1PGcfcES9EkaD8+dOUq5n8r8lVG
         WJPdaK1wIFbHrDJMGIWj748CJ7a90Aa0Uor5Qbj3Gr7gW7brJ926xRLrahi2cIc6Po
         gR9+tH2pUX3oI9ztFxOJ1Ii/MsJi/NiOtLJNa41uItHp8kCOQY6SPstxvT/3guPt+K
         35NrFI4GYnbtW91oBWjFYSmp98eijxm3S2Zf46M9YRdoBCJ6WWcrr0340BK/PJvLDJ
         pKnUPdF21OPSqGmS4uY7Xumm57aBz6yybjoxp7FmY6CQy1G2hd6f8CyeIvvhxZJa4D
         nMikXDEaVNdzw==
Received: by mail-ed1-f69.google.com with SMTP id c1-20020a0564021f8100b004acbe232c03so2623500edc.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 11:38:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jW91GFwHa0q+MwWu64cv8oJoKWfJC8HOCJGt4MYrAGA=;
        b=Cm9MwKR+vixuC9O2uAjAMHxmwjYoSex6iUDVuwue5T9qob8c4wewThgEkvEgjvlGWd
         qC8C1C1v4qK1P2G1cFU2SJ67fLM6/1UI++HxZqYW9Fd0xHN4Zh/OF8O3trTfa8HOwxmG
         pIAB7kgkbj8FcGBnk8OmvLRYDN2r1IibGnjzK1LZXzoeeKmbqtmXWs6rP5g1NLHJLMQ/
         AbFsno0Qt7vFbCznDHV9Rjh5cxLe8QDKz5ZdU+Uvl0z1JaH3JYPEyPUous+3qnjYzRc+
         zgrHNchbdu+AY7NElJVJ82BuPGfywjimp2rI3vfiqhswszBqMIG7qtyhC1+T8Iyd91to
         KbNw==
X-Gm-Message-State: AO0yUKU70iWm8ZrOxotcv1kcnhieM8Z4+LExmGm6VOvArw0Mybtr4/BR
        S3UZTvX1j8HByHvtQ1EZ0SSbfORBx5qWA6vxVGhI3+kOhLTYKggS70gTaAmBWcXawoV35gmCGaS
        BwQfZFoZTdBtiahFw2qj0cfUxzhdXH5aN0WC2cOEsxKg=
X-Received: by 2002:a17:906:29cc:b0:884:9217:4536 with SMTP id y12-20020a17090629cc00b0088492174536mr10234571eje.64.1676921889975;
        Mon, 20 Feb 2023 11:38:09 -0800 (PST)
X-Google-Smtp-Source: AK7set8z4Sn4FmTnxgH5/jvKzM2daPBSTzC8mbt7UgpOQKe2nkZcGU5ZLvwGrxz1EWKJaq8w5Ww+QA==
X-Received: by 2002:a17:906:29cc:b0:884:9217:4536 with SMTP id y12-20020a17090629cc00b0088492174536mr10234551eje.64.1676921889675;
        Mon, 20 Feb 2023 11:38:09 -0800 (PST)
Received: from amikhalitsyn.. ([2a02:8109:bd40:1414:bb20:aed2:bb7f:f0cf])
        by smtp.gmail.com with ESMTPSA id a19-20020a17090680d300b008d4df095034sm1526693ejx.195.2023.02.20.11.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 11:38:09 -0800 (PST)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     mszeredi@redhat.com
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
Subject: [RFC PATCH 0/9] fuse: API for Checkpoint/Restore
Date:   Mon, 20 Feb 2023 20:37:45 +0100
Message-Id: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=ASCII
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello everyone,

It would be great to hear your comments regarding this proof-of-concept Checkpoint/Restore API for FUSE.

Support of FUSE C/R is a challenging task for CRIU [1]. Last year I've given a brief talk on LPC 2022
about how we handle files C/R in CRIU and which blockers we have for FUSE filesystems. [2]

The main problem for CRIU is that we have to restore mount namespaces and memory mappings before the process tree.
It means that when CRIU is performing mount of fuse filesystem it can't use the original FUSE daemon from the
restorable process tree, but instead use a "fake daemon".

This leads to many other technical problems:
* "fake" daemon has to reply to FUSE_INIT request from the kernel and initialize fuse connection somehow.
This setup can be not consistent with the original daemon (protocol version, daemon capabilities/settings
like no_open, no_flush, readahead, and so on).
* each fuse request has a unique ID. It could confuse userspace if this unique ID sequence was reset.

We can workaround some issues and implement fragile and limited support of FUSE in CRIU but it doesn't make any sense, IMHO.
Btw, I've enumerated only CRIU restore-stage problems there. The dump stage is another story...

My proposal is not only about CRIU. The same interface can be useful for FUSE mounts recovery after daemon crashes.
LXC project uses LXCFS [3] as a procfs/cgroupfs/sysfs emulation layer for containers. We are using a scheme when
one LXCFS daemon handles all the work for all the containers and we use bindmounts to overmount particular
files/directories in procfs/cgroupfs/sysfs. If this single daemon crashes for some reason we are in trouble,
because we have to restart all the containers (fuse bindmounts become invalid after the crash).
The solution is fairly easy:
allow somehow to reinitialize the existing fuse connection and replace the daemon on the fly
This case is a little bit simpler than CRIU cause we don't need to care about the previously opened files
and other stuff, we are only interested in mounts.

Current PoC implementation was developed and tested with this "recovery case".
Right now I only have LXCFS patched and have nothing for CRIU. But I wanted to discuss this idea before going forward with CRIU.

Brief API/design description.

I've added two ioctl's:
* ioctl(FUSE_DEV_IOC_REINIT)
Performs fuse connection abort and then reinitializes all internal fuse structures as "brand new".
Then sends a FUSE_INIT request, so a new userspace daemon can reply to it and start processing fuse reqs.

* ioctl(FUSE_DEV_IOC_BM_REVAL)
A little bit hacky thing. Traverses all the bindmounts of existing fuse mount and performs relookup
of (struct vfsmount)->mnt_root dentries with the new daemon and reset them to new dentries.
Pretty useful for the recovery case (for instance, LXCFS).

Now about the dentry/inode invalidation mechanism.
* added the "fuse connection generation" concept.
When reinit is performed then connection generation is increased by 1.
Each fuse inode stores the generation of the connection it was allocated with.

* perform dentry revalidation if it has an old generation [fuse_dentry_revalidate]
The current implementation of fuse_dentry_revalidate follows a simple and elegant idea. When we
want to revalidate the dentry we just send a FUSE_LOOKUP request to the userspace
for the parent dentry with the name of the current dentry and check which attributes/inode id
it gets. If inode ids are the same and attributes (provided by the userspace) are valid
then we mark dentry valid and it continues to live (with inode).
I've only added a connection generation check to the condition when we have to perform revalidation
and added an inode connection generation reset (to actual connection gen) if the new userspace
daemon has looked up the same inode id (important for the CRIU case!).

Thank you for your attention and I'm waiting for your feedback :)

References:
[1] Support FUSE mountpoints https://github.com/checkpoint-restore/criu/issues/53
[2] Bringing up FUSE mounts C/R support https://lpc.events/event/16/contributions/1243/
[3] LXCFS https://github.com/lxc/lxcfs

Kind regards,
Alex

Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Stéphane Graber <stgraber@ubuntu.com>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: criu@openvz.org

Alexander Mikhalitsyn (9):
  fuse: move FUSE_DEFAULT_* defines to fuse common header
  fuse: add const qualifiers to common fuse helpers
  fuse: add fuse connection generation
  fuse: handle stale inode connection in fuse_queue_forget
  fuse: move fuse connection flags to the separate structure
  fuse: take fuse connection generation into account
  fuse: add fuse device ioctl(FUSE_DEV_IOC_REINIT)
  namespace: add sb_revalidate_bindmounts helper
  fuse: add fuse device ioctl(FUSE_DEV_IOC_BM_REVAL)

 fs/fuse/acl.c                 |   6 +-
 fs/fuse/dev.c                 | 167 +++++++++++++++++++-
 fs/fuse/dir.c                 |  38 ++---
 fs/fuse/file.c                |  85 +++++-----
 fs/fuse/fuse_i.h              | 281 ++++++++++++++++++++--------------
 fs/fuse/inode.c               |  62 ++++----
 fs/fuse/readdir.c             |   8 +-
 fs/fuse/xattr.c               |  18 +--
 fs/namespace.c                |  90 +++++++++++
 include/linux/mnt_namespace.h |   3 +
 include/uapi/linux/fuse.h     |   2 +
 11 files changed, 531 insertions(+), 229 deletions(-)

-- 
2.34.1

