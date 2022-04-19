Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6161E506911
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 12:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350776AbiDSKvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 06:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238369AbiDSKvX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:51:23 -0400
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com [85.158.142.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACB11CB33;
        Tue, 19 Apr 2022 03:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1650365319; i=@fujitsu.com;
        bh=L0gnk54iyGfM60Qjlex0JGvplvmF+grDZIqDPCSoCAQ=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Vbslnnvp7hIfI/TZE7tXKJR3U/OhVVDHi8Nw9ysK8O4YO+PvAYCM18PJZ8HA6Kdn+
         If51cY2Pw67flEgu2vdqdfOuq6cIybAAHtJkSAYZuBAPQMHMOLGGnlngMMZpsJqLMG
         gXrHPgh5XGU7xDzAlXBS8nwzW8RQ0zedJ/9gvroDF2o2StoYVv7u1NE3nb/MXgDyW7
         CO+qyFNdGjE0n4e4zXgA7jAOK/gxO7FifSPWONtuauFRyD3sIRbm+vn4YcuBc/zJUy
         DMOdO/0dLYpCdr8Yk9zIFp1GMZoC4qjqMAKA2xW34Ynwc22w2a54Ki68f5Tc61RVmg
         KnM9N9407wX5w==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleJIrShJLcpLzFFi42Kxs+GYots2OS7
  JYN4MVYvXhz8xWny4OYnJ4vTUs0wWW47dY7S4/ITP4ueyVewWlxa5W+zZe5LF4sKB06wWu/7s
  YLdY+Xgrk8X5v8dZHXg8Ti2S8Ni0qpPN48XmmYweuxd8ZvL4vEnOY9OTt0wBbFGsmXlJ+RUJr
  BlzfxUXvOCuODJlLmsDYytHFyMXh5DAa0aJaTNvMkE4exglun52MXcxcnKwCWhKPOtcAGaLCC
  hLLLhxjA3EZhb4wCQx8WAViC0sECFx/dkpsBoWAVWJN91P2EFsXgEPiTVbnjOB2BICChJTHr4
  Hq+EU8JTY+PY9C4gtBFRz/fAWZoh6QYmTM5+wQMyXkDj44gUzRK+ixKWOb4wQdoXErFltTBMY
  +WchaZmFpGUBI9MqRtukosz0jJLcxMwcXUMDA11DQ1NdMwtdIxO9xCrdRL3UUt3k1LySokSgr
  F5iebFeanGxXnFlbnJOil5easkmRmDEpBS7SOxgvNn3U+8QoyQHk5Iob31UXJIQX1J+SmVGYn
  FGfFFpTmrxIUYZDg4lCd7SCUA5waLU9NSKtMwcYPTCpCU4eJREeCf3A6V5iwsSc4sz0yFSpxh
  1OSb9ubaXWYglLz8vVUqcV6wFqEgApCijNA9uBCyRXGKUlRLmZWRgYBDiKUgtys0sQZV/xSjO
  wagkzLtxEtAUnsy8ErhNr4COYAI6onpKLMgRJYkIKakGpk06k238rWeF92iIH7bWTr1z9T+Lg
  b5E30Pf04c5889ZvDvQ4VFQ2H2jf/Oca5u8kh3F0zoW/QzM2Z+woPW276IZV0pnRu942+2fnM
  itYzh17m2Twgbjk6nCpj2h5mdE76lsX+jA+lP5d9aL/UXsjIfaeCcpqF+OEHwZwrp9+03OLes
  mnZl8gn/Ppb9vo68/mHqp+PKZtSzKiuWKvkL1JcJOSV82dL0TPbCdb+P8Dzxcgh72suKNThlu
  G5Zrs60236H6M8vy1aW4jqWuq+dusG/pm7J91Uv5nsSJPFsFlQ1+2XOIf79SNyHU+oLqro2PX
  Nie986TfyMys/buTfnrj73dzF5xtVZa7zhdGaH5RImlOCPRUIu5qDgRAJF7efCfAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-25.tower-545.messagelabs.com!1650365318!270565!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14526 invoked from network); 19 Apr 2022 10:48:38 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
  by server-25.tower-545.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 19 Apr 2022 10:48:38 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 23JAmcLA004855
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 19 Apr 2022 11:48:38 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 19 Apr 2022 11:48:32 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <ceph-devel@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
        <david@fromorbit.com>, <djwong@kernel.org>, <brauner@kernel.org>,
        <jlayton@kernel.org>, <ntfs3@lists.linux.dev>, <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v4 6/8] ntfs3: Use the same order for acl pointer check in ntfs_init_acl
Date:   Tue, 19 Apr 2022 19:47:12 +0800
Message-ID: <1650368834-2420-6-git-send-email-xuyang2018.jy@fujitsu.com>
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

Like ext4 and other use ${fs}_init_acl filesystem, they all used the following
style

       error = posix_acl_create(dir, &inode->i_mode, &default_acl, &acl);
       if (error)
                return error;

        if (default_acl) {
                error = __ext4_set_acl(handle, inode, ACL_TYPE_DEFAULT,
                                       default_acl, XATTR_CREATE);
                posix_acl_release(default_acl);
        } else {
                inode->i_default_acl = NULL;
        }
        if (acl) {
                if (!error)
                        error = __ext4_set_acl(handle, inode, ACL_TYPE_ACCESS,
                                               acl, XATTR_CREATE);
                posix_acl_release(acl);
        } else {
                inode->i_acl = NULL;
        }
	...

So for the readability and unity of the code, adjust this order.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 fs/ntfs3/xattr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index afd0ddad826f..64cefa869a61 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -642,13 +642,13 @@ int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		inode->i_default_acl = NULL;
 	}
 
-	if (!acl)
-		inode->i_acl = NULL;
-	else {
+	if (acl) {
 		if (!err)
 			err = ntfs_set_acl_ex(mnt_userns, inode, acl,
 					      ACL_TYPE_ACCESS);
 		posix_acl_release(acl);
+	} else {
+		inode->i_acl = NULL;
 	}
 
 	return err;
-- 
2.27.0

