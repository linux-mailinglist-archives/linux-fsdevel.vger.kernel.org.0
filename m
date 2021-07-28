Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224823D89E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 10:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbhG1IiC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 04:38:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:1100 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234238AbhG1IiB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 04:38:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="199835714"
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="199835714"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 01:37:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="663225937"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jul 2021 01:37:57 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m8f4e-00086z-Em; Wed, 28 Jul 2021 08:37:56 +0000
Date:   Wed, 28 Jul 2021 16:37:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     NeilBrown <neilb@suse.de>, Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Chris Mason <chris.mason@fusionio.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [RFC PATCH] btrfs: btrfs_mountpoint_expiry_timeout can be static
Message-ID: <20210728083727.GA157645@c5f9c8f3c8da>
References: <162742546558.32498.1901201501617899416.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162742546558.32498.1901201501617899416.stgit@noble.brown>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fs/btrfs/inode.c:5868:5: warning: symbol 'btrfs_mountpoint_expiry_timeout' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8667a26d684d4..4f9472e41074a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5865,7 +5865,7 @@ static int btrfs_dentry_delete(const struct dentry *dentry)
 static void btrfs_expire_automounts(struct work_struct *work);
 static LIST_HEAD(btrfs_automount_list);
 static DECLARE_DELAYED_WORK(btrfs_automount_task, btrfs_expire_automounts);
-int btrfs_mountpoint_expiry_timeout = 500 * HZ;
+static int btrfs_mountpoint_expiry_timeout = 500 * HZ;
 static void btrfs_expire_automounts(struct work_struct *work)
 {
 	struct list_head *list = &btrfs_automount_list;
