Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC3B1E0682
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 07:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388519AbgEYFrP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 01:47:15 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:46009 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388508AbgEYFrO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 01:47:14 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id DE73AEC0;
        Mon, 25 May 2020 01:47:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 25 May 2020 01:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        subject:from:to:cc:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm3; bh=
        FtR+UgOOZLBiQrxLIVMV0q/xz8NJCgPfEh2OWV3jrgA=; b=u0qmfAHxIMHVRI0N
        ZTFLJ3BxnZMG0HEatOhEhb4Xg9/co4Y4hOoiZkW5qwF5YRDOJIpkmlbzdivWun2n
        RbteUJx4HHE0283zBlb6GkvNihLxTVI65D64O3KFAajbm9DaYBCgKDoB2s92O6am
        FOTATTr/fPChVcCoVqDfCYEpDD+6LGMArgfYnoo/UGZmCygZvfaBQAynSwVw1DOP
        v+DND6hrpCttdZW4doSIBpGC9+5+RVeFfVh/llNYJEK8mzAc4TMMwe+LsqDyKXSK
        8E1BjYaSC1npJjGXFF/nbjlNW69Czxql8wXRrRdseCH2XObpT5xlVn4N88QIZlul
        saPhgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=FtR+UgOOZLBiQrxLIVMV0q/xz8NJCgPfEh2OWV3jr
        gA=; b=EJbduoMHGLUcTCmwBkosAXbtfWOJmbs4OauGGGo+rXXreutVzElhQr2d8
        yBGvwl1mhadY6HEsUVJ+1vlwE/CTscrj3LlPHGJhccCFQVssZoA0AhDo26M/zyQD
        4vvSDn3IS9Zu2dn2pucoX7MG9hWqwz/U0fKNVGd5USv4aqbBFv9xrFcq/dte9yYR
        Eugfn/g3aqxFrqrskD6HogUEaXXueeM6x97tAmiuVWsNioFoCzccc2Ry2Td4QsV2
        T9r6eEtBWg86WCUi4qXFbkAkgkgwIYgD1Uay1Ct9nRsHzLbr388OIP7UCTG0P+Mw
        b0gUInD0XSpQ/RhfhG5u0fSaLgjnw==
X-ME-Sender: <xms:4FvLXjTyjl1j7CmkHTK_mUqq4rIwtrgGoKjKHUKdkkWA58DUpBJuxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudduledgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffhvfffkfgjfhgfgggtgfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    egveeuudffieeiffefieehvdetieeiteelheetueekledtledugeffheffieduieenucfk
    phepuddukedrvddtkedrudejkedrudeknecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:4FvLXkz0Xeub3fRHwiz4PBO91KI6-GSZp0K8jM1f3YXy_Pp5q8q00g>
    <xmx:4FvLXo2k7bVelzsHfezieAD7qJdVd7ufLSePlcMko2eKTjGFxH0tKA>
    <xmx:4FvLXjAq5TRCGecgldV92qicrv4nORokkLjcRPc8LST1HotLPXWszw>
    <xmx:4FvLXmaEOwZGq7t_eB7Yw-yl7ExzDUsDK0RzNuZ4FQF6fDOyUPgkog>
Received: from mickey.localdomain (unknown [118.208.178.18])
        by mail.messagingengine.com (Postfix) with ESMTPA id 266F6306654C;
        Mon, 25 May 2020 01:47:12 -0400 (EDT)
Received: from mickey.themaw.net (localhost [127.0.0.1])
        by mickey.localdomain (Postfix) with ESMTP id B01C0A01C8;
        Mon, 25 May 2020 13:47:09 +0800 (AWST)
Subject: [PATCH 2/4] kernfs: move revalidate to be near lookup
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 25 May 2020 13:47:09 +0800
Message-ID: <159038562968.276051.1536156625429513766.stgit@mickey.themaw.net>
In-Reply-To: <159038508228.276051.14042452586133971255.stgit@mickey.themaw.net>
References: <159038508228.276051.14042452586133971255.stgit@mickey.themaw.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While the dentry operation kernfs_dop_revalidate() is grouped with
dentry'ish functions it also has a strong afinity to the inode
operation ->lookup(). And when path walk improvements are applied
it will need to call kernfs_find_ns() so move it to be near
kernfs_iop_lookup() to avoid the need for a forward declaration.

There's no functional change from this patch.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/kernfs/dir.c |   86 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index d8213fc65eba..9b315f3b20ee 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -559,49 +559,6 @@ void kernfs_put(struct kernfs_node *kn)
 }
 EXPORT_SYMBOL_GPL(kernfs_put);
 
-static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
-{
-	struct kernfs_node *kn;
-
-	if (flags & LOOKUP_RCU)
-		return -ECHILD;
-
-	/* Always perform fresh lookup for negatives */
-	if (d_really_is_negative(dentry))
-		goto out_bad_unlocked;
-
-	kn = kernfs_dentry_node(dentry);
-	down_read(&kernfs_rwsem);
-
-	/* The kernfs node has been deactivated */
-	if (!kernfs_active_read(kn))
-		goto out_bad;
-
-	/* The kernfs node has been moved? */
-	if (kernfs_dentry_node(dentry->d_parent) != kn->parent)
-		goto out_bad;
-
-	/* The kernfs node has been renamed */
-	if (strcmp(dentry->d_name.name, kn->name) != 0)
-		goto out_bad;
-
-	/* The kernfs node has been moved to a different namespace */
-	if (kn->parent && kernfs_ns_enabled(kn->parent) &&
-	    kernfs_info(dentry->d_sb)->ns != kn->ns)
-		goto out_bad;
-
-	up_read(&kernfs_rwsem);
-	return 1;
-out_bad:
-	up_read(&kernfs_rwsem);
-out_bad_unlocked:
-	return 0;
-}
-
-const struct dentry_operations kernfs_dops = {
-	.d_revalidate	= kernfs_dop_revalidate,
-};
-
 /**
  * kernfs_node_from_dentry - determine kernfs_node associated with a dentry
  * @dentry: the dentry in question
@@ -1085,6 +1042,49 @@ struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 	return ERR_PTR(rc);
 }
 
+static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
+{
+	struct kernfs_node *kn;
+
+	if (flags & LOOKUP_RCU)
+		return -ECHILD;
+
+	/* Always perform fresh lookup for negatives */
+	if (d_really_is_negative(dentry))
+		goto out_bad_unlocked;
+
+	kn = kernfs_dentry_node(dentry);
+	down_read(&kernfs_rwsem);
+
+	/* The kernfs node has been deactivated */
+	if (!kernfs_active_read(kn))
+		goto out_bad;
+
+	/* The kernfs node has been moved? */
+	if (kernfs_dentry_node(dentry->d_parent) != kn->parent)
+		goto out_bad;
+
+	/* The kernfs node has been renamed */
+	if (strcmp(dentry->d_name.name, kn->name) != 0)
+		goto out_bad;
+
+	/* The kernfs node has been moved to a different namespace */
+	if (kn->parent && kernfs_ns_enabled(kn->parent) &&
+	    kernfs_info(dentry->d_sb)->ns != kn->ns)
+		goto out_bad;
+
+	up_read(&kernfs_rwsem);
+	return 1;
+out_bad:
+	up_read(&kernfs_rwsem);
+out_bad_unlocked:
+	return 0;
+}
+
+const struct dentry_operations kernfs_dops = {
+	.d_revalidate	= kernfs_dop_revalidate,
+};
+
 static struct dentry *kernfs_iop_lookup(struct inode *dir,
 					struct dentry *dentry,
 					unsigned int flags)


