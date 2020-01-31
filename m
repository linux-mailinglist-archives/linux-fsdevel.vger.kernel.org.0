Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38B0914E843
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 06:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgAaFZF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 00:25:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42796 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgAaFZF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 00:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=luXr4pguSqUxp5EDGW1Cs8NsU4XySnJxKkuiFOnxP5g=; b=OciRWIPOfShUD0Ytvib3qy+dB
        Tvp0gn/sOoBxGHLcLLDq6Dlloutujfb2jKJRFu/QgG2pag6RXMAdZH25HTbsbjWz1JvyReEbMEF+8
        UvdBCIlei5fvgZUJLqiOyd5Aa5cLqSRbIKKMFLpgqEKLNb/gIk3nhTB6oDW0F60L95LHjnSMLdsVw
        40sKVrmc/f71aIwph7utp4bQIxvFJxMleZLbwcXy15fEtCPZFNBYcSEjHM7o0P+EFUr1KVWNLqY5i
        mitXW6229qiuQ0TX5LLt/iorUzWhLaa9W+ifHkOwt8UvXWDWVmyOjgEwWV3SsQHXRWrRHa7BhChNJ
        Pvkq8V+Dw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixOng-00080C-RX; Fri, 31 Jan 2020 05:25:04 +0000
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 1/2] fs/namespace.c: fix kernel-doc warnings and add
 kernel-doc
Message-ID: <2475df7a-2c6a-76cd-66a1-5872df0212a7@infradead.org>
Date:   Thu, 30 Jan 2020 21:25:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warnings in fs/namespace.c:

./fs/namespace.c:1309: warning: Function parameter or member 'm' not described in 'may_umount_tree'
./fs/namespace.c:1309: warning: Excess function parameter 'mnt' description in 'may_umount_tree'
./fs/namespace.c:1872: warning: Function parameter or member 'path' not described in 'clone_private_mount'

Also convert path_is_mountpoint() comments to kernel-doc.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- linux-next-20200130.orig/fs/namespace.c
+++ linux-next-20200130/fs/namespace.c
@@ -1205,8 +1205,9 @@ struct vfsmount *mntget(struct vfsmount
 }
 EXPORT_SYMBOL(mntget);
 
-/* path_is_mountpoint() - Check if path is a mount in the current
- *                          namespace.
+/**
+ * path_is_mountpoint() - Check if path is a mount in the current namespace.
+ * @path: path to check
  *
  *  d_mountpoint() can only be used reliably to establish if a dentry is
  *  not mounted in any namespace and that common case is handled inline.
@@ -1298,7 +1299,7 @@ const struct seq_operations mounts_op =
 
 /**
  * may_umount_tree - check if a mount tree is busy
- * @mnt: root of mount tree
+ * @m: root of mount tree
  *
  * This is called to check if a tree of mounts has any
  * open files, pwds, chroots or sub mounts that are
@@ -1860,10 +1861,11 @@ void drop_collected_mounts(struct vfsmou
 
 /**
  * clone_private_mount - create a private clone of a path
+ * @path: path to clone
  *
- * This creates a new vfsmount, which will be the clone of @path.  The new will
- * not be attached anywhere in the namespace and will be private (i.e. changes
- * to the originating mount won't be propagated into this).
+ * This creates a new vfsmount, which will be the clone of @path.  The new mount
+ * will not be attached anywhere in the namespace and will be private (i.e.
+ * changes to the originating mount won't be propagated into this).
  *
  * Release with mntput().
  */


