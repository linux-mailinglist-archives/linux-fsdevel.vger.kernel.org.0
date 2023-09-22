Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB52B7AA797
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 06:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjIVENp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 00:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjIVENX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:13:23 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BA41A3;
        Thu, 21 Sep 2023 21:12:58 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 061345C0222;
        Fri, 22 Sep 2023 00:12:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 22 Sep 2023 00:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1695355978; x=
        1695442378; bh=1rBf/tENa8Po/M99DgSqwjUd7A6nMFydxVLGoW1DBxw=; b=m
        Zr0GwKdhkpe1LLNAYPe/pVq2UTvLZ0nFT4U5r4Rkk8bcpkT3T+aYfSEnMrk008uQ
        PLanhuWeVexXiwIzYYEpL9mQk0alBM6Y38DxJyGeisbJVsWYdA4FNqAQ9SqdM3Rb
        BDXnL6abA37CcV0xLnUnNZI3vcYV4pmvzWnBvGOwcyi5qKlh5whKhRMYZEGUMMXI
        TEz/cwbwvwN4gFvE1RLYR2j2vO5McwXkhifYpqJIm70+jgnKoecpNe2gIuCSCxnt
        xjhgM3yZ0cPJHvAQzzuzh/zgsevzGLuJcwSpVzBtDHrOFABM+yXKsMgMTukVubjQ
        dh3u6ZyF2FuShML9Ns2lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1695355978; x=
        1695442378; bh=1rBf/tENa8Po/M99DgSqwjUd7A6nMFydxVLGoW1DBxw=; b=L
        Cj7AFu6VB8QYslobSLTvwCkrvIZn6n4zN60yexHUeBwRJcTn/Cf2hU/9M/k2/heD
        iw3mM/gsCFV8R+N85xcR47mbtU4lwe38WyDcyCLIdLnH/UVzh3w58Kuvs4EDAPAh
        f9t0wM3lDIiZ7TV5sAHi++UP308NgjqknXOEbdjZfNUI0GutCRFHXcFs7oG/WzGv
        TkE1VLhnz4O/ETOD0YD02x94Nzxg+RZylN+blTowT67Z6kOkvO/RyjYqpWIlAzGb
        YtfLbfABQcLyfZlZdFLsDv9ZDQldAqh+u905kGMlHMfTFsC1Svoe3r268mO2Z0QV
        rAXZpurAlvt1zck2HuNlw==
X-ME-Sender: <xms:SRQNZcyJZl_pxdGw2g4OVBtUqFjv3dYjEXG7lu3B-5wsa6CviaH5xw>
    <xme:SRQNZQQQfPZNnhBMnj8PkZnRdAA6A6e8_7C9jHW1HhUYtktvwGy9rSgGNu65QbZwJ
    neRZmTIC1_G>
X-ME-Received: <xmr:SRQNZeXBRpyL_xiiI377s7SPD3FliDf6eTV6PKkoYVNOGpX5qFeeN-57N84C7ZcU6OG9770F9GelHIgq0J7mmIiIEw6iy8xAKyoO287cilkFMpbk3Uuyvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekjedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duleegueffgfehudeufedtffeiudfghfejgeehvdffgefgjeetvdfffeeihfdvveenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:SRQNZai4U7boCZB0IQ4ZX-DDcvqZrNBmBqTrk92qRYfWsjKJiXEF2g>
    <xmx:SRQNZeBTsADf-em1syKP4_b4ZRdqlpiaGoLA9oLsYJCWWMdKhlPfRg>
    <xmx:SRQNZbKS1cl_VC9RAVh1s02SzcJOS88lmiv8cgk72Dmr8AnGUI7USA>
    <xmx:ShQNZQ36-aHig-9jQlOxPmDec7G7UFmn_al63lIpvAZrkdaWPr3nEA>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Sep 2023 00:12:53 -0400 (EDT)
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
Subject: [PATCH 6/8] autofs: validate protocol version
Date:   Fri, 22 Sep 2023 12:12:13 +0800
Message-ID: <20230922041215.13675-7-raven@themaw.net>
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

Move the protocol parameter validation into a seperate function.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/inode.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 5e061ce3ab8d..e2026e063d8c 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -287,6 +287,28 @@ static struct autofs_sb_info *autofs_alloc_sbi(void)
 	return sbi;
 }
 
+static int autofs_validate_protocol(struct autofs_sb_info *sbi)
+{
+	/* Test versions first */
+	if (sbi->max_proto < AUTOFS_MIN_PROTO_VERSION ||
+	    sbi->min_proto > AUTOFS_MAX_PROTO_VERSION) {
+		pr_err("kernel does not match daemon version "
+		       "daemon (%d, %d) kernel (%d, %d)\n",
+		       sbi->min_proto, sbi->max_proto,
+		       AUTOFS_MIN_PROTO_VERSION, AUTOFS_MAX_PROTO_VERSION);
+		return -EINVAL;
+	}
+
+	/* Establish highest kernel protocol version */
+	if (sbi->max_proto > AUTOFS_MAX_PROTO_VERSION)
+		sbi->version = AUTOFS_MAX_PROTO_VERSION;
+	else
+		sbi->version = sbi->max_proto;
+	sbi->sub_version = AUTOFS_PROTO_SUBVERSION;
+
+	return 0;
+}
+
 int autofs_fill_super(struct super_block *s, void *data, int silent)
 {
 	struct inode *root_inode;
@@ -335,22 +357,8 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 		goto fail_dput;
 	}
 
-	/* Test versions first */
-	if (sbi->max_proto < AUTOFS_MIN_PROTO_VERSION ||
-	    sbi->min_proto > AUTOFS_MAX_PROTO_VERSION) {
-		pr_err("kernel does not match daemon version "
-		       "daemon (%d, %d) kernel (%d, %d)\n",
-		       sbi->min_proto, sbi->max_proto,
-		       AUTOFS_MIN_PROTO_VERSION, AUTOFS_MAX_PROTO_VERSION);
+	if (autofs_validate_protocol(sbi))
 		goto fail_dput;
-	}
-
-	/* Establish highest kernel protocol version */
-	if (sbi->max_proto > AUTOFS_MAX_PROTO_VERSION)
-		sbi->version = AUTOFS_MAX_PROTO_VERSION;
-	else
-		sbi->version = sbi->max_proto;
-	sbi->sub_version = AUTOFS_PROTO_SUBVERSION;
 
 	if (pgrp_set) {
 		sbi->oz_pgrp = find_get_pid(pgrp);
-- 
2.41.0

