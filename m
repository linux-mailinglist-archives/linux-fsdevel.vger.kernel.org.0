Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E213F7B568E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 17:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238099AbjJBPZB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 11:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238089AbjJBPY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:24:58 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623B4AC
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 08:24:54 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A9205540E74
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 15:24:53 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 22D24541D41
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 15:24:53 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1696260293; a=rsa-sha256;
        cv=none;
        b=kYWVfCYXSLI71rvItKHn/YiR49DWodeC7woa6cVy8vpguvXZrUcnfQ+UD+Af3w7CrDNBMy
        0Q1udosZNj+rWFlnIF506alw0lw3wsCZwFICTIJRDthGQoSLvLI6mcTunb6+IVda8G1N8a
        LlNHZ1s3uwzWdwHeS6zBLPV1kQHXSXszHSEnhzru5siL/5E1t/6k6QuBEhDH+1IHSnycpF
        8V1O7mHokQB+dgVzrwURSsEqE76JEPUIPWV0CuMIOnDUMPe1ia63Am0TJiu32uCdA8TBs2
        l69JEIDaBofclIL1WijUUn0K5PGhfxxHdb9luQ6OZg1CqBprem73IPo9RVSnvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1696260293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=BpDz/GSeF06rc+c8xq1C9eT93VnU3phb3ZkiVcYrwwo=;
        b=7E3Qdt/v8aeHQvR00A58F7SI/cWHNloeX0BkUInnNVUQIcDbKT8DKtWEmWAg541O6APgBa
        j+piL0m2syRnO/PJm01faggtBmKahcwm0uP7lbNpIy+zDTHGrafDS5oLAXthzFIQq0PKRO
        /43148woUwxRzRXZ0lRjIZbNtgIPrX2nTSi4DZu80iNn0prq3g55zOpTkeDg5ARkMf1oJO
        +1m/14g6CP/5vrscJKTsALUBEnjj7xRaUOiZ3gPuCWPjYjIsIMZ09l99zSKYEELuVxq8dl
        qTAu4xtPimvFm0z4l4cw2ItC+ARW4BEMHXLirRcYF4dBnxleHmI31YDYYTRP+Q==
ARC-Authentication-Results: i=1;
        rspamd-7c449d4847-d8k9l;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Hysterical-Abaft: 208c7d221c8445bf_1696260293446_372728047
X-MC-Loop-Signature: 1696260293446:248023241
X-MC-Ingress-Time: 1696260293446
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.99.159.71 (trex/6.9.1);
        Mon, 02 Oct 2023 15:24:53 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4RzlBD5sNFz17l
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 08:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1696260292;
        bh=BpDz/GSeF06rc+c8xq1C9eT93VnU3phb3ZkiVcYrwwo=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=VmXXspI4qsfiYqhz5/mCWzzyo+dIKOMdlF3OebWW0mcd3gmSmEZvmYuMQ36gkw7NF
         MFCLv0xA1YtqyVzi2Q51ZVN2l9L5k5XQ1NmFghkA3l4rcKwfDKYpYn5lwy8xRx7DQZ
         iXln9qeqUX8y+SH3bSg5vWNRkHJRaZTDwkCic1/b8pu9VFbUJxah7LEGQwOfE/4kMK
         DSSuZf9s0lUI/Ue9kaXTI/HFkYmN4e7iBRNNFR+14UR6g7PF75HIImlWpDIuow3jsQ
         ACD1obGTy4TFa4wCDQNo6p04c+bjGObhDK5nLaDIRKVpEdkwOfIMSRw/6gJT5SRBG9
         mnFDWgCFSozkw==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0110
        by kmjvbox (DragonFly Mail Agent v0.12);
        Mon, 02 Oct 2023 08:24:49 -0700
Date:   Mon, 2 Oct 2023 08:24:49 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>
Subject: [resend PATCH v2 2/2] fuse: ensure that submounts lookup their parent
Message-ID: <45778432fba32dce1fb1f5fd13272c89c95c3f52.1696043833.git.kjlx@templeofstupid.com>
References: <cover.1696043833.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696043833.git.kjlx@templeofstupid.com>
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The submount code uses the parent nodeid passed into the function in
order to create the root dentry for the new submount.  This nodeid does
not get its remote reference count incremented by a lookup option.

If the parent inode is evicted from its superblock, due to memory
pressure for example, it can result in a forget opertation being sent to
the server.  Should this nodeid be forgotten while it is still in use in
a submount, users of the submount get an error from the server on any
subsequent access.  In the author's case, this was an EBADF on all
subsequent operations that needed to reference the root.

Debugging the problem revealed that the dentry shrinker triggered a forget
after killing the dentry with the last reference, despite the root
dentry in another superblock still using the nodeid.

As a result, a container that was also using this submount failed to
access its filesystem because it had borrowed the reference instead of
taking its own when setting up its superblock for the submount.

This commit fixes the problem by having the new submount trigger a
lookup for the parent as part of creating a new root dentry for the
virtiofsd submount superblock.  This allows each superblock to have its
inodes removed by the shrinker when unreferenced, while keeping the
nodeid reference count accurate and active with the server.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 fs/fuse/dir.c    | 10 +++++-----
 fs/fuse/fuse_i.h |  6 ++++++
 fs/fuse/inode.c  | 43 +++++++++++++++++++++++++++++++++++++------
 3 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 5e01946d7531..333730c74619 100644
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
index 405252bb51f2..a66fcf50a4cc 100644
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
index 444418e240c8..79a31cb55512 100644
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

