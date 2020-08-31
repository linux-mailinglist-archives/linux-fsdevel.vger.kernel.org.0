Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C08C257133
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 02:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgHaAaY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Aug 2020 20:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgHaAaU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Aug 2020 20:30:20 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9A8C061573
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2020 17:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=4NCWIAAdSci+WDFhQ0Fe1JcYuaN92F05Pk62g7D93B8=; b=sk6r3v9My6ocGJIkkyaa4eH7VC
        7feL5cy8CZ+RZfLNa04+4OEKvg6XtEmS3JdrFvPbYoUYKeLv6wt/5xC4r1+IZCZ1ioz5S63GqMOhO
        POwPZ0dgI/8UGi0vw49SCC0/6Y6FkvACG9Ot11ykm5726PNk7vLq7An+LB2zfrfjLfIWEPlVq4/98
        DWcmOKljvwsVwY2jlPPQU9hgYQtZGKajmpcbYeXc/bcePjJbLw2f2G7lD9czFC05pHjqutugVD9BC
        74yw5EL4KpjejOeSOhARJ1QsYVUiP3KC/eRYliOTauadlhs9pOIZ9DqwRs9ZyZwvgD6bntp6Yrswn
        tetaaifw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCXi7-0007nl-Gn; Mon, 31 Aug 2020 00:30:12 +0000
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frank van der Linden <fllinden@amazon.com>,
        Chuck Lever <chuck.lever@oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] fs/xattr.c: fix kernel-doc warnings for setxattr &
 removexattr
Message-ID: <7a3dd5a2-5787-adf3-d525-c203f9910ec4@infradead.org>
Date:   Sun, 30 Aug 2020 17:30:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warnings in fs/xattr.c:

../fs/xattr.c:251: warning: Function parameter or member 'dentry' not described in '__vfs_setxattr_locked'
../fs/xattr.c:251: warning: Function parameter or member 'name' not described in '__vfs_setxattr_locked'
../fs/xattr.c:251: warning: Function parameter or member 'value' not described in '__vfs_setxattr_locked'
../fs/xattr.c:251: warning: Function parameter or member 'size' not described in '__vfs_setxattr_locked'
../fs/xattr.c:251: warning: Function parameter or member 'flags' not described in '__vfs_setxattr_locked'
../fs/xattr.c:251: warning: Function parameter or member 'delegated_inode' not described in '__vfs_setxattr_locked'
../fs/xattr.c:458: warning: Function parameter or member 'dentry' not described in '__vfs_removexattr_locked'
../fs/xattr.c:458: warning: Function parameter or member 'name' not described in '__vfs_removexattr_locked'
../fs/xattr.c:458: warning: Function parameter or member 'delegated_inode' not described in '__vfs_removexattr_locked'

Fixes: 08b5d5014a27 ("xattr: break delegations in {set,remove}xattr")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: stable@vger.kernel.org # v4.9+
Cc: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Frank van der Linden <fllinden@amazon.com>
Cc: Chuck Lever <chuck.lever@oracle.com>
---
 fs/xattr.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- lnx-59-rc3.orig/fs/xattr.c
+++ lnx-59-rc3/fs/xattr.c
@@ -232,15 +232,15 @@ int __vfs_setxattr_noperm(struct dentry
 }
 
 /**
- * __vfs_setxattr_locked: set an extended attribute while holding the inode
+ * __vfs_setxattr_locked - set an extended attribute while holding the inode
  * lock
  *
- *  @dentry - object to perform setxattr on
- *  @name - xattr name to set
- *  @value - value to set @name to
- *  @size - size of @value
- *  @flags - flags to pass into filesystem operations
- *  @delegated_inode - on return, will contain an inode pointer that
+ *  @dentry: object to perform setxattr on
+ *  @name: xattr name to set
+ *  @value: value to set @name to
+ *  @size: size of @value
+ *  @flags: flags to pass into filesystem operations
+ *  @delegated_inode: on return, will contain an inode pointer that
  *  a delegation was broken on, NULL if none.
  */
 int
@@ -443,12 +443,12 @@ __vfs_removexattr(struct dentry *dentry,
 EXPORT_SYMBOL(__vfs_removexattr);
 
 /**
- * __vfs_removexattr_locked: set an extended attribute while holding the inode
+ * __vfs_removexattr_locked - set an extended attribute while holding the inode
  * lock
  *
- *  @dentry - object to perform setxattr on
- *  @name - name of xattr to remove
- *  @delegated_inode - on return, will contain an inode pointer that
+ *  @dentry: object to perform setxattr on
+ *  @name: name of xattr to remove
+ *  @delegated_inode: on return, will contain an inode pointer that
  *  a delegation was broken on, NULL if none.
  */
 int

