Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E1F52BDC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 17:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238911AbiERPAG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 11:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238862AbiERPAF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 11:00:05 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B98E19FB3A
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 08:00:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l38-20020a05600c1d2600b00395b809dfbaso1201864wms.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 08:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XxzsoVj48zOzOROlVdTIcCV40gZjRv+E/wRXittuHe4=;
        b=cz9fCFBV++bWFC/JYfgTrhcN93AG8lK1ctGN000/m7PclFgC8SZWUitkQkZoPXENZE
         sA+n8PM50pkKXs4527Oi58PHiGMFk6tqq3ls7WoGXN2ysErTLOjGD5ZnzzvDdGmPMBy3
         kPseFF+55tK6+fIR7LVf2cU4vb3Y7P9H4gvpi8Mqo5Ib0nIf7NZWm11Bo+7AFQMVx9Yz
         F+M74bMeUPVnsQE0L7ItQ/sywum/woWvGoj/cgHtS2obFX0DhyAL1Ors9D0TDkWuk8dd
         mZWE2NfuSLVZ/YY7d+oO4Z6QofKBP/k5bub329jTSM6ZtOhqExFeBd8nMcg8jegBgUot
         nrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XxzsoVj48zOzOROlVdTIcCV40gZjRv+E/wRXittuHe4=;
        b=2xpBcD/ZVY5NMDpU2Zp0HtR/tSxniiQLwcrg15d8VzSZHjzsY/VzvQGBW2NAnSN1V2
         hNHS3ozk7B4+TpFcWxNYA7TtWfyAK3hY8Hj6PJ8OtsA/Wc6P+jo8hdB4kMnS/l9rWjlm
         ci9BaP8v8Toih1reaCXHMF+2PtMmvFDYWiO0bjQQCC0M4IKpdAQVlt/QlHvparfsrdgT
         IZcyQlEgQ3xKjluzHhrGV0eT00h0JD+T2YqRUjvXhHN9tmc4CTIiSJJYz6Cj5nTXTg8F
         mDLMrzCgUNvXns+NqPNsynH2KQ9t/VeaopO+VBs8Gcg+02kwD4EYRu/N2tbYaZc3nGce
         2wXw==
X-Gm-Message-State: AOAM530RjZNGatXSwpPCW/YBOgcipINuXqY0uz4Nud/pu3Wcr7FYUeEK
        r43lvm4wdDnzCrsbzoG2VzQGIRZ1o24=
X-Google-Smtp-Source: ABdhPJxYZ366ZKHFbg/aLrXEIgO5JnSA4TLGJzJNm/VswQnQPfe2X8xctkXeqf+DsqUJfrb/+5GZGQ==
X-Received: by 2002:a7b:c5d0:0:b0:355:482a:6f44 with SMTP id n16-20020a7bc5d0000000b00355482a6f44mr356894wmk.58.1652886003235;
        Wed, 18 May 2022 08:00:03 -0700 (PDT)
Received: from DESKTOP-URN0IMF.localdomain (cpc78047-stav21-2-0-cust145.17-3.cable.virginm.net. [80.195.223.146])
        by smtp.gmail.com with ESMTPSA id h15-20020adfa4cf000000b0020c5253d8d3sm2538933wrb.31.2022.05.18.08.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 08:00:02 -0700 (PDT)
From:   Oliver Ford <ojford@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     ojford@gmail.com
Subject: [PATCH] fs: inotify: Fix typo in inotify comment
Date:   Wed, 18 May 2022 15:59:59 +0100
Message-Id: <20220518145959.41-1-ojford@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Correct spelling in comment.

Signed-off-by: Oliver Ford <ojford@gmail.com>
---
 fs/notify/inotify/inotify_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 54583f62dc44..bdd8436c4a7a 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -121,7 +121,7 @@ static inline u32 inotify_mask_to_arg(__u32 mask)
 		       IN_Q_OVERFLOW);
 }
 
-/* intofiy userspace file descriptor functions */
+/* inotify userspace file descriptor functions */
 static __poll_t inotify_poll(struct file *file, poll_table *wait)
 {
 	struct fsnotify_group *group = file->private_data;
-- 
2.35.1

