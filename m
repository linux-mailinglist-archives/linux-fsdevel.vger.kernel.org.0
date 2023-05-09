Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3E56FCBE9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 18:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbjEIQ5T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 12:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjEIQ5O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 12:57:14 -0400
Received: from out-60.mta1.migadu.com (out-60.mta1.migadu.com [95.215.58.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE954C0E
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 09:57:11 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683651429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mk2GM0+dzxVCnTybx12Btfro6vDgTHvnILBWigNj4c8=;
        b=gvv06Eflh4cSDF3nvay9HJM/D+7UHiIBgSqj7ssD0zLDoqIlYSxw9l1oY17SVUZrK3Vf42
        LpQMzG48+j/L6sANVmqlFcGlIj8Ig7PqI9jibpFr9xJNtXIt8bjU+VZFJiOgnKqSEWGJ49
        SPTS/U6/Tr/fe9ohzRHhEAZUr9KkMOU=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 01/32] Compiler Attributes: add __flatten
Date:   Tue,  9 May 2023 12:56:26 -0400
Message-Id: <20230509165657.1735798-2-kent.overstreet@linux.dev>
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

From: Kent Overstreet <kent.overstreet@gmail.com>

This makes __attribute__((flatten)) available, which is used by
bcachefs.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org> (maintainer:COMPILER ATTRIBUTES)
Cc: Nick Desaulniers <ndesaulniers@google.com> (reviewer:COMPILER ATTRIBUTES)
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/compiler_attributes.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index e659cb6fde..e56793bc08 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -366,4 +366,9 @@
  */
 #define __fix_address noinline __noclone
 
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-flatten-function-attribute
+ */
+#define __flatten __attribute__((flatten))
+
 #endif /* __LINUX_COMPILER_ATTRIBUTES_H */
-- 
2.40.1

