Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4BD559508
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 10:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiFXIFn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 04:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiFXIFB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:05:01 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40B06DB28;
        Fri, 24 Jun 2022 01:04:57 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eq6so2313776edb.6;
        Fri, 24 Jun 2022 01:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CVQLS1Q8p0L2oqy2feCuipYYw0Dn51iYeixzeYC0qk0=;
        b=diumkHDMGen9Vt3PpkuAbvqzWKQd+Xdn973nNKdfdCDDC0zTX2C6hvIxsHe2V7Hoc4
         IOhBR2vnm8dxvhsKFIBXPaolCk/OFXCBQ1WZCwL71kg8/Qq8WUQziQwUP00AOcwUcOGP
         rXTcnuW7puIRMcesyziDQyu7bT1G2aJvnhdPeFeaq+EwQpiHIGMo14FD4eE8URrxEDxV
         0m2ZDeucEfDeKkG17Nd8V6yPSz995Flq0dRdec0ubvhe6xb2D8xZHUXfzD0udY0tRU0C
         HcnFjUnQwXhFVgFVmkiIUcsMCluaFxgfHNgP1bHGOZQJ0mTg8yzEf2GVutNriYht8F60
         tNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CVQLS1Q8p0L2oqy2feCuipYYw0Dn51iYeixzeYC0qk0=;
        b=ku7kr8A/OMxxUJeWx/wLEJs9GrdDqw52ECkUkIsDmSIwD/biSwtzFQ2unXmBVtBZ+T
         4TikQqY8L+2o5uNIiw3ewIy6fbGuIMypqOFarbX/PdgjDQUik+nNL+FMTQ+PKrgaPPFf
         RLFoKS5EMY462R5cZeYcxmxjAGH9FzzauwCbax20wx78qLLd/LEkmNgVTTYL6Ci3Zi9R
         kVFhFUbdnNXztgVbDHWAgZGRUP8Ocp4B7e9RM+eoAWcLKGWyAe03ND8qxVebjDKc0mDh
         vl4xCp9EJblhrLoRHe/ICeo3LN7UGqAWMP3tzZcBezzp1HQVfmJbB2vU9YBURCPU0htP
         eVFA==
X-Gm-Message-State: AJIora82WTESJjaigjzFrS3CF+QejS3gyjFpvPukBG/Ih9HunL4gPA9m
        ZCPMEI/VNol/RJ7B52Ba6AyzhZDalqs=
X-Google-Smtp-Source: AGRyM1usD8rMmmeAdvKoxrU4g0pKdJN3rPJZdiIs4qY40gFmdzYVGQwJIExPFW+J17A2KjUq7SPWiA==
X-Received: by 2002:a05:6402:4408:b0:435:9ed2:9be with SMTP id y8-20020a056402440800b004359ed209bemr15656191eda.81.1656057897642;
        Fri, 24 Jun 2022 01:04:57 -0700 (PDT)
Received: from able.fritz.box (p57b0bd9f.dip0.t-ipconnect.de. [87.176.189.159])
        by smtp.gmail.com with ESMTPSA id c19-20020a170906155300b006fea43db5c1sm697779ejd.21.2022.06.24.01.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 01:04:57 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org
Cc:     mhocko@suse.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: [PATCH 08/14] drm/amdgpu: use drm_file_rss
Date:   Fri, 24 Jun 2022 10:04:38 +0200
Message-Id: <20220624080444.7619-9-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624080444.7619-1-christian.koenig@amd.com>
References: <20220624080444.7619-1-christian.koenig@amd.com>
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

From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

This allows the OOM killer to make a better decision which process to reap.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 8890300766a5..4508791fe80c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2635,8 +2635,9 @@ static const struct file_operations amdgpu_driver_kms_fops = {
 	.compat_ioctl = amdgpu_kms_compat_ioctl,
 #endif
 #ifdef CONFIG_PROC_FS
-	.show_fdinfo = amdgpu_show_fdinfo
+	.show_fdinfo = amdgpu_show_fdinfo,
 #endif
+	.file_rss = drm_file_rss,
 };
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv)
-- 
2.25.1

