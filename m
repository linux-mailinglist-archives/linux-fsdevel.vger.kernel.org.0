Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDFE5027E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 12:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352043AbiDOKEn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 06:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352028AbiDOKEm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:04:42 -0400
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com [85.158.142.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60A7BB096;
        Fri, 15 Apr 2022 03:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1650016932; i=@fujitsu.com;
        bh=YW2t31SigmRnYDSTgB+T1pJcLO8aD2sH2Tq7Mun3OFc=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=kx1S6IfwrNptAnxOZNBs2rUbCoMO5nDfeqdG5YaHFBsgvurrQvuK+v5olv357rKsj
         JGypxZpZP8ykQS6qsfTdQYVukQH765B/w0apyIcBq+vHGZn8y4R/2DCxRlUtZeaM5C
         nPVH8dEDIDZP/LFCPpe3nzpH0X3feITqsVf/7YLXbqzTf7b4siG6/9bJJzAhVGZW3S
         HWyruIJcXvHsN4/m1HxD98WLJWtMajmW3pUd1oFz34zRx3bNwcWo8GsHN+0mLxU2zE
         A91+kcpueuKjDTstvAzwPz2AdDr5PIWdanzzL6y20yK+bxCQksPQb+VvWJR1cEV1cg
         N8DOoz9YY220Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileJIrShJLcpLzFFi42Kxs+GYpLvYKTL
  J4O8OBYvXhz8xWny4OYnJYsuxe4wWl5/wWfxctordYs/ekywWFw6cZrXY9WcHu8X5v8dZHTg9
  Ti2S8Ni0qpPN4/MmOY9NT94yBbBEsWbmJeVXJLBmLP2znLFgPlvFrkPzmBsY17F2MXJxCAlsY
  ZT4v2Y7cxcjJ5CzgEli15wciMQeRolrrd/YQBJsApoSzzoXgBWJCLhILJywnhGkiFngCqPE9f
  Y5YAlhAS+JPVsaWUFsFgFViV1T94PZvAKeEt9nfGUBsSUEFCSmPHwPVM/BwQlU//9sLcRiT4m
  pky6zQZQLSpyc+QSsnFlAQuLgixfMEK2KEpc6vjFC2BUSs2a1MUHYahJXz21insAoOAtJ+ywk
  7QsYmVYx2iUVZaZnlOQmZuboGhoY6BoamuqaWeoamprpJVbpJuqlluomp+aVFCUCpfUSy4v1U
  ouL9Yorc5NzUvTyUks2MQKjJqXYdc4Oxgt9P/UOMUpyMCmJ8r4VjUwS4kvKT6nMSCzOiC8qzU
  ktPsQow8GhJMH71x4oJ1iUmp5akZaZA4xgmLQEB4+SCG+oNVCat7ggMbc4Mx0idYpRUUqcVxg
  Y90ICIImM0jy4NljSuMQoKyXMy8jAwCDEU5BalJtZgir/ilGcg1FJmPebI9AUnsy8Erjpr4AW
  MwEt/rYqFGRxSSJCSqqBqbxFOvPIlul5siv0wreIlL09k2OS9lT48/K/vb53bY27ylq0azPP+
  md7reWJ3JhyzDVGRnBeg9x7/s1tzzXqLZdnVtVoGl7u71AWavJQXe7wSKQ5t+Bo4ylZ/0+vu6
  c6iC5w2fwy1DPw4S/Hm/dXcvy4d3nvnsVNf508vC6f+bn++edLRX55FbkFf3uOGByKUzvIUmr
  Wo+trsNGbs/qbo9cHW6Z1JhfVz/Q+ct1TtTNab6HPFqlY36prxofZrTYbGyrL6O7g05226EJC
  uu4djTWb19us7VSzbXhd2B2qaymsIv3x4EOHCSeVxef4PXQ6sa++0vvaQRXHbXP7Z7zenbj5W
  5ak2tfY2xzqC22UWIozEg21mIuKEwHD8+6ylQMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-8.tower-532.messagelabs.com!1650016931!56198!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29816 invoked from network); 15 Apr 2022 10:02:11 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-8.tower-532.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 15 Apr 2022 10:02:11 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 08451100478;
        Fri, 15 Apr 2022 11:02:11 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id EF9B6100471;
        Fri, 15 Apr 2022 11:02:10 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 15 Apr 2022 11:02:00 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <david@fromorbit.com>, <djwong@kernel.org>, <brauner@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>,
        <linux-nfs@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <viro@zeniv.linux.org.uk>, <jlayton@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v3 2/7] fs/namei.c: Add missing umask strip in vfs_tmpfile
Date:   Fri, 15 Apr 2022 19:02:18 +0800
Message-ID: <1650020543-24908-2-git-send-email-xuyang2018.jy@fujitsu.com>
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

If underflying filesystem doesn't enable own CONFIG_FS_POSIX_ACL, then
posix_acl_create can't be called. So we will miss umask strip, ie
use ext4 with noacl or disblae CONFIG_EXT4_FS_POSIX_ACL.

Reported-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 fs/namei.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 3f1829b3ab5b..bbc7c950bbdc 100644
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

