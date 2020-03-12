Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC0CA183A6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 21:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgCLUNS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 16:13:18 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:35157 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726594AbgCLUNR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 16:13:17 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id EF867389;
        Thu, 12 Mar 2020 16:03:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 12 Mar 2020 16:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=u/9dibYxL56wS
        DkUFjjFnl2n24SOzknBdPH4frj5N3U=; b=ENvdF+Sgt7gz7f41/S9F7NfoVknZD
        b3ZV92KQFoP8zM0bdMuoYPky7hDlc/n78d6uEgGoSpmNIKiUTYGqokrDFnDtILqD
        kTvYpSYQlBNoHP0AqIgO5pa1+odrqBwC4jPt1fAlFxAOaeqg3jXdizRc5r7LElla
        C0N8muKO2TXD24nIqXZTnpDdHZSgdduLkkzczH0RVPxN/WnBgJyMAnBySjNRsr0R
        KTTN7guo3xD0ytU5V+5R/4CQ/8F9p/e7u6F5nfdaKYM4srLuQH47bnuoWJHnvA4X
        T5fxnF7Y2SUaBFlhbI3AF9c6+SQSNvYswjiXZSn8xwOoSMkXaJgePX7kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=u/9dibYxL56wSDkUFjjFnl2n24SOzknBdPH4frj5N3U=; b=XSQZPIvS
        CDuAexPY51TQweBJusJYe8/kYIF32eNEN4t0BtrtrPzVkU5qRxhnO+FMP1CKei1M
        IV5yULqou3apxpm8ADWfwwA47UsRj7TyY88tshNjItG5PWntty9wxtICw0zxJPLK
        9oJxsWJFiQ7oIlY3hbR85wF1A3GiRGp8hM5n3FFTIUiSwCYC2CxEDJQK/+NcArZ9
        3SjlKdyabA2QnGI3jD1+J1A9iR1Ii4ZBC9Vu2lnmJoc8ljYYSzZf09mR97mM++F4
        vdgn/wOt0nejSiOlorWPEtw29Tj9g/3hSg0xcfTNJaLVzKiL9MZe9OA5miej6F8/
        UpUyJvRwz5Lrsg==
X-ME-Sender: <xms:npVqXqFm9r2OfDZH33nQmf_OxYXX4fo7K9JCX2wasB3PniuA6W0zHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvhedgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecukfhppeduieefrdduudegrddufedvrdegnecuve
    hluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugig
    uhhuuhdrgiihii
X-ME-Proxy: <xmx:npVqXs6VOK8wVeNFL4XuLfYgHb8XbdH3S8m7X2zT2LuleZtMU-fulA>
    <xmx:npVqXjZzIXYh45jNzObgf3cLsl-4dC4Xc9sE2rL13i7R38u7uWXWHA>
    <xmx:npVqXqhjh440iWjZ8MwYiFnY48c7YW7DG2mJ2BA6yl1VqEygriln_Q>
    <xmx:npVqXjrpc_CVNB0kMkQP1L1XqcEJhKNEDsHhM4_G6pG4G2VQLTJqscZgVIQ>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [163.114.132.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4B8C630614B1;
        Thu, 12 Mar 2020 16:03:41 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     cgroups@vger.kernel.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, viro@zeniv.linux.org.uk
Cc:     Daniel Xu <dxu@dxuuu.xyz>, shakeelb@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, kernel-team@fb.com
Subject: [PATCH v3 4/4] cgroupfs: Support user xattrs
Date:   Thu, 12 Mar 2020 13:03:17 -0700
Message-Id: <20200312200317.31736-5-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200312200317.31736-1-dxu@dxuuu.xyz>
References: <20200312200317.31736-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch turns on xattr support for cgroupfs. This is useful for
letting non-root owners of delegated subtrees attach metadata to
cgroups.

One use case is for subtree owners to tell a userspace out of memory
killer to bias away from killing specific subtrees.

Tests:

    [/sys/fs/cgroup]# for i in $(seq 0 130); \
        do setfattr workload.slice -n user.name$i -v wow; done
    setfattr: workload.slice: No space left on device
    setfattr: workload.slice: No space left on device
    setfattr: workload.slice: No space left on device

    [/sys/fs/cgroup]# for i in $(seq 0 130); \
        do setfattr workload.slice --remove user.name$i; done
    setfattr: workload.slice: No such attribute
    setfattr: workload.slice: No such attribute
    setfattr: workload.slice: No such attribute

    [/sys/fs/cgroup]# for i in $(seq 0 130); \
        do setfattr workload.slice -n user.name$i -v wow; done
    setfattr: workload.slice: No space left on device
    setfattr: workload.slice: No space left on device
    setfattr: workload.slice: No space left on device

`seq 0 130` is inclusive, and 131 - 128 = 3, which is the number of
errors we expect to see.

    [/data]# cat testxattr.c
    #include <sys/types.h>
    #include <sys/xattr.h>
    #include <stdio.h>
    #include <stdlib.h>

    int main() {
      char name[256];
      char *buf = malloc(64 << 10);
      if (!buf) {
        perror("malloc");
        return 1;
      }

      for (int i = 0; i < 4; ++i) {
        snprintf(name, 256, "user.bigone%d", i);
        if (setxattr("/sys/fs/cgroup/system.slice", name, buf,
                     64 << 10, 0)) {
          printf("setxattr failed on iteration=%d\n", i);
          return 1;
        }
      }

      return 0;
    }

    [/data]# ./a.out
    setxattr failed on iteration=2

    [/data]# ./a.out
    setxattr failed on iteration=0

    [/sys/fs/cgroup]# setfattr -x user.bigone0 system.slice/
    [/sys/fs/cgroup]# setfattr -x user.bigone1 system.slice/

    [/data]# ./a.out
    setxattr failed on iteration=2

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/cgroup/cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 7a39dc882095..ae1d808c0b9b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1954,7 +1954,8 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 
 	root->kf_root = kernfs_create_root(kf_sops,
 					   KERNFS_ROOT_CREATE_DEACTIVATED |
-					   KERNFS_ROOT_SUPPORT_EXPORTOP,
+					   KERNFS_ROOT_SUPPORT_EXPORTOP |
+					   KERNFS_ROOT_SUPPORT_USER_XATTR,
 					   root_cgrp);
 	if (IS_ERR(root->kf_root)) {
 		ret = PTR_ERR(root->kf_root);
-- 
2.21.1

