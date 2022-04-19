Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7140D5068FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 12:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350749AbiDSKtZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 06:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350709AbiDSKtX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:49:23 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678281AF3D;
        Tue, 19 Apr 2022 03:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1650365198; i=@fujitsu.com;
        bh=ThqRNMVwN/gYuY+yP+qvGKhzoByHtom9pEJS+r8beCs=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=vq8WP8thCOyj7/cit9HcuzsuLaT7Dp6E5Mv4/k+4VpBVKwZ+PCFbO1n22gGwIZRic
         3EAXsuarx08FUb0aINwGjz+22QYqoIuaUmw1QiPfti+TAXN1G6iFNAfIyJFCkigljO
         xn7l4T/en7G07NbJi02RIWMWCjQIRzzS6bOpdqvKAyF+fUO0zthclHY/BOOVDw1QSX
         ybR9WRgQSa8SiryYEkeITq5n1nx+qwApuRusn2WBc32fhodUWClDYP1QWLKM4F14uD
         BKL5+xsiaO+2hwE4bEmtk1PvBs8RdxvEk/W3kbPBiNZHqhiCO3vXptGirx8uSz8omq
         G/P5MzBSVyhnw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRWlGSWpSXmKPExsViZ8MxSZd3cly
  Swd+txhavD39itPhwcxKTxempZ5ksthy7x2hx+Qmfxc9lq9gtLi1yt9iz9ySLxYUDp1ktdv3Z
  wW6x8vFWJovzf4+zOvB4nFok4bFpVSebx4vNMxk9di/4zOTxeZOcx6Ynb5kC2KJYM/OS8isSW
  DMe7lnLWPCRveLv/ZVsDYz32boYuTiEBLYwSuxa84gdwlnAJNE2eyeUs4dRYsnLt6xdjJwcbA
  KaEs86FzCD2CICyhILbhwDa2cWOMMkcenaEkaQhLCAk8SeBz3sIDaLgKrE0vcvWUBsXgEPiYl
  t28FqJAQUJKY8fA82iFPAU2Lj2/dgNUJANdcPb2GGqBeUODnzCVicWUBC4uCLF8wQvYoSlzq+
  Qc2pkJg1q40JwlaTuHpuE/MERsFZSNpnIWlfwMi0itEqqSgzPaMkNzEzR9fQwEDX0NBU10DXy
  NBUL7FKN1EvtVS3PLW4RNdQL7G8WC+1uFivuDI3OSdFLy+1ZBMjMMJSihmu72Cc2PdT7xCjJA
  eTkihvfVRckhBfUn5KZUZicUZ8UWlOavEhRhkODiUJ3tIJQDnBotT01Iq0zBxgtMOkJTh4lER
  4J/cDpXmLCxJzizPTIVKnGBWlxHnFWoASAiCJjNI8uDZYgrnEKCslzMvIwMAgxFOQWpSbWYIq
  /4pRnINRSZi3aSLQFJ7MvBK46a+AFjMBLa6eEguyuCQRISXVwHTiO/fzlm8l4Ve61jFftdvQL
  H6qR4J1SlY+g3qsSveUrUb6gWJtiVaWcadEZHY839Z2wldx++X+5U/EHKymHs6ryzBNMPnH9r
  z8mDDT+vnaX0Vm92wNiOnU+i/+at70zEPhD+daG9it+T3tjAqHa5fwXhX2HXkOwvlHyuYffLV
  TsCrITLfmYWH5uS0Xll7uUH0/I70gL2vbVOVaK3v3RxzWPf/3JMTHrOiLbF7/TSHf4J7QRscj
  uRKdG9qCz6+9l1jRc4pDUuPYhQ7nS8I7q76wCU++GuX1Mlr+3sVfPxZaMTzwFU7XO60uZKyar
  PI2VORSXzGTeFzI38YX3RuTNDfmRx2NXny/p1bLmX+tEktxRqKhFnNRcSIA0R2Z56sDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-16.tower-591.messagelabs.com!1650365197!273701!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13109 invoked from network); 19 Apr 2022 10:46:37 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-16.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 19 Apr 2022 10:46:37 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 4DBA01000F5;
        Tue, 19 Apr 2022 11:46:37 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 21AF3100459;
        Tue, 19 Apr 2022 11:46:37 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 19 Apr 2022 11:46:25 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <ceph-devel@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
        <david@fromorbit.com>, <djwong@kernel.org>, <brauner@kernel.org>,
        <jlayton@kernel.org>, <ntfs3@lists.linux.dev>, <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v4 2/8] fs: Add missing umask strip in vfs_tmpfile
Date:   Tue, 19 Apr 2022 19:47:08 +0800
Message-ID: <1650368834-2420-2-git-send-email-xuyang2018.jy@fujitsu.com>
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

All creation paths except for O_TMPFILE handle umask in the vfs directly
if the filesystem doesn't support or enable POSIX ACLs. If the filesystem
does then umask handling is deferred until posix_acl_create().
Because, O_TMPFILE misses umask handling in the vfs it will not honor
umask settings. Fix this by adding the missing umask handling.

Reported-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 fs/namei.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 509657fdf4f5..73646e28fae0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3521,6 +3521,8 @@ struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
 	child = d_alloc(dentry, &slash_name);
 	if (unlikely(!child))
 		goto out_err;
+	if (!IS_POSIXACL(dir))
+		mode &= ~current_umask();
 	error = dir->i_op->tmpfile(mnt_userns, dir, child, mode);
 	if (error)
 		goto out_err;
-- 
2.27.0

