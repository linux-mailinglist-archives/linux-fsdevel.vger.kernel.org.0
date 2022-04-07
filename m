Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C113C4F7D9D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 13:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244662AbiDGLLk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 07:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244657AbiDGLLh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:11:37 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5B84C79C;
        Thu,  7 Apr 2022 04:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1649329773; i=@fujitsu.com;
        bh=NzauDbBxvAOczt/DDOj64ajj68yNYs5AxACWnWWKhio=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=BkPkQOLgriYZyOVQlc6u+Mn64XJY2OCshqMJ/goJp6N3ADgTiHbVdbUiZkrFssxta
         tCw6iiatQyNrZIP8wizjQZfe3G8P48iANSVeoKBmiemOGQuJTEC9ladu3MJIIUe7PK
         TADC7AsB5Wc04Z6yYRHTHn4X/kb1cUsDdMQH3om00lURmEnJBfrPrYYW/CBDGeqkty
         BTNoECGPTCXvXPixFZUq4fINLMfSN8v+onqLuOC1raMj4r1MqHieOx8IAkRF1oxISE
         RtuOcHGs20CTNtjOepeBqhUxTDRpxoRcnCKGBkWBaQ2JcibeWyMljP4h6KHNlN7B0w
         XC7QuilnLkN5Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRWlGSWpSXmKPExsViZ8MxSTfnmF+
  Swf3T2havD39itNhy7B6jxeUnfBanW/ayW+zZe5LFgdXj1CIJj02rOtk8Pm+SC2COYs3MS8qv
  SGDNWN7Qx1iwO7jixLUV7A2Mk1y7GLk4hAS2MEq8nd/HAuEsYJJY+38WK4Szm1Fi+5sDTF2Mn
  BxsApoSzzoXMIPYIgIuEt/2/2UDsZkFUiQazjcxgtjCAr4S3d0H2EFsFgEViW9bF4P18gp4SB
  xYdZEFxJYQUJCY8vA92BxOAU+Ju4+/g80RAqppvjGDEaJeUOLkzCcsEPMlJA6+eMEM0asocan
  jGyOEXSExa1YbE4StJnH13CbmCYyCs5C0z0LSvoCRaRWjdVJRZnpGSW5iZo6uoYGBrqGhqa6x
  BZAy1Eus0k3USy3VLU8tLtE10kssL9ZLLS7WK67MTc5J0ctLLdnECAz/lGK1/B2Mf1f+1DvEK
  MnBpCTK27DTL0mILyk/pTIjsTgjvqg0J7X4EKMMB4eSBG/iEaCcYFFqempFWmYOMBZh0hIcPE
  oivEcPA6V5iwsSc4sz0yFSpxh1Of5++ruXWYglLz8vVUqcN+8oUJEASFFGaR7cCFhauMQoKyX
  My8jAwCDEU5BalJtZgir/ilGcg1FJmFcDZApPZl4J3KZXQEcwAR1Rd9AX5IiSRISUVAPTVr6T
  jfeeCMkvrLtYXj+1VmJaeuvqSwGTd/pMnLtCeA+7V+xWxx/fHXkM4jcwHs89mHmabXvzyuAzL
  etVfn68tXbHpybhWX5cGptYPPuXvP0RuEJKipFlzx2TOue0kx+2seczTw1tKXt9cRuj2gnDKT
  znf0pH13LGHK//eKZq74wFMq++VJmEfysMecLevN7cw5j34Y/Gxxd/57yTaBP9pcxuL6tewbf
  W/6mhp9cUj77tqqt1Yg7klHNFfizbe2Tj5EN7/t1fNef9FwV5U/ZSK4cHdeENut2MM5v+Vxdd
  WibV9cF0ovj2H7uXTz70x9zM6bTTm4jDOu+jVdYEbvvGwbn8+6t9mQKXE5Jdvrt9UmIpzkg01
  GIuKk4EAErmeOqGAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-21.tower-571.messagelabs.com!1649329772!30939!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14754 invoked from network); 7 Apr 2022 11:09:32 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-21.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 Apr 2022 11:09:32 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 4EDF910046B;
        Thu,  7 Apr 2022 12:09:32 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 419D2100451;
        Thu,  7 Apr 2022 12:09:32 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 7 Apr 2022 12:09:15 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <david@fromorbit.com>, <brauner@kernel.org>, <djwong@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <fstests@vger.kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v2 2/6] idmapped-mounts: Add mknodat operation in setgid test
Date:   Thu, 7 Apr 2022 20:09:31 +0800
Message-ID: <1649333375-2599-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1649333375-2599-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1649333375-2599-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since mknodat can create file, we should also check whether strip S_ISGID.
Also add new helper caps_down_fsetid to drop CAP_FSETID because strip S_ISGID
depond on this cap and keep other cap(ie CAP_MKNOD) because create character
device needs it when using mknod.

Only test mknodat with character device in setgid_create function because the another
two functions test mknodat with whiteout device.

Since kernel commit a3c751a50 ("vfs: allow unprivileged whiteout creation") in
v5.8-rc1, we can create whiteout device in userns test. Since kernel 5.12, mount_setattr
and MOUNT_ATTR_IDMAP was supported, we don't need to detect kernel whether allow
unprivileged whiteout creation. Using fs_allow_idmap as a proxy is safe.

Tested-by: Christian Brauner (Microsoft)<brauner@kernel.org>
Reviewed-by: Christian Brauner (Microsoft)<brauner@kernel.org>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/idmapped-mounts/idmapped-mounts.c | 190 +++++++++++++++++++++++++-
 1 file changed, 183 insertions(+), 7 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index dff6820f..e8a856de 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -241,6 +241,34 @@ static inline bool caps_supported(void)
 	return ret;
 }
 
+static int caps_down_fsetid(void)
+{
+	bool fret = false;
+#ifdef HAVE_SYS_CAPABILITY_H
+	cap_t caps = NULL;
+	cap_value_t cap = CAP_FSETID;
+	int ret = -1;
+
+	caps = cap_get_proc();
+	if (!caps)
+		goto out;
+
+	ret = cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap, 0);
+	if (ret)
+		goto out;
+
+	ret = cap_set_proc(caps);
+	if (ret)
+		goto out;
+
+	fret = true;
+
+out:
+	cap_free(caps);
+#endif
+	return fret;
+}
+
 /* caps_down - lower all effective caps */
 static int caps_down(void)
 {
@@ -7805,8 +7833,8 @@ out_unmap:
 #endif /* HAVE_LIBURING_H */
 
 /* The following tests are concerned with setgid inheritance. These can be
- * filesystem type specific. For xfs, if a new file or directory is created
- * within a setgid directory and irix_sgid_inhiert is set then inherit the
+ * filesystem type specific. For xfs, if a new file or directory or node is
+ * created within a setgid directory and irix_sgid_inhiert is set then inherit the
  * setgid bit if the caller is in the group of the directory.
  */
 static int setgid_create(void)
@@ -7863,15 +7891,41 @@ static int setgid_create(void)
 		if (!is_setgid(t_dir1_fd, DIR1, 0))
 			die("failure: is_setgid");
 
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(t_dir1_fd, DIR1 "/" FILE1, S_IFREG | S_ISGID | 0755, 0))
+			die("failure: mknodat");
+
+		if (!is_setgid(t_dir1_fd, DIR1 "/" FILE1, 0))
+			die("failure: is_setgid");
+
+		/* create a character device via mknodat() vfs_mknod */
+		if (mknodat(t_dir1_fd, CHRDEV1, S_IFCHR | S_ISGID | 0755, makedev(5, 1)))
+			die("failure: mknodat");
+
+		if (!is_setgid(t_dir1_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
 		if (!expected_uid_gid(t_dir1_fd, FILE1, 0, 0, 0))
 			die("failure: check ownership");
 
+		if (!expected_uid_gid(t_dir1_fd, DIR1 "/" FILE1, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(t_dir1_fd, CHRDEV1, 0, 0, 0))
+			die("failure: check ownership");
+
 		if (!expected_uid_gid(t_dir1_fd, DIR1, 0, 0, 0))
 			die("failure: check ownership");
 
 		if (unlinkat(t_dir1_fd, FILE1, 0))
 			die("failure: delete");
 
+		if (unlinkat(t_dir1_fd, DIR1 "/" FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(t_dir1_fd, CHRDEV1, 0))
+			die("failure: delete");
+
 		if (unlinkat(t_dir1_fd, DIR1, AT_REMOVEDIR))
 			die("failure: delete");
 
@@ -7889,8 +7943,8 @@ static int setgid_create(void)
 		if (!switch_ids(0, 10000))
 			die("failure: switch_ids");
 
-		if (!caps_down())
-			die("failure: caps_down");
+		if (!caps_down_fsetid())
+			die("failure: caps_down_fsetid");
 
 		/* create regular file via open() */
 		file1_fd = openat(t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
@@ -7917,6 +7971,19 @@ static int setgid_create(void)
 				die("failure: is_setgid");
 		}
 
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(t_dir1_fd, DIR1 "/" FILE1, S_IFREG | S_ISGID | 0755, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(t_dir1_fd, DIR1 "/" FILE1, 0))
+			die("failure: is_setgid");
+
+		/* create a character device via mknodat() vfs_mknod */
+		if (mknodat(t_dir1_fd, CHRDEV1, S_IFCHR | S_ISGID | 0755, makedev(5, 1)))
+			die("failure: mknodat");
+
+		if (is_setgid(t_dir1_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
 		/*
 		 * In setgid directories newly created files always inherit the
 		 * gid from the parent directory. Verify that the file is owned
@@ -7933,6 +8000,24 @@ static int setgid_create(void)
 		if (!expected_uid_gid(t_dir1_fd, DIR1, 0, 0, 0))
 			die("failure: check ownership");
 
+		if (!expected_uid_gid(t_dir1_fd, DIR1 "/" FILE1, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(t_dir1_fd, CHRDEV1, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (unlinkat(t_dir1_fd, FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(t_dir1_fd, DIR1 "/" FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(t_dir1_fd, CHRDEV1, 0))
+			die("failure: delete");
+
+		if (unlinkat(t_dir1_fd, DIR1, AT_REMOVEDIR))
+			die("failure: delete");
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -8051,6 +8136,12 @@ static int setgid_create_idmapped(void)
 		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 10000, 10000))
 			die("failure: check ownership");
 
+		if (unlinkat(open_tree_fd, FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
+			die("failure: delete");
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -8149,15 +8240,37 @@ static int setgid_create_idmapped_in_userns(void)
 		if (!is_setgid(open_tree_fd, DIR1, 0))
 			die("failure: is_setgid");
 
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(open_tree_fd, DIR1 "/" FILE1, S_IFREG | S_ISGID | 755, 0))
+			die("failure: mknodat");
+
+		if (!is_setgid(open_tree_fd, DIR1 "/" FILE1, 0))
+			die("failure: is_setgid");
+
+		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | 0755, 0))
+			die("failure: mknodat");
+
+		if (!is_setgid(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
 		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 0))
 			die("failure: check ownership");
 
 		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 0, 0))
 			die("failure: check ownership");
 
+		if (!expected_uid_gid(open_tree_fd, DIR1 "/" FILE1, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 0, 0))
+			die("failure: check ownership");
+
 		if (unlinkat(open_tree_fd, FILE1, 0))
 			die("failure: delete");
-
+		if (unlinkat(open_tree_fd, DIR1 "/" FILE1, 0))
+			die("failure: delete");
+		if (unlinkat(open_tree_fd, CHRDEV1, 0))
+			die("failure: delete");
 		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
 			die("failure: delete");
 
@@ -8190,9 +8303,12 @@ static int setgid_create_idmapped_in_userns(void)
 			exit(EXIT_SUCCESS);
 		}
 
-		if (!switch_userns(attr.userns_fd, 0, 0, true))
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
 			die("failure: switch_userns");
 
+		if (!caps_down_fsetid())
+			die("failure: caps_down_fsetid");
+
 		/* create regular file via open() */
 		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
 		if (file1_fd < 0)
@@ -8218,6 +8334,20 @@ static int setgid_create_idmapped_in_userns(void)
 				die("failure: is_setgid");
 		}
 
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(open_tree_fd, DIR1 "/" FILE1, S_IFREG | S_ISGID | 0755, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, DIR1 "/" FILE1, 0))
+			die("failure: is_setgid");
+
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | 0755, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
 		/*
 		 * In setgid directories newly created files always inherit the
 		 * gid from the parent directory. Verify that the file is owned
@@ -8234,9 +8364,21 @@ static int setgid_create_idmapped_in_userns(void)
 		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 0, 1000))
 			die("failure: check ownership");
 
+		if (!expected_uid_gid(open_tree_fd, DIR1 "/" FILE1, 0, 0, 1000))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 0, 1000))
+			die("failure: check ownership");
+
 		if (unlinkat(open_tree_fd, FILE1, 0))
 			die("failure: delete");
 
+		if (unlinkat(open_tree_fd, DIR1 "/" FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, CHRDEV1, 0))
+			die("failure: delete");
+
 		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
 			die("failure: delete");
 
@@ -8266,9 +8408,12 @@ static int setgid_create_idmapped_in_userns(void)
 			exit(EXIT_SUCCESS);
 		}
 
-		if (!switch_userns(attr.userns_fd, 0, 1000, true))
+		if (!switch_userns(attr.userns_fd, 0, 1000, false))
 			die("failure: switch_userns");
 
+		if (!caps_down_fsetid())
+			die("failure: caps_down_fsetid");
+
 		/* create regular file via open() */
 		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
 		if (file1_fd < 0)
@@ -8295,12 +8440,43 @@ static int setgid_create_idmapped_in_userns(void)
 				die("failure: is_setgid");
 		}
 
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(open_tree_fd, DIR1 "/" FILE1, S_IFREG | S_ISGID | 0755, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, DIR1 "/" FILE1, 0))
+			die("failure: is_setgid");
+
+		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | 0755, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
 		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 0))
 			die("failure: check ownership");
 
 		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 0, 0))
 			die("failure: check ownership");
 
+		if (!expected_uid_gid(open_tree_fd, DIR1 "/" FILE1, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (unlinkat(open_tree_fd, FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, DIR1 "/" FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, CHRDEV1, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
+			die("failure: delete");
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
-- 
2.27.0

