Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1928B79D8B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 20:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237445AbjILSew (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 14:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237173AbjILSev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:34:51 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195A410EF
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 11:34:48 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 854B681F60
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 18:34:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a271.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id EBF2F80E58
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 18:34:46 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1694543687; a=rsa-sha256;
        cv=none;
        b=RqRe/+tTCdJCwn7GPsyze+pzrwRUidDU7OZovjvr9nDrZz2dFBICB/+4pb4BH8hWGCG7KV
        MQCGQwVefV4+ko/0iTY1xOOf+I9mWBZ0eABpmCmCa6MieCBtjHFeAGVXvRzXqt9CgAaRhx
        FXsHskGTN955qh6PqbwqKsK0cUcqM1ZWaOwvKOlyLuOf1Yg6Gw/Toc5M9vSJFWTLo4BXBj
        DcQkrWbeNtCOYmF1geAwYLNBChUFc/VnDpDbGvtd+Bh/YvLM+CflUKry27odCUNwOHp3PX
        CeX4uE4PlMWYPypvSHdYwAnxe7g6sKExt6CO4MxfZLYAsTfvc/FbaBxTP+Fy9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1694543687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=VUQ0/fQcYYJTl1VWWtYiPFdUlYDopB1YGncT2DJDzrs=;
        b=QZyVp6ge9VsGey8cspBvnOQkMNKr0ekRisu8EM0tRuyKDBr/lrSsU1GCpShdvbUPNqb43q
        XV3R99ltkznNdA9wyYR9n4ohJSEbx9q6nXd0MAlfjOkYnTHeltX6h6aosqHzVFggoepXhB
        IECz9FRLRB8wUI3TwSO0KF42m7GTVhejuD+8eRZjyEP5yxFLbgGbiQAehzmgLtlkdk8TGi
        bCbO/KEPsSzqmzGbrKXJcdxkfxxCpMG22s8ur4EZG07xAj3qIwAFalZyzbUIATI8V4wu9H
        B5JFG2gvl8EpdB6kk4KJNgQryn1U0SiYlefHsfTKpZCGFnhobZGHM88mEgVvsA==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-6q69j;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Skirt-Fumbling: 21c89910564e6709_1694543687377_1306641520
X-MC-Loop-Signature: 1694543687377:343671777
X-MC-Ingress-Time: 1694543687377
Received: from pdx1-sub0-mail-a271.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.119.184.198 (trex/6.9.1);
        Tue, 12 Sep 2023 18:34:47 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a271.dreamhost.com (Postfix) with ESMTPSA id 4RlXLZ5510zDl
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 11:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1694543686;
        bh=VUQ0/fQcYYJTl1VWWtYiPFdUlYDopB1YGncT2DJDzrs=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=QFXQlpaLCMHpPFL4cg6KI3qVmg9Bk6wgHcL6YZ0ri/tP1NoUJWr7hPv3LzXgXQ44L
         cKgLgTgJ/flE5+LFtcPq8BjoUTxQ6soN45hbfY8EyeLnNYP2T+fIgBRJL6mREi6Len
         f8cTA5lNz4E+SgEpFjl/dZOLC8SzjBswdTmgVaTSrhIiLu91wcDSBFAwWB6O4nPOSz
         YrJuukZg9U1h7lDiaYgKlYG9HZjDraGMB4IDwJguXnwGBEZOGLSCjZdJIxp9i7DY51
         DmktsW9cbXzt3UpkDGhjDmhyAxnOw6Z8eGOaYB0JH1BAN2PAjkqFffNjx9sutr0qBQ
         H1VjOM6cKAKww==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0111
        by kmjvbox (DragonFly Mail Agent v0.12);
        Tue, 12 Sep 2023 11:34:36 -0700
Date:   Tue, 12 Sep 2023 11:34:36 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>
Subject: [PATCH v2 2/2] fuse: ensure that submounts lookup their root
Message-ID: <8690c10ec37a730659d5481054fc605c9741e2b4.1694541252.git.kjlx@templeofstupid.com>
References: <cover.1694541252.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694541252.git.kjlx@templeofstupid.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Prior to this commit, the submount code assumed that the inode for the
root filesystem could not be evicted.  When eviction occurs the server
may forget the inode.  This author has observed a submount get an EBADF
from a virtiofsd server that resulted from the sole dentry / inode
pair getting evicted from a mount namespace and superblock where they
were originally referenced.  The dentry shrinker triggered a forget
after killing the dentry with the last reference.

As a result, a container that was also using this submount failed to
access its filesystem because it had borrowed the reference instead of
taking its own when setting up its superblock for the submount.

Fix by ensuring that submount superblock configuration looks up the
nodeid for the submount as well.

Cc: stable@vger.kernel.org
Fixes: 1866d779d5d2 ("fuse: Allow fuse_fill_super_common() for submounts")
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 fs/fuse/dir.c    | 10 +++++-----
 fs/fuse/fuse_i.h |  6 ++++++
 fs/fuse/inode.c  | 43 +++++++++++++++++++++++++++++++++++++------
 3 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index da5b6079d88c..0002667170a9 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -183,11 +183,11 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
 	args->out_args[0].value = outarg;
 }
 
-static int fuse_dentry_revalidate_lookup(struct fuse_mount *fm,
-					 struct dentry *entry,
-					 struct inode *inode,
-					 struct fuse_entry_out *outarg,
-					 bool *lookedup)
+int fuse_dentry_revalidate_lookup(struct fuse_mount *fm,
+				  struct dentry *entry,
+				  struct inode *inode,
+				  struct fuse_entry_out *outarg,
+				  bool *lookedup)
 {
 	struct dentry *parent;
 	struct fuse_forget_link *forget;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index bf0b85d0b95c..f8ba293d5d30 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1325,6 +1325,12 @@ void fuse_dax_dontcache(struct inode *inode, unsigned int flags);
 bool fuse_dax_check_alignment(struct fuse_conn *fc, unsigned int map_alignment);
 void fuse_dax_cancel_work(struct fuse_conn *fc);
 
+/* dir.c */
+int fuse_dentry_revalidate_lookup(struct fuse_mount *fm, struct dentry *entry,
+				  struct inode *inode,
+				  struct fuse_entry_out *outarg,
+				  bool *lookedup);
+
 /* ioctl.c */
 long fuse_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 long fuse_file_compat_ioctl(struct file *file, unsigned int cmd,
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d47606206ec3..b3e7b0a397ae 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1464,7 +1464,13 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	struct fuse_mount *fm = get_fuse_mount_super(sb);
 	struct super_block *parent_sb = parent_fi->inode.i_sb;
 	struct fuse_attr root_attr;
+	struct fuse_inode *fi;
 	struct inode *root;
+	struct inode *parent;
+	struct dentry *pdent;
+	struct fuse_entry_out outarg;
+	bool lookedup = false;
+	int ret;
 
 	fuse_sb_defaults(sb);
 	fm->sb = sb;
@@ -1480,14 +1486,39 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	if (parent_sb->s_subtype && !sb->s_subtype)
 		return -ENOMEM;
 
-	fuse_fill_attr_from_inode(&root_attr, parent_fi);
-	root = fuse_iget(sb, parent_fi->nodeid, 0, &root_attr, 0, 0);
 	/*
-	 * This inode is just a duplicate, so it is not looked up and
-	 * its nlookup should not be incremented.  fuse_iget() does
-	 * that, though, so undo it here.
+	 * It is necessary to lookup the parent_if->nodeid in case the dentry
+	 * that triggered the automount of the submount is later evicted.
+	 * If this dentry is evicted without the lookup count getting increased
+	 * on the submount root, then the server can subsequently forget this
+	 * nodeid which leads to errors when trying to access the root of the
+	 * submount.
 	 */
-	get_fuse_inode(root)->nlookup--;
+	parent = &parent_fi->inode;
+	pdent = d_find_alias(parent);
+	if (!pdent)
+		return -EINVAL;
+
+	ret = fuse_dentry_revalidate_lookup(fm, pdent, parent, &outarg,
+	    &lookedup);
+	dput(pdent);
+	/*
+	 * The new root owns this nlookup on success, and it is incremented by
+	 * fuse_iget().  In the case the lookup succeeded but revalidate fails,
+	 * ensure that the lookup count is tracked by the parent.
+	 */
+	if (ret <= 0) {
+		if (lookedup) {
+			fi = get_fuse_inode(parent);
+			spin_lock(&fi->lock);
+			fi->nlookup++;
+			spin_unlock(&fi->lock);
+		}
+		return ret ? ret : -EINVAL;
+	}
+
+	fuse_fill_attr_from_inode(&root_attr, parent_fi);
+	root = fuse_iget(sb, parent_fi->nodeid, 0, &root_attr, 0, 0);
 	sb->s_d_op = &fuse_dentry_operations;
 	sb->s_root = d_make_root(root);
 	if (!sb->s_root)
-- 
2.25.1

