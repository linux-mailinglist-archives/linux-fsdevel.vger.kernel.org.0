Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C557AA794
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 06:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjIVENc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 00:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjIVENG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:13:06 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CA2100;
        Thu, 21 Sep 2023 21:12:54 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 979565C0232;
        Fri, 22 Sep 2023 00:12:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 22 Sep 2023 00:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1695355973; x=
        1695442373; bh=F3KK0azHrvJ3S4DAAH+Vjr5j2tc3bC5JP4rnLJ/SSuQ=; b=H
        81IOwlmkYtrJv8vDJiJPq3FUWLzvvHTxbiNPTDq0W7MLhClHzD0FDTF97QQ/hEa6
        t6oMaretIz/pM5ahS1WPK6VzGXSnDaAd5qWKzvbxAUDqMGo9/abhpfkk8DGha1Vn
        zxQOY9wjBTWqt0ADZ2aXskleKXZkFaHHKRQb/zMvSstd1GFpskOjHQA786wCw3VE
        4p0B+0tYXcYZF69lni/XJgfRMAFnSYkMpXAu69uxz3Do1G0jZp2AjV8hDfWKQ7fn
        D/DYYA06n/kasIUl/tkaY/xgdqWs5RuVEiNbs6/Sgz9V/gdAhq42UV17PZ5eGcZ2
        WIdgwLiX5eW8NmkWlyG+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1695355973; x=
        1695442373; bh=F3KK0azHrvJ3S4DAAH+Vjr5j2tc3bC5JP4rnLJ/SSuQ=; b=Q
        B6lMBWAVWbjSzSoaiiNPaalZYj62ulHn2Gxy2ayy0kW2PC1HKCEWiEXSYpl14UwQ
        hi+UChcd8IwnANXXsdUzYjnwyQv9iO/iAsgg2jDnxbLTzzja+n34VqPK3MNw1z5w
        5mhkiAhiwL/UneFstCgPUH9hs86mh8F55ycx1ZAi2IEr8cAy1o0k2GugWSEOFO5I
        QmjRXGazQifIWXCGvu9S+S35PoFi1uStX8ATCEsX0DYcOnj0k+BS7xXcI0thN3LG
        avN1oowNGbdzTEuKGUnX9xXbJaztzBkwT2XLBoFboUfSjiejLgxKOzyMa5t5j4AV
        hDH0vhsA85vakhjTEzX3Q==
X-ME-Sender: <xms:RRQNZZjVR8V87-fqJXBN5H7Wg-oRMS0QudBJAgm1Ur06kjtTJtbPGw>
    <xme:RRQNZeCdkomiz9hZlfu_9-tZ1NBbTsEjkt8kCF8JGZVTDNrcTRz6Xu6pNRsuGzPnN
    DJaizqROVSN>
X-ME-Received: <xmr:RRQNZZHQJA-wnbNf-HtErWcT_EB5z8-iN85p8hZIztsxzRRhO22SgOKX1BrWAd7tG5y3FXR26nLwDAYOPu2MVwP_omdPcFAM8AZYciB9nZ9zz7tID_s0yA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekjedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duleegueffgfehudeufedtffeiudfghfejgeehvdffgefgjeetvdfffeeihfdvveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:RRQNZeR_ns5t_xLlQ5uvfpIen5O3-z3uvUEVKuks88D15_LYB-Lj5w>
    <xmx:RRQNZWwQ1zr1ohc7AM4ixctRbd6488RVnn4gv3sfACiEAkQwcEIy_Q>
    <xmx:RRQNZU6iyZK9dwky98ZzEnf-e8d5Dn5D1xj4yKKKHmOrPMDyhN7v9Q>
    <xmx:RRQNZdnQNRs_OOhKnNCxzKuUI9e64Hg1NaY-vZ3yKEXVOeDN20fCUg>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Sep 2023 00:12:49 -0400 (EDT)
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
Subject: [PATCH 5/8] autofs: refactor parse_options()
Date:   Fri, 22 Sep 2023 12:12:12 +0800
Message-ID: <20230922041215.13675-6-raven@themaw.net>
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

Seperate out parts of parse_options() that will match better the
individual option processing used in the mount API to further simplify
the upcoming conversion.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/inode.c | 136 ++++++++++++++++++++++++----------------------
 1 file changed, 72 insertions(+), 64 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index d2b333c0682a..5e061ce3ab8d 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -167,18 +167,84 @@ static int autofs_parse_fd(struct autofs_sb_info *sbi, int fd)
 	return 0;
 }
 
-static int parse_options(char *options,
-			 struct inode *root, int *pgrp, bool *pgrp_set,
-			 struct autofs_sb_info *sbi)
+static int autofs_parse_param(char *optstr, struct inode *root,
+			      int *pgrp, bool *pgrp_set,
+			      struct autofs_sb_info *sbi)
 {
-	char *p;
 	substring_t args[MAX_OPT_ARGS];
 	int option;
 	int pipefd = -1;
 	kuid_t uid;
 	kgid_t gid;
+	int token;
 	int ret;
 
+	token = match_token(optstr, tokens, args);
+	switch (token) {
+	case Opt_fd:
+		if (match_int(args, &pipefd))
+			return 1;
+		ret = autofs_parse_fd(sbi, pipefd);
+		if (ret)
+			return 1;
+		break;
+	case Opt_uid:
+		if (match_int(args, &option))
+			return 1;
+		uid = make_kuid(current_user_ns(), option);
+		if (!uid_valid(uid))
+			return 1;
+		root->i_uid = uid;
+		break;
+	case Opt_gid:
+		if (match_int(args, &option))
+			return 1;
+		gid = make_kgid(current_user_ns(), option);
+		if (!gid_valid(gid))
+			return 1;
+		root->i_gid = gid;
+		break;
+	case Opt_pgrp:
+		if (match_int(args, &option))
+			return 1;
+		*pgrp = option;
+		*pgrp_set = true;
+		break;
+	case Opt_minproto:
+		if (match_int(args, &option))
+			return 1;
+		sbi->min_proto = option;
+		break;
+	case Opt_maxproto:
+		if (match_int(args, &option))
+			return 1;
+		sbi->max_proto = option;
+		break;
+	case Opt_indirect:
+		set_autofs_type_indirect(&sbi->type);
+		break;
+	case Opt_direct:
+		set_autofs_type_direct(&sbi->type);
+		break;
+	case Opt_offset:
+		set_autofs_type_offset(&sbi->type);
+		break;
+	case Opt_strictexpire:
+		sbi->flags |= AUTOFS_SBI_STRICTEXPIRE;
+		break;
+	case Opt_ignore:
+		sbi->flags |= AUTOFS_SBI_IGNORE;
+	}
+
+	return 0;
+}
+
+static int parse_options(char *options,
+			 struct inode *root, int *pgrp, bool *pgrp_set,
+			 struct autofs_sb_info *sbi)
+{
+	char *p;
+
 	root->i_uid = current_uid();
 	root->i_gid = current_gid();
 
@@ -186,71 +252,13 @@ static int parse_options(char *options,
 		return 1;
 
 	while ((p = strsep(&options, ",")) != NULL) {
-		int token;
-
 		if (!*p)
 			continue;
 
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_fd:
-			if (match_int(args, &pipefd))
-				return 1;
-			ret = autofs_parse_fd(sbi, pipefd);
-			if (ret)
-				return 1;
-			break;
-		case Opt_uid:
-			if (match_int(args, &option))
-				return 1;
-			uid = make_kuid(current_user_ns(), option);
-			if (!uid_valid(uid))
-				return 1;
-			root->i_uid = uid;
-			break;
-		case Opt_gid:
-			if (match_int(args, &option))
-				return 1;
-			gid = make_kgid(current_user_ns(), option);
-			if (!gid_valid(gid))
-				return 1;
-			root->i_gid = gid;
-			break;
-		case Opt_pgrp:
-			if (match_int(args, &option))
-				return 1;
-			*pgrp = option;
-			*pgrp_set = true;
-			break;
-		case Opt_minproto:
-			if (match_int(args, &option))
-				return 1;
-			sbi->min_proto = option;
-			break;
-		case Opt_maxproto:
-			if (match_int(args, &option))
-				return 1;
-			sbi->max_proto = option;
-			break;
-		case Opt_indirect:
-			set_autofs_type_indirect(&sbi->type);
-			break;
-		case Opt_direct:
-			set_autofs_type_direct(&sbi->type);
-			break;
-		case Opt_offset:
-			set_autofs_type_offset(&sbi->type);
-			break;
-		case Opt_strictexpire:
-			sbi->flags |= AUTOFS_SBI_STRICTEXPIRE;
-			break;
-		case Opt_ignore:
-			sbi->flags |= AUTOFS_SBI_IGNORE;
-			break;
-		default:
+		if (autofs_parse_param(p, root, pgrp, pgrp_set, sbi))
 			return 1;
-		}
 	}
+
 	return (sbi->pipefd < 0);
 }
 
-- 
2.41.0

