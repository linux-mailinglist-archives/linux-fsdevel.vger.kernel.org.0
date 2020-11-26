Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CBA2C4DE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 05:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387525AbgKZEDU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 23:03:20 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7229 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387482AbgKZEDU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 23:03:20 -0500
X-IronPort-AV: E=Sophos;i="5.78,371,1599494400"; 
   d="scan'208";a="101764321"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Nov 2020 12:03:17 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 8B3D04CE5CD8;
        Thu, 26 Nov 2020 12:03:15 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 26 Nov 2020 12:03:15 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Thu, 26 Nov 2020 12:03:14 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <miklos@szeredi.hu>, <linux-fsdevel@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] fuse: clean up redundant assignment
Date:   Thu, 26 Nov 2020 12:03:13 +0800
Message-ID: <20201126040313.141513-1-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 8B3D04CE5CD8.ACBC4
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The 'err' was assigned to -ENOMEM in just few lines above, no need to be
assigned again.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 fs/fuse/dir.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ff7dbeb16f88..f28eb54517ff 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -528,7 +528,6 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	if (!forget)
 		goto out_err;
 
-	err = -ENOMEM;
 	ff = fuse_file_alloc(fm);
 	if (!ff)
 		goto out_put_forget_req;
-- 
2.29.2



