Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFF85A3BE7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 07:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiH1FFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Aug 2022 01:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiH1FFB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Aug 2022 01:05:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEDD15719;
        Sat, 27 Aug 2022 22:04:57 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id f24so2336398plr.1;
        Sat, 27 Aug 2022 22:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=3zzuKMN3+5IFXI5agpZAhRn2uD/fOl95p/kXK18VWfs=;
        b=fwpsfQTDrkLaocRYnB83r1ZEa4jDsrgXmIPYQ0oHeMky7kFUQZdAIslJZ9DLVDi+cl
         OzkFARMqHDlZy49mDIsj+VcEjPqBpa7IJeH33RKxiO6x/fOaBl3ni8w3n+9GgJ41i19R
         wFuYykGtv+mlWDO7KfhWsNealu1Lb48XnZy4RHA0SLzrQRF4gpmWCib+5zeTANl7YbcI
         hhgX6nMY5a83sUXdWsq5W5ZznhhtHg/iUJpfO5omIoZEeNErgjahUnHnZEa11NuWBbdv
         wTEBxVsT/rZwGmOs7nYANeyC6RqeHNUIVFb7XNpizXTIgdyZFUePEVlu9dnlMCoBSStq
         Cw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=3zzuKMN3+5IFXI5agpZAhRn2uD/fOl95p/kXK18VWfs=;
        b=rmeFhmxCmy9/nZ6jR8I9DsPQ94LpvX9CMqJvH+bpi3tebz2AMdVWTSSyVeDKXLfcyb
         d84V2e1nBnp5pj+Z/xyPmJ/NZP2i1jS1ElwLm4ofW9/C2tHsh0VBlm79bJILCue3jH+w
         z5TPa6A1sLCcPIbWG/9If09pY+NubcGL1pj9J2Sgf6ZN0eQjzsF7vFJOOZTCOMnHiWaI
         neY0ZuYrSp1b4CotwIY7hFhHQql238hqTPSfjWqqsqCyQJBJKeMRCS82CgVpmnc9wzGP
         sAv7UFeXW/2dCZ+IzMyoMfglFLuKd8Az+lTuxOY2+6RGZqHIrir77K+Pwg8Ro57qNm38
         yVog==
X-Gm-Message-State: ACgBeo3bGGEkg73bYOKa6tW1R0SRvqIrLVcECqcnnOAc2JDNH06Cy/dK
        vkHT/60g7C5pY6XX2K/ygyWtyLxHOfY=
X-Google-Smtp-Source: AA6agR6iq5ZtBsmG9HyFc6CpVZd+ipiLECN7xma9bLTiyZGuwthUuCeiEAnfgHRCicvA7uMqbiXZyQ==
X-Received: by 2002:a17:902:ba8e:b0:172:ddb9:fe45 with SMTP id k14-20020a170902ba8e00b00172ddb9fe45mr10485494pls.86.1661663096590;
        Sat, 27 Aug 2022 22:04:56 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id w129-20020a623087000000b0052d4afc4302sm4706602pfw.175.2022.08.27.22.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 22:04:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/9] kernfs: Refactor kernfs_get_open_node()
Date:   Sat, 27 Aug 2022 19:04:34 -1000
Message-Id: <20220828050440.734579-4-tj@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220828050440.734579-1-tj@kernel.org>
References: <20220828050440.734579-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out commont part. This is cleaner and should help with future
changes. No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 fs/kernfs/file.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 6437f7c7162d..7060a2a714b8 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -554,31 +554,28 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
 static int kernfs_get_open_node(struct kernfs_node *kn,
 				struct kernfs_open_file *of)
 {
-	struct kernfs_open_node *on, *new_on = NULL;
+	struct kernfs_open_node *on;
 	struct mutex *mutex;
 
 	mutex = kernfs_open_file_mutex_lock(kn);
 	on = kernfs_deref_open_node_locked(kn);
 
-	if (on) {
-		list_add_tail(&of->list, &on->files);
-		mutex_unlock(mutex);
-		return 0;
-	} else {
+	if (!on) {
 		/* not there, initialize a new one */
-		new_on = kmalloc(sizeof(*new_on), GFP_KERNEL);
-		if (!new_on) {
+		on = kmalloc(sizeof(*on), GFP_KERNEL);
+		if (!on) {
 			mutex_unlock(mutex);
 			return -ENOMEM;
 		}
-		atomic_set(&new_on->event, 1);
-		init_waitqueue_head(&new_on->poll);
-		INIT_LIST_HEAD(&new_on->files);
-		list_add_tail(&of->list, &new_on->files);
-		rcu_assign_pointer(kn->attr.open, new_on);
+		atomic_set(&on->event, 1);
+		init_waitqueue_head(&on->poll);
+		INIT_LIST_HEAD(&on->files);
+		rcu_assign_pointer(kn->attr.open, on);
 	}
-	mutex_unlock(mutex);
 
+	list_add_tail(&of->list, &on->files);
+
+	mutex_unlock(mutex);
 	return 0;
 }
 
-- 
2.37.2

