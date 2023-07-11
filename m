Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D8774E3CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 03:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjGKB51 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 21:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGKB50 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:57:26 -0400
X-Greylist: delayed 1172 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Jul 2023 18:57:25 PDT
Received: from common.maple.relay.mailchannels.net (common.maple.relay.mailchannels.net [23.83.214.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C646AB
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 18:57:25 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1D6AB6C0F31
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 01:37:52 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 5DC6D6C0EFB
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 01:37:51 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1689039471; a=rsa-sha256;
        cv=none;
        b=YgwKP0DD2v8sEaDWVi7lfDMcOnQhYhYf0L+Z/ItwWXaYtG1KZeuloz/zxtrMkt+pM3DDdD
        IAYci3QLRaPBTh87aTeiK6A+DQQvVOdfMh1srnM4sd4kyA/pHn/3LnySTm68guJUTjKj5f
        ro4yOqKbASm5EcpjvpGpj+0hJA9PtrnFKpmC5TbbLYa/B0xmBSETetniGqIc64YiHRdE0e
        GcMndgknn05qZpxhqD15ZIsiIyKJvAw8tfsQ8N8J5d48mIQg7pqyRS9DRJ1Nyp+sFQ2/7l
        Xiyyb1fiTohszuaAiXeZlxLAPaHbN3H/+HiVF8HRGIH/YsjGhTOu8UWryE9kDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1689039471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=nM5r4kLoXtTj1OB8dGhlf8+7pkGcDvR2giSHwak5XTQ=;
        b=0DTWRP7pGwRBilyMz6AeJ5uFDe9ay9OD3Go5OnoRehdUeDxgS3OJSZWS+xMfr4uIKsEDES
        XshA/evfn3llrk0AYh7Z5xsV7MwfRT/dHnZ6d7mUlJKLZlu7GovgvQsCRt/Lpm5tye2dzY
        lmP7YNIF+gdp4i/vCgW7lXwnZK7dV/peScnP2m6lNe3yVGpR5ZyPb8iSr8Zp0ez1Y9zK4M
        WAMCLinNZahzVmx2TTYDWG4oE99pIkq5Q4kG2zd9b7JenUppUEmwit++P0bN6tgrjq7jCd
        7hhE7l/OPja9TaTzEpf8cg7BYBH4asMVI//ad2B334DLdS5vZxdHpsHgPxopMg==
ARC-Authentication-Results: i=1;
        rspamd-7d9c4d5c9b-nq969;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Bad
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Bored-Juvenile: 12557f2659a0a25a_1689039471875_3954098371
X-MC-Loop-Signature: 1689039471875:2866829768
X-MC-Ingress-Time: 1689039471875
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.12 (trex/6.9.1);
        Tue, 11 Jul 2023 01:37:51 +0000
Received: from kmjvbox (unknown [71.198.86.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4R0NmH0byfzy6
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 18:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1689039471;
        bh=nM5r4kLoXtTj1OB8dGhlf8+7pkGcDvR2giSHwak5XTQ=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=cl1sWhlgJDAUx+Fp8BqpjD0TB1F9tdkiF6lbGUQuKmzOVx4SI/cKyW3bVMURgeSOT
         LjqaTol9KsPyJ4xRMRRE5dceMeTxEiXoE3pKABgPp6SaWS++gvAPdIyFBSmM9btvd3
         l+ZDKsLXd4WMlXg4x/oJhV9wEVeoo6Yew1/jgloU=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0085
        by kmjvbox (DragonFly Mail Agent v0.12);
        Mon, 10 Jul 2023 18:37:14 -0700
Date:   Mon, 10 Jul 2023 18:37:14 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>
Subject: [RFC PATCH 1/2] fuse: revalidate: move lookup into a separate
 function
Message-ID: <b4947a6d3c2b9b82441a4c1b362048c834ddab6c.1689038902.git.kjlx@templeofstupid.com>
References: <cover.1689038902.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689038902.git.kjlx@templeofstupid.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If this refactoring seems cumbersome, it's because the goal is to move
the lookup parts of fuse_dentry_revalidate into a common function.  This
function will be used elsewhere in a separate commit.  In the meantime,
the new function fuse_dentry_revalidate_lookup is responsible for just
the lookup and validation portions of the revalidate dance.  The
fuse_dentry_revalidate function retains the responsibility for
invalidating and mutating any state associated with the origial
fuse_inode and dentry.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 fs/fuse/dir.c | 87 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 60 insertions(+), 27 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index f67bef9d83c4..bdf5526a0733 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -193,6 +193,59 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
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
@@ -216,9 +269,8 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 	else if (time_before64(fuse_dentry_time(entry), get_jiffies_64()) ||
 		 (flags & (LOOKUP_EXCL | LOOKUP_REVAL | LOOKUP_RENAME_TARGET))) {
 		struct fuse_entry_out outarg;
-		FUSE_ARGS(args);
-		struct fuse_forget_link *forget;
 		u64 attr_version;
+		bool lookedup = false;
 
 		/* For negative dentries, always do a fresh lookup */
 		if (!inode)
@@ -230,38 +282,19 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 
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

