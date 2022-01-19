Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B9549410C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jan 2022 20:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357134AbiASTl2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jan 2022 14:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357136AbiASTlY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:41:24 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B996DC061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jan 2022 11:41:24 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id g11-20020a17090a7d0b00b001b2c12c7273so3288287pjl.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jan 2022 11:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=Be7Cm0n+n8HNt/Mpjjw9TGmfe8Nlv6EQrvqvRZvGl/M=;
        b=YOgdwtUIAM/u3XgauPcto57FqA5Ps1loGCHL9DWKvMtl1qLekv6LLc4Ll1hC1G5V4c
         5WWQ4MsceyJDP+BgQ3ZT9BTSCm9r/RKzIcHdWHg80sVKr2ShsrtbAvvRFBRt+j8xZSBQ
         omqDvTR17qcsP0j8CIGtaKCWPYgNbuOH6okihcr8dJFD/lGj5BwhwsWdIKb05YVkQwsJ
         fLayXsdVUTOlIFob9eLVF0vFSqMm9lANoZ+VmM9u4eiF26OQyDVr8zzbmdpNaEn4OaaM
         YhS7Lkz4P6RfUIJyHCmoSR1fwqn7d0ZCFLuxyfbE+E/ce8XZX/c2KyWgsEp3uYdja2zW
         FM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=Be7Cm0n+n8HNt/Mpjjw9TGmfe8Nlv6EQrvqvRZvGl/M=;
        b=2DpLwom1jhqpyv62Alg+N1UQ0lkQWVqkUFNA/3zP7zmWQ5vpT4OVo7gExQFrfb7Ttd
         mRNeTYUaYeMWai1rX9TK1WBFizt9GYCzShOHMf3YnhtdJush5UaVx3FBdDMIFqoZx4JS
         Oiun5vz6oD8rDjZ2otLbEnqTabIeQ82flAdjvGjfx/fSJuPUKlZduXNt0hFkryIGKjU4
         Rax5uJotJ57KzTYCgjgyIOvVNXa+EKcj71jW6IdCPSIa8ol6utixwL8iHrnZnWpUT1MJ
         lYBLZHeZFYThGsffjCkEOw8X6+tgRI1C84R7hYZuSyjNEJ6/pbY6RxICO+329QY+EL7B
         bxvA==
X-Gm-Message-State: AOAM530oSV+14iqlQ4HCJnT/dcuPpa3al+KOKPpY7hXqpw0LzM2pWF43
        Czum2yYG5RzpvBUtdA/tgX22Xw==
X-Google-Smtp-Source: ABdhPJyi+LG876A4ka/vDXnkG2CKCQWt3/k45qvbs3eidfCuhbzkuKD24R0jMcsVRWaEdZcYxH3Qnw==
X-Received: by 2002:a17:902:e851:b0:14a:6763:b580 with SMTP id t17-20020a170902e85100b0014a6763b580mr33822833plg.171.1642621284321;
        Wed, 19 Jan 2022 11:41:24 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id s23sm440737pfg.144.2022.01.19.11.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 11:41:23 -0800 (PST)
Subject: [PATCH] perf_events: sysctl: Avoid unused one_thousand definition
Date:   Wed, 19 Jan 2022 11:40:19 -0800
Message-Id: <20220119194019.27703-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     mcgrof@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     keescook@chromium.org, yzaikin@google.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

The variable "one_thousand" is only used under CONFIG_PERF_EVENTS=y, but
is unconditionally defined.  This can fire a warning.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

---

I went with an #ifdef instead of a __maybe_unused because that's what
the other code is using, and I left the one_thousand in order despite
that requiring another #ifdef.
---
 kernel/sysctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ef77be575d87..81a6f2d47f77 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -122,7 +122,9 @@ static unsigned long one_ul = 1;
 static unsigned long long_max = LONG_MAX;
 static int one_hundred = 100;
 static int two_hundred = 200;
+#ifdef CONFIG_PERF_EVENTS
 static int one_thousand = 1000;
+#endif
 static int three_thousand = 3000;
 #ifdef CONFIG_PRINTK
 static int ten_thousand = 10000;
-- 
2.32.0

