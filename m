Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F006D5594E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 10:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiFXIGE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 04:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiFXIFQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:05:16 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCE36E788;
        Fri, 24 Jun 2022 01:05:01 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z7so2267681edm.13;
        Fri, 24 Jun 2022 01:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TEEoP8KCSv5pjlxAC2eGIjep+gJf30N0QWrbUiAblRs=;
        b=NsqpIeUqz6z1oXfKvdYH1/TqTFTXK9j1sJxHR/6+teGsI6wAcS38sTUENz1r/j+qWB
         Zx5BEXmUAQRLHC+0/WMd5cHg7pqTjt2mJsun4y65v/FkbkdUuEowB0Xeil8wiVIopW0C
         v7uFC+sCP7XMFz3Y74shfL8paThvoo6rqN5jyvJIG2lp6HaYqdHKi3OzUK5gdPk77trY
         JLyV0mg+oHiky3PUkntBd6bE+5pzI81H81uvLdg5+PBonm8eW64IOlBu28lZPhHT9xEL
         e7ST6iswEXQNp5oHPD8epprMYI811lDLgUfizTiIewMN4uvazsjzOwEcCSjRB0yo2rxG
         tMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TEEoP8KCSv5pjlxAC2eGIjep+gJf30N0QWrbUiAblRs=;
        b=486lAxdeXKRPNWmkCvEekzcz//SwRoOc70xCI/eB45iCbudC++2AEs6SQU7CCo43qW
         ngXGqz3yfxsHgYCbsbMDCWlh5MjWkm/HTydJ+sjSoN5nCPcooUYWyjgMLfrwS7UWRkRg
         GDrE4UD/0Qm38sV8j+rCCpYcQtCW+XEfw8NiiJTz60dlceYH3Yuhz0V2QBXBEYQfSYTB
         hdX8upnoftXmo2PcLllOMSGr7WE74kbTtn8s5LqxB05faeZ2o1iH7cwcyvAom1ZVAWYW
         cmhxwnj4wARLbzvhklZ5h/7cWbqronQlAB8FuXA0YwbecRffrCbFwM0RuY9DGzi4O+h+
         utHw==
X-Gm-Message-State: AJIora+3EI9Uw/I4YKMVFIF/3hYm5Cqx8MstvsqoS61SaJb69oi8mtNB
        t963w7QoYlKO74UHyAcS7UwKRCwXvG4=
X-Google-Smtp-Source: AGRyM1s12FOWdmvVSggeHhbhrd16lE3/DoVEUD/LwuW4RhCc+Y/hP3ZDhy6clyaoJ7ITIboMGB65hA==
X-Received: by 2002:aa7:c952:0:b0:434:edcc:f247 with SMTP id h18-20020aa7c952000000b00434edccf247mr15543375edt.412.1656057901251;
        Fri, 24 Jun 2022 01:05:01 -0700 (PDT)
Received: from able.fritz.box (p57b0bd9f.dip0.t-ipconnect.de. [87.176.189.159])
        by smtp.gmail.com with ESMTPSA id c19-20020a170906155300b006fea43db5c1sm697779ejd.21.2022.06.24.01.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 01:05:00 -0700 (PDT)
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
Subject: [PATCH 11/14] drm/nouveau: use drm_file_rss
Date:   Fri, 24 Jun 2022 10:04:41 +0200
Message-Id: <20220624080444.7619-12-christian.koenig@amd.com>
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
 drivers/gpu/drm/nouveau/nouveau_drm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 561309d447e0..cc0ac7b059fe 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -1218,6 +1218,7 @@ nouveau_driver_fops = {
 	.compat_ioctl = nouveau_compat_ioctl,
 #endif
 	.llseek = noop_llseek,
+	.file_rss = drm_file_rss,
 };
 
 static struct drm_driver
-- 
2.25.1

