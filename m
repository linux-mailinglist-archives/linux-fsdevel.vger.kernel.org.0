Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02121538E70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 12:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245580AbiEaKB4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 06:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245454AbiEaKA3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 06:00:29 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40E5880C8;
        Tue, 31 May 2022 03:00:24 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t5so16807078edc.2;
        Tue, 31 May 2022 03:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CBtdyMzsAJ1/aOexJ9rl7ZeO2ErFHAD5HxTQN3Dqn3Q=;
        b=clhRBft+k4X+UmpE7If794qBfOtGFA7pbEByZ2pinyy2YRsA2O6lLDOynJMSIVJoFM
         Wvro65LH9mtebwNBzBwhrtxkvox46+r6wwZH4eYd+mYlM8gfp2s7dxCrtouRZ2HvQ9rb
         5qqKVWSj4jEdYbd8S6LPV6K7PJCG4fHMCcDZkvLBlGNukalvsGNQKBVKwFWP7x+ZUNc0
         mZXiAkmse4krF81HSAGDete8t78Ll4SG7G5gaBi9gesUSTbQOYIe2O3LdV31q8XNetNL
         YzKH8enFbBx54aGHmjR5bRjrnOqioVrO6oNE62MwqlFCmvCaYYCBPM8DqoQ36EIiOpxJ
         EWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CBtdyMzsAJ1/aOexJ9rl7ZeO2ErFHAD5HxTQN3Dqn3Q=;
        b=Nqf67QK1xFhpnv3I+0YooXGTyza+0FyGc63aFgiOHpDkLk8bGbIdomrtXLmfObV57J
         DtG/u2Bh+5rHsyAPgSXG2qAnu8n7yueXB6DX9KJ55ZR8jF0TYOUk3PfMdUGqFYT9p3/q
         ZfGJE+x6gizeti6Fpxnw3zOWzB8kxaklkjEwyl62Tf9xHN7YrWV7l0hJJHOGLu1kuAvy
         GHjw2hjxUtEbcZKGwYXPJopHt3XlKOKH3bNe+lJHIjoelIbACxCoBYwVKLGYf0BG12Lp
         phNg4TKGFiljbQgwr6f5kgZhZYwAkjIZiI6ThDJabLKBn4PB0VKb+Hm6q2NxO1wZ7FDY
         ImcA==
X-Gm-Message-State: AOAM533yI1m1A8r4YarlX8Wkm3XlUzAJlaVblAU/VnBoOiuImk0UeemL
        hG2FsgObjE/Zye8SQvbq0PLeDvUE0u1NtA==
X-Google-Smtp-Source: ABdhPJw42FrkjYM4LnR278q9mfBravYOk4Zj2lNKJYJUZ/HCUi9Q4cA6PZiVhbQJK68MTRAAzi0sdA==
X-Received: by 2002:aa7:d285:0:b0:42d:ca4f:a046 with SMTP id w5-20020aa7d285000000b0042dca4fa046mr13232089edq.354.1653991224557;
        Tue, 31 May 2022 03:00:24 -0700 (PDT)
Received: from able.fritz.box (p5b0ea02f.dip0.t-ipconnect.de. [91.14.160.47])
        by smtp.gmail.com with ESMTPSA id r13-20020a056402018d00b0042617ba6389sm582062edv.19.2022.05.31.03.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:00:24 -0700 (PDT)
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
Subject: [PATCH 10/13] drm/nouveau: use drm_oom_badness
Date:   Tue, 31 May 2022 12:00:04 +0200
Message-Id: <20220531100007.174649-11-christian.koenig@amd.com>
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
 drivers/gpu/drm/nouveau/nouveau_drm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 561309d447e0..5439b6938455 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -1218,6 +1218,7 @@ nouveau_driver_fops = {
 	.compat_ioctl = nouveau_compat_ioctl,
 #endif
 	.llseek = noop_llseek,
+	.oom_badness = drm_oom_badness,
 };
 
 static struct drm_driver
-- 
2.25.1

