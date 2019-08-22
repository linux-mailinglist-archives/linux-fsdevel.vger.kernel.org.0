Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1750499859
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 17:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbfHVPk3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 11:40:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731416AbfHVPk3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:40:29 -0400
Received: from zzz.localdomain (ip-173-136-158-138.anahca.spcsdns.net [173.136.158.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8357D206B7;
        Thu, 22 Aug 2019 15:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566488428;
        bh=GaweZh37iKpQjkz5Lc6b7kfYEFD2n828E0+WldEl8XE=;
        h=From:To:Subject:Date:From;
        b=oypR/1W+/E4PGFBE1GsnWrKmTmQSiSQFQtrwAGQjIHwyXgXwLHhXmyqkP9HET1KJJ
         7CTYLqTM8bRNzS2wiWUtLx3UKfQLmvKLllpTUxEY1jvuarW109qUw3A8323pQlRuvj
         +J3aKVyMcbych3MjlwC1r+1E7s699PvC+HbpYm/E=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH RESEND] fs/nsfs.c: include headers for missing declarations
Date:   Thu, 22 Aug 2019 08:40:21 -0700
Message-Id: <20190822154021.14452-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.1
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
index a0431642c6b5..f75767bd623a 100644
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
2.22.1

