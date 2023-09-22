Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D467AA7A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 06:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjIVEN4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 00:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjIVENb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:13:31 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117AA1B6;
        Thu, 21 Sep 2023 21:13:03 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 772025C023C;
        Fri, 22 Sep 2023 00:13:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 22 Sep 2023 00:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1695355982; x=
        1695442382; bh=z60NMvoJr4KjeXqAhchaD4oFMo/nesmqYn0ND9WNzEI=; b=T
        VH6kS1UQ3Ztz6Vkf80AUUNO4hIUh1SdEm6iDT9iKv+3fMMarCtzey+btHFSDlaTF
        f4gBY9tHBxWxOfuu+916Mr1GOHnI7O5lGWOuoXqfpGsWALl6jsyvlaTcdkOylu/H
        94mdwodhBLvjXaYPRsjJBQAGaDyV6TIeIRj67rWiJTwETeJ+WVrJ8c3AlWCCwkTB
        YZeaPa2k3wTGzzb+xoYPwnLFwOy8QUNIIOI7v0SY5yoSvDecMnrs30m87XYxnPlK
        rg77BDkjYqZhiUFovFKOxeOEesUsUAyeNqH+oDsb+rkV3IkKaenUr3of3yL7XwPK
        3xCCQgN3PW1hLDch1NIdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1695355982; x=
        1695442382; bh=z60NMvoJr4KjeXqAhchaD4oFMo/nesmqYn0ND9WNzEI=; b=S
        Mwt/K+2KucqeUvKxCmkh0NaGdp/Oug+YJwMOfG9UIk0U5TptNPmYBrwrdARRhODJ
        /0HDFqu1Kx/tS7X7KyRdvs106sqWVP3GhVBGlX4Fdaf6w/jM2CCA8zACFvDy1sXo
        /gHDHt0DVUYOZ2O80DonHILedefEvwQAYU93OhvDS43/UZ0xtPsHsCchPiJAQXhF
        auSXhvLLmfulxNfldoHFmi1NGHOLAOgqBtltyJNJ7QsMzz1Nm3zQ6bifiOUclK/K
        4hyNqKSlvhRJnCs8eBQ8UN2S3RzNAG5cWQ9gA9rh74jCNBpOkLs+hj8MnmUidCTq
        uXnLjLD6FuoGsUBHD3E+Q==
X-ME-Sender: <xms:ThQNZatsO7DuylHi32GLCQlBIW0RUT3I4GBqYdeaiKV9N4oIEywdAA>
    <xme:ThQNZfcCiSzOux8dA4NChT_fYEV-7c0brOehcyLpb_O0N68doRYm-AY3ffFTXVF4K
    powJZOimSAf>
X-ME-Received: <xmr:ThQNZVyFFPSyXpUedDe__SATEAloanAwjyt0RHbYKen8kSvJfCZhatJLF8-d-oIjwVOxijtpQ12gvGL8wGguUHtM6MuHD3a_ek-nKYWPa1rwiRQVX6nMmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekjedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duleegueffgfehudeufedtffeiudfghfejgeehvdffgefgjeetvdfffeeihfdvveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:ThQNZVPcQFr8GzHix8IaNEE13OByz-j7K_K6GV1mPWmr8Xj0Tm4g6Q>
    <xmx:ThQNZa8lWAaDgFZry8vJxIkkwIjXvKHh_IrcZfEs8Vj4ZeikOxxXpw>
    <xmx:ThQNZdXhneUYgEEMZFAWTboR-nkd_5VNwQzNVWQkR3LP5IhccQJ1FQ>
    <xmx:ThQNZaxS2T7of3O1KZ0SXGyvvsXK9fx0Fr4v68k7fYJ1oDzCTwnx3Q>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Sep 2023 00:12:58 -0400 (EDT)
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
Subject: [PATCH 7/8] autofs: convert autofs to use the new mount api
Date:   Fri, 22 Sep 2023 12:12:14 +0800
Message-ID: <20230922041215.13675-8-raven@themaw.net>
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

Convert the autofs filesystem to use the mount API.

The conversion patch was originally written by David Howells.
I have taken that patch and broken it into several patches in an effort
to make the change easier to review.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/autofs_i.h |   5 +-
 fs/autofs/init.c     |   9 +-
 fs/autofs/inode.c    | 247 ++++++++++++++++++++++++-------------------
 3 files changed, 142 insertions(+), 119 deletions(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index c24d32be7937..244f18cdf23c 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -25,6 +25,8 @@
 #include <linux/completion.h>
 #include <linux/file.h>
 #include <linux/magic.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 
 /* This is the range of ioctl() numbers we claim as ours */
 #define AUTOFS_IOC_FIRST     AUTOFS_IOC_READY
@@ -205,7 +207,8 @@ static inline void managed_dentry_clear_managed(struct dentry *dentry)
 
 /* Initializing function */
 
-int autofs_fill_super(struct super_block *, void *, int);
+extern const struct fs_parameter_spec autofs_param_specs[];
+int autofs_init_fs_context(struct fs_context *fc);
 struct autofs_info *autofs_new_ino(struct autofs_sb_info *);
 void autofs_clean_ino(struct autofs_info *);
 
diff --git a/fs/autofs/init.c b/fs/autofs/init.c
index d3f55e874338..b5e4dfa04ed0 100644
--- a/fs/autofs/init.c
+++ b/fs/autofs/init.c
@@ -7,16 +7,11 @@
 #include <linux/init.h>
 #include "autofs_i.h"
 
-static struct dentry *autofs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
-{
-	return mount_nodev(fs_type, flags, data, autofs_fill_super);
-}
-
 struct file_system_type autofs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "autofs",
-	.mount		= autofs_mount,
+	.init_fs_context = autofs_init_fs_context,
+	.parameters	= autofs_param_specs,
 	.kill_sb	= autofs_kill_sb,
 };
 MODULE_ALIAS_FS("autofs");
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index e2026e063d8c..3f2dfed428f9 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -6,7 +6,6 @@
 
 #include <linux/seq_file.h>
 #include <linux/pagemap.h>
-#include <linux/parser.h>
 
 #include "autofs_i.h"
 
@@ -111,7 +110,6 @@ static const struct super_operations autofs_sops = {
 };
 
 enum {
-	Opt_err,
 	Opt_direct,
 	Opt_fd,
 	Opt_gid,
@@ -125,35 +123,48 @@ enum {
 	Opt_uid,
 };
 
-static const match_table_t tokens = {
-	{Opt_fd, "fd=%u"},
-	{Opt_uid, "uid=%u"},
-	{Opt_gid, "gid=%u"},
-	{Opt_pgrp, "pgrp=%u"},
-	{Opt_minproto, "minproto=%u"},
-	{Opt_maxproto, "maxproto=%u"},
-	{Opt_indirect, "indirect"},
-	{Opt_direct, "direct"},
-	{Opt_offset, "offset"},
-	{Opt_strictexpire, "strictexpire"},
-	{Opt_ignore, "ignore"},
-	{Opt_err, NULL}
+const struct fs_parameter_spec autofs_param_specs[] = {
+	fsparam_flag	("direct",		Opt_direct),
+	fsparam_fd	("fd",			Opt_fd),
+	fsparam_u32	("gid",			Opt_gid),
+	fsparam_flag	("ignore",		Opt_ignore),
+	fsparam_flag	("indirect",		Opt_indirect),
+	fsparam_u32	("maxproto",		Opt_maxproto),
+	fsparam_u32	("minproto",		Opt_minproto),
+	fsparam_flag	("offset",		Opt_offset),
+	fsparam_u32	("pgrp",		Opt_pgrp),
+	fsparam_flag	("strictexpire",	Opt_strictexpire),
+	fsparam_u32	("uid",			Opt_uid),
+	{}
 };
 
-static int autofs_parse_fd(struct autofs_sb_info *sbi, int fd)
+struct autofs_fs_context {
+	kuid_t	uid;
+	kgid_t	gid;
+	int	pgrp;
+	bool	pgrp_set;
+};
+
+/*
+ * Open the fd.  We do it here rather than in get_tree so that it's done in the
+ * context of the system call that passed the data and not the one that
+ * triggered the superblock creation, lest the fd gets reassigned.
+ */
+static int autofs_parse_fd(struct fs_context *fc, int fd)
 {
+	struct autofs_sb_info *sbi = fc->s_fs_info;
 	struct file *pipe;
 	int ret;
 
 	pipe = fget(fd);
 	if (!pipe) {
-		pr_err("could not open pipe file descriptor\n");
+		errorf(fc, "could not open pipe file descriptor");
 		return -EBADF;
 	}
 
 	ret = autofs_check_pipe(pipe);
 	if (ret < 0) {
-		pr_err("Invalid/unusable pipe\n");
+		errorf(fc, "Invalid/unusable pipe");
 		fput(pipe);
 		return -EBADF;
 	}
@@ -167,58 +178,43 @@ static int autofs_parse_fd(struct autofs_sb_info *sbi, int fd)
 	return 0;
 }
 
-static int autofs_parse_param(char *optstr, struct inode *root,
-			      int *pgrp, bool *pgrp_set,
-			      struct autofs_sb_info *sbi)
+static int autofs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	substring_t args[MAX_OPT_ARGS];
-	int option;
-	int pipefd = -1;
+	struct autofs_fs_context *ctx = fc->fs_private;
+	struct autofs_sb_info *sbi = fc->s_fs_info;
+	struct fs_parse_result result;
 	kuid_t uid;
 	kgid_t gid;
-	int token;
-	int ret;
+	int opt;
 
-	token = match_token(optstr, tokens, args);
-	switch (token) {
+	opt = fs_parse(fc, autofs_param_specs, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
 	case Opt_fd:
-		if (match_int(args, &pipefd))
-			return 1;
-		ret = autofs_parse_fd(sbi, pipefd);
-		if (ret)
-			return 1;
-		break;
+		return autofs_parse_fd(fc, result.int_32);
 	case Opt_uid:
-		if (match_int(args, &option))
-			return 1;
-		uid = make_kuid(current_user_ns(), option);
+		uid = make_kuid(current_user_ns(), result.uint_32);
 		if (!uid_valid(uid))
 			return 1;
-		root->i_uid = uid;
+		ctx->uid = uid;
 		break;
 	case Opt_gid:
-		if (match_int(args, &option))
-			return 1;
-		gid = make_kgid(current_user_ns(), option);
+		gid = make_kgid(current_user_ns(), result.uint_32);
 		if (!gid_valid(gid))
 			return 1;
-		root->i_gid = gid;
+		ctx->gid = gid;
 		break;
 	case Opt_pgrp:
-		if (match_int(args, &option))
-			return 1;
-		*pgrp = option;
-		*pgrp_set = true;
+		ctx->pgrp = result.uint_32;
+		ctx->pgrp_set = true;
 		break;
 	case Opt_minproto:
-		if (match_int(args, &option))
-			return 1;
-		sbi->min_proto = option;
+		sbi->min_proto = result.uint_32;
 		break;
 	case Opt_maxproto:
-		if (match_int(args, &option))
-			return 1;
-		sbi->max_proto = option;
+		sbi->max_proto = result.uint_32;
 		break;
 	case Opt_indirect:
 		set_autofs_type_indirect(&sbi->type);
@@ -239,29 +235,6 @@ static int autofs_parse_param(char *optstr, struct inode *root,
 	return 0;
 }
 
-static int parse_options(char *options,
-			 struct inode *root, int *pgrp, bool *pgrp_set,
-			 struct autofs_sb_info *sbi)
-{
-	char *p;
-
-	root->i_uid = current_uid();
-	root->i_gid = current_gid();
-
-	if (!options)
-		return 1;
-
-	while ((p = strsep(&options, ",")) != NULL) {
-		if (!*p)
-			continue;
-
-		if (autofs_parse_param(p, root, pgrp, pgrp_set, sbi))
-			return 1;
-	}
-
-	return (sbi->pipefd < 0);
-}
-
 static struct autofs_sb_info *autofs_alloc_sbi(void)
 {
 	struct autofs_sb_info *sbi;
@@ -287,12 +260,14 @@ static struct autofs_sb_info *autofs_alloc_sbi(void)
 	return sbi;
 }
 
-static int autofs_validate_protocol(struct autofs_sb_info *sbi)
+static int autofs_validate_protocol(struct fs_context *fc)
 {
+	struct autofs_sb_info *sbi = fc->s_fs_info;
+
 	/* Test versions first */
 	if (sbi->max_proto < AUTOFS_MIN_PROTO_VERSION ||
 	    sbi->min_proto > AUTOFS_MAX_PROTO_VERSION) {
-		pr_err("kernel does not match daemon version "
+		errorf(fc, "kernel does not match daemon version "
 		       "daemon (%d, %d) kernel (%d, %d)\n",
 		       sbi->min_proto, sbi->max_proto,
 		       AUTOFS_MIN_PROTO_VERSION, AUTOFS_MAX_PROTO_VERSION);
@@ -309,24 +284,18 @@ static int autofs_validate_protocol(struct autofs_sb_info *sbi)
 	return 0;
 }
 
-int autofs_fill_super(struct super_block *s, void *data, int silent)
+static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
 {
+	struct autofs_fs_context *ctx = fc->fs_private;
+	struct autofs_sb_info *sbi = s->s_fs_info;
 	struct inode *root_inode;
 	struct dentry *root;
-	struct autofs_sb_info *sbi;
 	struct autofs_info *ino;
-	int pgrp = 0;
-	bool pgrp_set = false;
-	int ret = -EINVAL;
-
-	sbi = autofs_alloc_sbi();
-	if (!sbi)
-		return -ENOMEM;
+	int ret = -ENOMEM;
 
 	pr_debug("starting up, sbi = %p\n", sbi);
 
 	sbi->sb = s;
-	s->s_fs_info = sbi;
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
 	s->s_magic = AUTOFS_SUPER_MAGIC;
@@ -338,33 +307,24 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 	 * Get the root inode and dentry, but defer checking for errors.
 	 */
 	ino = autofs_new_ino(sbi);
-	if (!ino) {
-		ret = -ENOMEM;
-		goto fail_free;
-	}
+	if (!ino)
+		goto fail;
+
 	root_inode = autofs_get_inode(s, S_IFDIR | 0755);
+	root_inode->i_uid = ctx->uid;
+	root_inode->i_gid = ctx->gid;
+
 	root = d_make_root(root_inode);
-	if (!root) {
-		ret = -ENOMEM;
+	if (!root)
 		goto fail_ino;
-	}
 
 	root->d_fsdata = ino;
 
-	/* Can this call block? */
-	if (parse_options(data, root_inode, &pgrp, &pgrp_set, sbi)) {
-		pr_err("called with bogus options\n");
-		goto fail_dput;
-	}
-
-	if (autofs_validate_protocol(sbi))
-		goto fail_dput;
-
-	if (pgrp_set) {
-		sbi->oz_pgrp = find_get_pid(pgrp);
+	if (ctx->pgrp_set) {
+		sbi->oz_pgrp = find_get_pid(ctx->pgrp);
 		if (!sbi->oz_pgrp) {
-			pr_err("could not find process group %d\n",
-				pgrp);
+			ret = invalf(fc, "Could not find process group %d",
+				     ctx->pgrp);
 			goto fail_dput;
 		}
 	} else {
@@ -393,15 +353,80 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 	 */
 fail_dput:
 	dput(root);
-	goto fail_free;
+	goto fail;
 fail_ino:
 	autofs_free_ino(ino);
-fail_free:
-	kfree(sbi);
-	s->s_fs_info = NULL;
+fail:
 	return ret;
 }
 
+/*
+ * Validate the parameters and then request a superblock.
+ */
+static int autofs_get_tree(struct fs_context *fc)
+{
+	struct autofs_sb_info *sbi = fc->s_fs_info;
+	int ret;
+
+	ret = autofs_validate_protocol(fc);
+	if (ret)
+		return ret;
+
+	if (sbi->pipefd < 0)
+		return invalf(fc, "No control pipe specified");
+
+	return get_tree_nodev(fc, autofs_fill_super);
+}
+
+static void autofs_free_fc(struct fs_context *fc)
+{
+	struct autofs_fs_context *ctx = fc->fs_private;
+	struct autofs_sb_info *sbi = fc->s_fs_info;
+
+	if (sbi) {
+		if (sbi->pipe)
+			fput(sbi->pipe);
+		kfree(sbi);
+	}
+	kfree(ctx);
+}
+
+static const struct fs_context_operations autofs_context_ops = {
+	.free		= autofs_free_fc,
+	.parse_param	= autofs_parse_param,
+	.get_tree	= autofs_get_tree,
+};
+
+/*
+ * Set up the filesystem mount context.
+ */
+int autofs_init_fs_context(struct fs_context *fc)
+{
+	struct autofs_fs_context *ctx;
+	struct autofs_sb_info *sbi;
+
+	ctx = kzalloc(sizeof(struct autofs_fs_context), GFP_KERNEL);
+	if (!ctx)
+		goto nomem;
+
+	ctx->uid = current_uid();
+	ctx->gid = current_gid();
+
+	sbi = autofs_alloc_sbi();
+	if (!sbi)
+		goto nomem_ctx;
+
+	fc->fs_private = ctx;
+	fc->s_fs_info = sbi;
+	fc->ops = &autofs_context_ops;
+	return 0;
+
+nomem_ctx:
+	kfree(ctx);
+nomem:
+	return -ENOMEM;
+}
+
 struct inode *autofs_get_inode(struct super_block *sb, umode_t mode)
 {
 	struct inode *inode = new_inode(sb);
-- 
2.41.0

