Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF6DAD45EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 18:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfJKQ5P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 12:57:15 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:40571 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbfJKQ5P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:57:15 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iIyDz-0002Hw-TJ; Fri, 11 Oct 2019 17:57:07 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iIyDz-00044V-GU; Fri, 11 Oct 2019 17:57:07 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nsfs: include internal.h for ns_dentry_operations
Date:   Fri, 11 Oct 2019 17:57:05 +0100
Message-Id: <20191011165706.15608-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Include "internal.h" for the ns_dentry_operations definiton.
Fixes the following spare warning:

fs/nsfs.c:41:32: warning: symbol 'ns_dentry_operations' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/nsfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index a0431642c6b5..ea384d0f225a 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -11,6 +11,8 @@
 #include <linux/nsfs.h>
 #include <linux/uaccess.h>
 
+#include "internal.h"
+
 static struct vfsmount *nsfs_mnt;
 
 static long ns_ioctl(struct file *filp, unsigned int ioctl,
-- 
2.23.0

