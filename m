Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD02A79B03F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 01:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjIKUwc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244001AbjIKSir (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 14:38:47 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825E61AE
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 11:38:42 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D6B6B9027AB
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 18:38:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a294.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 7A06F9021FA
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 18:38:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1694457521; a=rsa-sha256;
        cv=none;
        b=rwkssJPvoWOHis2U+aa0cd2lRHend2grB7EWyoNLl50KWodQ4Nh8rXLt7h+hQ+l6qV+bC3
        +TnEVQyZ7sw0bjbI5sHozQrv+ywOR3SpXdtoQeDJWz7bOHCNWQTfTg+0h70twulEu0vRQH
        qRqmBwky3F9iLGC0AOrhuG1oGnb4JsF7DxruwdbiSDQBYMaldtdnms2vs1CZLMSFKZKpD9
        9UW7dkz6SdCl/ylIMONhm7NTllhuP47tcFnrdqW7gT32EGPcBm7RWnUtl+pjEvgZulSFuF
        1/74+70C9ZnXzmzLmRUd0+qifc7GoYaxpA+ZwjxNj1VA55XU3oG/bsZ09917MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1694457521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=FSUK8pOwpvuxQ+JLt0jdCQPxsw4/FtxlxfMUCOvi2Vo=;
        b=pKZNnGGhdxQEPbNjq2v1M6fXpEW0nv0STxj5uhPzgJaYN+VZ6Gs86cEeJnGTR6pH6BmFqk
        QNTCAe0q3vJm0Le41xAlxG2f2oiezfLY8dlF8HOJ1a0Hlf52FlztEh4C6u2Wln5xWog9Oi
        CjAfU2SIYqjNuO2COGSuw0Iq1LzBIRNVmySuES/wF3VUA1gCqob7WHMOzJlD1+zsuBBvuU
        561yMRq42IvwzKdeV/50XTorWt+Mfv421rgcGk0saIDZmweZaNJSmbiiwNl+zSu8vobUSK
        9bU5qjKroAevdrcvB2fL406lNd3M74EBUpPkWKayxetFainbk+NWqKO1sNBK2g==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-drktx;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Ruddy-Belong: 415201571428fd05_1694457521709_2227481475
X-MC-Loop-Signature: 1694457521709:3455281592
X-MC-Ingress-Time: 1694457521709
Received: from pdx1-sub0-mail-a294.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.99.54.176 (trex/6.9.1);
        Mon, 11 Sep 2023 18:38:41 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a294.dreamhost.com (Postfix) with ESMTPSA id 4RkwTY1P2DzRn
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 11:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1694457521;
        bh=FSUK8pOwpvuxQ+JLt0jdCQPxsw4/FtxlxfMUCOvi2Vo=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=eLwToKe9t9/l6uyz4YUCl6xOhB4/7ZyDAweU7Jz4u/ulkpHnakUSCJU4WryiTG92u
         vzjJO7ofzGfXcxHina7YbbZ1vXedBZ5COGZ8mNe1jzMTN0DGxZOr6+NT7O8kJalfV+
         9b6a56/e+TNXhUhITfG6LXW2/1dGsFNdXPNUZQAjXZHB3vDrHbCNhMDCi1mQLuyzy+
         ot0uaQIFb+MZj5fW6WefrRCWjm6dtVSPDFwCnPWHXYXKd7BQ/MWtaotbDFKFl+TX8k
         YnjOo+1zCx8aSBPPnL+R+sXspSanqwvq5sGOEb7mI3y7x/c9t96qOZliZhe0yt/bdY
         qBWu9iBCjufnw==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e00c8
        by kmjvbox (DragonFly Mail Agent v0.12);
        Mon, 11 Sep 2023 11:38:38 -0700
Date:   Mon, 11 Sep 2023 11:38:38 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>
Subject: [PATCH 1/2] fuse: revalidate: move lookup into a separate function
Message-ID: <9a2b0c5b625cd88c561289bf7d4d7dfe305c10ed.1693440240.git.kjlx@templeofstupid.com>
References: <cover.1693440240.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1693440240.git.kjlx@templeofstupid.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If this refactoring seems cumbersome, it's because the goal is to move
the lookup parts of fuse_dentry_revalidate into a common function.  This
function will be used in a subsequent commit.  In the meantime, the new
function fuse_dentry_revalidate_lookup is responsible for just the
lookup and validation portions of the revalidate dance.  The
fuse_dentry_revalidate function retains the responsibility for
invalidating and mutating any state associated with the origial
fuse_inode and dentry.

Cc: stable@vger.kernel.org
Fixes: 1866d779d5d2 ("fuse: Allow fuse_fill_super_common() for submounts")
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 fs/fuse/dir.c | 87 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 60 insertions(+), 27 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index e190d09f220d..afbdd223b0f3 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -183,6 +183,59 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
 	args->out_args[0].value = outarg;
 }
 
+static int fuse_dentry_revalidate_lookup(struct fuse_mount *fm,
+					 struct dentry *entry,
+					 struct inode *inode,
+					 struct fuse_entry_out *outarg,
+					 bool *lookedup)
+{
+	struct dentry *parent;
+	struct fuse_forget_link *forget;
+	struct fuse_inode *fi;
+	FUSE_ARGS(args);
+	int ret;
+
+	forget = fuse_alloc_forget();
+	ret = -ENOMEM;
+	if (!forget)
+		goto out;
+
+	parent = dget_parent(entry);
+	fuse_lookup_init(fm->fc, &args, get_node_id(d_inode(parent)),
+			 &entry->d_name, outarg);
+	ret = fuse_simple_request(fm, &args);
+	dput(parent);
+
+	/* Zero nodeid is same as -ENOENT */
+	if (!ret && !outarg->nodeid)
+		ret = -ENOENT;
+	if (!ret) {
+		fi = get_fuse_inode(inode);
+		if (outarg->nodeid != get_node_id(inode) ||
+		    (bool) IS_AUTOMOUNT(inode) != (bool) (outarg->attr.flags & FUSE_ATTR_SUBMOUNT)) {
+			fuse_queue_forget(fm->fc, forget,
+					  outarg->nodeid, 1);
+			goto invalid;
+		}
+		*lookedup = true;
+	}
+	kfree(forget);
+	if (ret == -ENOMEM || ret == -EINTR)
+		goto out;
+	if (ret || fuse_invalid_attr(&outarg->attr) ||
+	    fuse_stale_inode(inode, outarg->generation, &outarg->attr)) {
+		goto invalid;
+	}
+
+	ret = 1;
+out:
+	return ret;
+
+invalid:
+	ret = 0;
+	goto out;
+}
+
 /*
  * Check whether the dentry is still valid
  *
@@ -206,9 +259,8 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 	else if (time_before64(fuse_dentry_time(entry), get_jiffies_64()) ||
 		 (flags & (LOOKUP_EXCL | LOOKUP_REVAL | LOOKUP_RENAME_TARGET))) {
 		struct fuse_entry_out outarg;
-		FUSE_ARGS(args);
-		struct fuse_forget_link *forget;
 		u64 attr_version;
+		bool lookedup = false;
 
 		/* For negative dentries, always do a fresh lookup */
 		if (!inode)
@@ -220,38 +272,19 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 
 		fm = get_fuse_mount(inode);
 
-		forget = fuse_alloc_forget();
-		ret = -ENOMEM;
-		if (!forget)
-			goto out;
-
 		attr_version = fuse_get_attr_version(fm->fc);
 
-		parent = dget_parent(entry);
-		fuse_lookup_init(fm->fc, &args, get_node_id(d_inode(parent)),
-				 &entry->d_name, &outarg);
-		ret = fuse_simple_request(fm, &args);
-		dput(parent);
-		/* Zero nodeid is same as -ENOENT */
-		if (!ret && !outarg.nodeid)
-			ret = -ENOENT;
-		if (!ret) {
+		ret = fuse_dentry_revalidate_lookup(fm, entry, inode, &outarg,
+						    &lookedup);
+		if (ret == -ENOMEM || ret == -EINTR)
+			goto out;
+		if (lookedup) {
 			fi = get_fuse_inode(inode);
-			if (outarg.nodeid != get_node_id(inode) ||
-			    (bool) IS_AUTOMOUNT(inode) != (bool) (outarg.attr.flags & FUSE_ATTR_SUBMOUNT)) {
-				fuse_queue_forget(fm->fc, forget,
-						  outarg.nodeid, 1);
-				goto invalid;
-			}
 			spin_lock(&fi->lock);
 			fi->nlookup++;
 			spin_unlock(&fi->lock);
 		}
-		kfree(forget);
-		if (ret == -ENOMEM || ret == -EINTR)
-			goto out;
-		if (ret || fuse_invalid_attr(&outarg.attr) ||
-		    fuse_stale_inode(inode, outarg.generation, &outarg.attr))
+		if (ret <= 0)
 			goto invalid;
 
 		forget_all_cached_acls(inode);
-- 
2.25.1

