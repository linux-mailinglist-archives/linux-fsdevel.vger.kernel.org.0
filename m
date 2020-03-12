Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7497E183A70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 21:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgCLUNR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 16:13:17 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:47913 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726859AbgCLUNR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 16:13:17 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 01F5F546;
        Thu, 12 Mar 2020 16:03:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 12 Mar 2020 16:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=kNlnuwMcimuimNS6Jo1KZfG1Ry
        Ya0T1T2FyiTi3yhps=; b=szEVJrm30FaD/kg1b6gDlqEtraYtSwmmiY99s5I0da
        DGUOk1qh1OTE09WdC6mLCLKvnwvNQut4O/x60UwuZF4IDFwe3jmdgt/8LA9PYTGD
        kxwzKXmI4aT5CzKTneRyiWrqeXubeJinvsZrpuZfntHWrYr8PYuAYUvRyrYxDEr2
        hhTTUQGpHFh8T6sX9+fBSSVQVA8nMYCrDcR6kubfb7RsvM+WNwrxjfI1xVdgcrea
        U3YW+agBt8/SnuDAR2xYvx0GQ09XxKv0GYhAD5BuiVr/B71wLCwZn6X/lTYjTLAf
        +BhqrA2wa3KYPCHTzrzURJ4oSKGowhYTKTJf3UaEne6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=kNlnuwMcimuimNS6J
        o1KZfG1RyYa0T1T2FyiTi3yhps=; b=Jq26f0WXtdpISQKByHKqy5pAnBoRJ3Gq2
        TLHcfPYJ0vOXBN+fiXG7IZoDj1nizaIeL6OzZ78ov0gLRplTCraQjqZm5Q+zS/dK
        KZ5oMk2HpTRhEdRi+51+VcCtOwBGJC+3YlCVg0OYmynLAskLqJ5O9IicBq6/znfS
        ByaiitijbhLihNKL29Z2wghfO88KgV2dES7tzhiZ6Ul8q+ZZDbdyQxhDoKrgGV8J
        o3rNJJYkWvbdsD8SWkFJ+a3YVW0j81ireEdTP+u/AIFSEWTV5Y8iPQOzSwflsZOP
        JCIz4ODcvsP9CLJtcLMhFJjDKa2CmR3v7rtCpsIcsbeQAAmeSSMaQ==
X-ME-Sender: <xms:mZVqXlbRhW-UuPS_KxqETWxRqLabam2TiEgNR6d9a17xpIeXbMh3BA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvhedgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecukfhppeduieefrdduudegrddufedvrdegnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhu
    uhdrgiihii
X-ME-Proxy: <xmx:mZVqXrig4A0ckLE0JYOoxNg_NGvedkfPYh-tWWeK3CBW5KEivumZ_g>
    <xmx:mZVqXs_QJ23jGJuvpMThk2jfEwocc3ZgTUZq32wKEhq7t2Wdl-O2qw>
    <xmx:mZVqXjP1ZdrsTmgMIiQRfAjTXvxUS17DQEMqh9NEC_Z5bzuHTMS9IA>
    <xmx:mpVqXnCuAq27hps2dOvVcSyHqa3DnmJCH3kINbzC6y4mvZnY03hwP1fiZqY>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [163.114.132.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id E4D863060F09;
        Thu, 12 Mar 2020 16:03:35 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     cgroups@vger.kernel.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, viro@zeniv.linux.org.uk
Cc:     Daniel Xu <dxu@dxuuu.xyz>, shakeelb@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, kernel-team@fb.com
Subject: [PATCH v3 0/4] Support user xattrs in cgroupfs
Date:   Thu, 12 Mar 2020 13:03:13 -0700
Message-Id: <20200312200317.31736-1-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

User extended attributes are useful as metadata storage for kernfs
consumers like cgroups. Especially in the case of cgroups, it is useful
to have a central metadata store that multiple processes/services can
use to coordinate actions.

A concrete example is for userspace out of memory killers. We want to
let delegated cgroup subtree owners (running as non-root) to be able to
say "please avoid killing this cgroup". This is especially important for
desktop linux as delegated subtrees owners are less likely to run as
root.

The first two commits set up some stuff for the third commit which
intro introduce a new flag, KERNFS_ROOT_SUPPORT_USER_XATTR,
that lets kernfs consumers enable user xattr support. The final commit
turns on user xattr support for cgroupfs.

Changes from v2:
- Rephrased commit message for "kernfs: kvmalloc xattr value instead of
  kmalloc"

Changes from v1:
- use kvmalloc for xattr values
- modify simple_xattr_set to return removed size
- add accounting for total user xattr size per cgroup

Daniel Xu (4):
  kernfs: kvmalloc xattr value instead of kmalloc
  kernfs: Add removed_size out param for simple_xattr_set
  kernfs: Add option to enable user xattrs
  cgroupfs: Support user xattrs

Daniel Xu (4):
  kernfs: kvmalloc xattr value instead of kmalloc
  kernfs: Add removed_size out param for simple_xattr_set
  kernfs: Add option to enable user xattrs
  cgroupfs: Support user xattrs

 fs/kernfs/inode.c           | 91 ++++++++++++++++++++++++++++++++++++-
 fs/kernfs/kernfs-internal.h |  2 +
 fs/xattr.c                  | 17 +++++--
 include/linux/kernfs.h      | 11 ++++-
 include/linux/xattr.h       |  3 +-
 kernel/cgroup/cgroup.c      |  3 +-
 mm/shmem.c                  |  2 +-
 7 files changed, 119 insertions(+), 10 deletions(-)

-- 
2.21.1

