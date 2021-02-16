Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5000B31C5F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 05:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhBPEad (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 23:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhBPEa2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 23:30:28 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6221BC061786;
        Mon, 15 Feb 2021 20:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=lwDM3FGLvw88JvWa7gPEM2MZc8nTKorAnJdtBb2TZyw=; b=oYvzSZQlLKei27xd5OawRHeVuv
        aqlK2QoVX6WbFKngWWUnTg7StbwQQ7v/ZpfMT0REtwEGVnD6rPDiOD8duJphWQLxPhswxLtZDBO9F
        u44A7oeExizNbYwejTmUz+/zkNYwu71yi8dDDK/rmHB+O6TAVTfVrKFy3xskTaab5Za0CD5F0+B3E
        phB24m+1sDLEZU8Hh/spt1eQDsqV2negrF1IEbU9oYIlT7AyRF+nfO+OIi+sdadYWERQtn1VonYWG
        kDWFTF1EPJAkOLSljLdH5cSlIvOObSWP26iG/0xjT2dJyaJItEzLW3abkPMHrbmkVWyXcoY1h86n8
        Sb+dAoWQ==;
Received: from [2601:1c0:6280:3f0::b669] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lBrzd-0002nO-Vd; Tue, 16 Feb 2021 04:29:46 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "David P . Quigley" <dpquigl@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>
Subject: [PATCH -next] fs: xattr: fix kernel-doc for mnt_userns and vfs xattr helpers
Date:   Mon, 15 Feb 2021 20:29:29 -0800
Message-Id: <20210216042929.8931-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210216042929.8931-1-rdunlap@infradead.org>
References: <20210216042929.8931-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix kernel-doc warnings in xattr.c:

../fs/xattr.c:257: warning: Function parameter or member 'mnt_userns' not described in '__vfs_setxattr_locked'
../fs/xattr.c:485: warning: Function parameter or member 'mnt_userns' not described in '__vfs_removexattr_locked'

and fix one function whose kernel-doc was not in the correct format.

Fixes: 71bc356f93a1 ("commoncap: handle idmapped mounts")
Fixes: b1ab7e4b2a88 ("VFS: Factor out part of vfs_setxattr so it can be called from the SELinux hook for inode_setsecctx.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: David P. Quigley <dpquigl@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>
---
 fs/xattr.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- linux-next-20210215.orig/fs/xattr.c
+++ linux-next-20210215/fs/xattr.c
@@ -186,12 +186,12 @@ EXPORT_SYMBOL(__vfs_setxattr);
  *  __vfs_setxattr_noperm - perform setxattr operation without performing
  *  permission checks.
  *
- *  @mnt_userns - user namespace of the mount the inode was found from
- *  @dentry - object to perform setxattr on
- *  @name - xattr name to set
- *  @value - value to set @name to
- *  @size - size of @value
- *  @flags - flags to pass into filesystem operations
+ *  @mnt_userns: user namespace of the mount the inode was found from
+ *  @dentry: object to perform setxattr on
+ *  @name: xattr name to set
+ *  @value: value to set @name to
+ *  @size: size of @value
+ *  @flags: flags to pass into filesystem operations
  *
  *  returns the result of the internal setxattr or setsecurity operations.
  *
@@ -242,6 +242,7 @@ int __vfs_setxattr_noperm(struct user_na
  * __vfs_setxattr_locked - set an extended attribute while holding the inode
  * lock
  *
+ *  @mnt_userns: user namespace of the mount of the target inode
  *  @dentry: object to perform setxattr on
  *  @name: xattr name to set
  *  @value: value to set @name to
@@ -473,6 +474,7 @@ EXPORT_SYMBOL(__vfs_removexattr);
  * __vfs_removexattr_locked - set an extended attribute while holding the inode
  * lock
  *
+ *  @mnt_userns: user namespace of the mount of the target inode
  *  @dentry: object to perform setxattr on
  *  @name: name of xattr to remove
  *  @delegated_inode: on return, will contain an inode pointer that
