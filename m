Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4FE53081B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 05:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355508AbiEWDhe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 23:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344989AbiEWDhd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 23:37:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B265FE0
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 20:37:32 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t25so23384302lfg.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 20:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=9UQu8iam12mr1azC0AwN8d8GZeiA3F7ieCwRsIPT1Hc=;
        b=2Ny8fPOIfkeR/zCgCZVs4d604QoRLRD7kf1grmDjiV7/+c7jz579J7cZi3ZRZJFB5B
         jqrtmyzX6E/sYFFGp+pRJTIQPGZjLCHwDqDx0UPBJghc6w+k2US/aQlZit32DrWsIFXR
         VLREogrSQkXdyf09YlbovbgLqjean3s4Aa3jFQ6v1fgqKGJgxrFQl3oAAB6AL6wB8YMo
         NMuoL01hVZoIKflht6xMLS3f61fs962a6s5Xpm6C11HyCWDw7Hu9I+o5czxN7cs6Z/JU
         yMnhFMhxtNSq8a/DQLvKDcE/uFgkNeVAETy/rSlRqJCWEPw8MBEWwou+GB1lEDIT2vTr
         y0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=9UQu8iam12mr1azC0AwN8d8GZeiA3F7ieCwRsIPT1Hc=;
        b=2zycsC2bNtYki8Aj4lePfrulz6MnwYUpbs7TaF/X1QNyj0KUvUWnCuqIs+RyOdFDsG
         NrO/fN/2ivBT9jfVXfNa05ce1WoJCJPo+jsCVMcDVg2KhyExd8Hk9jtX3kQ6x73lriJ7
         ZpeaXNiMwrLYjlo1AzMT34JC9j8YkcMauLTjIbaZi4UUIlKgRyLv3noWOUMPbv3SlQ7d
         TAOrvWedqOU5u1wjGuq5fAzSmTb56smnqlVS88TVJHvLBm64u7G7hunoiJu7V0s1eLs2
         V9cECKjP8q4XUyM5dOYB6TWaK8GBtkTXqu7r2dlY6BIE9tsedJ5LwYamYRWJPiU2+28/
         r95g==
X-Gm-Message-State: AOAM531GS/QPsMlQBvZkGNOVa/PtxJBpqqfcgfUTmfXDsMBG9TwNV0YO
        8sD+rZR4CMQbguURlkqCvwTsPQ==
X-Google-Smtp-Source: ABdhPJxuc29/hA686DXnRch2wG5okjZCgSK4wS5Pjwi7gxC7nL7YmruGivCuyAonbD5Uom3xb4NCFQ==
X-Received: by 2002:a05:6512:3c90:b0:478:5c02:44b8 with SMTP id h16-20020a0565123c9000b004785c0244b8mr7742878lfv.228.1653277050608;
        Sun, 22 May 2022 20:37:30 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.185])
        by smtp.gmail.com with ESMTPSA id o1-20020ac24e81000000b00473c87152besm1737346lfr.178.2022.05.22.20.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 20:37:30 -0700 (PDT)
Message-ID: <7761c3fd-4fb5-1d65-c2e6-044d689de6b6@openvz.org>
Date:   Mon, 23 May 2022 06:37:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH v4] fs/proc/base.c: fix incorrect fmode_t casts
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
References: <YorBiz6QA0JBVta/@casper.infradead.org>
Content-Language: en-US
In-Reply-To: <YorBiz6QA0JBVta/@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes sparce warnings:
fs/proc/base.c:2240:25: sparse: warning: cast to restricted fmode_t
fs/proc/base.c:2297:42: sparse: warning: cast from restricted fmode_t
fs/proc/base.c:2394:48: sparse: warning: cast from restricted fmode_t

fmode_t is birwie type and requires __force attribute for any cast

Signed-off-by: Vasily Averin <vvs@openvz.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
v4: improved according to Matthew Wilcox's hint
v3: split, reworked according to Christoph Hellwig recommendation
---
 fs/proc/base.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index c1031843cc6a..89521d3fc456 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2237,7 +2237,7 @@ static struct dentry *
 proc_map_files_instantiate(struct dentry *dentry,
 			   struct task_struct *task, const void *ptr)
 {
-	fmode_t mode = (fmode_t)(unsigned long)ptr;
+	fmode_t mode = *(fmode_t *)ptr;
 	struct proc_inode *ei;
 	struct inode *inode;
 
@@ -2294,7 +2294,7 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
 
 	if (vma->vm_file)
 		result = proc_map_files_instantiate(dentry, task,
-				(void *)(unsigned long)vma->vm_file->f_mode);
+						    &vma->vm_file->f_mode);
 
 out_no_vma:
 	mmap_read_unlock(mm);
@@ -2391,7 +2391,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 				      buf, len,
 				      proc_map_files_instantiate,
 				      task,
-				      (void *)(unsigned long)p->mode))
+				      &p->mode))
 			break;
 		ctx->pos++;
 	}
-- 
2.36.1

