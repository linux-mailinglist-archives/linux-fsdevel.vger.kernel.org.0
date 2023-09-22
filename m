Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226FB7AA78C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 06:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjIVEMt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 00:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjIVEMr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:12:47 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5E5F1;
        Thu, 21 Sep 2023 21:12:41 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9C9EE5C0220;
        Fri, 22 Sep 2023 00:12:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 22 Sep 2023 00:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1695355960; x=
        1695442360; bh=TEE4wPYbAGeMVO1QHy+prEbJ3Oufz9n/qsrCMLuDzgw=; b=c
        gl5DbRL6MzFd65XO5QYfnFPKUxVhYJneFCKqnKkbCgy+oufi7CNdBNDWhDVuTWzK
        GH/1Kvhsm3B/4QLd6bSiaabSvfTmi4b61m5/hJ+HNbRJ20sXka1A18qdHF5ivcIB
        SwzYtWjvwC2NkX5+DS0iErFVV4/Ylu33AqlOJPCUaQEH7r7T8iDCU3hAccc6xnhi
        72I2PvOYtIqIJ3Gy2Mm2bt3IlE8C9zJjTr1X3LcpDktBSmze2cJLgwUJ7pDTsG4F
        /DK42b6UNeDH10nD+bp5wpTd+wXDE0YLPxuzYIzcOjgcWXOCqj4qeP7Pb1mKhgrf
        9L0Uv+WmbxxTgKCXNBvfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1695355960; x=
        1695442360; bh=TEE4wPYbAGeMVO1QHy+prEbJ3Oufz9n/qsrCMLuDzgw=; b=W
        O4KsBNGZS2HbK4nP/Kd1PJJiTM36U4rwr9q+u1unOLCrSqsrBvEnEIwsnt7M8InY
        vk5IY0trPh/D9iatU62R4yaG5a87ywiDUhHTbOK3VjzEl6DT2XexvGgm3tVQYymC
        VsAfwTog55ymgMcftYI24tfCMrG2tYqP48Zv4GHF/PsKUXudSv8BmV0Vt3JroAzx
        idb7HIUbbCaDUbrpxRITnHMhPPAquTW7NNX384HKtEl5zRs/09/1RTQbh/2KVylL
        DlRBZ4PDdY89AzuUWS1ZgN3FNNbioiX4ClVEQQjwMR5+pIOHdpvVpQ8Jw0qX+YlB
        x4UAnB+bC+Vp/IF/cezfw==
X-ME-Sender: <xms:OBQNZT1J9lJV2RakVtugfMd2y44vAuPNQWVSBDwbKGVdP76W-Vph1w>
    <xme:OBQNZSEZ3EqwjjPvrvQbV0OeLRWtZP7OX3W3842i5I07n_8RI5t8_2ocgBXefcy5L
    KSLlG4E9XAH>
X-ME-Received: <xmr:OBQNZT6xFl55kLumt_6uW7zinVdRoRM2JM65UJwUWk5ezsP3N9LbwhBjn_qeICZMU3a_mm8JqiUeIPw4dLot3I2rpn5bJ5zEkH-Zl7u0wocl_qmta307JQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekjedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duleegueffgfehudeufedtffeiudfghfejgeehvdffgefgjeetvdfffeeihfdvveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:OBQNZY2X8uCh86h_mTDoeTIKFB7gqF4PiRaQhIR1hRgDOT2_WzeUqA>
    <xmx:OBQNZWH5svN9vZNOYRQP7PFmH1F8Zz8YCaSeImH9B33re-7ECAaZhA>
    <xmx:OBQNZZ_wkxPZ0Mhdq4x_27_65wYpIG2caabSqH_NLOCDFyz9T9IcTg>
    <xmx:OBQNZb53LLiWfYbUsoUmPFcVECggpY8-SdpQpE_du-2MUU0KG5bG3A>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Sep 2023 00:12:36 -0400 (EDT)
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
Subject: [PATCH 2/8] autofs: add autofs_parse_fd()
Date:   Fri, 22 Sep 2023 12:12:09 +0800
Message-ID: <20230922041215.13675-3-raven@themaw.net>
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

Factor out the fd mount option handling.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/inode.c | 48 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 2b49662ed237..e279e275b0a5 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -129,6 +129,33 @@ static const match_table_t tokens = {
 	{Opt_err, NULL}
 };
 
+static int autofs_parse_fd(struct autofs_sb_info *sbi, int fd)
+{
+	struct file *pipe;
+	int ret;
+
+	pipe = fget(fd);
+	if (!pipe) {
+		pr_err("could not open pipe file descriptor\n");
+		return -EBADF;
+	}
+
+	ret = autofs_check_pipe(pipe);
+	if (ret < 0) {
+		pr_err("Invalid/unusable pipe\n");
+		fput(pipe);
+		return -EBADF;
+	}
+
+	if (sbi->pipe)
+		fput(sbi->pipe);
+
+	sbi->pipefd = fd;
+	sbi->pipe = pipe;
+
+	return 0;
+}
+
 static int parse_options(char *options,
 			 struct inode *root, int *pgrp, bool *pgrp_set,
 			 struct autofs_sb_info *sbi)
@@ -139,6 +166,7 @@ static int parse_options(char *options,
 	int pipefd = -1;
 	kuid_t uid;
 	kgid_t gid;
+	int ret;
 
 	root->i_uid = current_uid();
 	root->i_gid = current_gid();
@@ -162,7 +190,9 @@ static int parse_options(char *options,
 		case Opt_fd:
 			if (match_int(args, &pipefd))
 				return 1;
-			sbi->pipefd = pipefd;
+			ret = autofs_parse_fd(sbi, pipefd);
+			if (ret)
+				return 1;
 			break;
 		case Opt_uid:
 			if (match_int(args, &option))
@@ -222,7 +252,6 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 {
 	struct inode *root_inode;
 	struct dentry *root;
-	struct file *pipe;
 	struct autofs_sb_info *sbi;
 	struct autofs_info *ino;
 	int pgrp = 0;
@@ -275,7 +304,6 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 		ret = -ENOMEM;
 		goto fail_ino;
 	}
-	pipe = NULL;
 
 	root->d_fsdata = ino;
 
@@ -321,16 +349,7 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 
 	pr_debug("pipe fd = %d, pgrp = %u\n",
 		 sbi->pipefd, pid_nr(sbi->oz_pgrp));
-	pipe = fget(sbi->pipefd);
 
-	if (!pipe) {
-		pr_err("could not open pipe file descriptor\n");
-		goto fail_put_pid;
-	}
-	ret = autofs_prepare_pipe(pipe);
-	if (ret < 0)
-		goto fail_fput;
-	sbi->pipe = pipe;
 	sbi->flags &= ~AUTOFS_SBI_CATATONIC;
 
 	/*
@@ -342,11 +361,6 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 	/*
 	 * Failure ... clean up.
 	 */
-fail_fput:
-	pr_err("pipe file descriptor does not contain proper ops\n");
-	fput(pipe);
-fail_put_pid:
-	put_pid(sbi->oz_pgrp);
 fail_dput:
 	dput(root);
 	goto fail_free;
-- 
2.41.0

