Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40DC538E61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 12:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245433AbiEaKB6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 06:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245468AbiEaKA3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 06:00:29 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD4484A00;
        Tue, 31 May 2022 03:00:28 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z7so5958261edm.13;
        Tue, 31 May 2022 03:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NiGv7XqpyS2XED0WdTZJaaW3qxD3EEwJnBgFNlUBlKA=;
        b=aUB5B9Qt8tVriEh42JHF6p0XPngykorf81VEvkU+jbQb7CSF/l+p5bKKOyZ20uEgsA
         E43T85l2RNnZ7ArvqSkvuaTiD93Z/Q+CcF5nsxGUHtbZPnk25OSTrL4t5vJROge1iv08
         D43ebZ6vcKHFJLX+daUhnhKonDnOhJN9wbzFrqgWFfIh7GjGBXxWi48JT9I+x8K6ogvq
         Gyvusf+zhEL6Gk09/w34fLwp6G9rdW/r/FFrInAhnujV6+INA3rKvI4kTTFmibLu1J5X
         yfuU2boXQuUY1zqYSg/AQttssmci0RltzIdFgKtVRPa9qApgcGl9lqhFBcWEyD7XIwTB
         xPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NiGv7XqpyS2XED0WdTZJaaW3qxD3EEwJnBgFNlUBlKA=;
        b=FaqtASZZb17pjWYFKDJD+uZoTjzidO6FoNahorxFxt1eYpE5Cjm7D7VKSR+cEN/DQp
         grZu988W5q6ZBL2c/fgaqkDbN6oA4VkkpN2e98yxc7PA2byEo0df68STYGa0whSFXaZG
         36sG1KxNc4v8eidZ0M2A9ZjQPKyhdHMwm5Tc+BBg8aJLLV1WM0zZS3QeMDUB+x1bzpOA
         0tmLht1LpOmwpr9R/pdpBau5RzUDg5ShNiqzg6dVc6SsR6hKSu0cpFZTqzTa0IecNKO2
         uzY9K+vNkE8ucFjR0K4FbPmSkgcbRydzAF2Z11DUoWQANbHiNTJAX4fHW4Le0r/vUs/j
         68FQ==
X-Gm-Message-State: AOAM530udPkOsHuGODJGngMORUvuYwNP6S4Z8F1aykRirvmjjjiE/kl1
        YLVEkL1EapNo4/+Nr7kG5YNXF7uDYjPTOQ==
X-Google-Smtp-Source: ABdhPJxaefghKbMHCtIN9ZsUiLrQ9JGsM6ui0kyhG9BoMRuUMSSLwMZQJupGKdHga/0PvqPhhZrEmQ==
X-Received: by 2002:a05:6402:90d:b0:428:c1ad:1e74 with SMTP id g13-20020a056402090d00b00428c1ad1e74mr63021246edz.345.1653991227420;
        Tue, 31 May 2022 03:00:27 -0700 (PDT)
Received: from able.fritz.box (p5b0ea02f.dip0.t-ipconnect.de. [91.14.160.47])
        by smtp.gmail.com with ESMTPSA id r13-20020a056402018d00b0042617ba6389sm582062edv.19.2022.05.31.03.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:00:27 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     christian.koenig@amd.com, alexander.deucher@amd.com,
        daniel@ffwll.ch, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, hughd@google.com,
        andrey.grodzovsky@amd.com
Subject: [PATCH 12/13] drm/vmwgfx: use drm_oom_badness
Date:   Tue, 31 May 2022 12:00:06 +0200
Message-Id: <20220531100007.174649-13-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220531100007.174649-1-christian.koenig@amd.com>
References: <20220531100007.174649-1-christian.koenig@amd.com>
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
index 01a5b47e95f9..e447e8ae29be 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -1577,6 +1577,7 @@ static const struct file_operations vmwgfx_driver_fops = {
 #endif
 	.llseek = noop_llseek,
 	.get_unmapped_area = vmw_get_unmapped_area,
+	.oom_badness = drm_oom_badness,
 };
 
 static const struct drm_driver driver = {
-- 
2.25.1

