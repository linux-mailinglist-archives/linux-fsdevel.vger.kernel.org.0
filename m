Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D57509867
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 09:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385375AbiDUG54 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 02:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385464AbiDUG5E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:57:04 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947C911A12;
        Wed, 20 Apr 2022 23:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1650524032; i=@fujitsu.com;
        bh=ThqRNMVwN/gYuY+yP+qvGKhzoByHtom9pEJS+r8beCs=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=tjrCl8UtPkba5w/pcw3u5QJAVYOycC5Bi4g3tqerZ8zM+piOrtpaMf0bfNJEnnLme
         TMketcMWUlAgCoJ89aSRy0kRVY7NCdM1ZbyfvjUydXsT45GfZtcg14jo0tbPUT5hY4
         CnYcQD9O7e1kN588knPXmgsMGGbp6FLbBlpT3p1fg87R+wKogEfSVbLkA7hKgsHZqv
         WiVToSl5BhZtUYJE4+OPMyx2OMU5aLtK4W1tcHgcIWcD1ricBJ/8wYk+BHFroQWTLu
         ACYW4mAqeKRZ/kGMoylzqIpA/MfynuzkIRwaCqpNkcALkvi9cLwj1QQgB1ZNu55PVv
         uU/CRhMyIMTMw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRWlGSWpSXmKPExsViZ8MxRbf+f0K
  SwadGNovXhz8xWny4OYnJYsuxe4wWl5/wWfxctordYs/ekywW5/8eZ7X4/WMOmwOHx6lFEh6b
  V2h5bFrVyebxeZOcx6Ynb5kCWKNYM/OS8isSWDMe7lnLWPCRveLv/ZVsDYz32boYuTiEBF4zS
  txoWcnUxcgJ5OxhlNiwhwPEZhPQlHjWuYAZxBYRcJR40T6DBaSBWeAQo8T9Q11gCWEBJ4klL6
  exgdgsAqoSazfuABvEK+AhsWbZCVYQW0JAQWLKw/dg9ZwCnhJbP3WyQizzkLi96RhUvaDEyZl
  PWEBsZgEJiYMvXjBD9CpKXOr4xghhV0jMmtXGNIGRfxaSlllIWhYwMq1itE4qykzPKMlNzMzR
  NTQw0DU0NNU1ttA1MjTSS6zSTdRLLdUtTy0u0QVyy4v1UouL9Yorc5NzUvTyUks2MQKDP6VY7
  coOxj2rfuodYpTkYFIS5b34KyFJiC8pP6UyI7E4I76oNCe1+BCjDAeHkgRv72egnGBRanpqRV
  pmDjASYdISHDxKIrzK/4DSvMUFibnFmekQqVOMilLivN1/gRICIImM0jy4Nlj0X2KUlRLmZWR
  gYBDiKUgtys0sQZV/xSjOwagkzHsDZApPZl4J3PRXQIuZgBZXT4kFWVySiJCSamBqVE6V7Vyy
  qXsr3/m1HSdWhiyS2rIibubr+gus7MwzxALc7hqeXjU9dcorgc0Z0esignnf7FzSkSF7Pjr2w
  f4HDppMGw2a1NRCLs4OPvrjoJv5BAtb1vSKNdy3d9xq2fqp6GDbdtlLa/hy9rFnMp8SMkqcKc
  X3tO/ZxuDOZucrsxK3hPkcUp9XFPND06q185zyCm/pBYL8Xl7f2rY+iphiMUVBIukuE+dB2z+
  ia894HHr2ZM5KPyFV9SQb7klCN1RDmR3CrX33RcdIO1kd3mGomSG5Nvnc7KQ7XMUXKucx1An7
  u2b1Neypadoddf32Lo27Hy7932+1ut9C4a+G4M9zCzyKjMM4np1/+ulXeIsSS3FGoqEWc1FxI
  gAjp4Z2eQMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-2.tower-571.messagelabs.com!1650524030!37115!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32105 invoked from network); 21 Apr 2022 06:53:51 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
  by server-2.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 21 Apr 2022 06:53:51 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 23L6rbVm002010
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 21 Apr 2022 07:53:37 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 21 Apr 2022 07:53:34 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <david@fromorbit.com>,
        <djwong@kernel.org>, <brauner@kernel.org>, <willy@infradead.org>,
        <jlayton@kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v5 2/4] fs: Add missing umask strip in vfs_tmpfile
Date:   Thu, 21 Apr 2022 15:54:16 +0800
Message-ID: <1650527658-2218-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1650527658-2218-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1650527658-2218-1-git-send-email-xuyang2018.jy@fujitsu.com>
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

