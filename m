Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FDC506909
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 12:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350798AbiDSKuQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 06:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243059AbiDSKuG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:50:06 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE811D335;
        Tue, 19 Apr 2022 03:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1650365242; i=@fujitsu.com;
        bh=0pzuZqnMKiL4erT/FsIYrH8hrYItIQ0ZRX22uC8lIbQ=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=hIwfAuc69Xx8K25DwcOytVfnY2HcBlHnpYAGbO4CnypR85lQ5SFVuTh/tkIJQY6Ou
         2AUfaSP0Uy2wkPcWyRMeT8JKKenGQPKsey63y6p3NOtsZL0gyTvAK35vkwzo2Nsd60
         FB6Lyt3Ztlp5nqmYSWLYvPiQCpODFdh0pwWJmlxRbvWBbqEHhN4V8xIQp1hmxrcf14
         EOOjwwtJo6M1zZuCRPbn9scL9ZwmIaFXx4ClIc3Z9gHSUVwYXGIWcCJaqy2kEZ+vXQ
         RXiFScjVnMIlMh9cHzIL+/14Si/jT8/nytq21b9Xrgl9LH5depfT0QxihYaSaXwZtA
         zkM1J0kBbT+lQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRWlGSWpSXmKPExsViZ8ORqGs5OS7
  JYEu3hMXrw58YLT7cnMRkcXrqWSaLLcfuMVpcfsJn8XPZKnaLS4vcLfbsPcliceHAaVaLXX92
  sFusfLyVyeL83+OsDjwepxZJeGxa1cnm8WLzTEaP3Qs+M3l83iTnsenJW6YAtijWzLyk/IoE1
  owlXy+xFuwUrdj1cjZ7A+NkoS5GLg4hgS2MEp1bpjJBOAuYJI78eczcxcgJ5OxhlDj0VhnEZh
  PQlHjWuQAsLiKgLLHgxjE2kAZmgTNMEpeuLWEESQgL+Ev8fv4WyObgYBFQlZg0PRckzCvgIXF
  t2QqwEgkBBYkpD9+DzeEU8JTY+PY9C8QuD4nrh7cwQ9QLSpyc+QQsziwgIXHwxQtmiF5FiUsd
  36DmVEjMmtXGBGGrSVw9t4l5AqPgLCTts5C0L2BkWsVolVSUmZ5RkpuYmaNraGCga2hoqgskT
  U30Eqt0E/VSS3XLU4tLdA31EsuL9VKLi/WKK3OTc1L08lJLNjECoyulmGHWDsZZfT/1DjFKcj
  ApifLWR8UlCfEl5adUZiQWZ8QXleakFh9ilOHgUJLgLZ0AlBMsSk1PrUjLzAFGOkxagoNHSYR
  3cj9Qmre4IDG3ODMdInWKUVFKnFesBSghAJLIKM2Da4Mll0uMslLCvIwMDAxCPAWpRbmZJajy
  rxjFORiVhHmbJgJN4cnMK4Gb/gpoMRPQ4uopsSCLSxIRUlINTBMil3oo5px9M+P21/9NC85/d
  fxqPvfMjN2PDk5jNq2KdnZnsNp99NFylynms66ZMf6cd9twjjzbhcbneX/1HTQWGM+7Glh9at
  JGyW+eU9ayfLZ9Gt66Ri3ploKHrken1j22j+Ffda7cn6Bu3tGb4nRrx4clF8InLVxTf3lrnOn
  iK2yKXwTSNb88m3LgXO7bxR2nowVzrI2v7On8Fbsh+67S67b2pYK5U0KtJ79rD73CYmd9h3vx
  rF8JPousU0O0pEqZ6l++/ZwnFHHobhTjCZmSSBkR9/CVLnwp129LB0zck2MtwxnN/TvJ0rtr9
  fSsXbz1P7KVGV2X/p4arHnH/wGvwG6+eMtep/NREmbfFZVYijMSDbWYi4oTAfUjQSGpAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-13.tower-591.messagelabs.com!1650365241!273698!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29673 invoked from network); 19 Apr 2022 10:47:21 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-13.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 19 Apr 2022 10:47:21 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 9AF6F1001A1;
        Tue, 19 Apr 2022 11:47:20 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 805B6100196;
        Tue, 19 Apr 2022 11:47:20 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 19 Apr 2022 11:47:01 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <ceph-devel@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
        <david@fromorbit.com>, <djwong@kernel.org>, <brauner@kernel.org>,
        <jlayton@kernel.org>, <ntfs3@lists.linux.dev>, <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v4 4/8] NFSv3: only do posix_acl_create under CONFIG_NFS_V3_ACL
Date:   Tue, 19 Apr 2022 19:47:10 +0800
Message-ID: <1650368834-2420-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1650368834-2420-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1650368834-2420-1-git-send-email-xuyang2018.jy@fujitsu.com>
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

Since nfs3_proc_create/nfs3_proc_mkdir/nfs3_proc_mknod these rpc ops are called
by nfs_create/nfs_mkdir/nfs_mkdir these inode ops, so they are all in control of
vfs.

nfs3_proc_setacls does nothing in the !CONFIG_NFS_V3_ACL case, so we put
posix_acl_create under CONFIG_NFS_V3_ACL and it also doesn't affect
sattr->ia_mode value because vfs has did umask strip.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 fs/nfs/nfs3proc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 1597eef40d54..9ab93427db30 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -337,7 +337,7 @@ static int
 nfs3_proc_create(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 		 int flags)
 {
-	struct posix_acl *default_acl, *acl;
+	struct posix_acl *default_acl = NULL, *acl = NULL;
 	struct nfs3_createdata *data;
 	struct dentry *d_alias;
 	int status = -ENOMEM;
@@ -361,9 +361,11 @@ nfs3_proc_create(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 		data->arg.create.verifier[1] = cpu_to_be32(current->pid);
 	}
 
+#if IS_ENABLED(CONFIG_NFS_V3_ACL)
 	status = posix_acl_create(dir, &sattr->ia_mode, &default_acl, &acl);
 	if (status)
 		goto out;
+#endif
 
 	for (;;) {
 		d_alias = nfs3_do_create(dir, dentry, data);
@@ -580,7 +582,7 @@ nfs3_proc_symlink(struct inode *dir, struct dentry *dentry, struct page *page,
 static int
 nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *sattr)
 {
-	struct posix_acl *default_acl, *acl;
+	struct posix_acl *default_acl = NULL, *acl = NULL;
 	struct nfs3_createdata *data;
 	struct dentry *d_alias;
 	int status = -ENOMEM;
@@ -591,9 +593,11 @@ nfs3_proc_mkdir(struct inode *dir, struct dentry *dentry, struct iattr *sattr)
 	if (data == NULL)
 		goto out;
 
+#if IS_ENABLED(CONFIG_NFS_V3_ACL)
 	status = posix_acl_create(dir, &sattr->ia_mode, &default_acl, &acl);
 	if (status)
 		goto out;
+#endif
 
 	data->msg.rpc_proc = &nfs3_procedures[NFS3PROC_MKDIR];
 	data->arg.mkdir.fh = NFS_FH(dir);
@@ -711,7 +715,7 @@ static int
 nfs3_proc_mknod(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 		dev_t rdev)
 {
-	struct posix_acl *default_acl, *acl;
+	struct posix_acl *default_acl = NULL, *acl = NULL;
 	struct nfs3_createdata *data;
 	struct dentry *d_alias;
 	int status = -ENOMEM;
@@ -723,9 +727,11 @@ nfs3_proc_mknod(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 	if (data == NULL)
 		goto out;
 
+#if IS_ENABLED(CONFIG_NFS_V3_ACL)
 	status = posix_acl_create(dir, &sattr->ia_mode, &default_acl, &acl);
 	if (status)
 		goto out;
+#endif
 
 	data->msg.rpc_proc = &nfs3_procedures[NFS3PROC_MKNOD];
 	data->arg.mknod.fh = NFS_FH(dir);
-- 
2.27.0

