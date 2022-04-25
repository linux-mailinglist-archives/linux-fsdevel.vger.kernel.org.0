Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43A650D6DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 04:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240290AbiDYCNG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Apr 2022 22:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240351AbiDYCMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Apr 2022 22:12:51 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE542980B;
        Sun, 24 Apr 2022 19:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1650852587; i=@fujitsu.com;
        bh=c5FCpwWbwNZnqJjma6yo9VosB0Dzi2MqAMD84YLxtik=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=HT2GkfBb5ARGC/yOfCN/H3kYyu3MhPrqCth/YvTncsD73iOvgTrvfEjJtZIerN7RB
         /Af8L4QEQHcUh9AOYS9R5nBi1q7P3rmU/c8LQXP7jyZjTnR+K45skttRidLab7J47c
         nzOPA1OW7lGCtOOQOremcQJ0wyzbF6pinlaQ/5rzgJ7UQ2LMUjmbgIG+0bYLiek4OG
         u/ozDswlOKy18QGH6qbw2/NG4qVUmwZn6keIvAlyE4CIr+rlkoNFsaKfffOLejXAsu
         W96q8QYADpht1nuPle9wDBoPOh5C4sMjuQINt3iVcbywgFnxlcwr7HUFoGoHOjuJG2
         JnRThXbfoOVmg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleJIrShJLcpLzFFi42Kxs+FI1H3KlJZ
  k8OaCmcXrw58YLT7cnMRkseXYPUaLy0/4LH4uW8VusWfvSRaL83+Ps1r8/jGHzYHD49QiCY/N
  K7Q8Nq3qZPP4vEnOY9OTt0wBrFGsmXlJ+RUJrBk9CxazFWxlr9izvpW1gXEZWxcjF4eQwBZGi
  VcLV7FCOAuYJDb8nMcE4exhlHg8ZR1QhpODTUBT4lnnAmYQW0TAUeJF+wwWEJtZYDOjxLLH4S
  C2sEC4xOTj39m7GDk4WARUJe48SwIJ8wp4Sqy/+JwRxJYQUJCY8vA92BhOAS+JaytOsoHYQkA
  1f3c+Y4KoF5Q4OfMJ1HgJiYMvXjBD9CpKXOr4BjWnQmLWrDYmCFtN4uq5TcwTGAVnIWmfhaR9
  ASPTKkarpKLM9IyS3MTMHF1DAwNdQ0NTXVNdI1NTvcQq3US91FLd8tTiEl1DvcTyYr3U4mK94
  src5JwUvbzUkk2MwFhJKWb9v4Oxu++n3iFGSQ4mJVHeDMa0JCG+pPyUyozE4oz4otKc1OJDjD
  IcHEoSvBdBcoJFqempFWmZOcC4hUlLcPAoifD++JGaJMRbXJCYW5yZDpE6xajL8fT5ib3MQix
  5+XmpUuK8G0BmCIAUZZTmwY2ApZBLjLJSwryMDAwMQjwFqUW5mSWo8q8YxTkYlYR5P4NM4cnM
  K4Hb9AroCCagIz7Vgh1RkoiQkmpgMngafMLTtufKLtlbHWVsXIHiKy1mWzjMf2dexrjRqiVkh
  /bHM3/YrLIMrtw9tvHBqqq4J9U5n+1OTnyYeJnn+sfotYGXL3oF7b69hWXj07d2KXdfTb8is3
  hyWHrNFpd3e/72TuvOnlK1tilk4wOHhBYxnZ/e6mdcm1O+v5jI+O4kl79v5LQeq0JFsV9Cq6K
  XLHReeHrps3/rJMJO7o/b0nJv+sEfPZMO2IZr/XLvnvT6yg37Vdlm01xbb0c0FgjtnvHD7ahV
  tVd+EZOmPn/XpoSNW85mhc9VeDFFa/JhgWT/+j6VHifT3v6lbO4KXZ2/2PUFvhpsOnPDKO4I1
  63dEgKzw/lFzwi2e8TkxBu7KLEUZyQaajEXFScCAH/rVhicAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-18.tower-591.messagelabs.com!1650852581!113011!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14581 invoked from network); 25 Apr 2022 02:09:41 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-18.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Apr 2022 02:09:41 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 5E776100193;
        Mon, 25 Apr 2022 03:09:41 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 4248310018F;
        Mon, 25 Apr 2022 03:09:41 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 25 Apr 2022 03:09:14 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <david@fromorbit.com>,
        <djwong@kernel.org>, <brauner@kernel.org>, <willy@infradead.org>,
        <jlayton@kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v6 4/4] ceph: Remove S_ISGID stripping code in ceph_finish_async_create
Date:   Mon, 25 Apr 2022 11:09:41 +0800
Message-ID: <1650856181-21350-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1650856181-21350-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1650856181-21350-1-git-send-email-xuyang2018.jy@fujitsu.com>
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

Previous patches moved sgid stripping exclusively into the vfs. So
manual sgid stripping by the filesystem isn't needed anymore.

Reviewed-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Christian Brauner (Microsoft)<brauner@kernel.org>
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

