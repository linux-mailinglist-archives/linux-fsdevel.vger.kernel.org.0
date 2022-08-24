Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6A859F3F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 09:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbiHXHId (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 03:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbiHXHIc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:08:32 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBF392F73;
        Wed, 24 Aug 2022 00:08:27 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 83so9940456pfw.6;
        Wed, 24 Aug 2022 00:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=C9ysgA8b1YgCBIvEexgqiQq6OdwO0KDUjA0c2BYGnmA=;
        b=LEEMGQDs4/g59g9kDUdIuPraqbT+/kClJ8jAWK7HzkvrxU/dqKEUb0RDp/+CpxB66Y
         3lCtmtIwLBpblH9Wjcjt7xvfpfOdXVIGHNBqpC5fiKiURR+vNyU+h2GkTeTLrClT69Mj
         UR7k+RkuheEe/W1EPL80oMbF7pczj7/zvN9htxsvmBi2hynsUwL7tmb3sHwhgK6G1zAO
         XSLOBK7t02VBHAOGHL55R6Gz1f2zjZw+DvudGfmyeN6I2oF+LDLJB5q9Vn1Y8+2PIxxF
         eataJ1qMgMdzAxciIS61HSYj02dBib4Ibq3Jl3kETnCP91qSi43T3UJs6selWo9VSudR
         /g5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=C9ysgA8b1YgCBIvEexgqiQq6OdwO0KDUjA0c2BYGnmA=;
        b=K9k0UVRHITql9F2GaYXWqjeGiCkOFLBfaBWy69Db9ge08YeKZH+u8WRU1bFk3rX2ZI
         WC3HFAJPDrO1p4j5IZ+mZSUUOf3xunNqJKJt9cESIMu2cRf9cZCys/pSnINbwrQEMjN7
         8zY9OWeFVEJ40sHjz6De62K33DGSzd3zKJKK6g0qXaf4pK/y7eSTnL59m6mzSxz0O+Hn
         dG/+7pxMdw0QZeBtRQkiJjuHFVh8/8tliVU2o4Vsv86LRqJMjryUjqDkmgmGGMp4fsZt
         JdG9jm4j8Q1FavvTqASyWbA8czqYBo26GAm44ZQCWcJe+67JFPNPsCxuUeg13KfBTC64
         KEEA==
X-Gm-Message-State: ACgBeo0XjBTDGJRLcLPNTwqPDlIBA8FVqyze/tdfyi5VvDA1typlELaT
        dsMrJatJTn2QhMG94K/0bb4=
X-Google-Smtp-Source: AA6agR50+EL5onhLdSLsvcV3vYXXL6Et8CPOgYqocPpC7tATpo1aqiWNYcQDHNDkTpbWlqQhAwkEHQ==
X-Received: by 2002:a05:6a00:1588:b0:52f:a5bb:b992 with SMTP id u8-20020a056a00158800b0052fa5bbb992mr28066493pfk.38.1661324907176;
        Wed, 24 Aug 2022 00:08:27 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902f68900b0016be96e07d1sm11654373plg.121.2022.08.24.00.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 00:08:26 -0700 (PDT)
From:   xu xin <cgel.zte@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     akpm@linux-foundation.org, corbet@lwn.net
Cc:     bagasdotme@gmail.com, adobriyan@gmail.com, willy@infradead.org,
        hughd@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, xu xin <xu.xin16@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: [PATCH v3 2/2] ksm: add profit monitoring documentation
Date:   Wed, 24 Aug 2022 07:08:21 +0000
Message-Id: <20220824070821.220092-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220824070559.219977-1-xu.xin16@zte.com.cn>
References: <20220824070559.219977-1-xu.xin16@zte.com.cn>
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
index b244f0202a03..40bc11f6fa15 100644
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
+range? Here is a simple approximate calculation for reference:
+
+	general_profit =~ pages_sharing * sizeof(page) - (all_rmap_items) *
+	         sizeof(rmap_item);
+
+where all_rmap_items can be easily obtained by summing ``pages_sharing``,
+``pages_shared``, ``pages_unshared`` and ``pages_volatile``.
+
+2) The KSM profit inner a single process can be similarly obtained by the
+following approximate calculation:
+
+	process_profit =~ ksm_merging_sharing * sizeof(page) -
+			  ksm_rmp_items * sizeof(rmap_item).
+
+where both ksm_merging_sharing and ksm_rmp_items are shown under the directory
+``/proc/<pid>/``.
+
+From the perspective of application, a high ratio of ``ksm_rmp_items`` to
+``ksm_merging_sharing`` means a bad madvise-applied policy, so developers or
+administrators have to rethink how to change madvise policy. Giving an example
+for reference, a page's size is usually 4K, and the rmap_item's size is
+separately 32B on 32-bit CPU architecture and 64B on 64-bit CPU architecture.
+so if the ``ksm_rmp_items/ksm_merging_sharing`` ratio exceeds 64 on 64-bit CPU
+or exceeds 128 on 32-bit CPU, then the app's madvise policy should be dropped,
+because the ksm profit is approximately zero or negative.
+
 Monitoring KSM events
 =====================
 
-- 
2.25.1

