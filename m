Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5E1C7DD66
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 16:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbfHAOHJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 10:07:09 -0400
Received: from mail.onyx.syn-alias.com ([206.152.134.66]:51567 "EHLO
        smtp.centurylink.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731504AbfHAOHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:07:09 -0400
X_CMAE_Category: , ,
X-CNFS-Analysis: v=2.3 cv=GbRpYjfL c=1 sm=1 tr=0 a=F7Cg5NNmPe0R/klA+vUXwA==:117 a=F7Cg5NNmPe0R/klA+vUXwA==:17 a=KGjhK52YXX0A:10 a=FmdZ9Uzk2mMA:10 a=5hZkEVmpKn8A:10 a=eQrCS-SpgXYA:10 a=6I5d2MoRAAAA:8 a=X0MrpzQjXdrw5BecmA0A:9 a=IjZwj45LgO3ly-622nXo:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
Feedback-ID: dfw:ctl:res:onyx
X-Authed-Username: YWxhbnNvbWVyc0BjZW50dXJ5bGluay5uZXQ=
Authentication-Results:  smtp04.onyx.dfw.sync.lan smtp.user=alansomers@centurylink.net; auth=pass (LOGIN)
Received: from [63.224.81.28] ([63.224.81.28:45548] helo=threonine.lauralan.noip.me)
        by smtp.centurylink.net (envelope-from <asomers@freebsd.org>)
        (ecelerity 3.6.25.56547 r(Core:3.6.25.0)) with ESMTPSA (cipher=DHE-RSA-AES128-GCM-SHA256) 
        id 77/35-26632-A02F24D5; Thu, 01 Aug 2019 10:07:07 -0400
From:   asomers@FreeBSD.org
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        Nikolaus@rath.org
Cc:     Alan Somers <asomers@FreeBSD.org>
Subject: [PATCH] fuse: Add changelog entries for protocols 7.1-7.8
Date:   Thu,  1 Aug 2019 08:06:36 -0600
Message-Id: <20190801140636.34841-1-asomers@FreeBSD.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Alan Somers <asomers@FreeBSD.org>

Retroactively add changelog entry for FUSE protocols 7.1 through 7.8.

Signed-off-by: Alan Somers <asomers@FreeBSD.org>
---
 include/uapi/linux/fuse.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 19fb55e3c73e..93784c4509a1 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -38,6 +38,44 @@
  *
  * Protocol changelog:
  *
+ * 7.1:
+ *  - add FUSE_SETATTR, FUSE_SYMLINK, FUSE_MKNOD, FUSE_MKDIR, FUSE_UNLINK,
+ *    FUSE_RMDIR, FUSE_RENAME, and FUSE_LINK messages
+ *  - add FUSE_OPEN, FUSE_READ, FUSE_WRITE, FUSE_RELEASE, FUSE_FSYNC, and
+ *    FUSE_FLUSH messages
+ *  - add FUSE_SETXATTR, FUSE_GETXATTR, FUSE_LISTXATTR, and FUSE_REMOVEXATTR
+ *    messages
+ *  - add padding to messages to accomodate 32-bit servers on 64-bit kernels
+ *  - add FUSE_OPENDIR, FUSE_READDIR, and FUSE_RELEASEDIR messages
+ *
+ * 7.2:
+ *  - add FOPEN_DIRECT_IO and FOPEN_KEEP_CACHE flags
+ *  - add FUSE_FSYNCDIR message
+ *
+ * 7.3:
+ *  - add FUSE_ACCESS message
+ *  - add FUSE_CREATE message
+ *  - add filehandle to fuse_setattr_in
+ *
+ * 7.4:
+ *  - add frsize to fuse_kstatfs
+ *  - clean up request size limit checking
+ *
+ * 7.5:
+ *  - add flags and max_write to fuse_init_out
+ *
+ * 7.6:
+ *  - add max_readahead to fuse_init_in and fuse_init_out
+ *
+ * 7.7:
+ *  - add FUSE_INTERRUPT message
+ *  - add POSIX file lock support
+ *
+ * 7.8:
+ *  - add lock_owner and flags fields to fuse_release_in
+ *  - add FUSE_BMAP message
+ *  - add FUSE_DESTROY message
+ *
  * 7.9:
  *  - new fuse_getattr_in input argument of GETATTR
  *  - add lk_flags in fuse_lk_in
-- 
2.21.0

