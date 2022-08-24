Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560ED59F256
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 06:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbiHXEDY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 00:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiHXEDX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 00:03:23 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F9E79610;
        Tue, 23 Aug 2022 21:03:19 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x19so12545574pfq.1;
        Tue, 23 Aug 2022 21:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=C9ysgA8b1YgCBIvEexgqiQq6OdwO0KDUjA0c2BYGnmA=;
        b=VEsHOnCWEXfZFWljS3gMXqT+43LsE3qQQEn6Wxws2JCmIAj78tGJc65sRXirHy62g9
         o4Vkh+lrklx0j5niQvV1bTn5+OvjBmMSXd1f3nOBgrUtssCjOwAigJ8NOzks/Gf5v+2P
         tHKZK+1d97PbfG94gV7iFbXwNlCD/U16aA6QaUmNlu7BSlQAmPYh8np1fNKRqVolcGK/
         Hh/05DNxZN50tBa+DXpz6wGuH2S7mTQiZvV5hpEhBVZanzKiRQdEns9K5Am8sDbsGWmR
         opE8XDGLDhiQA7CMWo8HA3g39ytKGDIs+5RM2P3hyMIAHCOo5zZZH0XgjxgtYNw0WqEJ
         6NGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=C9ysgA8b1YgCBIvEexgqiQq6OdwO0KDUjA0c2BYGnmA=;
        b=XwGwZtdv7zRkaKaftusrpP1FEw5jGzDaULoLmdZLhsqcx6Mz9JGmHtS+cOCmHs6tlk
         AgS2f4rhW6WATjC7u8S1iARWshAVKoyKvYBZ0csSO9bXcKYlcApwy82oHKbI5VGQJFMY
         zrV71LW/WcA0xWlKAHsE1F+z0S/gzWfHspFy0waMJm+t0klziC6XIZLOaSa7O/NOReKV
         92Ra79RMV0tKeZkCfL2QYz2L5IXgpNcqnxJ+lnLgshZO/jVKXFsjVKtGYnqv0z3AadM6
         r7kUudejoa6YPaZ+EUE6l8+choLhj3PTWMZ3jeLHQYBwHHyJV1vL6Q6TIH5bSKECor5j
         QpAQ==
X-Gm-Message-State: ACgBeo24AOG7LYPHCCKnvP0m/pAOOWh9WQeWqlAQaRo59j6/GRIhP5oX
        CErRNPQeYUmZS8Y9JNnC7rk=
X-Google-Smtp-Source: AA6agR6IzgeF8jGuGG1mbk2YL+egSHkQLMmccGQwPlHhVJ1tdw9/WNs4QOtdcEhb/viGaO7zAfJ1Wg==
X-Received: by 2002:a05:6a00:244a:b0:52b:e9a8:cb14 with SMTP id d10-20020a056a00244a00b0052be9a8cb14mr28070025pfj.32.1661313799208;
        Tue, 23 Aug 2022 21:03:19 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902e55100b0016dbaf3ff2esm11427481plf.22.2022.08.23.21.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 21:03:18 -0700 (PDT)
From:   xu xin <cgel.zte@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     akpm@linux-foundation.org, corbet@lwn.net
Cc:     adobriyan@gmail.com, willy@infradead.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: [PATCH v2 2/2] ksm: add profit monitoring documentation
Date:   Wed, 24 Aug 2022 04:03:13 +0000
Message-Id: <20220824040313.215119-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220824040036.215002-1-xu.xin16@zte.com.cn>
References: <20220824040036.215002-1-xu.xin16@zte.com.cn>
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

