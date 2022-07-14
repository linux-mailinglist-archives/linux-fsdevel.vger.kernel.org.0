Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2074F574451
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 07:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiGNFLZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 01:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiGNFLX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 01:11:23 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8490B8D;
        Wed, 13 Jul 2022 22:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1657775479; i=@fujitsu.com;
        bh=Ee6AykvAc8CUR4U99ISoALmVhL0cPM9SpY5gbd6+6u4=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=j9XNeDk9NjcWUcMOZePyzPIk7OOCI2FhJPTtr6TAgClZcQVbUsASuSD3/jKeNmYEb
         ch7pK0P3Dv6uhWcn1QuDerS5ySoIi4MpRjiWm84YpoMMvI9YAOxytDDMJVZsj7NgXa
         scBWwDU7UwfGrUHFnTGJUkPM1haQQK9bnlMtc331EfFOpHUV80BlCqAmOLJ8r9RYzT
         A9eVheCrgxaHJtAx8AZixffhMfEs1L+J+TeANSCRfX213EUAvu3PBxfI2219L3+GZa
         4milMcLPbyKnpwYGoDy160FZt/6GWF7qotvXx5LOQHltFfR6lO+ruib70Dsi4mpS2k
         tcP6ymt+SCxAw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRWlGSWpSXmKPExsViZ8MxSbdg6fk
  kg/2LrC1eH/7EaPHh5iQmiy3H7jFaXH7CZ/Fz2Sp2iz17T7JY/Lh1g8Xi/N/jrBa/f8xhc+D0
  OLVIwmPzCi2PTas62TzOLDjC7vF5k5zHpidvmQLYolgz85LyKxJYM66u/MBesFem4tH0ZawNj
  D/Euxi5OIQEtjBKXN00hQnCWc4kMfn7YlYIZw+jxK3FJ4AynBxsApoSzzoXMIPYIgKOEi/aZ7
  CAFDEL7GWUaNp0ngUkISxgKbF9+mEwm0VAVeLZ3jawBl4BD4mPU5eD2RICChJTHr6HigtKnJz
  5BKyeWUBC4uCLF1A1ihKXOr4xQtgVEq8PX4KKq0lcPbeJeQIj/ywk7bOQtC9gZFrFaJlUlJme
  UZKbmJmja2hgoGtoaKprrGtooZdYpZuol1qqW55aXKJrqJdYXqyXWlysV1yZm5yTopeXWrKJE
  RgRKcXMQjsY1/f91DvEKMnBpCTKe3vR+SQhvqT8lMqMxOKM+KLSnNTiQ4wyHBxKErzyi4Fygk
  Wp6akVaZk5wOiESUtw8CiJ8D4FaeUtLkjMLc5Mh0idYlSUEueNWQKUEABJZJTmwbXBEsIlRlk
  pYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK88iBTeDLzSuCmvwJazAS0WC7yDMjikkSElFQDU9yy
  WxEHRX4rf7DI1EuJXrBZdbXFbfHJlxmmbXX6Y8G6Zh3nnlt5vJJ9nWX/EqX/Na5Zd87dzz9yy
  9tJ9Zyn2rey1hxii0maYvfeI++lp4MYB1PRCd81hamnNdTMzzgwr3m/pLnaJ5CxPFrva6UDI9
  +pW7rcTakyL5O4a+8nryuO/Rn76s2iJfOv90/b1iWfdC+v1PqCxjzTA/PlQ0uCJNdytnE0/nf
  e6+PL8/KM8YzwrfwfzSbZSMVvvT/7mGLAqdqTM87fev5GcultuwatWl6V85VZTUef1sm0Ppux
  XCd46eljJ85K7/Q8q7C87VR8xMrNa7xFNfInB1aH7ziXZPPGvTY6Oky2K7bWv5hNiaU4I9FQi
  7moOBEAj/muQoMDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-13.tower-587.messagelabs.com!1657775472!249207!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30112 invoked from network); 14 Jul 2022 05:11:12 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-13.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 14 Jul 2022 05:11:12 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 812731000C2;
        Thu, 14 Jul 2022 06:11:12 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 73FD21000C1;
        Thu, 14 Jul 2022 06:11:12 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 14 Jul 2022 06:11:08 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <david@fromorbit.com>,
        <djwong@kernel.org>, <brauner@kernel.org>, <willy@infradead.org>,
        <jlayton@kernel.org>, <xuyang2018.jy@fujitsu.com>, <pvorel@suse.cz>
Subject: [PATCH v10 1/4] fs: add mode_strip_sgid() helper
Date:   Thu, 14 Jul 2022 14:11:25 +0800
Message-ID: <1657779088-2242-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
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

Add a dedicated helper to handle the setgid bit when creating a new file
in a setgid directory. This is a preparatory patch for moving setgid
stripping into the vfs. The patch contains no functional changes.

Currently the setgid stripping logic is open-coded directly in
inode_init_owner() and the individual filesystems are responsible for
handling setgid inheritance. Since this has proven to be brittle as
evidenced by old issues we uncovered over the last months (see [1] to
[3] below) we will try to move this logic into the vfs.

Link: e014f37db1a2 ("xfs: use setattr_copy to set vfs inode attributes") [1]
Link: 01ea173e103e ("xfs: fix up non-directory creation in SGID directories") [2]
Link: fd84bfdddd16 ("ceph: fix up non-directory creation in SGID directories") [3]
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Reviewed-and-Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 fs/inode.c         | 37 +++++++++++++++++++++++++++++++++----
 include/linux/fs.h |  2 ++
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index bd4da9c5207e..133bf018d6ee 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2246,10 +2246,8 @@ void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
 		/* Directories are special, and always inherit S_ISGID */
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
-		else if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP) &&
-			 !in_group_p(i_gid_into_mnt(mnt_userns, dir)) &&
-			 !capable_wrt_inode_uidgid(mnt_userns, dir, CAP_FSETID))
-			mode &= ~S_ISGID;
+		else
+			mode = mode_strip_sgid(mnt_userns, dir, mode);
 	} else
 		inode_fsgid_set(inode, mnt_userns);
 	inode->i_mode = mode;
@@ -2405,3 +2403,34 @@ struct timespec64 current_time(struct inode *inode)
 	return timestamp_truncate(now, inode);
 }
 EXPORT_SYMBOL(current_time);
+
+/**
+ * mode_strip_sgid - handle the sgid bit for non-directories
+ * @mnt_userns: User namespace of the mount the inode was created from
+ * @dir: parent directory inode
+ * @mode: mode of the file to be created in @dir
+ *
+ * If the @mode of the new file has both the S_ISGID and S_IXGRP bit
+ * raised and @dir has the S_ISGID bit raised ensure that the caller is
+ * either in the group of the parent directory or they have CAP_FSETID
+ * in their user namespace and are privileged over the parent directory.
+ * In all other cases, strip the S_ISGID bit from @mode.
+ *
+ * Return: the new mode to use for the file
+ */
+umode_t mode_strip_sgid(struct user_namespace *mnt_userns,
+			const struct inode *dir, umode_t mode)
+{
+	if ((mode & (S_ISGID | S_IXGRP)) != (S_ISGID | S_IXGRP))
+		return mode;
+	if (S_ISDIR(mode) || !dir || !(dir->i_mode & S_ISGID))
+		return mode;
+	if (in_group_p(i_gid_into_mnt(mnt_userns, dir)))
+		return mode;
+	if (capable_wrt_inode_uidgid(mnt_userns, dir, CAP_FSETID))
+		return mode;
+
+	mode &= ~S_ISGID;
+	return mode;
+}
+EXPORT_SYMBOL(mode_strip_sgid);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9ad5e3520fae..50642668c60f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1903,6 +1903,8 @@ extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
 void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
 		      const struct inode *dir, umode_t mode);
 extern bool may_open_dev(const struct path *path);
+umode_t mode_strip_sgid(struct user_namespace *mnt_userns,
+			const struct inode *dir, umode_t mode);
 
 /*
  * This is the "filldir" function type, used by readdir() to let
-- 
2.27.0

