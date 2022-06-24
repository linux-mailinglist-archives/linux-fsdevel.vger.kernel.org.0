Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D51559518
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 10:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiFXIFA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 04:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiFXIEx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:04:53 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1843B6DB15;
        Fri, 24 Jun 2022 01:04:53 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c65so2326836edf.4;
        Fri, 24 Jun 2022 01:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p1KsJJhvBthReekWVkDyI4HkkhGOTDE0uEXhDskma64=;
        b=KRem//CoENhA5H2UpmZZdJhIsNw+EqHDcRDSpekGpVdLUsKXbAGMuEpz4BJJr9Z87z
         IFYClc3R1wwPUygzstZ5aUNS6Wq5y0CfGSvfoDrVHkFbu0scIpPzWzMEq6eV8O7oB/AX
         FqDJRWt2Ipnk6y0r0VVTgjAU7cmOXdZEoJ0Qo2ZbG6rmkxKpX6vKZa5MuOPpSarFPIOI
         rvJt3BfdWDmWUzFnm2BJraq/RqKiudFoTZr0bvTI3SMqicR6ERRh4vwjGTYV2bCjY/8g
         Cs+cebdzqLUOjb0//Sl+P40ocJPd2A5kT/PXdXVI6tczXXpaQaD+aGMxYg5hyRLGbgEA
         pMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p1KsJJhvBthReekWVkDyI4HkkhGOTDE0uEXhDskma64=;
        b=ve4hzxF5YN0K2HZGxk44xINw2BaY8gfobyv0/JCoEedxJ15NQHQz7X6slgZszL6zQX
         4KY/u9DYkeVcVQUh3zlCqKv/WI2UTQqYxvXEopXctR6WRCAJ316AlQWosfszNbSAPblZ
         N6rBYARA5hWVaPCCFqS9QyFLqfxY5VE58hvDu2c5QV9qlbbSkMR7sa1khpXGbMdnyqZ2
         NWYDEyQc/LRBwApkSvroflrFDK9VI7Z+RaHXrjfr+DbXIz2yG8D+Zez9smIsFzZX3bdw
         Rx/C2li/nlJgqtvCmxHFFr/iDQ0UkWC21GaGnkyXlImk29R8FVaKkpkknPER2PkcAL75
         VHtQ==
X-Gm-Message-State: AJIora+JOVKHTSFj5QZd/Tl6Ienvus1rqJfN7n7ITZJdh9THuESOwFf5
        RWtOypFAxIaiP+9oxTcOGi//XK7RzAI=
X-Google-Smtp-Source: AGRyM1sHNTKfIbC1nDS/xDvZBcuQhpYMoeUWuMsHYIL5xwYmRCaeHIcH9pVKRTHXqSe2jlNLioeTeQ==
X-Received: by 2002:a05:6402:3807:b0:435:20fb:318d with SMTP id es7-20020a056402380700b0043520fb318dmr15936277edb.272.1656057892772;
        Fri, 24 Jun 2022 01:04:52 -0700 (PDT)
Received: from able.fritz.box (p57b0bd9f.dip0.t-ipconnect.de. [87.176.189.159])
        by smtp.gmail.com with ESMTPSA id c19-20020a170906155300b006fea43db5c1sm697779ejd.21.2022.06.24.01.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 01:04:52 -0700 (PDT)
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
Subject: [PATCH 04/14] mm: shmem: provide RSS for shmem files
Date:   Fri, 24 Jun 2022 10:04:34 +0200
Message-Id: <20220624080444.7619-5-christian.koenig@amd.com>
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

This gives the OOM killer an additional hint which processes are
referencing shmem files with potentially no other accounting for them.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 mm/shmem.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index a6f565308133..b068ac5ba4bf 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2209,6 +2209,21 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 	return inflated_addr;
 }
 
+static long shmem_file_rss(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	unsigned long nrpages;
+
+	/* Only account shmem files which aren't part of any fs */
+	if (atomic_read(&inode->i_count) > 1)
+		return 0;
+
+	xa_lock(&file->f_mapping->i_pages);
+	nrpages = file->f_mapping->nrpages;
+	xa_unlock(&file->f_mapping->i_pages);
+	return nrpages;
+}
+
 #ifdef CONFIG_NUMA
 static int shmem_set_policy(struct vm_area_struct *vma, struct mempolicy *mpol)
 {
@@ -3811,6 +3826,7 @@ EXPORT_SYMBOL(shmem_aops);
 static const struct file_operations shmem_file_operations = {
 	.mmap		= shmem_mmap,
 	.get_unmapped_area = shmem_get_unmapped_area,
+	.file_rss	= shmem_file_rss,
 #ifdef CONFIG_TMPFS
 	.llseek		= shmem_file_llseek,
 	.read_iter	= shmem_file_read_iter,
-- 
2.25.1

