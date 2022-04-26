Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D87550EF21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 05:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242952AbiDZDWx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 23:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240250AbiDZDWr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 23:22:47 -0400
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com [85.158.142.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8EC939BC;
        Mon, 25 Apr 2022 20:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1650943179; i=@fujitsu.com;
        bh=c5FCpwWbwNZnqJjma6yo9VosB0Dzi2MqAMD84YLxtik=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=fUXBqVyEvw/5IispoMnJ1mjZEEqWRIQQeu7OyjUoadguRMM1XKYIRmfXke8qkFPiy
         btgwT+2QHUwHziBNmlE1NN6nj3EnSNUEEvxwcsuqzeG7dQLzzCYb7l4cDIi+CQP/fg
         7A8mO+AvD6SJ+R/WcUNj0bDcTbNrFop9A4ZUE15tYc4ubDJ0AYJUCJJGwaps51WAR/
         x6DphjzhiCoayBaKBSVXz3oXBXzxIiIZ0toQFkkZFhwq4YoTorqFzegpIyYcVcsbF9
         2noE9aIocBUHl+kopsFr04oKGAYecEwBWMgk0JE78v1yhjYx5NGOM7kwTC6W5yItso
         gstZTnoOPPfsQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRWlGSWpSXmKPExsViZ8MxRfdUSnq
  SQcNDDovXhz8xWny4OYnJYsuxe4wWl5/wWfxctordYs/ekywW5/8eZ7X4/WMOmwOHx6lFEh6b
  V2h5bFrVyebxeZOcx6Ynb5kCWKNYM/OS8isSWDN6FixmK9jKXrFnfStrA+Myti5GLg4hgdeME
  ptu3WeBcPYwSnz6spW5i5GTg01AU+JZ5wIwW0TAUeJF+wywImaBQ4wS9w91gSWEBcIlZnavYQ
  KxWQRUJdbc6QGzeQU8JLZ962cHsSUEFCSmPHwPVs8p4Cnx63g7G4gtBFSzYuksRoh6QYmTM5+
  wgNjMAhISB1+8YIboVZS41PGNEcKukJg1q41pAiP/LCQts5C0LGBkWsVol1SUmZ5RkpuYmaNr
  aGCga2hoqmtmqWtoaaqXWKWbqJdaqpucmldSlAiU1kssL9ZLLS7WK67MTc5J0ctLLdnECIyCl
  GLXwzsYd/f91DvEKMnBpCTKuyUpPUmILyk/pTIjsTgjvqg0J7X4EKMMB4eSBC8rSE6wKDU9tS
  ItMwcYkTBpCQ4eJRHeMpA0b3FBYm5xZjpE6hSjLsfT5yf2Mgux5OXnpUqJ87oA41tIAKQoozQ
  PbgQsOVxilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJAwxhSczrwRu0yugI5iAjvhUmwpyREki
  QkqqgUnZWPOn2/mKRy3mueeSnrRqs5oIz7/APp3DdMVuIZsv5rsi5K5cqdjGf3yHQfL5be8rn
  xxJc/TrCRGYUPwgu1b72a4TBhE340UqAjhPuzgXHXhUu623fkHQkbv2Tx6ztF4XYjiVOqPO3o
  WZ76bt0vsq+X3igS0NXJv4jv1YfHND9/xyRZ+H1renxsb7TeRWnfXy6qsPIbFHKtNXpIQz8tx
  heZI9JyV5/WHpSQrSH8vZpx56GXF8mnek0LWyWZf8Xu+5+Pbhjp8blk9Vvvow2bZsh79G7JUM
  L51JPzf0nXE9mblA26qocMb2Rc4LHvgvniB3sCBFiPN9zqPughjhMz57n/RelRFPefc2l9Fc0
  ESJpTgj0VCLuag4EQCCJj5IiQMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-20.tower-532.messagelabs.com!1650943177!213272!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4507 invoked from network); 26 Apr 2022 03:19:38 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
  by server-20.tower-532.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 26 Apr 2022 03:19:38 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 23Q3Jb7O022457
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 26 Apr 2022 04:19:37 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 26 Apr 2022 04:19:33 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <david@fromorbit.com>,
        <djwong@kernel.org>, <brauner@kernel.org>, <willy@infradead.org>,
        <jlayton@kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v7 4/4] ceph: Remove S_ISGID stripping code in ceph_finish_async_create
Date:   Tue, 26 Apr 2022 12:19:52 +0800
Message-ID: <1650946792-9545-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1650946792-9545-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1650946792-9545-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
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

