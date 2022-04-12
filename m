Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75F74FDE7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 13:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348205AbiDLLuu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 07:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355049AbiDLLtJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:49:09 -0400
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com [85.158.142.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714C16329;
        Tue, 12 Apr 2022 03:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1649759597; i=@fujitsu.com;
        bh=/6FqkHTAW3qkYDVGKL25u4oczxQc+1U7/FW1LcygMS4=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=kjTotdBltPESsEFbbqXPsAZSWlopwg88NLREXEwhN7vhReBgUffbzoBo+tpIdXlrc
         J8U7xKxPOkUZb5KDCSE0lajVb9itsRecUGdK3dZVjrchAVYiOcLM+ByGrUQH7lC38K
         yUEfzmBDjerdRcEdZR1zfjydZakwsbamtEojebrhRmNTLk8qcR91Hj9hargwbgSDZv
         UifCYGLB7DTc0MEgicsJTwqhACcQCUaRZDHET7Kb7ZS/BOPdIl2c/TbsMlBOjTCgUy
         JPyFz6qRTuyIIgXQXaw7O5YI3O0hUTS1X7ANhEfXAiW8n62Weg04MgnrIVUbPa36k7
         JvBs+OjcWs1zw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRWlGSWpSXmKPExsViZ8MRopsbGpp
  kcHyqiMXrw58YLbYcu8docfkJn8Xplr3sFnv2nmRxYPU4tUjCY9OqTjaPz5vkApijWDPzkvIr
  Elgzzp5fw1JwP6bizaHTLA2ML3y6GLk4hAReM0p8vf+JBcLZwyjxd/VJpi5GTg42AU2JZ50Lm
  EFsEQEXiW/7/7KB2MwCORINu3+A1QgL+Eq8mtzGCGKzCKhK7Lk9B6ieg4NXwEPiTyMHSFhCQE
  FiysP3YGM4BTwlJh3ZxwJiCwGVzGhdDTaSV0BQ4uTMJywQ4yUkDr54wQzRqyhxqeMbI4RdITF
  rVhvTBEb+WUhaZiFpWcDItIrRLqkoMz2jJDcxM0fX0MBA19DQVNfMQtfQxFgvsUo3US+1VDc5
  Na+kKBEorZdYXqyXWlysV1yZm5yTopeXWrKJERjQKcUu/TsY7/f91DvEKMnBpCTKa8ATmiTEl
  5SfUpmRWJwRX1Sak1p8iFGGg0NJglcuGCgnWJSanlqRlpkDjC6YtAQHj5IIb2wgUJq3uCAxtz
  gzHSJ1ilGX4++nv3uZhVjy8vNSpcR5OUOAigRAijJK8+BGwCL9EqOslDAvIwMDgxBPQWpRbmY
  JqvwrRnEORiVhXn6QKTyZeSVwm14BHcEEdETotkCQI0oSEVJSDUzph566dRncLxJZ8umDi2iz
  qdmU2jthtpJnUlSmiSrl/5P7935hyXOtObJWkxVtFh9Nv7/256wlwZFFNc/8/z0tXSO9OOhod
  urP+6dTNEU+Nf+95N06WZjjyNIVGY7PDVYdvbtHJl+0/47KYfcHW4v710/ZcnGCzpN3x1N/+v
  MqVta6prYzLpZR5TTPkZw91b7AX+GpwJELRnt5jQ4zfGF+37Lu4s5XM+xPTeqqiow3ObIwKZx
  5K6PnofU/nUp0qjbfbkwVFHC9tWnuTtH4q92vsgze72KSip2q1jtHVcHkZPvUu5zzgh5u799+
  hVstawXDRSs3w/8zZj4T+b+t+9jHa4z2P78z2U7VyGBx8yhRYinOSDTUYi4qTgQA4y8UhG8DA
  AA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-16.tower-545.messagelabs.com!1649759596!62404!1
X-Originating-IP: [62.60.8.84]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25341 invoked from network); 12 Apr 2022 10:33:17 -0000
Received: from unknown (HELO mailhost3.uk.fujitsu.com) (62.60.8.84)
  by server-16.tower-545.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 12 Apr 2022 10:33:17 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 23CAXGW3000905
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 12 Apr 2022 11:33:16 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 12 Apr 2022 11:33:13 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <david@fromorbit.com>, <brauner@kernel.org>, <djwong@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <fstests@vger.kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v3 2/5] idmapped-mounts: Add mknodat operation in setgid test
Date:   Tue, 12 Apr 2022 19:33:43 +0800
Message-ID: <1649763226-2329-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1649763226-2329-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1649763226-2329-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since mknodat can create file, we should also check whether strip S_ISGID.
Also add new helper caps_down_fsetid to drop CAP_FSETID because strip S_ISGID
depend on this cap and keep other cap(ie CAP_MKNOD) because create character
device needs it when using mknod.

Only test mknodat with character device in setgid_create function and the another
two functions test mknodat with whiteout device.

Since kernel commit a3c751a50 ("vfs: allow unprivileged whiteout creation") in
v5.8-rc1, we can create whiteout device in userns test. Since kernel 5.12, mount_setattr
and MOUNT_ATTR_IDMAP was supported, we don't need to detect kernel whether allow
unprivileged whiteout creation. Using fs_allow_idmap as a proxy is safe.

Tested-by: Christian Brauner (Microsoft)<brauner@kernel.org>
Reviewed-by: Christian Brauner (Microsoft)<brauner@kernel.org>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/idmapped-mounts/idmapped-mounts.c | 219 +++++++++++++++++++++++++-
 1 file changed, 213 insertions(+), 6 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 8e6405c5..617f56e0 100644
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
@@ -7863,18 +7891,44 @@ static int setgid_create(void)
 		if (!is_setgid(t_dir1_fd, DIR1, 0))
 			die("failure: is_setgid");
 
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(t_dir1_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (!is_setgid(t_dir1_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		/* create a character device via mknodat() vfs_mknod */
+		if (mknodat(t_dir1_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, makedev(5, 1)))
+			die("failure: mknodat");
+
+		if (!is_setgid(t_dir1_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
 		if (!expected_uid_gid(t_dir1_fd, FILE1, 0, 0, 0))
 			die("failure: check ownership");
 
 		if (!expected_uid_gid(t_dir1_fd, DIR1, 0, 0, 0))
 			die("failure: check ownership");
 
+		if (!expected_uid_gid(t_dir1_fd, FILE2, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(t_dir1_fd, CHRDEV1, 0, 0, 0))
+			die("failure: check ownership");
+
 		if (unlinkat(t_dir1_fd, FILE1, 0))
 			die("failure: delete");
 
 		if (unlinkat(t_dir1_fd, DIR1, AT_REMOVEDIR))
 			die("failure: delete");
 
+		if (unlinkat(t_dir1_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(t_dir1_fd, CHRDEV1, 0))
+			die("failure: delete");
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
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
+		if (mknodat(t_dir1_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(t_dir1_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		/* create a character device via mknodat() vfs_mknod */
+		if (mknodat(t_dir1_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, makedev(5, 1)))
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
 
+		if (!expected_uid_gid(t_dir1_fd, FILE2, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(t_dir1_fd, CHRDEV1, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (unlinkat(t_dir1_fd, FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(t_dir1_fd, DIR1, AT_REMOVEDIR))
+			die("failure: delete");
+
+		if (unlinkat(t_dir1_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(t_dir1_fd, CHRDEV1, 0))
+			die("failure: delete");
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -8035,6 +8120,20 @@ static int setgid_create_idmapped(void)
 				die("failure: is_setgid");
 		}
 
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(open_tree_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		/* create a whiteout device via mknodat() vfs_mknod */
+		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
 		/*
 		 * In setgid directories newly created files always inherit the
 		 * gid from the parent directory. Verify that the file is owned
@@ -8051,6 +8150,24 @@ static int setgid_create_idmapped(void)
 		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 10000, 10000))
 			die("failure: check ownership");
 
+		if (!expected_uid_gid(open_tree_fd, FILE2, 0, 10000, 10000))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 10000, 10000))
+			die("failure: check ownership");
+
+		if (unlinkat(open_tree_fd, FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, CHRDEV1, 0))
+			die("failure: delete");
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -8149,18 +8266,44 @@ static int setgid_create_idmapped_in_userns(void)
 		if (!is_setgid(open_tree_fd, DIR1, 0))
 			die("failure: is_setgid");
 
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(open_tree_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (!is_setgid(open_tree_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		/* create a whiteout device via mknodat() vfs_mknod */
+		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (!is_setgid(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
 		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 0))
 			die("failure: check ownership");
 
 		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 0, 0))
 			die("failure: check ownership");
 
+		if (!expected_uid_gid(open_tree_fd, FILE2, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 0, 0))
+			die("failure: check ownership");
+
 		if (unlinkat(open_tree_fd, FILE1, 0))
 			die("failure: delete");
 
 		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
 			die("failure: delete");
 
+		if (unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, CHRDEV1, 0))
+			die("failure: delete");
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -8190,9 +8333,12 @@ static int setgid_create_idmapped_in_userns(void)
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
@@ -8218,6 +8364,20 @@ static int setgid_create_idmapped_in_userns(void)
 				die("failure: is_setgid");
 		}
 
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(open_tree_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		/* create a whiteout device via mknodat() vfs_mknod */
+		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
 		/*
 		 * In setgid directories newly created files always inherit the
 		 * gid from the parent directory. Verify that the file is owned
@@ -8234,12 +8394,24 @@ static int setgid_create_idmapped_in_userns(void)
 		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 0, 1000))
 			die("failure: check ownership");
 
+		if (!expected_uid_gid(open_tree_fd, FILE2, 0, 0, 1000))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 0, 1000))
+			die("failure: check ownership");
+
 		if (unlinkat(open_tree_fd, FILE1, 0))
 			die("failure: delete");
 
 		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
 			die("failure: delete");
 
+		if (unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, CHRDEV1, 0))
+			die("failure: delete");
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -8266,9 +8438,12 @@ static int setgid_create_idmapped_in_userns(void)
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
@@ -8295,12 +8470,44 @@ static int setgid_create_idmapped_in_userns(void)
 				die("failure: is_setgid");
 		}
 
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(open_tree_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		/* create a whiteout device via mknodat() vfs_mknod */
+		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
 		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 0))
 			die("failure: check ownership");
 
 		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 0, 0))
 			die("failure: check ownership");
 
+		if (!expected_uid_gid(open_tree_fd, FILE2, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (unlinkat(open_tree_fd, FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, CHRDEV1, 0))
+			die("failure: delete");
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
-- 
2.27.0

