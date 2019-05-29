Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13CA42E755
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 23:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfE2VUy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 17:20:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbfE2VUy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 17:20:54 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B80E8241F7;
        Wed, 29 May 2019 21:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559164853;
        bh=M7t1IOL4YjLa66C5NwuyBjqpj/XCamymsEi6A/q3j4U=;
        h=From:To:Subject:Date:From;
        b=uttYjhCFs1Pznloje5a36Q+ED+D/I1z/Odjl2GHsozxDES0IYxuIqfiJjkxZrkfc7
         lxsZwdYvP3FxymiVonu6NE3y1Wsh1H15JL1YIN4Molewbi/+D71YB7A3LF3P9s8nSv
         UbG+cKY5R56g9AUn6P+uIlikcRoL3AiYKPKXHJn8=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] fs/buffer.c: include fs/internal.h for missing prototypes
Date:   Wed, 29 May 2019 14:20:44 -0700
Message-Id: <20190529212044.164109-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
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
index e450c55f64342..f3c21f2266a5a 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -48,6 +48,8 @@
 #include <linux/sched/mm.h>
 #include <trace/events/block.h>
 
+#include "internal.h"
+
 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
 static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 			 enum rw_hint hint, struct writeback_control *wbc);
-- 
2.22.0.rc1.257.g3120a18244-goog

