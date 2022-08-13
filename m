Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899B0591967
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Aug 2022 10:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbiHMIVU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Aug 2022 04:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMIVT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Aug 2022 04:21:19 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6C933360;
        Sat, 13 Aug 2022 01:21:16 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so2775364pjf.2;
        Sat, 13 Aug 2022 01:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=8J2yQzwToOaPX464zrF30DjQn1+095iGEYHxU+cVWDs=;
        b=OX4FXqRRqM8h+6sJ2eEVVjT5JlCSlIQGjkiBH9sSOKKMP8PWj6LrWes0P+kq7HK7LR
         11Rn33m7Vb929Qq3zkKw0ZejzTbHu6ZLsM+vCqYpOZvbtNEiSITLmBhByiXMTQ/67Ekz
         7IlVoVumINUUZMUmJB3rt995T6gZ0T1mj5fi+cGMz9o8DYIPINIpxlZ/o+YZFRu83cI7
         VssKJek8Wb6LZLEtVEP0carPAuR7+pp4vRL3UkL9+VGYs9+VF78/goOrT1ZTZCxFgE3X
         GWtwgtLhQFiX+Wt1jRAE9ERaBrqpoEPlBi0Ma5YJxMrVMnUSnzcf1k+pqlUUF441CC9q
         z83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=8J2yQzwToOaPX464zrF30DjQn1+095iGEYHxU+cVWDs=;
        b=hUnrHM/KEwbWSVzSI6WOauoS6qPnuLpUPz5f6jtAIs+YwzPsBUNUawPfz8mNQlu2z4
         NIurDZzlSIlWvleMalz8Fb7//2zF7azbEMPbIN91Cex337GLpJ9j4VkjGeFcq2DvFBFb
         08ZE/29fpKoKBJAGp37cPazofxkhEaTojAke1Uj/LzCeyVrXtnAIwInFutr2EaeO9+Sc
         HoK3WPdta4AhPDPBBCDYGC9a/0Oil9E0qwHIlLyMzQK9AReVesmPEOjYNEHgQxqtxi8P
         7Hx1YhkTnegPufGW0gkmgSaliWglnr4Pn+c6KMz9a3tj0IMl3V4gHifBKI9XsHnsFaHX
         Ty/w==
X-Gm-Message-State: ACgBeo14HQXjFkVvaY+ZBpjkYyB4RsbEcAt+zHvtjS952pWAjZu4ebLo
        I+dUAUEdLJCOLn2wkX7739I=
X-Google-Smtp-Source: AA6agR4GB8X04N2F7C9JZIAvHIs5zpN+gvaTfqq4HgCuIxREwmwnry3zz89g7npVAHYfUYYiKl1oZQ==
X-Received: by 2002:a17:903:22d0:b0:16f:7754:1e99 with SMTP id y16-20020a17090322d000b0016f77541e99mr7360793plg.150.1660378875776;
        Sat, 13 Aug 2022 01:21:15 -0700 (PDT)
Received: from autolfshost ([2409:4041:2d12:e5fd:fa7e:5407:87c6:7072])
        by smtp.gmail.com with ESMTPSA id l8-20020a17090a4d4800b001f4dd3b7d7fsm1080636pjh.9.2022.08.13.01.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 01:21:15 -0700 (PDT)
Date:   Sat, 13 Aug 2022 13:50:48 +0530
From:   Anup K Parikh <parikhanupk.foss@gmail.com>
To:     bigeasy@linutronix.de, mcgrof@kernel.org, xiubli@redhat.com,
        akpm@linux-foundation.org, jlayton@kernel.org,
        skhan@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] Doc fix for dget_dlock and dget
Message-ID: <Yvde4NryqBnZesTI@autolfshost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

dcache header:

1. Remove a warning for dget_dlock

2. Add a similar comment for dget and
   mention the difference between dget and dget_dlock
   as suggested by Mr. Randy Dunlap
   Link: https://lore.kernel.org/all/29708eb3-ff1e-411e-cf84-7aa9af765603@infradead.org/

Signed-off-by: Anup K Parikh <parikhanupk.foss@gmail.com>
---
 include/linux/dcache.h | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 92c78ed02..aa473b6bf 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -299,12 +299,15 @@ extern char *dentry_path(const struct dentry *, char *, int);
 /* Allocation counts.. */
 
 /**
- *	dget, dget_dlock -	get a reference to a dentry
- *	@dentry: dentry to get a reference to
+ * dget_dlock - get a reference to a dentry
+ * @dentry: dentry to get a reference to
  *
- *	Given a dentry or %NULL pointer increment the reference count
- *	if appropriate and return the dentry. A dentry will not be 
- *	destroyed when it has references.
+ * Given a dentry or %NULL pointer increment the reference count
+ * if appropriate and return the dentry. A dentry will not be
+ * destroyed when it has references.
+ *
+ * The reference count increment in this function is not atomic.
+ * Consider dget() if atomicity is required.
  */
 static inline struct dentry *dget_dlock(struct dentry *dentry)
 {
@@ -313,6 +316,17 @@ static inline struct dentry *dget_dlock(struct dentry *dentry)
 	return dentry;
 }
 
+/**
+ * dget - get a reference to a dentry
+ * @dentry: dentry to get a reference to
+ *
+ * Given a dentry or %NULL pointer increment the reference count
+ * if appropriate and return the dentry. A dentry will not be
+ * destroyed when it has references.
+ *
+ * This function atomically increments the reference count.
+ * Consider dget_dlock() if atomicity is not required or manually managed.
+ */
 static inline struct dentry *dget(struct dentry *dentry)
 {
 	if (dentry)
-- 
2.35.1

