Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CC150067A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 08:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240182AbiDNG7t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Apr 2022 02:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239661AbiDNG7s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Apr 2022 02:59:48 -0400
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com [85.158.142.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EF4541AB;
        Wed, 13 Apr 2022 23:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1649919442; i=@fujitsu.com;
        bh=2BEBt+KtqG1w23kjA03oL0N4j7CMYSd/9MBWpZADdAw=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=iwSsDcpvAvkjUEu64lNDvisMQWbNpRIiqVDmoINWJgHiFAmbWxl/p2P6McLBslCpX
         RAsKK6q2qBPEKXHYgs+sk4iVTRTvXxtX8WMY5etCjrKoA5ig8pK32FDjwJn4BDSxAD
         4Ip2yRsrWRzu0lfRrOK1jhodvPBHx4WeRjBaagVEcnDV3HtLv6ZkrUlkhty7hNhlWx
         2KT/pkYv1Vuj31v/ou+vJmTY77rOLlHgnYTAW7L1xSBp9W6RklHNzx5W+H5W+g429h
         g4QbknfTmyzY5uRxT5v94SXJtoWGaPoU/S43i7m4Sj+SOnS6RMbFeCaYhJsTwJHanU
         2xHprd+akkj9g==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleJIrShJLcpLzFFi42Kxs+FI1L14NDz
  JYOJiS4vXhz8xWny4OYnJYsuxe4wWl5/wWfxctordYs/ekywWu96cY7c4//c4qwOHx6lFEh6b
  VnWyeVxY9obN4/MmOY9NT94yBbBGsWbmJeVXJLBmnOo8yVbQy1bx8MBFlgbGXtYuRi4OIYEtj
  BLzf09mhnAWMElcWrWJCcLZwyhx4vt8oAwnB5uApsSzzgVgtohAgsTrW4vBOpgF5jBKPD5xmw
  0kISwQLDGr/RRQNwcHi4CqxNI3PCBhXgEPic2f1oCVSAgoSEx5+B5sDqeAp0Tf7ruMILYQUM3
  2S3+ZIOoFJU7OfMICYjMLSEgcfPGCGaJXUeJSxzdGCLtCYtasNiYIW03i6rlNzBMYBWchaZ+F
  pH0BI9MqRrukosz0jJLcxMwcXUMDA11DQ1NdMzNdQwszvcQq3US91FLd5NS8kqJEoLReYnmxX
  mpxsV5xZW5yTopeXmrJJkZg3KQUO+3awXiw76feIUZJDiYlUd4mYEQJ8SXlp1RmJBZnxBeV5q
  QWH2KU4eBQkuD9fwQoJ1iUmp5akZaZA4xhmLQEB4+SCK8fSCtvcUFibnFmOkTqFKOilDjvapA
  +AZBERmkeXBssbVxilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMx7AWQKT2ZeCdz0V0CLmYAW
  f1sVCrK4JBEhJdXAFF7+6MOM3Kx2p2vzdJpkuf7ILtmSvVd1ruZWDu4Iiy0h+vaMp0tFt655w
  pV3dMYzj+mBNzcuSQtzrlpu+fjbGdeHh1t4ZVs9bERuiSZLTg+U1bLdYLxkte+xcK2uuD+TBW
  QerC9a8aueXVVzUbyocmPjB0tDF8Y3BfopLd/8k+W14972M0y4f2nZ9Ed3zvzQM1h/8bHxPx9
  j96pjpSm1MuFOL+VaLKbkL3++8EiryFW3o1nnl06qPjHlq//7ZctUQzfMm2Ar4+3cK/XfUEaW
  tYTxioeU3rVck0CzeXbnLd81bj/qvVas8+yeoNsn5aq4rddv/N8SsdxsBov63f0O/m/ZDiyUf
  CTYKfx1jYyxEktxRqKhFnNRcSIA27pvNpYDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-23.tower-532.messagelabs.com!1649919441!33213!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17612 invoked from network); 14 Apr 2022 06:57:21 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-23.tower-532.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 14 Apr 2022 06:57:21 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 61CB6100199;
        Thu, 14 Apr 2022 07:57:21 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 54D7D100181;
        Thu, 14 Apr 2022 07:57:21 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 14 Apr 2022 07:56:53 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>,
        <ocfs2-devel@oss.oracle.com>
CC:     <viro@zeniv.linux.org.uk>, <david@fromorbit.com>,
        <brauner@kernel.org>, <djwong@kernel.org>, <jlayton@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v2 3/3] ceph: Remove S_ISGID clear code in ceph_finish_async_create
Date:   Thu, 14 Apr 2022 15:57:19 +0800
Message-ID: <1649923039-2273-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1649923039-2273-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1649923039-2273-1-git-send-email-xuyang2018.jy@fujitsu.com>
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

