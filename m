Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA479538E3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 12:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245484AbiEaKAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 06:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245440AbiEaKA2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 06:00:28 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E256F84A23;
        Tue, 31 May 2022 03:00:20 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n10so25580324ejk.5;
        Tue, 31 May 2022 03:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RT3RFL0VBSkluM1f3vm/WSgrGA2Qjw/08Ja0Fnc8nAM=;
        b=pn14iMQ9n0FDWwmArA4Jf35k//oaml9s3mxFl2ky/DMcmh2eS5QQUAfVDrFOHrWe0F
         KMtAdL2ItYXoMBH38/cM7Y5adUTzh6hcJoR+bDw3M9kaX7/WIFSLDyC89uegMORBvy8a
         BHKTy4vuZTReGoejbiTSY6UKILNxobjAL1xvmGcoXh1D/U10MyxWoiEN1o6YdrZUfevt
         sj80RQonfCLZAawaQ34qBTRrlatRa3mUKNi0wDk1pC3/0cWVa8FNjNAuvChUXdFusk2T
         xG3+L8wayhRfjE/jFGd2K1s01WQzFRlhAG5nSv/aQI6SJBaKFuP7a15DEZJ3u2J3fVab
         1s1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RT3RFL0VBSkluM1f3vm/WSgrGA2Qjw/08Ja0Fnc8nAM=;
        b=q2ME/bkkJkPttlsZqtSfGSsS5zhcgdEyFuRmvifmCiSQSAxKYEz8i1Tt0kFdtt+1tV
         1ssEcJBQGVTW9WFux8iGS4CyJjPGrtKbdAOEMWzU05tmJ97kOuyRzFL986nW8ZRaFG03
         cKe0EM/txjDUS+VwYJBAYE8xslChF8wIoDvqIGPMcR0QBjdz1FkSzKv57Ui+2gQg2S73
         ISUwPEceYxu0o/93+T7ja8SGuyurF21mirGfapRxuBTzYCLZCnunSc3TQAG9On//yV5k
         4MsZfi7roksrGIKccOnmzhXDwTkN9gcYfctW9YU6DB+SjCQd6n32cOygTuJUodF76cr1
         EWmA==
X-Gm-Message-State: AOAM532BEbfgnndLaYTN7RJwfAmWblS9orofu5uRdbNGaIWzV6xIVOOA
        vcCOGtGr08UzRJpaOIx4CNwMqkCbIm/orw==
X-Google-Smtp-Source: ABdhPJw2HPaoRajF+IeqkgNAoVDs/MgxP3po1idYa4R4fWsq47S5BbJXHf6FD6GIdoI/D1SZlKNRiA==
X-Received: by 2002:a17:907:2cc4:b0:6fe:2100:de21 with SMTP id hg4-20020a1709072cc400b006fe2100de21mr52095547ejc.462.1653991220342;
        Tue, 31 May 2022 03:00:20 -0700 (PDT)
Received: from able.fritz.box (p5b0ea02f.dip0.t-ipconnect.de. [91.14.160.47])
        by smtp.gmail.com with ESMTPSA id r13-20020a056402018d00b0042617ba6389sm582062edv.19.2022.05.31.03.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:00:19 -0700 (PDT)
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
Subject: [PATCH 07/13] drm/amdgpu: Use drm_oom_badness for amdgpu
Date:   Tue, 31 May 2022 12:00:01 +0200
Message-Id: <20220531100007.174649-8-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220531100007.174649-1-christian.koenig@amd.com>
References: <20220531100007.174649-1-christian.koenig@amd.com>
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
index ebd37fb19cdb..9d6e57c93d3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2651,8 +2651,9 @@ static const struct file_operations amdgpu_driver_kms_fops = {
 	.compat_ioctl = amdgpu_kms_compat_ioctl,
 #endif
 #ifdef CONFIG_PROC_FS
-	.show_fdinfo = amdgpu_show_fdinfo
+	.show_fdinfo = amdgpu_show_fdinfo,
 #endif
+	.oom_badness = drm_oom_badness,
 };
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv)
-- 
2.25.1

