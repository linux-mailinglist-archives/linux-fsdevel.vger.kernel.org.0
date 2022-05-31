Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D9A538E4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 12:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245442AbiEaKAe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 06:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245452AbiEaKA2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 06:00:28 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA7387A33;
        Tue, 31 May 2022 03:00:24 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gi33so25609123ejc.3;
        Tue, 31 May 2022 03:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SAtySkLvcNUXzz7ib9IziiicjVedfmYHvbHXwfWUJSo=;
        b=ezNoQAUxlApzRSlxG4JiS/YCWxGANQEMBMCQgATxnhP3gp3+ZMVr411g/URtHp2KFA
         f2ChR3RFwngrCVs7MCiQWoekB8YkFKK+caOAEKNtMtGAJPRZLUJ7j2c00h0X9TNtL0T+
         aHJui7m2EbzQadDD+FbLWipH1ktNgQpHm6lf1sj28ZZvD/1iiXkps8ipinLAy0O42RLY
         zTTegaIaDQYL53vJKk+O5RhcAs4qMBsDl6YHcQkYjXJTY1EOfzlpFLZZ/uwgiQXHKYDy
         rZAwphV2HGF7mwKPv8gVMLQ03jkfQzE4TopEkv5xWw0C5eXfVpfmNZ6CvesBT9o5ZvqD
         ltxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SAtySkLvcNUXzz7ib9IziiicjVedfmYHvbHXwfWUJSo=;
        b=Qi186EXGsTGa47+LcWMHbqv2ZHoPrPtOfUP5O3cKg0hVFwirUKgLyisM6OcMaR0wHc
         LtMciFs+qLv94DjvLcUCxnzvFxZeVDgUhcUxBOYhaGElJct1cQT2xcnL1eXcnsFcCSDR
         EPr2ipPFA9v80NlBIHbscyOTEoFZWNk0UdArhb9783nCToEYdtHuPbcuuf1bxZOz/B7+
         Gw7YVm9BMjgf4awzadBVLWq6SYw/cbvp1+S+YICLnr+z6EjfIGe9gPiZCNwCO6mlkvUX
         fvJQkMpgwk5Mb0J7PrS/sbLa4v4swPzzSZirmOR4ysAqzAAydBkNN7PePGd8xPn10MB0
         GTKA==
X-Gm-Message-State: AOAM533BZYtQBQkUle+fOOySoOjPQMRUKyf2sG5a8X3T2e8Hb710hWIo
        3E3A7fmn2rYEBeslPOcxqTryUHkXGKUZKQ==
X-Google-Smtp-Source: ABdhPJxwBRRiOzRIc4wcP7bPQevp2uh1nTKIEri7IbT6+yRjL76vQVcRcKWHOXi4dB6U6w/w9RxFJg==
X-Received: by 2002:a17:906:974e:b0:6f5:2d44:7e3c with SMTP id o14-20020a170906974e00b006f52d447e3cmr51605009ejy.167.1653991223194;
        Tue, 31 May 2022 03:00:23 -0700 (PDT)
Received: from able.fritz.box (p5b0ea02f.dip0.t-ipconnect.de. [91.14.160.47])
        by smtp.gmail.com with ESMTPSA id r13-20020a056402018d00b0042617ba6389sm582062edv.19.2022.05.31.03.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:00:22 -0700 (PDT)
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
Subject: [PATCH 09/13] drm/i915: use drm_oom_badness
Date:   Tue, 31 May 2022 12:00:03 +0200
Message-Id: <20220531100007.174649-10-christian.koenig@amd.com>
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
 drivers/gpu/drm/i915/i915_driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index 3ffb617d75c9..f9676a5b8aeb 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -1748,6 +1748,7 @@ static const struct file_operations i915_driver_fops = {
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo = i915_drm_client_fdinfo,
 #endif
+	.oom_badness = drm_oom_badness,
 };
 
 static int
-- 
2.25.1

