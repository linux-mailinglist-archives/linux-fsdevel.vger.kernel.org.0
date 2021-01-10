Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339FF2F0628
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Jan 2021 10:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbhAJJRF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Jan 2021 04:17:05 -0500
Received: from m12-12.163.com ([220.181.12.12]:35937 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbhAJJRE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Jan 2021 04:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=RDFd4ojr9oPLVYMa8v
        ZUnB0tEmIsHcjTNiyT+hAwf60=; b=bgDPBNi/Yo5DpqjD94PUtddTNi60PycowQ
        f3/dDdG62Xi/jcftsXHpOgiKDFov4i6DJfm8LPQOr3TTuCykwfPHGvvuSyZjkGYz
        oOk0hhctkSi1n33UN7M2J2FDdYK1qVASqqg+IjvoPNahK5B82vZtN5yF65Vfb7Vu
        SwilCV8Hc=
Received: from localhost.localdomain.localdomain (unknown [182.150.135.160])
        by smtp8 (Coremail) with SMTP id DMCowABnyxxyuvpf3_6QLQ--.21667S2;
        Sun, 10 Jan 2021 16:27:30 +0800 (CST)
From:   winndows@163.com
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liao Pingfang <winndows@163.com>
Subject: [PATCH] writeback: Remove useless comment for __wakeup_flusher_threads_bdi()
Date:   Sun, 10 Jan 2021 16:14:53 +0800
Message-Id: <1610266493-5526-1-git-send-email-winndows@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DMCowABnyxxyuvpf3_6QLQ--.21667S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4fKF4DZFWfKrW3Cw18Grg_yoW3uFc_Xa
        y8ArWDGFsxZ3W5G34xZ3Z3tFW0gr4kCr4rZanakF98JFy5ur9Fvw4kZrWDAw109FW3WFZx
        GwnrXFWvkrZIkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjfgADUUUUU==
X-Originating-IP: [182.150.135.160]
X-CM-SenderInfo: hzlq0vxrzvqiywtou0bp/xtbBDRMWmVaEB5WxWQAAs5
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Liao Pingfang <winndows@163.com>

Remove useless comment for __wakeup_flusher_threads_bdi(), as
argument 'nr_pages' was removed.

Fixes: e8e8a0c6c9bf ("writeback: move nr_pages == 0 logic to one location")
Signed-off-by: Liao Pingfang <winndows@163.com>
---
 fs/fs-writeback.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index acfb558..05eee22 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2099,10 +2099,6 @@ void wb_workfn(struct work_struct *work)
 	current->flags &= ~PF_SWAPWRITE;
 }
 
-/*
- * Start writeback of `nr_pages' pages on this bdi. If `nr_pages' is zero,
- * write back the whole world.
- */
 static void __wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
 					 enum wb_reason reason)
 {
-- 
1.8.3.1


