Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40E531C5F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 05:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhBPEab (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 23:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhBPEa1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 23:30:27 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650A5C0613D6;
        Mon, 15 Feb 2021 20:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=g0RpN84wUT0yixGx7EFyBU7WD3PcEA7S8c2B41kxWUM=; b=Xo7REI9hG4v8Rim3wecgde6+kd
        a1VHhKNzwaWhtun9nTfVee8nFQL3q68qa/2lOcunlTfV1Ebwcb1X8GwHP2YN4Gbuy+PeCgxqYSmat
        acURxMBu+zwtS2Kxae9WWzZWut4wZkSolu7NzCHvEyMEAx32KYBCTxHZK52wD1dkjapoZy/fSvnAy
        zKPU5jmtetnaf+zyIn+10Tgk+YttHI9bkx6BigrcZY9wJabp8stm3xe4mNNIfSP/9wC1Kfzs/oLS/
        fa8f2LGEXgCJrzFzsf3C+z6fWQ6mMc192dESbg4sI6Amnk9NFiHNK3nbauR9ubQPFmwPeHiEKsZ+0
        1FMxOyow==;
Received: from [2601:1c0:6280:3f0::b669] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lBrza-0002nO-K9; Tue, 16 Feb 2021 04:29:43 +0000
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
Subject: [PATCH -next] fs: namei: fix kernel-doc for struct renamedata and more
Date:   Mon, 15 Feb 2021 20:29:28 -0800
Message-Id: <20210216042929.8931-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210216042929.8931-1-rdunlap@infradead.org>
References: <20210216042929.8931-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix kernel-doc warnings in namei.c:

../fs/namei.c:1149: warning: Excess function parameter 'dir_mode' description in 'may_create_in_sticky'
../fs/namei.c:1149: warning: Excess function parameter 'dir_uid' description in 'may_create_in_sticky'
../fs/namei.c:3396: warning: Function parameter or member 'open_flag' not described in 'vfs_tmpfile'
../fs/namei.c:3396: warning: Excess function parameter 'open_flags' description in 'vfs_tmpfile'
../fs/namei.c:4460: warning: Function parameter or member 'rd' not described in 'vfs_rename'
../fs/namei.c:4460: warning: Excess function parameter 'old_mnt_userns' description in 'vfs_rename'
../fs/namei.c:4460: warning: Excess function parameter 'old_dir' description in 'vfs_rename'
../fs/namei.c:4460: warning: Excess function parameter 'old_dentry' description in 'vfs_rename'
../fs/namei.c:4460: warning: Excess function parameter 'new_mnt_userns' description in 'vfs_rename'
../fs/namei.c:4460: warning: Excess function parameter 'new_dir' description in 'vfs_rename'
../fs/namei.c:4460: warning: Excess function parameter 'new_dentry' description in 'vfs_rename'
../fs/namei.c:4460: warning: Excess function parameter 'delegated_inode' description in 'vfs_rename'
../fs/namei.c:4460: warning: Excess function parameter 'flags' description in 'vfs_rename'

Fixes: 9fe61450972d ("namei: introduce struct renamedata")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/namei.c |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

--- linux-next-20210215.orig/fs/namei.c
+++ linux-next-20210215/fs/namei.c
@@ -1121,8 +1121,7 @@ int may_linkat(struct user_namespace *mn
  *			  should be allowed, or not, on files that already
  *			  exist.
  * @mnt_userns:	user namespace of the mount the inode was found from
- * @dir_mode: mode bits of directory
- * @dir_uid: owner of directory
+ * @nd: nameidata pathwalk data
  * @inode: the inode of the file to open
  *
  * Block an O_CREAT open of a FIFO (or a regular file) when:
@@ -3381,7 +3380,7 @@ static int do_open(struct nameidata *nd,
  * @mnt_userns:	user namespace of the mount the inode was found from
  * @dentry:	pointer to dentry of the base directory
  * @mode:	mode of the new tmpfile
- * @open_flags:	flags
+ * @open_flag:	flags
  *
  * Create a temporary file.
  *
@@ -4406,14 +4405,7 @@ SYSCALL_DEFINE2(link, const char __user
 
 /**
  * vfs_rename - rename a filesystem object
- * @old_mnt_userns:	old user namespace of the mount the inode was found from
- * @old_dir:		parent of source
- * @old_dentry:		source
- * @new_mnt_userns:	new user namespace of the mount the inode was found from
- * @new_dir:		parent of destination
- * @new_dentry:		destination
- * @delegated_inode:	returns an inode needing a delegation break
- * @flags:		rename flags
+ * @rd:		pointer to &struct renamedata info
  *
  * The caller must hold multiple mutexes--see lock_rename()).
  *
