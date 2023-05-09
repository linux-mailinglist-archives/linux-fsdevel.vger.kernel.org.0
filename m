Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB606FCC1D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 18:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbjEIQ7Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 12:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbjEIQ6V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 12:58:21 -0400
Received: from out-26.mta1.migadu.com (out-26.mta1.migadu.com [95.215.58.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAC96180
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 09:57:29 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683651448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3bOiJuZA7MMn1dUAKvZtsb+DsEd9kjQVDcRKBJgcodE=;
        b=P3hZFno74bG0D5MVwOiAtytjPyoMXAxWkMWmWGCfGM3DquFD0ALELeBdVg3CPwnj+gUHgK
        NJJNgmjsEoEC/xiuoLdUK+Ku0A3kOpGxgm/PyfDlH1n2Qe/3QX9XUJTlO8rHac+1xpTczX
        3qQ/rx1r/qiBVGrivA0TW/KTk46S0t0=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 19/32] closures: Add a missing include
Date:   Tue,  9 May 2023 12:56:44 -0400
Message-Id: <20230509165657.1735798-20-kent.overstreet@linux.dev>
In-Reply-To: <20230509165657.1735798-1-kent.overstreet@linux.dev>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes building in userspace.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 lib/closure.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/closure.c b/lib/closure.c
index b38ded00b9..0855e698ce 100644
--- a/lib/closure.c
+++ b/lib/closure.c
@@ -9,6 +9,7 @@
 #include <linux/closure.h>
 #include <linux/debugfs.h>
 #include <linux/export.h>
+#include <linux/rcupdate.h>
 #include <linux/seq_file.h>
 #include <linux/sched/debug.h>
 
-- 
2.40.1

