Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAA37AA78E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 06:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjIVENE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 00:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjIVENA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:13:00 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D22F1A6;
        Thu, 21 Sep 2023 21:12:45 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0151E5C0248;
        Fri, 22 Sep 2023 00:12:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 22 Sep 2023 00:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1695355964; x=
        1695442364; bh=WbaN132An1pGGYu2OwYGx9AA8K508D+ik2jKmw/3K8c=; b=H
        zqjPsEFgQsMTX3cvZZnq+iJv81m9Iylso4uVo3DYw+7CsmpWoQeikVHmJ+MYFviM
        yNEzHomcixzheNwaOrfjI8StGrH919B3vYtn1lW+PyfWkKNguO+xSVUuFy9XnSbl
        Yumd/WneTgFjRCsG2hdWwCM6YXE5nestLNapL2kcenSpu4KHYDMSqEjj9Zjm57vw
        DeONTCe/oxjeS3w2klJybE1Isb/EMTLWzwQOtn5Bg2XfvStMixF4Sm6OyMO586zu
        n5pEuuvr3w8xJSAsk/LbMAWyzAXmr8IsmFjPHA62B3a1r0ats8X+YWYx1xCmE1fx
        1cAGsdb3HzMhD/ETVWGfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1695355964; x=
        1695442364; bh=WbaN132An1pGGYu2OwYGx9AA8K508D+ik2jKmw/3K8c=; b=j
        GUPW12fWIFz2HJTEDeSYUuNkXycA4F5WxRqNKWC7gmrWuzTTTcffEo+bqQ6YAOaf
        M/0VuiAy2/BhbnCt83LfvYeIq+w7jdx3pArHokr1CWy1Uj+/axVzNn50q/1rbu6D
        nxvqi1wCXpa8y6r1PtIGAtlpb5cloJMAtWIVHFtqt6bL9A2aTn9DTGxeVtOVpVKY
        G8LHk0Q4FU6HWm+n7jDzzKHjg3KK21D8whA0KVSHXikZ8lVc2NsBh8NdHUR+lL+c
        Ilvto5gZANoD4l06PZuJ4ouIYKbI2hNgJF8/SwVhikM8mQmyiPZAfALmuZmVq27u
        I3qwwCdWIla2gA6KtO0Fw==
X-ME-Sender: <xms:PBQNZc18ixBO9AsTwRQ34cuVdUq7QVwt64LAJDmElqKg23eQy6bxyw>
    <xme:PBQNZXFtdniq5gUW2k9gXLQlYLucO4V6s8_FOIcfnfqwkAIhjPGwc5tq9rhBPCQYf
    Dv6P8Iv7iHF>
X-ME-Received: <xmr:PBQNZU53TIrE91fnXRRZkkbtqVEXungcdj1STeaGTxtLO5GfvXLOSuknSVnCDZghb1npx_rk7hNtaArADA8jvie-1XEeBvcdUZKIkUZ_ntTU5P-QQbniDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekjedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duleegueffgfehudeufedtffeiudfghfejgeehvdffgefgjeetvdfffeeihfdvveenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:PBQNZV1Minp6puaVr86M21ozMNFRqmJzgYXLJd4NnOyZ6fJpvgwq-g>
    <xmx:PBQNZfHVfbWhcZZ7Wk3X4zufi9B59XWvDAV2Hdw8JkPDg8Bxja4BOw>
    <xmx:PBQNZe853Q1HwoV0da34qzCgane_rNV4ko8HcMhPMTAFhJb64_4GLw>
    <xmx:PBQNZU6vtWI3aNNe3PSPx_Gr7TupFiEyk37bm0nI9-Ghtd9URciHEA>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Sep 2023 00:12:40 -0400 (EDT)
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bill O'Donnell <billodo@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Ian Kent <raven@themaw.net>
Subject: [PATCH 3/8] autofs: refactor super block info init
Date:   Fri, 22 Sep 2023 12:12:10 +0800
Message-ID: <20230922041215.13675-4-raven@themaw.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922041215.13675-1-raven@themaw.net>
References: <20230922041215.13675-1-raven@themaw.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the allocation and initialisation of the super block
info struct to its own function.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/inode.c | 53 +++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index e279e275b0a5..992d6cb29707 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -171,11 +171,6 @@ static int parse_options(char *options,
 	root->i_uid = current_uid();
 	root->i_gid = current_gid();
 
-	sbi->min_proto = AUTOFS_MIN_PROTO_VERSION;
-	sbi->max_proto = AUTOFS_MAX_PROTO_VERSION;
-
-	sbi->pipefd = -1;
-
 	if (!options)
 		return 1;
 
@@ -248,41 +243,49 @@ static int parse_options(char *options,
 	return (sbi->pipefd < 0);
 }
 
-int autofs_fill_super(struct super_block *s, void *data, int silent)
+static struct autofs_sb_info *autofs_alloc_sbi(void)
 {
-	struct inode *root_inode;
-	struct dentry *root;
 	struct autofs_sb_info *sbi;
-	struct autofs_info *ino;
-	int pgrp = 0;
-	bool pgrp_set = false;
-	int ret = -EINVAL;
 
 	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
-		return -ENOMEM;
-	pr_debug("starting up, sbi = %p\n", sbi);
+		return NULL;
 
-	s->s_fs_info = sbi;
 	sbi->magic = AUTOFS_SBI_MAGIC;
-	sbi->pipefd = -1;
-	sbi->pipe = NULL;
-	sbi->exp_timeout = 0;
-	sbi->oz_pgrp = NULL;
-	sbi->sb = s;
-	sbi->version = 0;
-	sbi->sub_version = 0;
 	sbi->flags = AUTOFS_SBI_CATATONIC;
+	sbi->min_proto = AUTOFS_MIN_PROTO_VERSION;
+	sbi->max_proto = AUTOFS_MAX_PROTO_VERSION;
+	sbi->pipefd = -1;
+
 	set_autofs_type_indirect(&sbi->type);
-	sbi->min_proto = 0;
-	sbi->max_proto = 0;
 	mutex_init(&sbi->wq_mutex);
 	mutex_init(&sbi->pipe_mutex);
 	spin_lock_init(&sbi->fs_lock);
-	sbi->queues = NULL;
 	spin_lock_init(&sbi->lookup_lock);
 	INIT_LIST_HEAD(&sbi->active_list);
 	INIT_LIST_HEAD(&sbi->expiring_list);
+
+	return sbi;
+}
+
+int autofs_fill_super(struct super_block *s, void *data, int silent)
+{
+	struct inode *root_inode;
+	struct dentry *root;
+	struct autofs_sb_info *sbi;
+	struct autofs_info *ino;
+	int pgrp = 0;
+	bool pgrp_set = false;
+	int ret = -EINVAL;
+
+	sbi = autofs_alloc_sbi();
+	if (!sbi)
+		return -ENOMEM;
+
+	pr_debug("starting up, sbi = %p\n", sbi);
+
+	sbi->sb = s;
+	s->s_fs_info = sbi;
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
 	s->s_magic = AUTOFS_SUPER_MAGIC;
-- 
2.41.0

