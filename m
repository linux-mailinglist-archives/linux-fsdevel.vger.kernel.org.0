Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E659E117BC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 00:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfLIXsY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 18:48:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:52458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbfLIXsY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 18:48:24 -0500
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CE2B2071E;
        Mon,  9 Dec 2019 23:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575935303;
        bh=OIYHBUYFVPcXfW6t1DsMkTRdYhwjz29c7cchDo01Hqw=;
        h=From:To:Cc:Subject:Date:From;
        b=U+UDqZnrzAIkVtl+Edh1xSTNgeSULCd4GriiOFGwO817yHQM9fzbsg60c4SFwZwk5
         q5gQElO7GQipFaCwazutVMNRnU3UPgDp6Mdh3n6rIcIZO3vizV/VdUyNhdBS/g9KOl
         r0VUfbIAWOBZdZQi1BGA5epnU4W9wNdPXv2wUNW4=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/nsfs.c: include headers for missing declarations
Date:   Mon,  9 Dec 2019 15:48:22 -0800
Message-Id: <20191209234822.156179-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Include linux/proc_fs.h and fs/internal.h to address the following
'sparse' warnings:

    fs/nsfs.c:41:32: warning: symbol 'ns_dentry_operations' was not declared. Should it be static?
    fs/nsfs.c:145:5: warning: symbol 'open_related_ns' was not declared. Should it be static?

Signed-off-by: Eric Biggers <ebiggers@google.com>
---

Hi Andrew, please consider applying this straightforward cleanup.
This has been sent to Al four times with no response.

 fs/nsfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index a0431642c6b55..f75767bd623af 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -3,6 +3,7 @@
 #include <linux/pseudo_fs.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/proc_fs.h>
 #include <linux/proc_ns.h>
 #include <linux/magic.h>
 #include <linux/ktime.h>
@@ -11,6 +12,8 @@
 #include <linux/nsfs.h>
 #include <linux/uaccess.h>
 
+#include "internal.h"
+
 static struct vfsmount *nsfs_mnt;
 
 static long ns_ioctl(struct file *filp, unsigned int ioctl,
-- 
2.24.0.393.g34dc348eaf-goog

