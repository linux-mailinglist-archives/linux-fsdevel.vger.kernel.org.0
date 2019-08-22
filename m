Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABAA599856
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 17:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731614AbfHVPjx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 11:39:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731069AbfHVPjw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:39:52 -0400
Received: from zzz.localdomain (ip-173-136-158-138.anahca.spcsdns.net [173.136.158.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0DD4233FD;
        Thu, 22 Aug 2019 15:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566488392;
        bh=aARxdUI6zLhTlAxrzSYkLr70nMwIFoF+qzQs3YYEF1k=;
        h=From:To:Subject:Date:From;
        b=dx9ofnFcdg2Ev1zBtCSIW4dav5kOxCLra/oNukCoi5z1jjzdsYu8fQMqB/sGO5uUu
         DYvc0Hj+xDS3LE/F2U5ONhy/GrAWMm5Gq4S6nmzkj/EBQiEC2hq9YzxEwviYCYiOE1
         saVyUb8pr5FpmonK7LIOIqSLpZpQtKdbqFNgiKtI=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH RESEND] fs/buffer.c: include fs/internal.h for missing prototypes
Date:   Thu, 22 Aug 2019 08:39:26 -0700
Message-Id: <20190822153926.14294-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Include fs/internal.h to address the following 'sparse' warnings:

    fs/buffer.c:1930:5: warning: symbol '__block_write_begin_int' was not declared. Should it be static?
    fs/buffer.c:2089:6: warning: symbol '__generic_write_end' was not declared. Should it be static?
    fs/buffer.c:2998:6: warning: symbol 'guard_bio_eod' was not declared. Should it be static?

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 0faa41fb4c88..95d08807863b 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -47,6 +47,8 @@
 #include <linux/sched/mm.h>
 #include <trace/events/block.h>
 
+#include "internal.h"
+
 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
 static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 			 enum rw_hint hint, struct writeback_control *wbc);
-- 
2.22.1

