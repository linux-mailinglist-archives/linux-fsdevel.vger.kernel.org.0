Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169FF76FC73
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 10:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjHDIty (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 04:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjHDItd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:49:33 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11464234
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 01:49:30 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CEBA5417B7
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 08:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691138967;
        bh=METYU9DUhdz7w9tfxjdR9SRB9971VLPfiTChHLgb/Js=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=uOgeKt1fjpoZLqqqmXWaMsrtFcHGv//YTMTIe0chLSKqWsIMcvwdXt0xCEBd4CvBf
         yg3rVVrSV8xMu9wyXjnpJsFfLAve30jKr/0QhN4VlTu5kluV8/t2iHjAmsl9CKX1cS
         QHDFtX7cHFbZUpLx/QksVjwz+Jd+HT7EN/yOi3IVUPwqpMlRAjSeySQgUkWu6N180K
         E/8VPbK6D6SDo4XJDAbt1nEgYY1cwZ2/LQdnb8QcL7y1gY/LBnSil4tOda2GFnG77z
         kLzNTJvSLnmFnhuozVXe0EoWV512/GNiNbME0WU/CUCpEkYXNnl1aINPojOmCOqYcp
         gJDHgDJ+4UoYA==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99c0fb2d4b0so133772766b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Aug 2023 01:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691138967; x=1691743767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=METYU9DUhdz7w9tfxjdR9SRB9971VLPfiTChHLgb/Js=;
        b=TXAJOBvUNVAL/+mHRHU/6/ss2mX7qGSyBKskNCCQbla3Q6pClWeB2WtRFhJFPHKpq3
         2euyUKouJCiSKi6oEMcQSPx/ppPHR3K5CLe3da7tqkYMQ7xbyl9lm8rqRxWzK01JBPyQ
         JF1vO5bvoHGXCQ0vZNWgvoLKJ1mHJWhF21K2Fhm0iW66lQ+KxizDvfr6TIfuh3JkWe+R
         LyvJ5u6su/+o2DZsngBps2Zh5rbW1uK+u77Lx+Z3Je8cjK0MIG2Zwx74V0eD/th/MU6O
         DZElkPgtEX2gnwmL9D3WD6VVL/3ywvkpK3JIi/Y9JLzx1wfL2USd0Unogc5bIv3p31Eg
         Mcew==
X-Gm-Message-State: AOJu0YwxcREs1o1xI1qAmcbEkcp8yIF65HLAmHoV7nn8SQPyRuWdZvm2
        5Of+WtTraRvF/IlQkEoNtAVn9lrNNCc49zhMn621hln8P4LK3e98dlt9aCYLDNzHTfd9lGsc+9U
        ViFhn08hF6fa1tecAuRxrXYWreJFKmxtaIk9ya+lll74=
X-Received: by 2002:a17:906:7696:b0:99c:56d1:7c71 with SMTP id o22-20020a170906769600b0099c56d17c71mr1039335ejm.26.1691138967527;
        Fri, 04 Aug 2023 01:49:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE8vAQJrrJBhmmk+58RSJCJps5iblu6CrLIkTLzO8cGlTpmaIm/bRCdAr3Cr7AMoInLRQtJw==
X-Received: by 2002:a17:906:7696:b0:99c:56d1:7c71 with SMTP id o22-20020a170906769600b0099c56d17c71mr1039318ejm.26.1691138967138;
        Fri, 04 Aug 2023 01:49:27 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id k25-20020a17090646d900b00992e94bcfabsm979279ejs.167.2023.08.04.01.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:49:26 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 00/12] ceph: support idmapped mounts
Date:   Fri,  4 Aug 2023 10:48:46 +0200
Message-Id: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear friends,

This patchset was originally developed by Christian Brauner but I'll continue
to push it forward. Christian allowed me to do that :)

This feature is already actively used/tested with LXD/LXC project.

Git tree (based on https://github.com/ceph/ceph-client.git testing):
v9: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v9
current: https://github.com/mihalicyn/linux/tree/fs.idmapped.ceph

In the version 3 I've changed only two commits:
- fs: export mnt_idmap_get/mnt_idmap_put
- ceph: allow idmapped setattr inode op
and added a new one:
- ceph: pass idmap to __ceph_setattr

In the version 4 I've reworked the ("ceph: stash idmapping in mdsc request")
commit. Now we take idmap refcounter just in place where req->r_mnt_idmap
is filled. It's more safer approach and prevents possible refcounter underflow
on error paths where __register_request wasn't called but ceph_mdsc_release_request is
called.

Changelog for version 5:
- a few commits were squashed into one (as suggested by Xiubo Li)
- started passing an idmapping everywhere (if possible), so a caller
UID/GID-s will be mapped almost everywhere (as suggested by Xiubo Li)

Changelog for version 6:
- rebased on top of testing branch
- passed an idmapping in a few places (readdir, ceph_netfs_issue_op_inline)

Changelog for version 7:
- rebased on top of testing branch
- this thing now requires a new cephfs protocol extension CEPHFS_FEATURE_HAS_OWNER_UIDGID
https://github.com/ceph/ceph/pull/52575

Changelog for version 8:
- rebased on top of testing branch
- added enable_unsafe_idmap module parameter to make idmapped mounts
work with old MDS server versions
- properly handled case when old MDS used with new kernel client

Changelog for version 9:
- added "struct_len" field in struct ceph_mds_request_head as requested by Xiubo Li

I can confirm that this version passes xfstests and
tested with old MDS (without CEPHFS_FEATURE_HAS_OWNER_UIDGID)
and with recent MDS version.

Links to previous versions:
v1: https://lore.kernel.org/all/20220104140414.155198-1-brauner@kernel.org/
v2: https://lore.kernel.org/lkml/20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com/
tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v2
v3: https://lore.kernel.org/lkml/20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com/#t
v4: https://lore.kernel.org/lkml/20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com/#t
tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v4
v5: https://lore.kernel.org/lkml/20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com/#t
tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v5
v6: https://lore.kernel.org/lkml/20230609093125.252186-1-aleksandr.mikhalitsyn@canonical.com/
tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v6
v7: https://lore.kernel.org/all/20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com/
tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v7
v8: https://lore.kernel.org/all/20230803135955.230449-1-aleksandr.mikhalitsyn@canonical.com/
tree: -

Kind regards,
Alex

Original description from Christian:
========================================================================
This patch series enables cephfs to support idmapped mounts, i.e. the
ability to alter ownership information on a per-mount basis.

Container managers such as LXD support sharaing data via cephfs between
the host and unprivileged containers and between unprivileged containers.
They may all use different idmappings. Idmapped mounts can be used to
create mounts with the idmapping used for the container (or a different
one specific to the use-case).

There are in fact more use-cases such as remapping ownership for
mountpoints on the host itself to grant or restrict access to different
users or to make it possible to enforce that programs running as root
will write with a non-zero {g,u}id to disk.

The patch series is simple overall and few changes are needed to cephfs.
There is one cephfs specific issue that I would like to discuss and
solve which I explain in detail in:

[PATCH 02/12] ceph: handle idmapped mounts in create_request_message()

It has to do with how to handle mds serves which have id-based access
restrictions configured. I would ask you to please take a look at the
explanation in the aforementioned patch.

The patch series passes the vfs and idmapped mount testsuite as part of
xfstests. To run it you will need a config like:

[ceph]
export FSTYP=ceph
export TEST_DIR=/mnt/test
export TEST_DEV=10.103.182.10:6789:/
export TEST_FS_MOUNT_OPTS="-o name=admin,secret=$password

and then simply call

sudo ./check -g idmapped

========================================================================

Alexander Mikhalitsyn (3):
  fs: export mnt_idmap_get/mnt_idmap_put
  ceph: add enable_unsafe_idmap module parameter
  ceph: pass idmap to __ceph_setattr

Christian Brauner (9):
  ceph: stash idmapping in mdsc request
  ceph: handle idmapped mounts in create_request_message()
  ceph: pass an idmapping to mknod/symlink/mkdir
  ceph: allow idmapped getattr inode op
  ceph: allow idmapped permission inode op
  ceph: allow idmapped setattr inode op
  ceph/acl: allow idmapped set_acl inode op
  ceph/file: allow idmapped atomic_open inode op
  ceph: allow idmapped mounts

 fs/ceph/acl.c                 |  6 +--
 fs/ceph/crypto.c              |  2 +-
 fs/ceph/dir.c                 |  3 ++
 fs/ceph/file.c                | 10 ++++-
 fs/ceph/inode.c               | 29 +++++++++------
 fs/ceph/mds_client.c          | 70 ++++++++++++++++++++++++++++++++---
 fs/ceph/mds_client.h          |  8 +++-
 fs/ceph/super.c               |  7 +++-
 fs/ceph/super.h               |  3 +-
 fs/mnt_idmapping.c            |  2 +
 include/linux/ceph/ceph_fs.h  |  5 ++-
 include/linux/mnt_idmapping.h |  3 ++
 12 files changed, 121 insertions(+), 27 deletions(-)

-- 
2.34.1

