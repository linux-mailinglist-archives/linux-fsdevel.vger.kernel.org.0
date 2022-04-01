Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EC24EE6F6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 05:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244762AbiDADyd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 23:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiDADyZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 23:54:25 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF11129279;
        Thu, 31 Mar 2022 20:52:36 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id y6so1413869plg.2;
        Thu, 31 Mar 2022 20:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LxPG2mpbpgdg5W4Fei+LZxCM5WvyBZ/Qj+QMe9CK3jY=;
        b=VSGqhbbErXhfRKb/EP95CpvDlJaqHmF24MHDXj4qIGyl5U7DKiVi3Q295jWbHJlQZs
         RUGDBqBsJaEmcxr03IlzhOvh6lEjuV+gW/lq8gea61XHQEx0gk2WwriznZrneVd4KcUm
         O+Fh9/eYravoB7OomQjDQ7596DjtNbJRQZJlC9LdyFMBrA0Ky3D6IAGkhUNNF5g9Zm6h
         66R61UcQqTzy6s511JH1W/5eCnEszYPkG6vuiS96pC4xLwCj8fPi+O+jcRC1Jn5150S9
         u4+ZdCmsOa4pw2Zy4M+KqzUx4/iOu2KCDVd9rAirbN1xXT8OP9j4oTMPFihGvl6VYC5q
         L3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LxPG2mpbpgdg5W4Fei+LZxCM5WvyBZ/Qj+QMe9CK3jY=;
        b=kfpIftmd0+h+YS9Pw/7xLc1LyPbw6PiIpWQJ94mMo4auRRiBQ0QwloEEF8TXRjAOcg
         1XnAHoemUDf/6/dqejZV4l18g9y2F5nBafeYumUjjfQ1R05rQfbzqy45m84Ucn3h/eG2
         1Uo29AsRN8g1/4d356mus61nAGWP8AxetBVbmPfsZNjfqLDYk+yEwpRgcUt2HD5Mj/zK
         ltM0T3+5/BzeUI+ok0qoKmZ9dYiPREagq/6oW6vIQrZkujPzIbTYPFF+Y8X3P4Ye7TP8
         8GfvQXqs4esW4A27OuOIwiDsT0U/ZdvvNPaELwjiMNOANghjkEmFPzVM520kWEo8AArX
         Rt3A==
X-Gm-Message-State: AOAM532BYpq2dbseCqJxH4YuQKDw5UoWczWaIyvxlWL8FOJ/1ARKyjP7
        5CZxRAVdmlgYDIrqlVjAt2o=
X-Google-Smtp-Source: ABdhPJwPRaIsAvn9tUV2ITPY/djkqas+NX3RSnWj4lMJM7obvGzz2BMpJTcjoYuaWqVJANY/xfVmTQ==
X-Received: by 2002:a17:90b:504:b0:1c7:3095:fd78 with SMTP id r4-20020a17090b050400b001c73095fd78mr9628348pjz.142.1648785156200;
        Thu, 31 Mar 2022 20:52:36 -0700 (PDT)
Received: from localhost.localdomain (114-24-19-120.dynamic-ip.hinet.net. [114.24.19.120])
        by smtp.gmail.com with ESMTPSA id 75-20020a62144e000000b004fae56c42a0sm966922pfu.211.2022.03.31.20.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 20:52:35 -0700 (PDT)
From:   Zhiguang Ni <zhiguangni01@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhiguang Ni <zhiguangni01@gmail.com>
Subject: [PATCH] d_path:fix missing include file in d_path.c
Date:   Fri,  1 Apr 2022 11:52:21 +0800
Message-Id: <20220401035221.454319-1-zhiguangni01@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Include internal.h to fix below error:
fs/d_path.c:318:7: error: no previous prototype for ‘simple_dname’ [-Werror=missing-prototypes]
  318 | char *simple_dname(struct dentry *dentry, char *buffer, int buflen)
In fact, this function is declared in fs/internal.h.

Signed-off-by: Zhiguang Ni <zhiguangni01@gmail.com>
---
 fs/d_path.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/d_path.c b/fs/d_path.c
index e4e0ebad1f15..f9123b84f1ba 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/prefetch.h>
 #include "mount.h"
+#include "internal.h"
 
 struct prepend_buffer {
 	char *buf;
-- 
2.25.1

