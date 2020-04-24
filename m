Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F5F1B6FA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 10:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgDXIUA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 04:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgDXIT7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 04:19:59 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77495C09B045
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2020 01:19:59 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a31so1769760pje.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2020 01:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=t1Arj/gzrMBw1kx2rzm1Fk8kWjfNHCa+Y2zL2kb2ExY=;
        b=GQywM6aV/luppcnShqKJylRbQSbOE598XV+TVKYmAhaEZftW/7tt2mnjHXve1NE5wk
         tQlMO01InSnJOVhVOXHu6oP3eSWK/7E7NUYQJERUr5f7eQ7bCDyIGdFLqCrr7d0DWRK7
         meiVAEwT6vr7l3WaUgCD37vUmUyaADnAXTARvXffMDCO2TmL+ogpGLcBhBrHB0K69ZjN
         sZeUyyIB0AsBrB4nS5uxad+KutwL8Glb2vlpolaw2fpGlJ59LefECnXLY+yCttochb2E
         c6Y/X03rJZFwFKH4ZXIVcNS5GwOpARIzTM5+ztsc3vQjtj7Z4UPrjrSR1JHJlIxIulxq
         JP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=t1Arj/gzrMBw1kx2rzm1Fk8kWjfNHCa+Y2zL2kb2ExY=;
        b=PeUWpyhwdGhlWKNsYzakbK419AiX3QTm9mbJn6Y18jme8G5rdPDt6BCAF96m3tB/mI
         lq0/BWZizoftEt9+5KjXdea7sRB2ju/NcRfEHFnTRVOt+kyUjuR1TtRZDoCetdCXkdqV
         6OmArXwOmIPQ/yBq9SdgIykvUnzHd4TkS6q+GNFdkYr3UXSat9/gM8D7DCa+67pYrGpq
         j1640cii7atMF8QsS3vIXKGFKu/Ux1hSKAv3xU54yThI3q6WJ16eMNvAoPjwM7F5Tk4k
         /B88Ekb4fJANKN38OJnDPEnslF4Hk0xnCXJjsnekWxhurm+nL1Ut7RdPe5ZmZCfjjB1x
         W5KA==
X-Gm-Message-State: AGi0Pub+AEtk3jZmqRpWcBoH+qRW1MVmenRym5uyZScUjQJMi+JcglOa
        pN+0ZAnqxXD3lLAuQIaNJVs=
X-Google-Smtp-Source: APiQypLUv5gL/wzz5AQ++jS50++V6g7C/ieTQjBNoPxHqYW6BO7Nn301DKLlpCvF+363Zth1/ixpvw==
X-Received: by 2002:a17:902:a40b:: with SMTP id p11mr8241740plq.304.1587716398846;
        Fri, 24 Apr 2020 01:19:58 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com. [34.92.144.28])
        by smtp.gmail.com with ESMTPSA id f10sm4253503pju.34.2020.04.24.01.19.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 01:19:58 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH] fs/seq_file.c: Rename the "Fill" label to avoid build failure
Date:   Fri, 24 Apr 2020 16:29:04 +0800
Message-Id: <1587716944-28250-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

MIPS define a "Fill" macro as a cache operation in cacheops.h, this
will cause build failure under some special configurations. To avoid
this failure we rename the "Fill" label in seq_file.c.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 fs/seq_file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 70f5fdf..4e6c56be 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -213,7 +213,7 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 			continue;
 		}
 		if (m->count < m->size)
-			goto Fill;
+			goto Fillbuf;
 		m->op->stop(m, p);
 		kvfree(m->buf);
 		m->count = 0;
@@ -225,7 +225,7 @@ ssize_t seq_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
 	m->op->stop(m, p);
 	m->count = 0;
 	goto Done;
-Fill:
+Fillbuf:
 	/* they want more? let's try to get some more */
 	while (1) {
 		size_t offs = m->count;
-- 
2.7.0

