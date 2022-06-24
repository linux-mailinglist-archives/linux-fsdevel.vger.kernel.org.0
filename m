Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9851D55951D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 10:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiFXIGC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 04:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiFXIFf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:05:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B05A6E7A1;
        Fri, 24 Jun 2022 01:05:05 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u12so3062012eja.8;
        Fri, 24 Jun 2022 01:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zYeizJ3QsvNICXqczpSXbVJYn4Q15WJ3kWZARt06sMw=;
        b=J/wgCdTYLso/wR3DyIMcpoWNVTSy/cjwLHx9Q39+E1ZodWxIhAlJ61DCaVuR1rD/f1
         pY38NwP9kY3Plwb6iN8EMe8/vG9qymIkGWF2JCZ+R7/X1R4EnwTmpYPULDKENIe2Fh6w
         FQCJsTwM3UQu3vJZESwvyK8+QhBWg7q572dTWiwHnN2NLv3ZwrQIiyW3sjqRVSC1nkgR
         oPerAY9zKue3qqTiHQ2r5ixckyjq8LP76+lkRLuVQapgOCZ4X7rOOw4Ml4021WrsttG3
         2MNeb6ISLKoiQ0jg06LSWwnAoniobzMHdFdZQd7CD+Jp+dZlI40apQN+4mRvkiBAtwMN
         +2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zYeizJ3QsvNICXqczpSXbVJYn4Q15WJ3kWZARt06sMw=;
        b=vpZoE2zxTO6nJ0s6+LAAUzqu0ZWFRJv180XJMQ4s4yQ7aIo325eNGUozeIs4FoQqhL
         nATeEjFQySbQNukh5/npcM4i52wMUABBJMv7cWOpfc9Wk3TEO0XjYp1dfw9+eyieXphq
         iYc9fUjflBKnl1jRF7CsSlDpJmYzswJKeGe0jhRzAGvieZgsWIAs4hJi0cxOQwU+Mlxv
         2FKT+cGJw7mq79NbW6/ZTknYwCV3KUL7i40FpWRQ1FQmzHMaTLHerxE+qzXOgasz+1QE
         hHP10iitLfNA2W6uOJPRxJDIdjxa5OTe39RhMETq4uPJswl23rNbtgMWmbMDFf1N7UmX
         TqWw==
X-Gm-Message-State: AJIora8re2bR7dLzpqgNgkGXDR8wLkSe3qGBXYw7oppm39/lHed0X96k
        58M+mIsAtccosW/dUJcBMTIPd+DX508=
X-Google-Smtp-Source: AGRyM1uXEIqId7b73deRFKUwrzmvPTkFA55neIHh4LETAN1AX61HEKuXSB8HtzpeXXBy1GfUk1mJtQ==
X-Received: by 2002:a17:906:ee1:b0:70d:d293:7b30 with SMTP id x1-20020a1709060ee100b0070dd2937b30mr11782721eji.134.1656057903826;
        Fri, 24 Jun 2022 01:05:03 -0700 (PDT)
Received: from able.fritz.box (p57b0bd9f.dip0.t-ipconnect.de. [87.176.189.159])
        by smtp.gmail.com with ESMTPSA id c19-20020a170906155300b006fea43db5c1sm697779ejd.21.2022.06.24.01.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 01:05:03 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org
Cc:     mhocko@suse.com,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 13/14] drm/vmwgfx: use drm_file_rss
Date:   Fri, 24 Jun 2022 10:04:43 +0200
Message-Id: <20220624080444.7619-14-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624080444.7619-1-christian.koenig@amd.com>
References: <20220624080444.7619-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This allows the OOM killer to make a better decision which process to reap.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 01a5b47e95f9..99bf405d31b9 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -1577,6 +1577,7 @@ static const struct file_operations vmwgfx_driver_fops = {
 #endif
 	.llseek = noop_llseek,
 	.get_unmapped_area = vmw_get_unmapped_area,
+	.file_rss = drm_file_rss,
 };
 
 static const struct drm_driver driver = {
-- 
2.25.1

