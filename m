Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB610559514
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 10:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiFXIFm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 04:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiFXIFB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:05:01 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FBC6DB21;
        Fri, 24 Jun 2022 01:04:57 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e2so2336029edv.3;
        Fri, 24 Jun 2022 01:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ID2laRfYSApmjGzin/c5O7ZzYP1tMI9ua34YWk456Wk=;
        b=U7uY3MsA0DHippF6S8UKVRKmsJnNzZVtyS/oxSk8mnuxYbuH6lVcfrpX+0QqNbAzsr
         OHPqC1A2CJXe90yHB7/dZKLeRQkrpAbVd3R0tfpASOsFiFVpqjxyZSja4Ln6UQfGkV1F
         vEhUaLJqQTsf0mDlK6LHd6b+sDgfx27xoxB1E1JLj9lewb9qKNqcQpOqIQ9VN902Eeco
         K9AuesVMeK0hPkCglbUSWjfKsjVujF7T8cb3mCE5ZaCnxoDqUl7F2zCL64/5pa0gH7B9
         1NKNHVz889djG0KWGG8iwf1I/ljLUIKtvBLVbUBVPCkEvOT+MIVlMWKc5SSwZwD6KAKU
         AbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ID2laRfYSApmjGzin/c5O7ZzYP1tMI9ua34YWk456Wk=;
        b=aNZm7aVbX8lW2nnYZgqV5Nd3i4XyVaz3Hb/d08kJmsfaP/dOOlIkrGRLYNYE0aofBC
         h9BPwaJj8sBXgmpw2lJI1YTyKBNZ7BnWf+dX4VvextoN7Y2xgzYuPiqVKZA/hBPDzfeZ
         kKwv/u+sEXPCT+tWVONg5VOzssMtSfGJxoKi29N6oXX29epmD8Tw1LdimBrRyRo6oPLx
         pXy6dLyQWpRHY+UGpx0AVNU60e97P/0IyA2SBV88ORvK8VebO8zxJ5ABbSjXTXTxumGi
         SN8tmkuZGJoQvCfyaXvoETC4Lx2pHgsaXKFjbQWp3MP9FpdHTjf4ACrZiF6AjYfxpnqX
         FAlg==
X-Gm-Message-State: AJIora+LGN64mXmWaWaAl+BHyITyKkpxca5W2rZ0oEi2LckSscgI3tdo
        xZE9zlSSjL/wECgCBp7bQHKs+1wvGCM=
X-Google-Smtp-Source: AGRyM1vXothqzNCeq2wfXu0Iy7pDBGR1100k8JOpLZpuKKiLhk+9M6Fn95/BBmkDNLC1mjmi1D/X+w==
X-Received: by 2002:a05:6402:11d1:b0:435:d76d:f985 with SMTP id j17-20020a05640211d100b00435d76df985mr7954996edw.8.1656057896438;
        Fri, 24 Jun 2022 01:04:56 -0700 (PDT)
Received: from able.fritz.box (p57b0bd9f.dip0.t-ipconnect.de. [87.176.189.159])
        by smtp.gmail.com with ESMTPSA id c19-20020a170906155300b006fea43db5c1sm697779ejd.21.2022.06.24.01.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 01:04:56 -0700 (PDT)
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
Subject: [PATCH 07/14] drm/gma500: use drm_file_rss
Date:   Fri, 24 Jun 2022 10:04:37 +0200
Message-Id: <20220624080444.7619-8-christian.koenig@amd.com>
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
 drivers/gpu/drm/gma500/psb_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 1d8744f3e702..92c005aa6e9e 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -513,6 +513,7 @@ static const struct file_operations psb_gem_fops = {
 	.mmap = drm_gem_mmap,
 	.poll = drm_poll,
 	.read = drm_read,
+	.file_rss = drm_file_rss,
 };
 
 static const struct drm_driver driver = {
-- 
2.25.1

