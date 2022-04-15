Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4B25027EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 12:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352085AbiDOKFm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 06:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352069AbiDOKFk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:05:40 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B353BB083;
        Fri, 15 Apr 2022 03:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1650016990; i=@fujitsu.com;
        bh=jvyr5zTg5fIxJzLCbvkKxPjtKUEx6nOlVugEaKagNVE=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=DRWU0iSNpftPbKO6rRT1pu2zTj+HI7lybk8l3DZrhUh9pUEXfIoGLIQRnkW7xJZCl
         GgqHMosyFfjS8XawSnwKBXUX75QYpRlPNZUvUZTxcXYEAvBWmXObrx6lLz/AjiJxyL
         aVMtX0t8D94duqpYPGboMgUv4W/dBEifNZ202bOJ7JTFWPjvkXYMZqs43GCfhIxhc8
         aKVard0Yu0DOnEWWSH12mdW12vEtov6d520bkGsv5T9r5QXKAqss6m8Jq5eKLYHMJS
         EmdmGIVISlpIOwCh5+lEGSCbVYhwd1X93O8vrO3r7f5bPlMBVVPx5ZPIdk7LkkIPUY
         KEdpHA4v0Q5TA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRWlGSWpSXmKPExsViZ8MxSfeeU2S
  SweMJbBavD39itPhwcxKTxZZj9xgtLj/hs/i5bBW7xZ69J1ksLhw4zWqx688Odovzf4+zOnB6
  nFok4bFpVSebx+dNch6bnrxlCmCJYs3MS8qvSGDNeL5/IUvBSvmK0+svsTcwXpTqYuTiEBLYw
  igxvXs2I4SzgEliy9lfbF2MnEDOHkaJGeujQGw2AU2JZ50LmEFsEQEXiYUT1oM1MAtcYZS43j
  4HLCEsEC/xZdZkFhCbRUBVovnrO3YQm1fAU+L5wwYwW0JAQWLKw/dA9RwcnAJeEv/P1kLs8pS
  YOukyG0S5oMTJmU/AxjALSEgcfPGCGaJVUeJSxzdGCLtCYtasNiYIW03i6rlNzBMYBWchaZ+F
  pH0BI9MqRqukosz0jJLcxMwcXUMDA11DQ1NdY0tdUyO9xCrdRL3UUt3y1OISXSC3vFgvtbhYr
  7gyNzknRS8vtWQTIzBaUorVTXYwdq/8qXeIUZKDSUmU961oZJIQX1J+SmVGYnFGfFFpTmrxIU
  YZDg4lCd6/9kA5waLU9NSKtMwcYOTCpCU4eJREeEOtgdK8xQWJucWZ6RCpU4yKUuK8wsB4FxI
  ASWSU5sG1wZLFJUZZKWFeRgYGBiGegtSi3MwSVPlXjOIcjErCvMYgU3gy80rgpr8CWswEtPjb
  qlCQxSWJCCmpBqak6/0TbC5f7syW9dweseFfnfA0x9ypYUIi7Cc6XFbU+NiY+PwIfGzUO0+B2
  d4qu33agltp2vY73+sVn2ByYdvY1/b1+/c4lfN/Hi3uNjHr8bLc37HKn7tj4paJkW+8nSNnW1
  y7dHTtMWm9vqPqP3Vas6erC32a9WbRhkD5if+LMpO3npzlbPHvgJyhmmzZxrAJ6qEmO6Vllr6
  crNDDHPwvyUA+MjBf0yAponIjn/eU/nlh72dtONzD5xKk8YpnffiWRet+L1m1bKK7VWrXsQBX
  y4WL5Ca/13ppdeLcFv/p+yL3bFrWL1J35vjaqW0OK5bcqJtbw1Mh8uT+tMslMg0iSpIdv7cn9
  m23mCQv2qzEUpyRaKjFXFScCAAxvgIgkQMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-10.tower-565.messagelabs.com!1650016989!56017!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12386 invoked from network); 15 Apr 2022 10:03:10 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-10.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 15 Apr 2022 10:03:10 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id A919F10047A;
        Fri, 15 Apr 2022 11:03:09 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 9BC31100467;
        Fri, 15 Apr 2022 11:03:09 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 15 Apr 2022 11:02:44 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <david@fromorbit.com>, <djwong@kernel.org>, <brauner@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>,
        <linux-nfs@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <viro@zeniv.linux.org.uk>, <jlayton@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v3 4/7] nfs3: Only do posix acl setup/release operation under CONFIG_NFS_V3_ACL
Date:   Fri, 15 Apr 2022 19:02:20 +0800
Message-ID: <1650020543-24908-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1650020543-24908-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1650020543-24908-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Usually, filesystem will use a function named as fs_init_acl function that belong
to acl.c and this function is externed in acl.h by using CONFIG_FS_POSIX_ACL.

If filesystem disable this switch, we should not call nfs3_proc_setacls also not
call posix_acl_create/posix_acl_release because it is useless(We have do umask
strip in vfs).

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 fs/nfs/nfs3proc.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 1597eef40d54..55789a625d18 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -337,7 +337,9 @@ static int
 nfs3_proc_create(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 		 int flags)
 {
+#ifdef CONFIG_NFS_V3_ACL
 	struct posix_acl *default_acl, *acl;
+#endif
 	struct nfs3_createdata *data;
 	struct dentry *d_alias;
 	int status = -ENOMEM;
@@ -361,9 +363,11 @@ nfs3_proc_create(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 		data->arg.create.verifier[1] = cpu_to_be32(current->pid);
 	}
 
+#ifdef CONFIG_NFS_V3_ACL
 	status = posix_acl_create(dir, &sattr->ia_mode, &default_acl, &acl);
 	if (status)
 		goto out;
+#endif
 
 	for (;;) {
 		d_alias = nfs3_do_create(dir, dentry, data);
@@ -415,13 +419,18 @@ nfs3_proc_create(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 			goto out_dput;
 	}
 
+#ifdef CONFIG_NFS_V3_ACL
 	status = nfs3_proc_setacls(d_inode(dentry), acl, default_acl);
+#endif
 
 out_dput:
 	dput(d_alias);
+
 out_release_acls:
+#ifdef CONFIG_NFS_V3_ACL
 	posix_acl_release(acl);
 	posix_acl_release(default_acl);
+#endif
 out:
 	nfs3_free_createdata(data);
 	dprintk("NFS reply create: %d\n", status);
@@ -580,7 +589,9 @@ nfs3_proc_symlink(struct inode *dir, struct dentry *dentry, struct page *page,
 static int
 nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *sattr)
 {
+#ifdef CONFIG_NFS_V3_ACL
 	struct posix_acl *default_acl, *acl;
+#endif
 	struct nfs3_createdata *data;
 	struct dentry *d_alias;
 	int status = -ENOMEM;
@@ -591,9 +602,11 @@ nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *sattr)
 	if (data == NULL)
 		goto out;
 
+#ifdef CONFIG_NFS_V3_ACL
 	status = posix_acl_create(dir, &sattr->ia_mode, &default_acl, &acl);
 	if (status)
 		goto out;
+#endif
 
 	data->msg.rpc_proc = &nfs3_procedures[NFS3PROC_MKDIR];
 	data->arg.mkdir.fh = NFS_FH(dir);
@@ -610,12 +623,16 @@ nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *sattr)
 	if (d_alias)
 		dentry = d_alias;
 
+#ifdef CONFIG_NFS_V3_ACL
 	status = nfs3_proc_setacls(d_inode(dentry), acl, default_acl);
-
+#endif
 	dput(d_alias);
+
 out_release_acls:
+#ifdef CONFIG_NFS_V3_ACL
 	posix_acl_release(acl);
 	posix_acl_release(default_acl);
+#endif
 out:
 	nfs3_free_createdata(data);
 	dprintk("NFS reply mkdir: %d\n", status);
@@ -711,7 +728,9 @@ static int
 nfs3_proc_mknod(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 		dev_t rdev)
 {
+#ifdef CONFIG_NFS_V3_ACL
 	struct posix_acl *default_acl, *acl;
+#endif
 	struct nfs3_createdata *data;
 	struct dentry *d_alias;
 	int status = -ENOMEM;
@@ -723,9 +742,11 @@ nfs3_proc_mknod(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 	if (data == NULL)
 		goto out;
 
+#ifdef CONFIG_NFS_V3_ACL
 	status = posix_acl_create(dir, &sattr->ia_mode, &default_acl, &acl);
 	if (status)
 		goto out;
+#endif
 
 	data->msg.rpc_proc = &nfs3_procedures[NFS3PROC_MKNOD];
 	data->arg.mknod.fh = NFS_FH(dir);
@@ -760,12 +781,16 @@ nfs3_proc_mknod(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 	if (d_alias)
 		dentry = d_alias;
 
+#ifdef CONFIG_NFS_V3_ACL
 	status = nfs3_proc_setacls(d_inode(dentry), acl, default_acl);
-
+#endif
 	dput(d_alias);
+
 out_release_acls:
+#ifdef CONFIG_NFS_V3_ACL
 	posix_acl_release(acl);
 	posix_acl_release(default_acl);
+#endif
 out:
 	nfs3_free_createdata(data);
 	dprintk("NFS reply mknod: %d\n", status);
-- 
2.27.0

