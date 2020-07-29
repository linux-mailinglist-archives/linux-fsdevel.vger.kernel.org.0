Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5902318AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 06:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgG2EbP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 00:31:15 -0400
Received: from smtpbgbr2.qq.com ([54.207.22.56]:37616 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgG2EbP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 00:31:15 -0400
X-QQ-mid: bizesmtp12t1595997035txi2axre
Received: from xr-hulk-k8s-node1933.gh.sankuai (unknown [101.236.11.2])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 29 Jul 2020 12:30:31 +0800 (CST)
X-QQ-SSF: 01100000002000E0ZJ10B00A0000000
X-QQ-FEAT: Gxd91G060N3t/fxkDmSko6wqncUyScSSnBVGZ7tUpxGp7k7dDIeip59M5RCcq
        p+Q7Fc1ZgPJeSI0ojD94Soo7ASRWBp/wbXunCLL6Kge8eoP51mHh0zGFhm3se6jBhwgMCsK
        Ahr+E8wapLAgnMD4HHH6eln2NJ6sHTK08ZYreBgCHK7o61EpjRWEfpztj5zUExu6d7cNlV0
        qV4j4hBwVpTqMsuFv+Nf65cpZx9lR05qoWYuZi/4j2ow+STxtwJj4leSPoqaafFCYZLvlkm
        TBGckTKNJSEYAj1qsSV/w/a3ym85rRKO+/rH+azSRGrkH7cU0Rpn0pWcU=
X-QQ-GoodBg: 0
From:   Wang Long <w@laoqinren.net>
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        w@laoqinren.net
Subject: [PATCH] idr: Fix a typo in idr_alloc_cyclic()'s comment
Date:   Wed, 29 Jul 2020 12:30:30 +0800
Message-Id: <1595997030-94257-1-git-send-email-w@laoqinren.net>
X-Mailer: git-send-email 1.8.3.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:laoqinren.net:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch fix a typo in comment for function idr_alloc_cyclic().

Signed-off-by: Wang Long <w@laoqinren.net>
---
 lib/idr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/idr.c b/lib/idr.c
index c2cf2c5..47d203f 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -100,7 +100,7 @@ int idr_alloc(struct idr *idr, void *ptr, int start, int end, gfp_t gfp)
  * @end: The maximum ID (exclusive).
  * @gfp: Memory allocation flags.
  *
- * Allocates an unused ID in the range specified by @nextid and @end.  If
+ * Allocates an unused ID in the range specified by @start and @end.  If
  * @end is <= 0, it is treated as one larger than %INT_MAX.  This allows
  * callers to use @start + N as @end as long as N is within integer range.
  * The search for an unused ID will start at the last ID allocated and will
-- 
1.8.3.1




