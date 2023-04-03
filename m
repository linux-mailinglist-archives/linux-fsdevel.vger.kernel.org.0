Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB74D6D4A67
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 16:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbjDCOqt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 10:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbjDCOqf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:46:35 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098EAD4F87
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 07:46:18 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 080843F22F
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 14:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1680533138;
        bh=vnzySuWpn2fzOdO5+1JPUkZQvxbNLkst5PcVHPdiSbI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=UrdbwBLW2fiG3+1zCVc7wG7YvXHv1I8lNBh2leqWhiXJQHwfhkIkoOQ0VZ2/pEuaj
         VDjc1acMDlSjLTn4VJ2c5p7omY7pp/GR3Z84BXdEPkRqoCjKihF/L/583/ZGJIbn1h
         bqaQJ6YVlWKlxFqXa2vvKNc2Fef31tRVQp7O3j+fX0IEE8utICNZuNYdvo4oxcXFVy
         NcJqTH+8spqt1VmYviq3InQbN2NkDWR0n5a0/XCfQqCLD8vY/24OImmwkDZDvNfcid
         3Wm7r5eIGXTXm+LYyyxkNoPDnrgzNKqstFZMH+3wGf+pd4Atk2ZtUBfEdhRZHVX1MM
         qQ4onVFoTehoA==
Received: by mail-ed1-f70.google.com with SMTP id k30-20020a50ce5e000000b00500544ebfb1so41340722edj.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Apr 2023 07:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680533135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnzySuWpn2fzOdO5+1JPUkZQvxbNLkst5PcVHPdiSbI=;
        b=hfGUBdvrkD4BLOmykR6nYgBhMhC04292VaFyhg9XFpNdlHfYGLecCpgGvgqA+a89EB
         NlBnpxkIDt7/jMlVPreadq0HbiEy3V1MnKKfLggZHo9PqeyC2upwYALx5jq2nfKBu6YL
         m8QHXdluDXPnOlscl4zUoxrLMMRFScRI6+o5qtU/dGPGjBVLVKfBK8go6lErIDGsNGDs
         2eVy26wGbmUVfOXq6hgjVS5vIlB8adwfZDolGSQW3hyZemckleLa83dpPNzo7T1yCA1K
         I54MFpOd2dGdNwZrGKW6jsGw+sOYwQSojRvpxcZX4P5AWFnvI3Lh5IdRJ5qqBPtFJ8Qp
         DLSA==
X-Gm-Message-State: AAQBX9elvdJZMsr4oOyMTN7BuepUYj4ev4suIiRg3JIIN8vqDf9Al5hK
        425hjHE7mxrQ01D5/6yJDFY7QVX00ehXLWoApf2xaLZ3XpMKi246sojSBfeSgFC7hw8ijljCu6z
        qob10sKR8nmShhsWCW0Ug3muOjIPmDXsFc8EZ14LU7RA=
X-Received: by 2002:a17:906:a8d:b0:878:52cd:9006 with SMTP id y13-20020a1709060a8d00b0087852cd9006mr37906944ejf.69.1680533135532;
        Mon, 03 Apr 2023 07:45:35 -0700 (PDT)
X-Google-Smtp-Source: AKy350bAiuVh3lsBhMr+h30HHvifpPWJUO8Mib81eersEgBb0Rdw76ve5q7xt8XBTouzFay6aan3FA==
X-Received: by 2002:a17:906:a8d:b0:878:52cd:9006 with SMTP id y13-20020a1709060a8d00b0087852cd9006mr37906922ejf.69.1680533135221;
        Mon, 03 Apr 2023 07:45:35 -0700 (PDT)
Received: from amikhalitsyn.. (ip5f5bd076.dynamic.kabel-deutschland.de. [95.91.208.118])
        by smtp.gmail.com with ESMTPSA id i5-20020a50d745000000b004fa19f5ba99sm4735804edj.79.2023.04.03.07.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 07:45:34 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     mszeredi@redhat.com
Cc:     flyingpeng@tencent.com,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Bernd Schubert <bschubert@ddn.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
Subject: [RFC PATCH v2 0/9] fuse: API for Checkpoint/Restore
Date:   Mon,  3 Apr 2023 16:45:08 +0200
Message-Id: <20230403144517.347517-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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

Branch link: https://github.com/mihalicyn/linux/commits/fuse_cr_rev0

References:
[1] Support FUSE mountpoints https://github.com/checkpoint-restore/criu/issues/53
[2] Bringing up FUSE mounts C/R support https://lpc.events/event/16/contributions/1243/
[3] LXCFS https://github.com/lxc/lxcfs

Kind regards,
Alex

--

v2:
	- rebased
	- fixes according to review comments from Bernd Schubert
--

Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Stéphane Graber <stgraber@ubuntu.com>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Bernd Schubert <bschubert@ddn.com>
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
 fs/fuse/dev.c                 | 187 +++++++++++++++++++++-
 fs/fuse/dir.c                 |  38 ++---
 fs/fuse/file.c                |  92 ++++++-----
 fs/fuse/fuse_i.h              | 287 ++++++++++++++++++++--------------
 fs/fuse/inode.c               |  62 ++++----
 fs/fuse/readdir.c             |   8 +-
 fs/fuse/xattr.c               |  18 +--
 fs/namespace.c                |  90 +++++++++++
 include/linux/mnt_namespace.h |   3 +
 include/uapi/linux/fuse.h     |   2 +
 11 files changed, 563 insertions(+), 230 deletions(-)


base-commit: c68ea140050e631d24d61b6e399ca8224a4a2219
-- 
2.34.1

