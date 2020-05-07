Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F461C9DA8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 23:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgEGVoq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 17:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgEGVo2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 17:44:28 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0FDC05BD0B
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 14:44:28 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d16so6739517edv.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2020 14:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YYgWnESh6GA5v0OESDXoG2vIRhhETFyg3jLhszcc4vQ=;
        b=DWWns2xvSlGzPgxMP9SaFal+La3ugXLBILgUhzIBLx1qKHh1M2kKUcWn8htwx+14hQ
         /xj8yvFubU2EGz0sN8ohxRCbR/H3S/DhR38Uk5KjH2FKMN+sfvKW+BXhbtIHNZiNwbWo
         Kz3nyrJ3wr7svHXNNNMTyUd9Nht/APxBhFKNHxGdLK2k7fBHvmWHlifcsCm8CgWLwXg9
         wtrZNFrm1eqCnjRdThbsEh9XdVQw6I+3Tzi16Enj0KuTiVTBrYd9cRYH4InFe68162kI
         2Oa9/B3B9FV6TaVEIUSkFI+iIhWgfkGWXnWtE7Mh1+sJwVXl1bhxfcxl+jjvh9ErDTrO
         sffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YYgWnESh6GA5v0OESDXoG2vIRhhETFyg3jLhszcc4vQ=;
        b=BTqiB/8vwIiukIiXVP2c2GlUPZ4KuBqUtIVi3pGpD+AdYvYM3VB+P7okkvtLhPGmY6
         /188q4ygOuc8K8FUe6Qf/E5+zRvFlCcurgiEx0XTh5z0ooMQy2NCLusjgffZqqJdDsNi
         EmrjO5Eg+XOD2/r/5+AzCEFO5vzchSyVacuUqp1wOGSj0ZzGjewzn+Ng8AGIvHAA8nPK
         M59Jd9KAgs+WLQZ6NLBgBbOjA+TTi9HVAcMcs/CG/1MUj+ZJS4ZnJiFd1x6ERdA7Mr1S
         UEyxxRsPZm/TyVmqBgBM+yUi378mZ7XDbexyakfJ5yoCLtX08GcnMslBX13PSOCNdUlK
         gkyw==
X-Gm-Message-State: AGi0PuYe6O3T45fpY5q78IfzWkwxr5WNieEGfJhAnOPH67E9OtFc4T93
        OoXI6uZZ8zu87MLMKy67glP1UVIrzsgNTw==
X-Google-Smtp-Source: APiQypLp6wHTm7EDK8AfP2PSXpgEq087c1HKWFStkQHDrDai1hobruGJfFO4+hL+A7w+Bxkg3C69lw==
X-Received: by 2002:aa7:de0b:: with SMTP id h11mr14191067edv.133.1588887867072;
        Thu, 07 May 2020 14:44:27 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a1ee:a39a:b93a:c084])
        by smtp.gmail.com with ESMTPSA id k3sm613530edi.60.2020.05.07.14.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:44:26 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [RFC PATCH V3 09/10] buffer_head.h: remove attach_page_buffers
Date:   Thu,  7 May 2020 23:43:59 +0200
Message-Id: <20200507214400.15785-10-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
References: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All the callers have replaced attach_page_buffers with the new function
attach_page_private, so remove it.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Roman Gushchin <guro@fb.com>
Cc: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
No change since RFC.

 include/linux/buffer_head.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 15b765a181b8..22fb11e2d2e0 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -272,14 +272,6 @@ void buffer_init(void);
  * inline definitions
  */
 
-static inline void attach_page_buffers(struct page *page,
-		struct buffer_head *head)
-{
-	get_page(page);
-	SetPagePrivate(page);
-	set_page_private(page, (unsigned long)head);
-}
-
 static inline void get_bh(struct buffer_head *bh)
 {
         atomic_inc(&bh->b_count);
-- 
2.17.1

