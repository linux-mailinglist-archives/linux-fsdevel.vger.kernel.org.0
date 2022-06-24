Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55659559506
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 10:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiFXIFQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 04:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiFXIE6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:04:58 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E9E6DB23;
        Fri, 24 Jun 2022 01:04:55 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eq6so2313776edb.6;
        Fri, 24 Jun 2022 01:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SN2tXnkiXYHDkRcNluGEiWD+Zcie7EgTba4v+LS00Rw=;
        b=CjcSe9wc4EjfAkbjkiF8NJM6p2V4TBIzx/MVoQMmpgiPsjLyR+gRuRTFEYB3Ktsmj6
         uDAJoHxOnz8/QuPN6vTSy5gLwbvZIrxGeq6qoPabZTcRU6gXi4B9UgKRuVNDxdOuXcL1
         cxd/73iXXQR+fr9ZjFoDFmjR0cLQM1R0DIR2jGAJPqHq78r8H+21zwbEgz340DrDdfqf
         X5N2BIdOCyjdEdUdAOIQhfOYFDl6u7OALHxEmKZyWH8er7gOe7gpZJPRqEWHVjjT+Zda
         LFVWx/ojsAy6fLSK9XLReier7Yc/aQFSo1vJ6Ffb4pLtiw1aDQ3/hGk/ftltPnqcfrJN
         mArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SN2tXnkiXYHDkRcNluGEiWD+Zcie7EgTba4v+LS00Rw=;
        b=EjBSiZ75Ayf61zrTp/ltdWre9Fb8WySzMKawhgTxa00w/4/iRJhlVw3PtQ4HRa/CmU
         a9O/XUiIkGvhusPjM0ZGDAiho2bVicumLsaLKttjgG//hE4xSOq7Qhg76XqUh52BTPjG
         fwleQoUxipCEbPHR55pHYFE6bSMfbiaifxXNOpPClYjldNxY3orSPCcDNNcxalpzGMnN
         yFZwh3PUAMops/Tr19T+0RTn/NP8VKYzmqmINTGYvchDMbvI1Mm9DgnLm89SZf3o/Akx
         axEmqtdgwQJBnonAvkn1PAgzGxcj9SNVtkTPGeCoVq3NUHrfWJKihfFtvbMsv0d0BjFR
         WmnA==
X-Gm-Message-State: AJIora++bHJR5lxkTIWhmOwHZGOlcXZA892XZi7+w0j7sgNBj+hbXvFt
        g93OsnzcmmmKKh/TTt4+VrR4vGGO2NM=
X-Google-Smtp-Source: AGRyM1tBvj71cbsgZ5j4wXJcKfxDt7AmGXAvH0woqtRU4by1QVnuj6MIlbtq+6gf5TBsdwCsD9lmDQ==
X-Received: by 2002:aa7:d296:0:b0:435:7f33:38bc with SMTP id w22-20020aa7d296000000b004357f3338bcmr15804834edq.399.1656057893977;
        Fri, 24 Jun 2022 01:04:53 -0700 (PDT)
Received: from able.fritz.box (p57b0bd9f.dip0.t-ipconnect.de. [87.176.189.159])
        by smtp.gmail.com with ESMTPSA id c19-20020a170906155300b006fea43db5c1sm697779ejd.21.2022.06.24.01.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 01:04:53 -0700 (PDT)
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
Subject: [PATCH 05/14] dma-buf: provide file RSS for DMA-buf files
Date:   Fri, 24 Jun 2022 10:04:35 +0200
Message-Id: <20220624080444.7619-6-christian.koenig@amd.com>
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

Just return the size of the DMA-buf in pages since pages allocated or
mapped through DMA-bufs are usually not accounted elsewhere.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-buf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 630133284e2b..16162ec3538c 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -494,6 +494,11 @@ static void dma_buf_show_fdinfo(struct seq_file *m, struct file *file)
 	spin_unlock(&dmabuf->name_lock);
 }
 
+static long dma_buf_file_rss(struct file *file)
+{
+	return i_size_read(file_inode(file)) >> PAGE_SHIFT;
+}
+
 static const struct file_operations dma_buf_fops = {
 	.release	= dma_buf_file_release,
 	.mmap		= dma_buf_mmap_internal,
@@ -502,6 +507,7 @@ static const struct file_operations dma_buf_fops = {
 	.unlocked_ioctl	= dma_buf_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.show_fdinfo	= dma_buf_show_fdinfo,
+	.file_rss	= dma_buf_file_rss,
 };
 
 /*
-- 
2.25.1

