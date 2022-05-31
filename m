Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DB0538E5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 12:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245516AbiEaKBy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 06:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245471AbiEaKAa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 06:00:30 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C6284A14;
        Tue, 31 May 2022 03:00:29 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t5so16807078edc.2;
        Tue, 31 May 2022 03:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dox2mMkLl/5c9D2gga469zGN9zQ+j614KEWkuEZ4MV4=;
        b=TtHtny7NdbtnaKMNgHxxZ1P6YiZMqlmrfAD504KQpkpUdOed8kz6s4qe73Oso8t6aL
         GH45XnJdlS9fPbcsu06cjzlIDPfSLe4vdmLZk7L0colYmkysDdcFQUfaXrpgfhWM8Uu9
         mwNsso9fA2grp70nK3W+gfRLzK4em/GxgeHMyOxZAQwF2uHJZHUlKeoWDTsO9Pf3mIoR
         +MU2pw1Hj93sIubQtkBk95FwjgyvioAIuxLDOXetbKFAI5WclUufvdU4gR+xUVC90tO0
         kjPZ8sljqOzsGufGGBR2iVo/n5ohkrTAeCPS+lQRYxTn5nYYxcG4Bmjfy2K5n7PsifJS
         ohDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dox2mMkLl/5c9D2gga469zGN9zQ+j614KEWkuEZ4MV4=;
        b=R9EQlfnogdhovkuWtbKi7WmNKNGzsgbZzVQcou2RUYVzeU3Z1K/Q9/0Hf/VA291VGC
         PJcI1he9qf43XlhXd2zDECwCEuridMqly+xh9uy00J012va49lpQX/xDBIDxKO0Gq1Hr
         89H2ezS3LCdFQZshRPneapEvds22w3qMl88tY9CWlbIn/1PgZ4r/swKkLF5ylb0jR5Au
         a5uON4cJc9MAWGoR2n4eD785pwbtlKXH3XvsV7/i6g56lanyyzkxtA//uzh+PF1aYNwE
         KYcIkbTyT0ODLPgrInmMBC649i4ufFJ/IyWu4JnS70uDwXJdU1CWb4+VRiiui9czkC8h
         43og==
X-Gm-Message-State: AOAM533ay4mCTKdrXplfP9GfFptIV0dqH2UB+WIH6E3x6U8zFUKUOAck
        UZRRf92qB91xKHUnRm8wH7BPVbp6SLtYTA==
X-Google-Smtp-Source: ABdhPJwaDMI96aKfbI0lqqtNolmvi5yHB6A4EjRXIsAbd+0AZ25rrn/qiMxaKibl1aGvqzYNEfcjIQ==
X-Received: by 2002:aa7:db02:0:b0:42d:c3ba:9c86 with SMTP id t2-20020aa7db02000000b0042dc3ba9c86mr14927377eds.337.1653991228918;
        Tue, 31 May 2022 03:00:28 -0700 (PDT)
Received: from able.fritz.box (p5b0ea02f.dip0.t-ipconnect.de. [91.14.160.47])
        by smtp.gmail.com with ESMTPSA id r13-20020a056402018d00b0042617ba6389sm582062edv.19.2022.05.31.03.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:00:28 -0700 (PDT)
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
Subject: [PATCH 13/13] drm/tegra: use drm_oom_badness
Date:   Tue, 31 May 2022 12:00:07 +0200
Message-Id: <20220531100007.174649-14-christian.koenig@amd.com>
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
 drivers/gpu/drm/tegra/drm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 9464f522e257..89ea4f658815 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -803,6 +803,7 @@ static const struct file_operations tegra_drm_fops = {
 	.read = drm_read,
 	.compat_ioctl = drm_compat_ioctl,
 	.llseek = noop_llseek,
+	.oom_badness = drm_oom_badness,
 };
 
 static int tegra_drm_context_cleanup(int id, void *p, void *data)
-- 
2.25.1

