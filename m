Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0096F2E758
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 23:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfE2VVU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 17:21:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfE2VVU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 17:21:20 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4DCF241F7;
        Wed, 29 May 2019 21:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559164879;
        bh=QX4RJlrZI+sCAuvsEErFnEMQl7z2FGq8iohsIsXvEH0=;
        h=From:To:Subject:Date:From;
        b=OCm+GHUV0kROy0/y2MoCIAG66Sax919y6W1o7AdZ2nc/30+5KmLC2h5n+6JW/MRyB
         egEzrhDaPHJsqLo3vuuxp3ADdsE7x1LizgpAO5SVwXWyXz/Dwcdjg3zpuWeXTDlWWj
         JqxZd6c9hrw92IjXYzAE4L9a9nKMl4tZ11jiI7ak=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] fs/nsfs.c: include headers for missing declarations
Date:   Wed, 29 May 2019 14:21:15 -0700
Message-Id: <20190529212115.164313-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Include linux/proc_fs.h and fs/internal.h to address the following
'sparse' warnings:

    fs/nsfs.c:40:32: warning: symbol 'ns_dentry_operations' was not declared. Should it be static?
    fs/nsfs.c:144:5: warning: symbol 'open_related_ns' was not declared. Should it be static?

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/nsfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index e3bf08c5af411..d0e8391ae3d77 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -2,6 +2,7 @@
 #include <linux/mount.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/proc_fs.h>
 #include <linux/proc_ns.h>
 #include <linux/magic.h>
 #include <linux/ktime.h>
@@ -10,6 +11,8 @@
 #include <linux/nsfs.h>
 #include <linux/uaccess.h>
 
+#include "internal.h"
+
 static struct vfsmount *nsfs_mnt;
 
 static long ns_ioctl(struct file *filp, unsigned int ioctl,
-- 
2.22.0.rc1.257.g3120a18244-goog

