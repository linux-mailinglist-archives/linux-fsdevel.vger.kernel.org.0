Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FF0403B87
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 16:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhIHOaS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 10:30:18 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:41486 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351925AbhIHOaR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 10:30:17 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1mNyAO-0004qz-NL; Wed, 08 Sep 2021 10:03:08 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org,
        Alex Shi <alex.shi@linux.alibaba.com>
Subject: [PATCH 3/9] coda: remove err which no one care
Date:   Wed,  8 Sep 2021 10:03:02 -0400
Message-Id: <20210908140308.18491-4-jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210908140308.18491-1-jaharkes@cs.cmu.edu>
References: <20210908140308.18491-1-jaharkes@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Alex Shi <alex.shi@linux.alibaba.com>

No one care 'err' in func coda_release, so better remove it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 fs/coda/file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/coda/file.c b/fs/coda/file.c
index ef5ca22bfb3e..52deab784667 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -238,11 +238,10 @@ int coda_release(struct inode *coda_inode, struct file *coda_file)
 	struct coda_file_info *cfi;
 	struct coda_inode_info *cii;
 	struct inode *host_inode;
-	int err;
 
 	cfi = coda_ftoc(coda_file);
 
-	err = venus_close(coda_inode->i_sb, coda_i2f(coda_inode),
+	venus_close(coda_inode->i_sb, coda_i2f(coda_inode),
 			  coda_flags, coda_file->f_cred->fsuid);
 
 	host_inode = file_inode(cfi->cfi_container);
-- 
2.25.1

