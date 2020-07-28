Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CBE23109F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 19:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731951AbgG1RLT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 13:11:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731070AbgG1RLR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:11:17 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9053320825;
        Tue, 28 Jul 2020 17:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595956277;
        bh=xmaCUO7w5bqGCiLrpTvKhPLilEJbllIwuDFeA8NymgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jA5G6/nO/8dGBaSvYbruAtnBFneMRAQUHzq+O7pfnNG3/7UjAgII1kSLRBoefe2p8
         D6RX4+XjPlVScObPbFGn9HGSK/C6Uj0tfc7UfYw5njmvPoI1nTejF0VYHCPZ+QMIDJ
         8t+pS2Vt5lKWx7imCan382QlJlsmI70q2GMOcI4c=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/4] mm: swap: Fix kerneldoc of swap_vma_readahead()
Date:   Tue, 28 Jul 2020 19:11:07 +0200
Message-Id: <20200728171109.28687-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728171109.28687-1-krzk@kernel.org>
References: <20200728171109.28687-1-krzk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix W=1 compile warnings (invalid kerneldoc):

    mm/swap_state.c:742: warning: Function parameter or member 'fentry' not described in 'swap_vma_readahead'
    mm/swap_state.c:742: warning: Excess function parameter 'entry' description in 'swap_vma_readahead'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 mm/swap_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 66e750f361ed..d034dbf9d0d5 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -725,7 +725,7 @@ static void swap_ra_info(struct vm_fault *vmf,
 
 /**
  * swap_vma_readahead - swap in pages in hope we need them soon
- * @entry: swap entry of this memory
+ * @fentry: swap entry of this memory
  * @gfp_mask: memory allocation flags
  * @vmf: fault information
  *
-- 
2.17.1

