Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D82538E3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 12:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245433AbiEaKA0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 06:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245410AbiEaKAR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 06:00:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4341782170;
        Tue, 31 May 2022 03:00:16 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v25so8726073eda.6;
        Tue, 31 May 2022 03:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mIxGnBiNQH7wWhpTAOYvfGm3yBUdW2Lv8hSFkOKs0aA=;
        b=YDb0d+PyOKs210qCqYAFGBvUZTTS4RAIRhhK/d+QO9gshGdaDWgKspQVMQpG7nrtX+
         TufVc/6A+Te4bjWf9pWyv6ntrZjNTvO1o8tYpzOoAdjIqo9Bklfzy8dXk7BYMrxpSM95
         usfHUfKLh7JEKoG9wN5zLAoQm71wvfUxu+xCGMzIBHPjTBYFFRg/fQ8Bc1mbpWvV9bwY
         PR/pdpoW3OmlfWODJKjL9jIEkGs8hD/ZjjXmxLFGR2b/njvlb082VeR+rrGF1R55oj4p
         qQAdYumTKMLx79UKpj8YkktDQvBcFKlZvP9zcVhZ48lAtSdY31sMnKI1F4yE0kXKaL3w
         HsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mIxGnBiNQH7wWhpTAOYvfGm3yBUdW2Lv8hSFkOKs0aA=;
        b=EzU/VTjDPqbd6mX5MnUJBZf5dPyBbmugrc/qa0bl+TwK43Qf7AD99U0bvcESR6zR7i
         3uBLQU3dbVVm93HWnv8zNa6vg6WguSKa5Un9bCuy7dKs0HNmRzCbUEBMujEN1j7Ldd2q
         LTrUSQlTbvSldcKsL1Rw7lXSyxm/gy5ekjfZY5ZE1FH6IwCGWX+Va7+Tmhh2e0NiVbOz
         XEq+YQfaTbFCdPfOKoUMEiYwfKiwORZ+hFuE28k4dzcrKMwjJl4QTwnF2IVpf3aOS5A4
         pgB22kveaeyPFoQZKeU/cuYogDzRX/UcPng8mYNfUE8j3BO2uPFe51bFVY/ykvKE//5T
         K6RA==
X-Gm-Message-State: AOAM532YkWiHHg3W2caL6K9FJxax7zUFkECOtG86b0yNgY43FdMTcjqX
        tlWMlvEhHfSGl4LhnsYPMCrTQysD1KyrYQ==
X-Google-Smtp-Source: ABdhPJym6XbAZzn9cN4OBs65hCeI931sSsPopVK1yV+b7qr9DjRRmdjRD8OGAyhyWkR+LhQlwkaGRQ==
X-Received: by 2002:a50:8754:0:b0:42d:e92f:c924 with SMTP id 20-20020a508754000000b0042de92fc924mr902302edv.389.1653991214818;
        Tue, 31 May 2022 03:00:14 -0700 (PDT)
Received: from able.fritz.box (p5b0ea02f.dip0.t-ipconnect.de. [91.14.160.47])
        by smtp.gmail.com with ESMTPSA id r13-20020a056402018d00b0042617ba6389sm582062edv.19.2022.05.31.03.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:00:14 -0700 (PDT)
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
Subject: [PATCH 03/13] mm: shmem: provide oom badness for shmem files
Date:   Tue, 31 May 2022 11:59:57 +0200
Message-Id: <20220531100007.174649-4-christian.koenig@amd.com>
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

This gives the OOM killer an additional hint which processes are
referencing shmem files with potentially no other accounting for them.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 mm/shmem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 4b2fea33158e..a4ad92a16968 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2179,6 +2179,11 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 	return inflated_addr;
 }
 
+static long shmem_oom_badness(struct file *file)
+{
+	return i_size_read(file_inode(file)) >> PAGE_SHIFT;
+}
+
 #ifdef CONFIG_NUMA
 static int shmem_set_policy(struct vm_area_struct *vma, struct mempolicy *mpol)
 {
@@ -3780,6 +3785,7 @@ EXPORT_SYMBOL(shmem_aops);
 static const struct file_operations shmem_file_operations = {
 	.mmap		= shmem_mmap,
 	.get_unmapped_area = shmem_get_unmapped_area,
+	.oom_badness	= shmem_oom_badness,
 #ifdef CONFIG_TMPFS
 	.llseek		= shmem_file_llseek,
 	.read_iter	= shmem_file_read_iter,
-- 
2.25.1

