Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC87778986E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Aug 2023 19:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjHZReV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Aug 2023 13:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjHZRdu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Aug 2023 13:33:50 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760FACA;
        Sat, 26 Aug 2023 10:33:47 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bcfd3220d3so12072921fa.2;
        Sat, 26 Aug 2023 10:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693071225; x=1693676025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iRjmdyxoAFRe/422LDRSdZX4LEiIQWUkHvgIm5S2Hcw=;
        b=ZmwC7Tb+KSJfpYAYkPicnMn4ING3TvNCyK/KbKhfpbjIWBtHCqMZGdCwxBbOgOP5ly
         +bvXrysqAfFcSejJqIlDmVhzUaegQIb42Rp8Tcxq+E20ma2Yfk9YUa3Z+Qga1aHDcBtm
         7pa3EegfcMS97GGXZY10eSci9ZGc9UPodQfkk8pXlqnYUNkDMo38M04k4ruVI7dmKAP2
         UtrCh1+wr+N5gUOOAVj/Y7Aikzcwd5ufpQnEthzCgVJa1D1+iqVBBOobV+sWY7iWG17N
         i+1czxcr1p4SyTMrNaSZziGyr8Y/aTdgHN/5Pk2qEYgSStU7TWGZc6fZU/RXPtfIxire
         YnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693071225; x=1693676025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRjmdyxoAFRe/422LDRSdZX4LEiIQWUkHvgIm5S2Hcw=;
        b=VDM4v/XN3D0fZ63E7TIQbhR5q9wIjTqCoYsZ9rQwFAWCLosUkxbPnrqWsYkNy6m11n
         mnGplQc3jtEG/5en8dyhxrc6jyi5PIuQGKWU1QFX67LTI9BNW7NL0sNtq7ShXz0fySMc
         9IV8gB8S8MuwzhaoWeeOtcqTmViV9jqLbjCFIhumd9GSEGoxxAb2ffW9+P8vMf9d8z56
         +lmppjEH5LOBhgGSmSeFR037HHkUvAP6JpnExEfjNOMEL6psH+7i+wEo+pxgTTi8W+8V
         ndpft6PFjqZz1rq5hKQJ64Nl2ulpBjUo4LONHjJ7HfR84EQAC9/unHi4ODQDqVDhBA+j
         dpew==
X-Gm-Message-State: AOJu0YwcVxLAnphp9Dt9OkBLmE3LOmdOZO9FfX7Ao05OLW1R9q4MVKLk
        Q90Xy3BT9GIOKflKlXZAdu9emrvYHSg=
X-Google-Smtp-Source: AGHT+IG+g/cM69mdojMoRKVPT5HPCW16KQ4jwQjEcRvxT0Ux15ptWu8eU6NISWK8l3qjcW2IP93F5g==
X-Received: by 2002:a2e:a401:0:b0:2b6:d0fc:ee18 with SMTP id p1-20020a2ea401000000b002b6d0fcee18mr15084678ljn.19.1693071225369;
        Sat, 26 Aug 2023 10:33:45 -0700 (PDT)
Received: from ariel-marco.local ([2a06:c701:42bb:ef00:dce:4a86:9ee9:556])
        by smtp.googlemail.com with ESMTPSA id h1-20020a1709062dc100b0099bd046170fsm2386702eji.104.2023.08.26.10.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 10:33:45 -0700 (PDT)
From:   Ariel Marcovitch <arielmarcovitch@gmail.com>
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ariel Marcovitch <arielmarcovitch@gmail.com>
Subject: [PATCH] idr: fix param name in idr_alloc_cyclic() doc
Date:   Sat, 26 Aug 2023 20:33:17 +0300
Message-Id: <20230826173317.93767-1-arielmarcovitch@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The relevant parameter is 'start' and not 'nextid'

Fixes: 460488c58ca8 ("idr: Remove idr_alloc_ext")
Signed-off-by: Ariel Marcovitch <arielmarcovitch@gmail.com>
---
 lib/idr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/idr.c b/lib/idr.c
index 7ecdfdb5309e..13f2758c2377 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -100,7 +100,7 @@ EXPORT_SYMBOL_GPL(idr_alloc);
  * @end: The maximum ID (exclusive).
  * @gfp: Memory allocation flags.
  *
- * Allocates an unused ID in the range specified by @nextid and @end.  If
+ * Allocates an unused ID in the range specified by @start and @end.  If
  * @end is <= 0, it is treated as one larger than %INT_MAX.  This allows
  * callers to use @start + N as @end as long as N is within integer range.
  * The search for an unused ID will start at the last ID allocated and will

base-commit: 7d2f353b2682dcfe5f9bc71e5b61d5b61770d98e
-- 
2.34.1

