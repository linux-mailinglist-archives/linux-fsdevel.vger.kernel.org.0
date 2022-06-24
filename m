Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922225594DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 10:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiFXIGC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 04:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiFXIFf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:05:35 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BD96E795;
        Fri, 24 Jun 2022 01:05:04 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ge10so3073474ejb.7;
        Fri, 24 Jun 2022 01:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7h6tONB4sw4uv1o8ITO08dQoAN0r8TWfzTc1cDvUnqs=;
        b=Q59ZDM0bs66kYTouHFV3SH7kQiFRv8zAdPLal5R6bK6lLwicp/kD7pik3lBee8DZX6
         WjFSGBfwF+GZvlJE8V2r4yZYlHtq+V7w5wxAfdmue81Rk5Au3jDlZEuUJFHZndYxL05t
         Ibe4zJZteTFiI3OYBpLOLUg3BL649o69+FMAHcL8GF+ZgZAjH9/pTivOYrkyoaDuf/d6
         QStbApg579KEKEi3o8lC8TkfL1GqADjPzKl4hmJsbaygYpN4yg8E0HDtU5D+m69zgWyk
         oqqPfy5Xdm5n/aLuRFeGPi/fosEZBhi026xzbJX77OYzK7dtCEyZRZkwWliyAnH8t2Be
         qmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7h6tONB4sw4uv1o8ITO08dQoAN0r8TWfzTc1cDvUnqs=;
        b=QYwGglxlM2PQF1c8GWGrvdwWE/6/+rbGAc1sg79rrpP3b7aZsDdWHpHHpmJS2h7Z80
         OGrx0Wu/KRXHrcQSVAPFqX/TWl4f8eB97r5BBsESVkFmEuWz1gczt2m6iIa3lJF4GTEh
         31R8U0E2rmd93FMunymvnXY+bDm6VGxoxupCy6xnNOMbEvjxcYPAgjEvI59tRBLvHI5q
         7h1rBlDi6obfNtL0ucQ8GLpkP63i6HQbCAQtKdNuFgGvGxF9cUS/1pm4pd+/x+dPinH/
         M0Yhh5T+2bwEHF+GesMZFGw6ByhQ2xkWaxsz2WooNwO6/ImAdW6cTIyaKU5fb/654Nas
         i13Q==
X-Gm-Message-State: AJIora8qBX39a2Sbo0c+SwuMl33y9xnX7vjNmZ6TfM9SP6er5OlqM8Nu
        +9RlqDWy6LK51oKfOuy/SkWajUXQM+M=
X-Google-Smtp-Source: AGRyM1u1kM9hV5B2jw9gM+JFOfPel32sur1C9sCcKAHE7MFpkQ9lyzjasZeMq//UEzPa6HSaMFHF8w==
X-Received: by 2002:a17:907:97d1:b0:722:e6fc:a04 with SMTP id js17-20020a17090797d100b00722e6fc0a04mr12082666ejc.217.1656057902587;
        Fri, 24 Jun 2022 01:05:02 -0700 (PDT)
Received: from able.fritz.box (p57b0bd9f.dip0.t-ipconnect.de. [87.176.189.159])
        by smtp.gmail.com with ESMTPSA id c19-20020a170906155300b006fea43db5c1sm697779ejd.21.2022.06.24.01.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 01:05:02 -0700 (PDT)
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
Subject: [PATCH 12/14] drm/omap: use drm_file_rss
Date:   Fri, 24 Jun 2022 10:04:42 +0200
Message-Id: <20220624080444.7619-13-christian.koenig@amd.com>
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
 drivers/gpu/drm/omapdrm/omap_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index eaf67b9e5f12..dff637de00a3 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -684,6 +684,7 @@ static const struct file_operations omapdriver_fops = {
 	.poll = drm_poll,
 	.read = drm_read,
 	.llseek = noop_llseek,
+	.file_rss = drm_file_rss,
 };
 
 static const struct drm_driver omap_drm_driver = {
-- 
2.25.1

