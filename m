Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7783F74E3A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 03:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjGKBnV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 21:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjGKBnT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:43:19 -0400
X-Greylist: delayed 310 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Jul 2023 18:43:14 PDT
Received: from bongo.yew.relay.mailchannels.net (bongo.yew.relay.mailchannels.net [23.83.220.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539FFE3
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 18:43:13 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5EAF95C1FE3
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 01:38:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id C89345C1FD5
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 01:37:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1689039479; a=rsa-sha256;
        cv=none;
        b=Eepe0L+JeueNalBbNPX01tuZGhgDvaRYSl4yb8P6Mz7FoDG9x7f2vp5GCxWV4FoYE4fD2/
        OCM3DawntNTRsk+cd0aplXsAjeil8ryT1r4GqzzQf3IjVw5EKrMub3jKBJZQub4oJj2SPO
        sQz0KwdXB8mQCs+B9fOCrnfbyb/PVRJha9fN2S3k7gYJlTSMLN4kBkrCJgTbSyGkHj2KhB
        awf8Oja3LPavjuubxpgxLDjfO9wYyL6Q3ttHaqCo3WPX+xFWyMyTPS3hgqklponGsq/xQq
        YLNdswhmD0aS4hwkPflMu4ImsSjcfk9XkNT/pedsH8/7ZhUfEqQNwllDermTjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1689039479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=5PpiEQMklI816ebRSrfaSOe/p+XsnMxbP2nT9Lvxh7E=;
        b=to4hU8cJzlO8PDPWiTowg/cG0e1zYc+tbmBWaD8SHJ/3or4C+JoJvxD46BIJptwrFriLCu
        tOTQF0uRQELQ4l7z9/UAjdmOqLjodgBdDqt2WFOqCpRm87RWu4FvUWhg2NzkbnrI57GAr2
        Cu5VM4C749gMxY43ERrvtPcultl6oCwVS0LLo2eMJgtP8AseLnehvU+5YOg/7nCo6iGl15
        c8d/2qYDMTGoAWwjSunKzSB6mICQrwj8F1d0A891EmSu82kBraJBNQnv5rBl7qGe28oG5s
        qV7uRJ789TOVXvQ7Rnzgj0RclunfTH/CpjOHvyMHYNFeI8PTmeiGhBU4rUrlag==
ARC-Authentication-Results: i=1;
        rspamd-7d9c4d5c9b-8hgvc;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Cooperative-Soft: 1809e47444d762d3_1689039480058_1462993165
X-MC-Loop-Signature: 1689039480057:3270341153
X-MC-Ingress-Time: 1689039480057
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.127.59.40 (trex/6.9.1);
        Tue, 11 Jul 2023 01:38:00 +0000
Received: from kmjvbox (unknown [71.198.86.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4R0NmR3q93zH9
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 18:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1689039479;
        bh=5PpiEQMklI816ebRSrfaSOe/p+XsnMxbP2nT9Lvxh7E=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=GnyelvYY+4t170d0F5+gLLM5nhFNtQejR4H0kvM4fklyug0IWxbWM7kdASi4snYoL
         yspaikeJEA1iZZXTgSMcsx4wOcyYpvtXjf5oyYEYvuaYIN16AT9x2gmj0kMMP5ojas
         XgiqBUfHSxCpnNSuF9E4JBsR4+xfmmCgV5i+odjM=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0085
        by kmjvbox (DragonFly Mail Agent v0.12);
        Mon, 10 Jul 2023 18:37:23 -0700
Date:   Mon, 10 Jul 2023 18:37:23 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>
Subject: [RFC PATCH 2/2] fuse: ensure that submounts lookup their root
Message-ID: <69bb95c34deb25f56b3b842528edcb40a098d38d.1689038902.git.kjlx@templeofstupid.com>
References: <cover.1689038902.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689038902.git.kjlx@templeofstupid.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 fs/fuse/dir.c    | 10 +++++-----
 fs/fuse/fuse_i.h |  6 ++++++
 fs/fuse/inode.c  | 32 ++++++++++++++++++++++++++++----
 3 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index bdf5526a0733..fe6b3fd4a49c 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -193,11 +193,11 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
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
index 9b7fc7d3c7f1..77b123eddb6d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1309,6 +1309,12 @@ void fuse_dax_dontcache(struct inode *inode, unsigned int flags);
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
index f19d748890f0..1032e4b05d9c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1441,6 +1441,10 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	struct super_block *parent_sb = parent_fi->inode.i_sb;
 	struct fuse_attr root_attr;
 	struct inode *root;
+	struct inode *parent;
+	struct dentry *pdent;
+	bool lookedup = false;
+	int ret;
 
 	fuse_sb_defaults(sb);
 	fm->sb = sb;
@@ -1456,14 +1460,34 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	if (parent_sb->s_subtype && !sb->s_subtype)
 		return -ENOMEM;
 
+	/*
+	 * It is necessary to lookup the parent_if->nodeid in case the dentry
+	 * that triggered the automount of the submount is later evicted.
+	 * If this dentry is evicted without the lookup count getting increased
+	 * on the submount root, then the server can subsequently forget this
+	 * nodeid which leads to errors when trying to access the root of the
+	 * submount.
+	 */
+	parent = &parent_fi->inode;
+	pdent = d_find_alias(parent);
+	if (pdent) {
+		struct fuse_entry_out outarg;
+
+		ret = fuse_dentry_revalidate_lookup(fm, pdent, parent, &outarg,
+						    &lookedup);
+		dput(pdent);
+		if (ret < 0)
+			return ret;
+	}
+
 	fuse_fill_attr_from_inode(&root_attr, parent_fi);
 	root = fuse_iget(sb, parent_fi->nodeid, 0, &root_attr, 0, 0);
 	/*
-	 * This inode is just a duplicate, so it is not looked up and
-	 * its nlookup should not be incremented.  fuse_iget() does
-	 * that, though, so undo it here.
+	 * fuse_iget() sets nlookup to 1 at creation time.  If this nodeid was
+	 * not successfully looked up then decrement the count.
 	 */
-	get_fuse_inode(root)->nlookup--;
+	if (!lookedup)
+		get_fuse_inode(root)->nlookup--;
 	sb->s_d_op = &fuse_dentry_operations;
 	sb->s_root = d_make_root(root);
 	if (!sb->s_root)
-- 
2.25.1

