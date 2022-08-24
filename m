Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A139359FA63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 14:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbiHXMtE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 08:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237170AbiHXMs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:48:56 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C34094EC5;
        Wed, 24 Aug 2022 05:48:54 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 20so15571352plo.10;
        Wed, 24 Aug 2022 05:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3OQD2+oSTaOvMGB6cXQRW5a+Su7VAZ4WsnuVjsdDDzM=;
        b=SOLX/QZmuIMPp/2Uy5E2CSAvHb3+m0SzUirILcS/EyK012Umz3AIw5jq35bTeKP/W3
         8hj9kX7BOqCt8zpWftYwwOYR2DAHqy6PKJltIDwnlvBb/VXcpefOZScCwgSFGU2BwMSA
         lEpxytTHRX6mJkCbRObicYCiC9EGxuBd4YgVLSmc7AwAm4sSue60aeoDTZXDzwE5HW0y
         auNxftyQXFx6uaXUtp0c7D8IxLutVaWbbIZb9CxGA6BvUWGENUIzvInwHLHfTrQSPpVI
         dl2go6my+QL5J7TOPuGz5Uz9RgDAE4D2BFvB9u+HJMX6WWXP7qNC5/I2y3g3miYcKnRE
         6Gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3OQD2+oSTaOvMGB6cXQRW5a+Su7VAZ4WsnuVjsdDDzM=;
        b=cqoHtF7RqCahc5hWqar9lX+3vsI1RSL2r/i+7sgIfTzWtJijPspRFvUaJyXayF8uY/
         sXRLngEgfsP8XrPPwwLRFOFMkfccSceSspmkKV4Yd/WF0AgZWp0byU3jiBGjAgLQQoCE
         NdQWnFzfWBPRykzrBx1HQB5dRmzXUN3FEa9LWIhkX7xK9JX5THWl0rLaj+7Xx7XukL+f
         tRcwtPB/sb9Wlge6o17qcwTafo9CbhMQ8TH6MAaYBwwFBlwcoeiq5r1EGo6Ukivl7lDw
         7j4mxGEVQd9u/jjInaSwuu0BocAhoN8qd9PQaaWDt+fuPtUiCzfirrz6b5ybuNLSLUMx
         4xnA==
X-Gm-Message-State: ACgBeo1C3RjbWV9OQmFO7pNE+bIeHYvHisjzWBVGZUIMdiDRMxND/7ma
        BoN2UdGsxG9UBwZfl+rNFnY=
X-Google-Smtp-Source: AA6agR7i2f7HdP9QZhENuohXe5QBXSpJvJM6qjCdMoq6KBiyK5/RzX1er86DvyF8scdrDgu1w7RwIA==
X-Received: by 2002:a17:902:a982:b0:170:d646:5851 with SMTP id bh2-20020a170902a98200b00170d6465851mr29526104plb.134.1661345333276;
        Wed, 24 Aug 2022 05:48:53 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090a7c4600b001ef81574355sm1318786pjl.12.2022.08.24.05.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 05:48:53 -0700 (PDT)
From:   xu xin <cgel.zte@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     akpm@linux-foundation.org, corbet@lwn.net
Cc:     bagasdotme@gmail.com, adobriyan@gmail.com, willy@infradead.org,
        hughd@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, xu xin <xu.xin16@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: [PATCH v4 2/2] ksm: add profit monitoring documentation
Date:   Wed, 24 Aug 2022 12:48:46 +0000
Message-Id: <20220824124846.223217-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220824124512.223103-1-xu.xin16@zte.com.cn>
References: <20220824124512.223103-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the description of KSM profit and how to determine it separately
in system-wide range and inner a single process.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
---
 Documentation/admin-guide/mm/ksm.rst | 36 ++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
index b244f0202a03..c2893027cbe6 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -184,6 +184,42 @@ The maximum possible ``pages_sharing/pages_shared`` ratio is limited by the
 ``max_page_sharing`` tunable. To increase the ratio ``max_page_sharing`` must
 be increased accordingly.
 
+Monitoring KSM profit
+=====================
+
+KSM can save memory by merging identical pages, but also can consume
+additional memory, because it needs to generate a number of rmap_items to
+save each scanned page's brief rmap information. Some of these pages may
+be merged, but some may not be abled to be merged after being checked
+several times, which are unprofitable memory consumed.
+
+1) How to determine whether KSM save memory or consume memory in system-wide
+   range? Here is a simple approximate calculation for reference::
+
+	general_profit =~ pages_sharing * sizeof(page) - (all_rmap_items) *
+			  sizeof(rmap_item);
+
+   where all_rmap_items can be easily obtained by summing ``pages_sharing``,
+   ``pages_shared``, ``pages_unshared`` and ``pages_volatile``.
+
+2) The KSM profit inner a single process can be similarly obtained by the
+   following approximate calculation::
+
+	process_profit =~ ksm_merging_pages * sizeof(page) -
+			  ksm_rmp_items * sizeof(rmap_item).
+
+   where both ksm_merging_pages and ksm_rmp_items are shown under the
+   directory ``/proc/<pid>/``.
+
+From the perspective of application, a high ratio of ``ksm_rmp_items`` to
+``ksm_merging_pages`` means a bad madvise-applied policy, so developers or
+administrators have to rethink how to change madvise policy. Giving an example
+for reference, a page's size is usually 4K, and the rmap_item's size is
+separately 32B on 32-bit CPU architecture and 64B on 64-bit CPU architecture.
+so if the ``ksm_rmp_items/ksm_merging_pages`` ratio exceeds 64 on 64-bit CPU
+or exceeds 128 on 32-bit CPU, then the app's madvise policy should be dropped,
+because the ksm profit is approximately zero or negative.
+
 Monitoring KSM events
 =====================
 
-- 
2.25.1

