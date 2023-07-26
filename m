Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1419F763871
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbjGZOIQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjGZOHi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:07:38 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A464D2D67
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:06 -0700 (PDT)
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 122883F171
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690380424;
        bh=SYeeGp92pdelv4rH6q2bM2VgBXIS4lj+xBV/rEvt80A=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Ety92YVsRX4zqCeXimsm6je0cRpH2r9HJ2HI/lsNdUAOXGQK8D3YclsvZB75X1g0v
         LuO5Q4sY0GZWfTEpFE883N+GitkWUY2Qlq8ZMJSgk6u66nLNBlP0qoQk//AjEcjF1A
         c0COR48vsD+skBM657hR20NMTsz2Ts1LucwOUQCRyr0/LQ7MYI0yWR8cgy24eA7N3E
         Zan7h1wV2zflBIbB/z9doX4YkWHdXVcRwQ4YIPw007Q6nXJa1i+MDcIIWWZFcrE89y
         rOX3KwQjpQdCuU3mPsiexY1kvW6Fei46d0PiFLDBd/YF/89v50jjQw3jKBK7KcU6PX
         1wu78/1AafuuQ==
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b9b820c94fso6544861fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380422; x=1690985222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYeeGp92pdelv4rH6q2bM2VgBXIS4lj+xBV/rEvt80A=;
        b=cJ1jaIcxcUHoW5VkpWBNMaL95ix5IP19XTt0actqWhQ+WsbU4paUReBTkRmNgIBQm8
         /fpL2fw5avNzCyJe3umcPZx3qxUwk6MjYFtOJAtlwOxxM52mXWHO2DIJdlTZeCzBE3Qm
         dql2Ramac7Kf+/HPfEPifpseBKIS0b240SODvV4Wo/ujJbqTTFQ6y7H39m7lAaUz1McK
         xfvwspFgLh5zVyAuhQDNFcejisYpGKlvTMWrnCf04w9H51ldzxidFZpDo6zQcAx0xxEb
         8LV5S6aewwgXBBikkb2FIOpoRAHpmT7QlFICr9UdXlw7VTygshRu4QCoJcBl4Ngn1BDl
         AJRw==
X-Gm-Message-State: ABy/qLbdrNmXaRor+hadyW+ceZNrtx557/e5ihXjn8edmlN3LlZ5H3OC
        jdmMu3wPvQFejMW7uFhRjgjbc6Bk1SpHAKbj7douYqhG5boRPDM4pJaDAHQwwM82gVa7xUEOQk6
        DubgaISD3xR1LlMBUUI/+7Yo8jj6uUXrzc1C2w85QWzJYM1uRrSE=
X-Received: by 2002:a2e:9815:0:b0:2b9:4476:ab28 with SMTP id a21-20020a2e9815000000b002b94476ab28mr1655756ljj.38.1690380422692;
        Wed, 26 Jul 2023 07:07:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEa9fkPpw9PcHxKk1rcEFaOWtQXNQYdfONXpw2NCs+M4iu2Y08/aqQ1Upg3TRqJsc6HLWSXNw==
X-Received: by 2002:a2e:9815:0:b0:2b9:4476:ab28 with SMTP id a21-20020a2e9815000000b002b94476ab28mr1655727ljj.38.1690380422261;
        Wed, 26 Jul 2023 07:07:02 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id o22-20020a170906289600b00977c7566ccbsm9572931ejd.164.2023.07.26.07.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:07:01 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 00/11] ceph: support idmapped mounts
Date:   Wed, 26 Jul 2023 16:06:38 +0200
Message-Id: <20230726140649.307158-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
v7: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v7
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

I can confirm that this version passes xfstests.

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
  ceph: handle idmapped mounts in create_request_message()
  ceph: pass idmap to __ceph_setattr

Christian Brauner (8):
  ceph: stash idmapping in mdsc request
  ceph: pass an idmapping to mknod/symlink/mkdir
  ceph: allow idmapped getattr inode op
  ceph: allow idmapped permission inode op
  ceph: allow idmapped setattr inode op
  ceph/acl: allow idmapped set_acl inode op
  ceph/file: allow idmapped atomic_open inode op
  ceph: allow idmapped mounts

 fs/ceph/acl.c                 |  6 +++---
 fs/ceph/crypto.c              |  2 +-
 fs/ceph/dir.c                 |  3 +++
 fs/ceph/file.c                | 10 ++++++++--
 fs/ceph/inode.c               | 29 +++++++++++++++++------------
 fs/ceph/mds_client.c          | 25 +++++++++++++++++++++++++
 fs/ceph/mds_client.h          |  6 +++++-
 fs/ceph/super.c               |  2 +-
 fs/ceph/super.h               |  3 ++-
 fs/mnt_idmapping.c            |  2 ++
 include/linux/ceph/ceph_fs.h  |  4 +++-
 include/linux/mnt_idmapping.h |  3 +++
 12 files changed, 73 insertions(+), 22 deletions(-)

-- 
2.34.1

