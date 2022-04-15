Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2085027F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 12:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352100AbiDOKHT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 06:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbiDOKHS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:07:18 -0400
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com [85.158.142.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E5B9FCB;
        Fri, 15 Apr 2022 03:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1650017083; i=@fujitsu.com;
        bh=2BEBt+KtqG1w23kjA03oL0N4j7CMYSd/9MBWpZADdAw=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=bW3TaDdV0Lz8DzgF0QxGg1uM2d1wZG8DuvE3UVTnNFOCzRUeV0eDd502znGoRedpd
         TxpYEclkcTimdkKEyO8CddXIKpHyB23+e0JLMbm9E/ft4soDZEtXQclB4/9k5XwVWw
         RqgpAPLfEEbzR72sWCWxUQ3stdFeZEnfUtESjkIVT7fl/ht9rGDo+pOGWdP7Pf0deU
         GnZWBYVOoy7c7IfbiqCXxKd2xhDHk6n0DIxQ3bhjQG9mkq+HM3hT+ScW24Kmz2JgxT
         JoISNSb6q6ZWt8kLW1axzLUNJB2S476DYA/+5BuMCXRuRiFYgpd2ttTqfrcumKRInk
         rXAiUQm3QsEqQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleJIrShJLcpLzFFi42Kxs+GYpGvtHJl
  k8KaT0+L14U+MFh9uTmKy2HLsHqPF5Sd8Fj+XrWK32LP3JIvFhQOnWS12/dnBbnH+73FWB06P
  U4skPDat6mTz+LxJzmPTk7dMASxRrJl5SfkVCawZpzpPshX0slU8PHCRpYGxl7WLkYtDSGALo
  8Sh+3sZIZwFTBLfPl1m6WLkBHL2MEp8ORIJYrMJaEo861zADGKLCLhILJywHqyBWeAKo8T19j
  lgCWGBYIkp+1vBmlkEVCV6dkwDinNw8Ap4SrzrFAQJSwgoSEx5+B4szCngJfH/bC3EKk+JqZM
  us4HYvAKCEidnPgGbwiwgIXHwxQtmiFZFiUsd3xgh7AqJWbPamCBsNYmr5zYxT2AUnIWkfRaS
  9gWMTKsYbZOKMtMzSnITM3N0DQ0MdA0NTXXNLHWNjfUSq3QT9VJLdZNT80qKEoGyeonlxXqpx
  cV6xZW5yTkpenmpJZsYgRGTUuyquIPxWt9PvUOMkhxMSqK8b0Ujk4T4kvJTKjMSizPii0pzUo
  sPMcpwcChJ8P61B8oJFqWmp1akZeYAoxcmLcHBoyTCG2oNlOYtLkjMLc5Mh0idYlSUEucVdgJ
  KCIAkMkrz4NpgCeMSo6yUMC8jAwODEE9BalFuZgmq/CtGcQ5GJWFeY5ApPJl5JXDTXwEtZgJa
  /G1VKMjikkSElFQDk6KRdNR0Ld5fVzKaPO8Xm3fILncRsAuPy9j9xljL8cJ+7d2qLy3+vt2c8
  rC0ReTm/UcVUjdfve4UMra+HCDwfZrrp1+f9gs45K/+trPFw9Wt2PPa2TYFx+XP776WmviltK
  xa0PBvVtqV77MvSl5tWia85ryOWcHFAxsZJlqJfSj6Ifyg0mQ/c8WdinUVcVtneOR1Ni1wdDp
  z6p+WzPJlr2SDk1pFDCsP5n8LlN47+/Fx3/e7bI7WJbPNvy9zTevTVsXGlQ+vnDSe8HbSbWG5
  /P4fHmmPJm14wexfeiGvMfTfbQmjH1rli4OLs5peSly4Fnr4k158ZM9XU0v/VTnzWG9tfuPra
  HFIPH9y7knWE0osxRmJhlrMRcWJAPSKhAmTAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-12.tower-528.messagelabs.com!1650017082!67435!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4420 invoked from network); 15 Apr 2022 10:04:43 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-12.tower-528.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 15 Apr 2022 10:04:43 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 9E27110047A;
        Fri, 15 Apr 2022 11:04:42 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 919E2100467;
        Fri, 15 Apr 2022 11:04:42 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 15 Apr 2022 11:04:18 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <david@fromorbit.com>, <djwong@kernel.org>, <brauner@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>,
        <linux-nfs@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <viro@zeniv.linux.org.uk>, <jlayton@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v3 7/7] ceph: Remove S_ISGID clear code in ceph_finish_async_create
Date:   Fri, 15 Apr 2022 19:02:23 +0800
Message-ID: <1650020543-24908-7-git-send-email-xuyang2018.jy@fujitsu.com>
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

Since vfs has stripped S_ISGID, we don't need this code any more.

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

