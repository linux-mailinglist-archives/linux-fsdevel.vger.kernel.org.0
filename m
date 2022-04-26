Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC4450FA8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 12:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348889AbiDZKeX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 06:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349070AbiDZKdh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:33:37 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FFFCA0CF;
        Tue, 26 Apr 2022 03:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1650967873; i=@fujitsu.com;
        bh=AmdaMYwdMPjs5w7+yq5w0jM1iN47ZxSrdRA++43KWF0=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=vlGgzz8PK+ffYzUO1U3DrA+7wry3AKiSGGUvtJFR0ihAQwrKWcSVT/JZi1rpbjsx6
         +FjaWArD9wvDct6SFHB1AaAy3IZCWdS07/iefHja1RDAYVh6LcLyYxQSRJZFkRScx2
         Gb66BRSlkAcdtrcXWm6V02iG6JcppYs4YgTCg6t+nap89sy73NT7lc1z9AoEFGjzJL
         ugT+38QYneEafy0CCE8RNLzYDDzzegkRgs9Vk/xvqhl4CNjxbAoxwOuI5gs/HgriNI
         P623aDxzxlhoKXzaMd1L5C8Ta83V3aIU0yhcnTvYq5dKsxiaORcqxG72DRj3FRuHUw
         Vvfr1ulDlojXQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleJIrShJLcpLzFFi42Kxs+GYpOt4ND3
  J4E8rl8Xrw58YLT7cnMRkseXYPUaLy0/4LH4uW8VusWfvSRaL83+Ps1r8/jGHzYHD49QiCY/N
  K7Q8Nq3qZPP4vEnOY9OTt0wBrFGsmXlJ+RUJrBkLjm9jLejgqJh8+TJTA+Mrti5GLg4hgS2ME
  nOeTWCGcBYwSayZ+IEJwtnDKHFnzz2gDCcHm4CmxLPOBWC2iICjxIv2GSwgNrPAZkaJZY/DQW
  xhATuJm7Ma2EFsFgFVie+rz4HV8Ap4SJx+dRysV0JAQWLKw/dgNqeAp8Tb/imMILYQUM2t5X1
  MEPWCEidnPoGaLyFx8MULqF5FiUsd3xgh7AqJWbPamCBsNYmr5zYxT2AUnIWkfRaS9gWMTKsY
  rZOKMtMzSnITM3N0DQ0MdA0NTXWNTXUNLUz0Eqt0E/VSS3XLU4tLdI30EsuL9VKLi/WKK3OTc
  1L08lJLNjEC4yWlWHnHDsa2VT/1DjFKcjApifLq7EtPEuJLyk+pzEgszogvKs1JLT7EKMPBoS
  TBG3gIKCdYlJqeWpGWmQOMXZi0BAePkgjv28NAad7igsTc4sx0iNQpRl2Op89P7GUWYsnLz0u
  VEuddvheoSACkKKM0D24ELI1cYpSVEuZlZGBgEOIpSC3KzSxBlX/FKM7BqCQMsYonM68EbtMr
  oCOYgI74VJsKckRJIkJKqoHJY+vBnprk2Qq5rJrTdiuw71394p5ZxeWga45b/J95LvV5wJp6b
  r6m1xMbLeadX3fWasgLJE75uKfM2+TWgbvXWKaXT9iuX6Q55+hSw1TlR2eKJAWncyuePKTd/X
  RB3DUJq4Vblv06eGpB7ulHzMd2xKW9ORb48oD1vV+XmmfGsLB5BR8qE3u1OOdh5OFvVyVCXMO
  W3lr1JLRFeUa0c8/qaQY3jVav3e7Y02VwY+njimZmFzuvCXWrCk+6Ckk/2r6zLaR3s6i78IY5
  k3780jzpNltVs/r44n8qUflXZ3D9zvnzROeBh9XUaXcmzckwnHi3lI09av5Lzp02Z7hyZ7Dee
  1DZmyTF9NZ1UZTgqiTZ9UosxRmJhlrMRcWJALzRAESeAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-6.tower-571.messagelabs.com!1650967872!244513!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11979 invoked from network); 26 Apr 2022 10:11:13 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-6.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 26 Apr 2022 10:11:13 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id BA15C10046D;
        Tue, 26 Apr 2022 11:11:12 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 9FA95100466;
        Tue, 26 Apr 2022 11:11:12 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 26 Apr 2022 11:11:01 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <david@fromorbit.com>,
        <djwong@kernel.org>, <brauner@kernel.org>, <willy@infradead.org>,
        <jlayton@kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v8 4/4] ceph: rely on vfs for setgid stripping
Date:   Tue, 26 Apr 2022 19:11:30 +0800
Message-ID: <1650971490-4532-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1650971490-4532-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1650971490-4532-1-git-send-email-xuyang2018.jy@fujitsu.com>
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

Now that we finished moving setgid stripping for regular files in setgid
directories into the vfs, individual filesystem don't need to manually
strip the setgid bit anymore. Drop the now unneeded code from ceph.

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

