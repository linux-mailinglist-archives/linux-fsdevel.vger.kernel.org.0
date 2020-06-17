Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEEC1FC79D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 09:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgFQHiA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 03:38:00 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:49597 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725901AbgFQHh6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:37:58 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id C652C5B1;
        Wed, 17 Jun 2020 03:37:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 17 Jun 2020 03:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        subject:from:to:cc:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm3; bh=
        FtR+UgOOZLBiQrxLIVMV0q/xz8NJCgPfEh2OWV3jrgA=; b=rMMRedoET73KVhcm
        v5wamPEc6LIuFh66Ri5S1XuHBwvm7ZuAdQH2nnX9TcSLKr19InvPfMHoq8DWEmqc
        dvS/4fF0E+F/c1bK/Ftbt0XqxKNig8D3clbR94gs7HPsSeNIM/BRHZn9t1aMeFsd
        LglU7Y+Cbp6xsT37amk3OccSRIm7h4PLz8mlmBOjCYthRKgghMekhICZROUNsvS0
        iaCxqCdFWGy/OAbNgxKCy5eIen4XhfwPZLkhMTrVxQ1GWwGH9PdXXgAfY2aNG771
        jV/wc2YDJ/FBWaEblYB0kEMkdzdoxJ5VddWRmuyDWo4WHcs1F2m2/Qmi0NNhgmJo
        CX5SRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=FtR+UgOOZLBiQrxLIVMV0q/xz8NJCgPfEh2OWV3jr
        gA=; b=Qkg0mF0LYwEWjenY/Ia5QGA0r6oLp5YZXj6Hz2TaraRoENC2nxYLZNBfg
        uBbhIQUA4dKPRBVQd/OboEDQgTnNJlfvEaYEXdLBqJ2nKGXxtkoT9I8CK6dl9Xak
        NcjKpd9D1XCvY1ZMs4XLKeBikLMvyS0kImERwTBY1/gtj03dEwuB8W8tNmHIvPfZ
        Gskl+PdCJiiBYYm9xyF8+2epbMGpwWT4cBEfdju+O+bLSXazgbsre0LfgehX/RKB
        TDVQcnsPx9QAGFPREvgR1gTyf4aDGBiKqFLBh9LIlqKgYX3spEaUg06vkpwTZvFy
        E8NbT9fRrVC8jtfOdkETRYRalhFYA==
X-ME-Sender: <xms:VMjpXte9yj0hV3MJ_Y7FkPnNFJp9U8AtFTtX461sh6OrWuH5q11XOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudejuddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuhffvfffkjghffgggtgfgsehtjedttddtreejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epvddvvdfgleefhfelgfekvdejjefhvdetfeevueeggeefhfdujeegveejveejgfdunecu
    kfhppeehkedrjedrudelgedrkeejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
    hmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:VMjpXrMaDDIEeBbq1DD3ntEo3Q9aU8N9Ekl6FDshmtp_5SEb9Ch0KA>
    <xmx:VMjpXmiIiP0hKa7-EPZe1eRqqgCQYfcDimoC_wy9dNC_9UCSt2AJGw>
    <xmx:VMjpXm_wctLsiy0DYVXA16Bb8zWJDyISQxCG1OS7IZUk73Ff6fBWFw>
    <xmx:VMjpXnWmOYUozuU1Ly2HFN1cnHoms62SEwZFie2NsoKLTSC3fIdRhg>
Received: from mickey.themaw.net (58-7-194-87.dyn.iinet.net.au [58.7.194.87])
        by mail.messagingengine.com (Postfix) with ESMTPA id E37A93280060;
        Wed, 17 Jun 2020 03:37:55 -0400 (EDT)
Received: from mickey.themaw.net (localhost [127.0.0.1])
        by mickey.themaw.net (Postfix) with ESMTP id 5D080A0314;
        Wed, 17 Jun 2020 15:37:53 +0800 (AWST)
Subject: [PATCH v2 2/6] kernfs: move revalidate to be near lookup
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 17 Jun 2020 15:37:53 +0800
Message-ID: <159237947334.89469.11409230524327917644.stgit@mickey.themaw.net>
In-Reply-To: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
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


