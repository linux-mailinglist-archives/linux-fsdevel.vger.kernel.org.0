Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64685A6673
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 16:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiH3OkO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 10:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiH3OkM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:40:12 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B331E12D00;
        Tue, 30 Aug 2022 07:40:10 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id c24so10849267pgg.11;
        Tue, 30 Aug 2022 07:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=4LpW3pBq4YCMnGCeoHBb6AhvMm53b5+mcPk8hEFGdFk=;
        b=YcB6giRBioWHgdR0J3FejlbwSNcysVfeLaPUcpzrbXVBUHz0GvCqovIeciA+JlHo5B
         4GPgLUyM+khMRZwPjMRG2sEjzi5tuUPrCuewAiBNFZSNA4uwtj/CeZMJEGIyTM8+EYsl
         rqjnKowNEXJ/SxFo2+DVQGk4+o7mM6E/+Y+y+o7dSNkBaJ5KrP0K9ldFObP+VGcE5XYX
         jlwBFC76a5O7IDT3R+7I3q/5olBrAuGKiGou8zMOE2q+nM5PQPOw65xZqihVnNc/EbC/
         e1ZU7HpuAKeWENxKxmATS35pGlkYo1gJI4kOUET2meBV9If6wouinmlI6fhcFmSn1CnN
         SLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=4LpW3pBq4YCMnGCeoHBb6AhvMm53b5+mcPk8hEFGdFk=;
        b=fgGCmNEhZXwoPNyCt3F9B7+OexfPy9reMpelMwl+zOPQeAHcfeW0/GOlfJZ4VzGP/e
         PaX4cpwQ55LpyuuovcxTYRuTaLh7FQ3HhNP3fiNhGg9Z0FRULFryXOjlPbUroSkNrvAM
         XDaeSkQ2ONhi0eiaY9blvbO9oCLEq7fXqp3TbaIh84FzOAqDd7rx0YT0nROa4XKOacww
         lTUn0vLMhZhvrVlFX1KP3oeCumV3KfxPqVHqRYbkABpBH83UigFFik8Z2GPNaBPoKbcv
         CN6oG/JmLafYTNUb2ZqU6rbNR4mLAufu9XFIJeBN83A8xTQ4wsE3LEq4DonHaBCcnoER
         27Og==
X-Gm-Message-State: ACgBeo1dPxtW14ozdyBCMmyWmAgmWRl+LWs7oOrr+USKb/EDUYuKz2bS
        nl1uvmT4aG/zkEqR6SHZ9kI=
X-Google-Smtp-Source: AA6agR53rkweOQcXv7pg1HcvympT5QGJO3ia7ENGgkw+wGggX7tRcF0jok0kUK6ydRmtIoFMuZYyaw==
X-Received: by 2002:a05:6a00:16c4:b0:535:890:d4a with SMTP id l4-20020a056a0016c400b0053508900d4amr21704709pfc.0.1661870410235;
        Tue, 30 Aug 2022 07:40:10 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b0016d8d277c02sm9740711plb.25.2022.08.30.07.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 07:40:09 -0700 (PDT)
From:   xu xin <cgel.zte@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     akpm@linux-foundation.org, adobriyan@gmail.com, willy@infradead.org
Cc:     bagasdotme@gmail.com, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, xu xin <xu.xin16@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: [PATCH v5 2/2] ksm: add profit monitoring documentation
Date:   Tue, 30 Aug 2022 14:40:03 +0000
Message-Id: <20220830144003.299870-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830143731.299702-1-xu.xin16@zte.com.cn>
References: <20220830143731.299702-1-xu.xin16@zte.com.cn>
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
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/mm/ksm.rst | 36 ++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
index b244f0202a03..fb6ba2002a4b 100644
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
+			  ksm_rmap_items * sizeof(rmap_item).
+
+   where ksm_merging_pages is shown under the directory ``/proc/<pid>/``,
+   and ksm_rmap_items is shown in ``/proc/<pid>/ksm_stat``.
+
+From the perspective of application, a high ratio of ``ksm_rmap_items`` to
+``ksm_merging_pages`` means a bad madvise-applied policy, so developers or
+administrators have to rethink how to change madvise policy. Giving an example
+for reference, a page's size is usually 4K, and the rmap_item's size is
+separately 32B on 32-bit CPU architecture and 64B on 64-bit CPU architecture.
+so if the ``ksm_rmap_items/ksm_merging_pages`` ratio exceeds 64 on 64-bit CPU
+or exceeds 128 on 32-bit CPU, then the app's madvise policy should be dropped,
+because the ksm profit is approximately zero or negative.
+
 Monitoring KSM events
 =====================
 
-- 
2.25.1

