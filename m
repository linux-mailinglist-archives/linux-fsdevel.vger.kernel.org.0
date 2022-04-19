Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E3050690D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 12:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbiDSKum (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 06:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348948AbiDSKul (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:50:41 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847BF1D338;
        Tue, 19 Apr 2022 03:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1650365276; i=@fujitsu.com;
        bh=5OQ/Hq2ZgIjiCcAVb/a2oNQEva6kfuXLNoiXM0nDZ3Q=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=r5MwFFr2WWDUk61GLUsbh5JTCIZEpkXCpaJ0qL62tSpTmwYBZB3XSBbPLvbOAg1rb
         ekxsFqL3U5xO9+rhi+xB9/1RqcWvX+tWWGQlXYermRWYV9uNMspMm8HenLhwSVjosG
         GGnksgt32LTuoCdY9GLut+vKZ5dXMTIx+RaSvtB3/GygRywhno2b9myLkVGaXQFFS0
         bDU8Dgt14SkkVZsyuXPyVv3NeuyF5Ru9FURWhU9YIoh0XrzOxfzaWD58XJIpA50QGI
         1ZgoRicAz1G0WPtkwvL5eZi3nzzdAAcb1qhsJO95T+HcOVWKSW1aPxjCB6GFCsTYKL
         fpw4KTbmFgPrQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRWlGSWpSXmKPExsViZ8MxSTdmcly
  SwZUjQhavD39itPhwcxKTxempZ5ksthy7x2hx+Qmfxc9lq9gtLi1yt9iz9ySLxYUDp1ktdv3Z
  wW6x8vFWJovzf4+zOvB4nFok4bFpVSebx4vNMxk9di/4zOTxeZOcx6Ynb5kC2KJYM/OS8isSW
  DMaLy9hLFjHVrHz1DvWBsYNrF2MXBxCAlsYJd62rGTqYuQEchYwSZx4zAmR2MMo0Xz8JCNIgk
  1AU+JZ5wJmEFtEQFliwY1jbCBFzAJnmCQuXVsCVMTBISwQJvHoRgJIDYuAqsT3ex/BenkFPCR
  eLj4ItkBCQEFiysP3YHM4BTwlNr59zwKx2EPi+uEtzBD1ghInZz4BizMLSEgcfPGCGaJXUeJS
  xzdGCLtCYtasNqiZahJXz21insAoOAtJ+ywk7QsYmVYxWiUVZaZnlOQmZuboGhoY6Boamuqa6
  RqaWeolVukm6qWW6panFpfoGuollhfrpRYX6xVX5ibnpOjlpZZsYgRGV0ox28odjCv7fuodYp
  TkYFIS5a2PiksS4kvKT6nMSCzOiC8qzUktPsQow8GhJMFbOgEoJ1iUmp5akZaZA4x0mLQEB4+
  SCO/kfqA0b3FBYm5xZjpE6hSjopQ4r1gLUEIAJJFRmgfXBksulxhlpYR5GRkYGIR4ClKLcjNL
  UOVfMYpzMCoJ8xZNAprCk5lXAjf9FdBiJqDF1VNiQRaXJCKkpBqYLFj3Llz8jqd68sIG94ZpM
  15fWW7Eou4xU1kpcq75wjB7Zfkks62rOiNWL9efYfNgjUNRh1dUpgZLaOO1a6334l/zv9Scuu
  e9XUmO1YpbooUHzdMiXymlznizc9nXgIRkYeuokKUtL/XEYi1XXmB0jCr5y/2Vfdud97dFF1b
  8vCp4fpWQoLf0ksV/RS7PT7PiK3TPqFgW56K3K7/8+IkaFuXLKzy4A+SX9T9Km3D0guD1OV92
  HnCLiOw6Imnr/W37r/BDlakXlyUvW6jy20omjW+hyS2vY3xTZYIvXz+zVf6t7U+jOLd3h7pdm
  GfVv5bck7RtpZCPC1MD50/jZsdNPLtNmJqXl+wunKo3u+63EktxRqKhFnNRcSIA4mPkI6kDAA
  A=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-13.tower-587.messagelabs.com!1650365275!269614!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9211 invoked from network); 19 Apr 2022 10:47:56 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-13.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 19 Apr 2022 10:47:56 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id BABB7100460;
        Tue, 19 Apr 2022 11:47:55 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id AB4B1100459;
        Tue, 19 Apr 2022 11:47:55 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 19 Apr 2022 11:47:35 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <ceph-devel@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
        <david@fromorbit.com>, <djwong@kernel.org>, <brauner@kernel.org>,
        <jlayton@kernel.org>, <ntfs3@lists.linux.dev>, <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v4 5/8] f2fs: Remove useless NULL assign value for acl and default_acl
Date:   Tue, 19 Apr 2022 19:47:11 +0800
Message-ID: <1650368834-2420-5-git-send-email-xuyang2018.jy@fujitsu.com>
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

Like other use ${fs}_init_acl and posix_acl_create filesystem, we don't
need to assign NULL for acl and default_acl pointer because f2fs_acl_create
will do this job. So remove it.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 fs/f2fs/acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index eaa240b21f07..9ae2d2fec58b 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -412,7 +412,7 @@ static int f2fs_acl_create(struct inode *dir, umode_t *mode,
 int f2fs_init_acl(struct inode *inode, struct inode *dir, struct page *ipage,
 							struct page *dpage)
 {
-	struct posix_acl *default_acl = NULL, *acl = NULL;
+	struct posix_acl *default_acl, *acl;
 	int error;
 
 	error = f2fs_acl_create(dir, &inode->i_mode, &default_acl, &acl, dpage);
-- 
2.27.0

