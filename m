Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6299538E48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 12:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245498AbiEaKAh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 06:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245429AbiEaKAV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 06:00:21 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7247385EF2;
        Tue, 31 May 2022 03:00:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t5so16807078edc.2;
        Tue, 31 May 2022 03:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z7tQVrAvhtwsiyqp5g4EfVxGXeEppLEfrV1ntrEYWJE=;
        b=Xh9vdv7Md1Jc0nNaz/QEZs5wsG3AfJ2/jRFF8rTAcPZ6QG7f0rxiqBLYOf13+3PUe5
         DS/CL5kAFDHB7/bv8EYLoIYIYA3Cx4+ppq4UyjhqSGPcSsG+p4nVI7VGhcdno4MC08p8
         XVfyNLF1mWExyyS8ZBwIS6tDDHVn9frsIcma0mUCQvKpUlAle8k82hD4G+7Sd4WdVmlz
         3Cwt+4X8TIMztGZf/ISlFleQ6/rglSf1VgibZ0Ewo75ycww+oCt0RuyECJkUJZ9D3opK
         u/Qh77+csPwSloqfrGgfn1EfcZpOm7AfMN65GulQjeG/U1vHukfs/GzY6+Kbrf4gD0d7
         2ncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z7tQVrAvhtwsiyqp5g4EfVxGXeEppLEfrV1ntrEYWJE=;
        b=nsPS0IKYPq3Uh/fLmXmLklePJOipSWlroquZopF1i87MZ7pIinyRcQ4zLvRxiNhvsN
         ERm0jvdaZ9bYfyF7LJIYOlRR/p6RIk7NXmUCf834XDCjxHrbrq5ITkY905Ml/EGMjWIT
         UGNbdg3LVvwCKK8mlzLsZ8WvNclXXA+YQr+7tiuvhPjKukviAjiriKiM2Mo7MV1KseuQ
         2JPb5XTg7O1go/fSJJJG6HlwCFr6g/W+Ykb1DeFo/T/pN5aAECVEctBX4IuFGDInHzUO
         7w0yaPJZ+V5+Rf9vyUmXSsyhHf9Bgu4Jgcwmk5C+t4z+5DWHxS3RBi9kc21m1k6BvBBT
         0s3w==
X-Gm-Message-State: AOAM531V5pwzy57xNuN3EJLgQC7WTuGs3Ha6L1S3iFGmDcT1gRDpAucH
        5BOB9SpqltgNW2o5j6Rr17ae0j5Bma78Iw==
X-Google-Smtp-Source: ABdhPJwU+/41hzABOSPHIeWy2MYGjljgCs1L+eRQW55IH1wpboag3ARspMl2JoO5SvKoTgZp0xZVQw==
X-Received: by 2002:aa7:cdd2:0:b0:42b:aeb2:bc99 with SMTP id h18-20020aa7cdd2000000b0042baeb2bc99mr34074044edw.382.1653991218991;
        Tue, 31 May 2022 03:00:18 -0700 (PDT)
Received: from able.fritz.box (p5b0ea02f.dip0.t-ipconnect.de. [91.14.160.47])
        by smtp.gmail.com with ESMTPSA id r13-20020a056402018d00b0042617ba6389sm582062edv.19.2022.05.31.03.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:00:18 -0700 (PDT)
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
Subject: [PATCH 06/13] drm/gma500: use drm_oom_badness
Date:   Tue, 31 May 2022 12:00:00 +0200
Message-Id: <20220531100007.174649-7-christian.koenig@amd.com>
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
 drivers/gpu/drm/gma500/psb_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 1d8744f3e702..d5ab4e081b53 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -513,6 +513,7 @@ static const struct file_operations psb_gem_fops = {
 	.mmap = drm_gem_mmap,
 	.poll = drm_poll,
 	.read = drm_read,
+	.oom_badness = drm_oom_badness,
 };
 
 static const struct drm_driver driver = {
-- 
2.25.1

