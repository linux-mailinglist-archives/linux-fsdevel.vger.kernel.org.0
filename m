Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51D32310A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 19:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbgG1RLU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 13:11:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731949AbgG1RLT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:11:19 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 710DD20829;
        Tue, 28 Jul 2020 17:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595956278;
        bh=IoeFFZHY5ykUCVRt5xB8qAKcgJTbvlo0eD39HYG2lJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V8sgHnkmWMNwd59YfpAg1lIWXL6UdRiqQ/YVg2SIew4s0FVHYb8EwBjM32Us90LuC
         AUm7+dY65bX/GpFllt1Wb9RfMayb+VA+6spzj5e1vK7pPss+SKC2veZNZt7yjwa0NP
         /1Mwt9l5EQazIp/58D9zxt+sRvABosVvxnbwVyOQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/4] mm: mempolicy: Fix kerneldoc of numa_map_to_online_node()
Date:   Tue, 28 Jul 2020 19:11:08 +0200
Message-Id: <20200728171109.28687-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728171109.28687-1-krzk@kernel.org>
References: <20200728171109.28687-1-krzk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix W=1 compile warnings (invalid kerneldoc):

    mm/mempolicy.c:137: warning: Function parameter or member 'node' not described in 'numa_map_to_online_node'
    mm/mempolicy.c:137: warning: Excess function parameter 'nid' description in 'numa_map_to_online_node'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 93fcfc1f2fa2..9894bb2f7452 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -129,7 +129,7 @@ static struct mempolicy preferred_node_policy[MAX_NUMNODES];
 
 /**
  * numa_map_to_online_node - Find closest online node
- * @nid: Node id to start the search
+ * @node: Node id to start the search
  *
  * Lookup the next closest node by distance if @nid is not online.
  */
-- 
2.17.1

