Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0808E4ED6F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 11:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbiCaJas (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 05:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiCaJai (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:30:38 -0400
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com [85.158.142.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B22203A7D;
        Thu, 31 Mar 2022 02:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1648718888; i=@fujitsu.com;
        bh=11hHL51oJKIRRxJ2cKGm8qGia+vQkgT71xo8XfL1lYk=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=WZmObQvO69zpIC7M7M3usxpDbuHb1Z0wBMdsokqyEUoI0mSfhJJr7ieOg7y3YbyjG
         Dpvk2Vshf1uwiW3wyxPfGkInbB9KbsMBviDQlAeRSm27izwaqeXbp4joC4QxXBp6yg
         48asTRlrFwynYBGgEOOH3xLft29bGjZcEkcI2uAirFCTSZ6K3p+lfvaEOziJxMzMol
         9AafxkIZHBdBqo3w9WFnf9DLGKSFXJa0EIul+z2JchS5sorqr3RDX+wlxuxrjBJlH0
         uWxjuqNPfMkZoTISgsdf20hdTnpTdhFtnKqXCIgzrv+V6rJFg6PgKLyBx8xUcUlHIY
         vS+rHNkFu8M1Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRWlGSWpSXmKPExsViZ8ORqKte4pp
  k8GaSgcXrw58YLbYcu8docfkJn8Xplr3sFnv2nmRxYPU4tUjCY9OqTjaPz5vkApijWDPzkvIr
  Elgz/lxeylIw373iw/NmpgbG+1ZdjFwcQgJbGCX2fL3HDOEsYJLo6fvCAuHsYZTY/WI5axcjJ
  webgKbEs84FzCC2iICLxLf9f9lAbGaBFImG802MILawgK/EwoWvgOo5OFgEVCVO9TmDhHkFPC
  Ra915mAbElBBQkpjx8zwwRF5Q4OfMJC8QYCYmDL14wQ9QoSlzq+MYIYVdIzJrVxgRhq0lcPbe
  JeQIj/ywk7bOQtC9gZFrFaJdUlJmeUZKbmJmja2hgoGtoaKprZqZrZGShl1ilm6iXWqqbnJpX
  UpQIlNZLLC/WSy0u1iuuzE3OSdHLSy3ZxAgM6ZRipyc7GF/3/dQ7xCjJwaQkyusU4JokxJeUn
  1KZkVicEV9UmpNafIhRhoNDSYK3vgAoJ1iUmp5akZaZA4wvmLQEB4+SCG8oSJq3uCAxtzgzHS
  J1ilGX4++nv3uZhVjy8vNSpcR5ZxcCFQmAFGWU5sGNgMX6JUZZKWFeRgYGBiGegtSi3MwSVPl
  XjOIcjErCvFeLgKbwZOaVwG16BXQEE9ARdY8dQY4oSURISTUwhT2953lm+6yFNRF5614vl7aY
  u27zMTFF9892SS/jGk8/aTrM9UP/84eToRNij/mpKk7LW/9g8pofK+/VLJC7ck5lquK5+Ja97
  3skZVne1WluK2L98viOYMJbj9+TEw4cDXvCetpXW+i/68qFlfJ/T17K2Zh6soVH6c2qQyt3L4
  wRVc++eWPzY7abM8+0z4zJcHH7vUNKwKbdg1P8pS7ru2Of1rWdcpcO6QyXur+UoWm1q4DKn0P
  njzhns7lssmKynVE9V3pzVaf0nDr+k/Xrn16x/LD3ycrrmzdXtM6Wvzdn4ZsAsXBzFta5z+++
  eOG/IjZHNX7dDOconcN58jqcDlc+sL7iaI97XjthtUZllYoSS3FGoqEWc1FxIgABoqgVcAMAA
  A==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-3.tower-545.messagelabs.com!1648718887!135975!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15602 invoked from network); 31 Mar 2022 09:28:07 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-3.tower-545.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 31 Mar 2022 09:28:07 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 065721001B8;
        Thu, 31 Mar 2022 10:28:07 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id B291B1001AE;
        Thu, 31 Mar 2022 10:28:06 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 31 Mar 2022 10:27:53 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <david@fromorbit.com>, <brauner@kernel.org>, <djwong@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <fstests@vger.kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v1 1/2] idmapped-mounts: Add mknodat operation in setgid test
Date:   Thu, 31 Mar 2022 17:28:21 +0800
Message-ID: <1648718902-2319-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
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

Since mknodat can create file, we should also check whether strip S_ISGID.
Also add new helper caps_down_fsetid to drop CAP_FSETID because strip S_ISGID
depond on this cap and keep other cap(ie CAP_MKNOD) because create character device
needs it when using mknod.

Only test mknod with character device in setgid_create function because the another
two functions will hit EPERM error.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/idmapped-mounts/idmapped-mounts.c | 154 ++++++++++++++++++++++++--
 1 file changed, 147 insertions(+), 7 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 4cf6c3bb..1e2f3904 100644
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
 
+		if (unlinkat(t_dir1_fd, FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(t_dir1_fd, DIR1, AT_REMOVEDIR))
+			die("failure: delete");
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -8149,15 +8240,26 @@ static int setgid_create_idmapped_in_userns(void)
 		if (!is_setgid(open_tree_fd, DIR1, 0))
 			die("failure: is_setgid");
 
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(open_tree_fd, DIR1 "/" FILE1, S_IFREG | S_ISGID | 755, 0))
+			die("failure: mknodat");
+
+		if (!is_setgid(open_tree_fd, DIR1 "/" FILE1, 0))
+			die("failure: is_setgid");
+
 		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 0))
 			die("failure: check ownership");
 
 		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 0, 0))
 			die("failure: check ownership");
 
+		if (!expected_uid_gid(open_tree_fd, DIR1 "/" FILE1, 0, 0, 0))
+			die("failure: check ownership");
+
 		if (unlinkat(open_tree_fd, FILE1, 0))
 			die("failure: delete");
-
+		if (unlinkat(open_tree_fd, DIR1 "/" FILE1, 0))
+			die("failure: delete");
 		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
 			die("failure: delete");
 
@@ -8190,9 +8292,12 @@ static int setgid_create_idmapped_in_userns(void)
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
@@ -8218,6 +8323,13 @@ static int setgid_create_idmapped_in_userns(void)
 				die("failure: is_setgid");
 		}
 
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(open_tree_fd, DIR1 "/" FILE1, S_IFREG | S_ISGID | 0755, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, DIR1 "/" FILE1, 0))
+			die("failure: is_setgid");
+
 		/*
 		 * In setgid directories newly created files always inherit the
 		 * gid from the parent directory. Verify that the file is owned
@@ -8234,9 +8346,15 @@ static int setgid_create_idmapped_in_userns(void)
 		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 0, 1000))
 			die("failure: check ownership");
 
+		if (!expected_uid_gid(open_tree_fd, DIR1 "/" FILE1, 0, 0, 1000))
+			die("failure: check ownership");
+
 		if (unlinkat(open_tree_fd, FILE1, 0))
 			die("failure: delete");
 
+		if (unlinkat(open_tree_fd, DIR1 "/" FILE1, 0))
+			die("failure: delete");
+
 		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
 			die("failure: delete");
 
@@ -8266,9 +8384,12 @@ static int setgid_create_idmapped_in_userns(void)
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
@@ -8295,12 +8416,31 @@ static int setgid_create_idmapped_in_userns(void)
 				die("failure: is_setgid");
 		}
 
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(open_tree_fd, DIR1 "/" FILE1, S_IFREG | S_ISGID | 0755, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, DIR1 "/" FILE1, 0))
+			die("failure: is_setgid");
+
 		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 0))
 			die("failure: check ownership");
 
+		if (!expected_uid_gid(open_tree_fd, DIR1 "/" FILE1, 0, 0, 0))
+			die("failure: check ownership");
+
 		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 0, 0))
 			die("failure: check ownership");
 
+		if (unlinkat(open_tree_fd, FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, DIR1 "/" FILE1, 0))
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

