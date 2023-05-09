Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A506FCC2B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 19:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbjEIRAP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 13:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbjEIQ7U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 12:59:20 -0400
Received: from out-7.mta1.migadu.com (out-7.mta1.migadu.com [IPv6:2001:41d0:203:375::7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758246597
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 09:57:45 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683651460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NRkDg8/QDL78Ozn75JlJivS7ptmCxyI7V8VfiBBetMw=;
        b=v9vcpKP2I5oVsGiASi9Z0yhNlg6/OYU386b+4kL3mJUwu9isTUH1JIw2lUNkRwA5UwTzmh
        dP5UkDVzix9yn6X3BvFL/2jYJQDuPcJHnH652qQP87dseSaZP2loDaloabniLSAIIVOiqr
        mJsb3JdfLSw+HpSncpkM+6GoKL/zt0E=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Christopher James Halse Rogers <raof@ubuntu.com>
Subject: [PATCH 30/32] lib: Export errname
Date:   Tue,  9 May 2023 12:56:55 -0400
Message-Id: <20230509165657.1735798-31-kent.overstreet@linux.dev>
In-Reply-To: <20230509165657.1735798-1-kent.overstreet@linux.dev>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The bcachefs module now wants this and it seems sensible.

Signed-off-by: Christopher James Halse Rogers <raof@ubuntu.com>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 lib/errname.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/errname.c b/lib/errname.c
index 67739b174a..dd1b998552 100644
--- a/lib/errname.c
+++ b/lib/errname.c
@@ -228,3 +228,4 @@ const char *errname(int err)
 
 	return err > 0 ? name + 1 : name;
 }
+EXPORT_SYMBOL(errname);
-- 
2.40.1

