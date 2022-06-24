Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2C055950A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 10:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiFXIGQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 04:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiFXIFl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:05:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADFE6E7AE;
        Fri, 24 Jun 2022 01:05:06 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id q6so3012304eji.13;
        Fri, 24 Jun 2022 01:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EK5bTabBrzOC4s5o5qACkkoAhewHbBIhpYTiUtnXhVE=;
        b=JwN96QcsgT/HsX0Xpol3mA630eF5N5PgavN/AUY9qBXwAsuVmy5cd/GZroEBwxc86X
         ZaDki0JPCb7oEXIMUIfGTswi25k7wAP19cnFbDOv/5t9BukJv9rDcgt58DFQ74NADH2u
         CYXiAOkYs3SpdYAaOxY3UUVCX6ptHEJ6TRdbP7p4or3Zgu3/WAjyLLMK5jZ7vcqCp7eW
         EZMJA+g9/yiNDw7fyROAvFU5wIayjnD37MVXkIpRkTRGWcd7zygExPX5kLKinTCY8K/T
         5pdb6n5eb6/P1j1smDPETJawXNBlVLLfjUdE34ynUZs+JMkdILaXVbWdyIS5dNH8CO+w
         oVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EK5bTabBrzOC4s5o5qACkkoAhewHbBIhpYTiUtnXhVE=;
        b=kCJf2k3X5MoX9kD1lSJnnK95Y5OR4Q4dPajw0uVAm8iuRGfEdaeGKZ1L31zjY3iZlY
         eK6Kjtmj6X0341nwUHA+mVHJ7q4WUFliDHfeeEQYYFGg4IViIVUhLRdV4Gy39ftqfZgi
         53RRbWtc+CJtSKU3a0MkKF4LkPbOOnS0JYz5NLM1TzqfqqTUkrTqi3lNuQKPz/01O5nG
         YoDFKyKKIMba6p/ZtClpglZFYGzs9obczrcfnr/d3FSPar6msl4rmnKoD3iNwyeCyMd7
         VUunAL1oYggh+N+YfZQ//Jcg4iUspN6HmtIbQmHiHiEFMXogFqT9qP02XfO7fu7BVIGg
         DTTA==
X-Gm-Message-State: AJIora/+32/ulkw+uG2WW1Zr3LqfLFnySJx6L/UduM9utPWQ3TAD7uBR
        XgdCWhBMgu9gfaQRdbnZHIomBAfqpEw=
X-Google-Smtp-Source: AGRyM1tgbH7HQwAMplhNlcow9evBtQqHgtM4KLSWjdQaSt6HlGVy+kDMyMimMYEkA9mtx94cpAF30g==
X-Received: by 2002:a17:906:7a54:b0:722:e8e3:ef60 with SMTP id i20-20020a1709067a5400b00722e8e3ef60mr11829570ejo.453.1656057904986;
        Fri, 24 Jun 2022 01:05:04 -0700 (PDT)
Received: from able.fritz.box (p57b0bd9f.dip0.t-ipconnect.de. [87.176.189.159])
        by smtp.gmail.com with ESMTPSA id c19-20020a170906155300b006fea43db5c1sm697779ejd.21.2022.06.24.01.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 01:05:04 -0700 (PDT)
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
Subject: [PATCH 14/14] drm/tegra: use drm_file_rss
Date:   Fri, 24 Jun 2022 10:04:44 +0200
Message-Id: <20220624080444.7619-15-christian.koenig@amd.com>
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
 drivers/gpu/drm/tegra/drm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 4cdc8faf798f..cc0c2fc57250 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -804,6 +804,7 @@ static const struct file_operations tegra_drm_fops = {
 	.read = drm_read,
 	.compat_ioctl = drm_compat_ioctl,
 	.llseek = noop_llseek,
+	.file_rss = drm_file_rss,
 };
 
 static int tegra_drm_context_cleanup(int id, void *p, void *data)
-- 
2.25.1

