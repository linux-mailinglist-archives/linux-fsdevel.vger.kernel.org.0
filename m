Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B0A506926
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 12:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350820AbiDSKxU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 06:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350787AbiDSKxS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:53:18 -0400
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com [85.158.142.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FEC1DA57;
        Tue, 19 Apr 2022 03:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1650365434; i=@fujitsu.com;
        bh=KUoy2iJzDfdq/6qX+n+tPy7WXkIBqP/Z5evBH4xlq3s=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=AT9aGIGMrlK8j3YT8sBCHhuIuq3BBxBztbgg9uLgpz6aYou7skZoN2sviXtypDbIp
         iuPWQZ/oa4nGFNXih74LyowrhN+6xM4thKV5HaSWRAg/kzEo8QDXLSfxZHX7gVIoJh
         nMa0X6sb4dZF+s3o6B+Fg4+k4WflRRqHfCxtk09Cmm2MRmw7ZR7MyDV1nqUDyGRSK3
         7KPxlyt91Ap2MiLeu6/9/0f9PzcjTtkDVEnamVDJYahQwwygUxy23FZud8lTbwyYCO
         Ext/aTQNCz5Z7X+whqQ7hnFX/vYpaCWM0IMv7uu0ahJMVVwVsVBQAg1trPWm0T9Daw
         1JiynZzDAI9kg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleJIrShJLcpLzFFi42Kxs+GYovtzcly
  SwfZv1havD39itPhwcxKTxempZ5ksthy7x2hx+Qmfxc9lq9gtLi1yt9iz9ySLxYUDp1ktdv3Z
  wW6x8vFWJovzf4+zOvB4nFok4bFpVSebx4vNMxk9di/4zOTxeZOcx6Ynb5kC2KJYM/OS8isSW
  DN+7uxlK9jHWfHy1U3WBsYd7F2MXBxCAq8ZJfpv9LFAOHsYJZZfamDtYuTkYBPQlHjWuYAZxB
  YRUJZYcOMYG4jNLPCBSWLiwSoQW1ggWGLvjBdg9SwCqhIfvsxk7GLk4OAV8JA4dp4TJCwhoCA
  x5eF7sDGcAp4SG9++ZwGxhYBKrh/eAhbnFRCUODnzCQvEeAmJgy9eMEP0Kkpc6vjGCGFXSMya
  1cY0gZF/FpKWWUhaFjAyrWK0SyrKTM8oyU3MzNE1NDDQNTQ01TUHUmZmeolVuol6qaW6yal5J
  UWJQGm9xPJivdTiYr3iytzknBS9vNSSTYzAmEkpdlu2g3Ff30+9Q4ySHExKorz1UXFJQnxJ+S
  mVGYnFGfFFpTmpxYcYZTg4lCR4SycA5QSLUtNTK9Iyc4DxC5OW4OBREuGd3A+U5i0uSMwtzky
  HSJ1iVJQS5xVrAUoIgCQySvPg2mAp4xKjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDkYlYd6Nk4Cm
  8GTmlcBNfwW0mAlocfWUWJDFJYkIKakGJhamGom9xs1Ne7JeT25ldZgp33ErXdWeWad4t9J1B
  dfXeqsnefxSYFmukhWYWfCjTm8HV9B1ieMf+lbW/XfZdCQr5zLPoy38jh/z35Y9yNreVlH4eJ
  ZKy++qP7Vcqpv3xvrcvNq2M/TUDW5ZNraDmxK72W4+2/OktzDlUwTzz0Mi1z4etIvav5sz8uv
  d+/M/qey9dby9pk/kZHfpX0dudteH7nKqUqznGteFCn25XnGhvUG08FljQ/PKdY5d2adO3Obw
  5BE7rmbvyfJJMPbZhSMfdaP/+Qv13KkOnjTl/bn40uXbnye7ySdZV9y8bpktfmbL9UmOz9l4m
  VyKb+ltzpPInbLZdf1PnylnHq7jV2Ipzkg01GIuKk4EAPdP9QqUAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-25.tower-545.messagelabs.com!1650365433!270749!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1555 invoked from network); 19 Apr 2022 10:50:33 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
  by server-25.tower-545.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 19 Apr 2022 10:50:33 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 23JAoXvI005594
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 19 Apr 2022 11:50:33 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 19 Apr 2022 11:50:28 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <ceph-devel@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
        <david@fromorbit.com>, <djwong@kernel.org>, <brauner@kernel.org>,
        <jlayton@kernel.org>, <ntfs3@lists.linux.dev>, <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v4 8/8] ceph: Remove S_ISGID clear code in ceph_finish_async_create
Date:   Tue, 19 Apr 2022 19:47:14 +0800
Message-ID: <1650368834-2420-8-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1650368834-2420-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1650368834-2420-1-git-send-email-xuyang2018.jy@fujitsu.com>
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

Since vfs has stripped S_ISGID in the previous patch, the calltrace
as below:

vfs:	lookup_open
	...
	  if (open_flag & O_CREAT) {
                if (open_flag & O_EXCL)
                        open_flag &= ~O_TRUNC;
                prepare_mode(mnt_userns, dir->d_inode, &mode);
	...
	   dir_inode->i_op->atomic_open

ceph:	ceph_atomic_open
	...
	      if (flags & O_CREAT)
            		ceph_finish_async_create

We have stripped sgid and umask in prepare mode, so remove this useless
code here.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 fs/ceph/file.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 6c9e837aa1d3..8e3b99853333 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -651,10 +651,6 @@ static int ceph_finish_async_create(struct inode *dir, struct dentry *dentry,
 		/* Directories always inherit the setgid bit. */
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
-		else if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP) &&
-			 !in_group_p(dir->i_gid) &&
-			 !capable_wrt_inode_uidgid(&init_user_ns, dir, CAP_FSETID))
-			mode &= ~S_ISGID;
 	} else {
 		in.gid = cpu_to_le32(from_kgid(&init_user_ns, current_fsgid()));
 	}
-- 
2.27.0

