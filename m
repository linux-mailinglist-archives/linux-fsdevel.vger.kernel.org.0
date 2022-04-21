Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EE5509869
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 09:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385395AbiDUG5L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 02:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385352AbiDUG5C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:57:02 -0400
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB1E6350;
        Wed, 20 Apr 2022 23:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1650524014; i=@fujitsu.com;
        bh=bsIcrEQ7T7ZDVCzc9c2YjRMuEHA0WkrkYfM8+exRdkg=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=YdKQCqP0aagpdAvIVn+6T818kHeK7wZvH4FiNWjk2AFzAwOBH8xcSCkLDJdKUVNPj
         r2JUHuGj0Bgk4z6HVGaxReV6t4KmjAM507R0ElaIAbqvzefk8YiYNEfY6HmOB5BRbZ
         15Wd1qoJ376xwdwoDluzXEjs6W14cEAHoaGDCcZEEoXeHdqY3lbI9wcp0j0DwgSjl2
         iQA/JjOBg8DuIGtX3pYzV1RUko+vuyrA2bUl0R3c5BBwTYGZha79JQenDRLcqSkzlR
         AitgalKTC6u8EU9Kfa/EKVUBeDRQO3GvtvLn9SRj+j1WmWV9nQdxieHY0OKFJVBjBN
         JWVJ7h3Z9Wg2A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRWlGSWpSXmKPExsViZ8ORqJv7PyH
  JYPZmbYvXhz8xWny4OYnJYsuxe4wWl5/wWfxctordYs/ekywW5/8eZ7X4/WMOmwOHx6lFEh6b
  V2h5bFrVyebxeZOcx6Ynb5kCWKNYM/OS8isSWDO6dh1iLfgmWDFj9Ry2BsbJ/F2MXBxCAlsYJ
  Q7N6GTuYuQEchYwSSzfwQOR2MMocefFVBaQBJuApsSzzgVgRSICjhIv2meAxZkFNjNKLHscDm
  ILCyRKtP+eCFbDIqAqceEohM0r4CHxa85yNhBbQkBBYsrD91BxQYmTM59AzZGQOPjiBTNEjaL
  EpY5vjBB2hcSsWW1MELaaxNVzm5gnMPLPQtI+C0n7AkamVYxWSUWZ6RkluYmZObqGBga6hoam
  uqa6RkameolVuol6qaW65anFJbqGeonlxXqpxcV6xZW5yTkpenmpJZsYgaGfUsz6cAfj4r6fe
  ocYJTmYlER5L/5KSBLiS8pPqcxILM6ILyrNSS0+xCjDwaEkwdv7GSgnWJSanlqRlpkDjEOYtA
  QHj5IIr/I/oDRvcUFibnFmOkTqFKOilDivFUhCACSRUZoH1waL/UuMslLCvIwMDAxCPAWpRbm
  ZJajyrxjFORiVhHn9QabwZOaVwE1/BbSYCWhx9ZRYkMUliQgpqQYmV+WtC28JVP3zljyhPm1x
  1VaVtVwBy9o+PLprP/NBxrPmVzz9Coszum/yia1hqTTr+Tzp/A5VyZvJN1Yeq9px4XRHhmSw+
  bl5/duCik61TPEq3eNh83uJVmVjXX2g+hqmLStkGI/G7kn2/dkWoPPXNnnq3Oi+2Z1/zNLLpB
  9VXz3wenfGZx2/uWGrvAI97DedP3lFaeMOAR+L2BOFWnLCkm+aU5/vVXQLdmIRP7x2An/ise3
  cxkIZ9hPSOWIUe9vf167fz21pcOaD2byPlc/L/p2Jfdc8c0HomYvfex2V9Z9vMEn8FCdVzK8q
  syBCppgtfA7veqZ9fDLzO2+lm2zeacc98b+Zcobcz/PCMzWVWIozEg21mIuKEwF6hfXreAMAA
  A==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-16.tower-585.messagelabs.com!1650524013!37518!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28394 invoked from network); 21 Apr 2022 06:53:33 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-16.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 21 Apr 2022 06:53:33 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 07ED71001A0;
        Thu, 21 Apr 2022 07:53:33 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id E1755100183;
        Thu, 21 Apr 2022 07:53:32 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 21 Apr 2022 07:53:27 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <david@fromorbit.com>,
        <djwong@kernel.org>, <brauner@kernel.org>, <willy@infradead.org>,
        <jlayton@kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v5 1/4] fs: move sgid strip operation from inode_init_owner into inode_sgid_strip
Date:   Thu, 21 Apr 2022 15:54:15 +0800
Message-ID: <1650527658-2218-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This has no functional change. Just create and export inode_sgid_strip
api for the subsequent patch. This function is used to strip inode's
S_ISGID mode when init a new inode.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
v4-v5:
use umode_t return value instead of mode pointer
 fs/inode.c         | 23 +++++++++++++++++++----
 include/linux/fs.h |  2 ++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 9d9b422504d1..57130e4ef8b4 100644
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
+			mode = inode_sgid_strip(mnt_userns, dir, mode);
 	} else
 		inode_fsgid_set(inode, mnt_userns);
 	inode->i_mode = mode;
@@ -2405,3 +2403,20 @@ struct timespec64 current_time(struct inode *inode)
 	return timestamp_truncate(now, inode);
 }
 EXPORT_SYMBOL(current_time);
+
+umode_t inode_sgid_strip(struct user_namespace *mnt_userns,
+			 const struct inode *dir, umode_t mode)
+{
+	if (S_ISDIR(mode) || !dir || !(dir->i_mode & S_ISGID))
+		return mode;
+	if ((mode & (S_ISGID | S_IXGRP)) != (S_ISGID | S_IXGRP))
+		return mode;
+	if (in_group_p(i_gid_into_mnt(mnt_userns, dir)))
+		return mode;
+	if (capable_wrt_inode_uidgid(mnt_userns, dir, CAP_FSETID))
+		return mode;
+
+	mode &= ~S_ISGID;
+	return mode;
+}
+EXPORT_SYMBOL(inode_sgid_strip);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bbde95387a23..532de76c9b91 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1897,6 +1897,8 @@ extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
 void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
 		      const struct inode *dir, umode_t mode);
 extern bool may_open_dev(const struct path *path);
+umode_t inode_sgid_strip(struct user_namespace *mnt_userns,
+			 const struct inode *dir, umode_t mode);
 
 /*
  * This is the "filldir" function type, used by readdir() to let
-- 
2.27.0

