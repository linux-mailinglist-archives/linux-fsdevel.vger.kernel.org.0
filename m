Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4156751263
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 23:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjGLVMq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 17:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbjGLVMZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:12:25 -0400
Received: from out-11.mta1.migadu.com (out-11.mta1.migadu.com [IPv6:2001:41d0:203:375::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7664E270D
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 14:11:49 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689196307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W3IMW7979m4jEebRkm8ameWmv+95K3nEqS903wmmHh0=;
        b=vbep1jNU0N7Jzwmjd5QsnkyOd0o6hFZhSLceXkvNwltVrEi2Z1ZXTcX6QCSV1gJVOc/WLF
        h60etV64dRc6xQYpgawuyE30Rsx0NnbZEeeAlB8x6ykzReiSTbh+XjlARtjEa2Mgg33ZbV
        L1xcl2iw/73hce7GxYCk6Ma+TSfCYEs=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 19/20] lib/generic-radix-tree.c: Add a missing include
Date:   Wed, 12 Jul 2023 17:11:14 -0400
Message-Id: <20230712211115.2174650-20-kent.overstreet@linux.dev>
In-Reply-To: <20230712211115.2174650-1-kent.overstreet@linux.dev>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

We now need linux/limits.h for SIZE_MAX.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/generic-radix-tree.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/generic-radix-tree.h b/include/linux/generic-radix-tree.h
index 63080822dc..f6cd0f909d 100644
--- a/include/linux/generic-radix-tree.h
+++ b/include/linux/generic-radix-tree.h
@@ -38,6 +38,7 @@
 
 #include <asm/page.h>
 #include <linux/bug.h>
+#include <linux/limits.h>
 #include <linux/log2.h>
 #include <linux/math.h>
 #include <linux/types.h>
-- 
2.40.1

