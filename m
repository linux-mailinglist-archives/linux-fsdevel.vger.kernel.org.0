Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D171355951B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 10:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiFXIF7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 04:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiFXIFP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:05:15 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B4A6DB3E;
        Fri, 24 Jun 2022 01:05:00 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ej4so2305709edb.7;
        Fri, 24 Jun 2022 01:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=byPE9Yoru8EMtsMIQe5jAdiqqlz8rrO56DVvtVJd9qg=;
        b=m1LPw4Tq7YAn8lQCGgWgt12CjzJ5ei1Ei63rf/aKMcF5rpgBfXhWWd5y3NKVG8Ui9/
         K3F30mqlEy32o+QZsZXlA17af4wRr1DVKixhlju+deheafQ/NAXkt5GRlFmAkXrz01om
         TzwlkMMWSIsZz8Y8uObLx5ljXVdIXmDX3AUzGfBhaZh2KCqzGxsWKyfjOqHtTTOnuQk3
         r1HIiRKeCgO4p1DUTcPzLqAFw481eF/Afji3PnuaKxzRhlw9/Ofd3QbWU/gWWeNF2Y9Z
         eMVfDCvHAUic+3PY3ZEtifzoXXEm0gqpa/KTCrNtzATjGFHR2fzV08RAqKXrhHMLRFyL
         Yixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=byPE9Yoru8EMtsMIQe5jAdiqqlz8rrO56DVvtVJd9qg=;
        b=vBRBjATHVJZMQcTviNAFJt1x76Skz8TnfTQIuqI9oOBvyhNx+R90hezpFVpm4YVqDz
         b7hdq/NGPlgl7P89EltJMwBSEFcSEgOMce4frX8YhEc2G7QvXczlGimxcMI5UItBHKEN
         0csuNd/KXWAZWj1H9zkl43Hjc/BNJXwpnPPsVJzwzrINvsW4fb3FNbPqbRs1HeCE5Kzb
         TZ99wExNMO/BB8wVdE/7Onjqoabpw5Ps3ybmURVsIV5MCEFMp2LfVFqpo1P54HWvzQVn
         Vg0z7L41U4EOAz7J1NHS7imTJUw7Qeb8GHfyyKpSXsAc5dGCrz6jUhSbfruEBAmvhmqs
         I9hQ==
X-Gm-Message-State: AJIora9MkD7ARa1UrdVCHvrO9i46efGO5KzxmDFjTNqhXX2G7o4LPuV+
        BT+rl7vvwV0sFCIe69p/Q30Vd49W5zA=
X-Google-Smtp-Source: AGRyM1tei8ieA1a6mCZFwIOAyKz2hIJ91XJFBH3Ye843yczThgaTMvzSiEfsJRV0/KOD+tyxr8SMCg==
X-Received: by 2002:a05:6402:2790:b0:431:4bb6:a6dc with SMTP id b16-20020a056402279000b004314bb6a6dcmr15766928ede.48.1656057898870;
        Fri, 24 Jun 2022 01:04:58 -0700 (PDT)
Received: from able.fritz.box (p57b0bd9f.dip0.t-ipconnect.de. [87.176.189.159])
        by smtp.gmail.com with ESMTPSA id c19-20020a170906155300b006fea43db5c1sm697779ejd.21.2022.06.24.01.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 01:04:58 -0700 (PDT)
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
Subject: [PATCH 09/14] drm/radeon: use drm_oom_badness
Date:   Fri, 24 Jun 2022 10:04:39 +0200
Message-Id: <20220624080444.7619-10-christian.koenig@amd.com>
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
 drivers/gpu/drm/radeon/radeon_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 956c72b5aa33..11d310cdd2e8 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -550,6 +550,7 @@ static const struct file_operations radeon_driver_kms_fops = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = radeon_kms_compat_ioctl,
 #endif
+	.file_rss = drm_file_rss,
 };
 
 static const struct drm_ioctl_desc radeon_ioctls_kms[] = {
-- 
2.25.1

