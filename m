Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A200196063
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 22:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgC0VYg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 17:24:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35947 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbgC0VYc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 17:24:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id g62so14070329wme.1;
        Fri, 27 Mar 2020 14:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ALcoYp10x9FcpeDcmDwp78wr5UzvY5AhSnD49w1EnHs=;
        b=py8hXeX3LdEEuS/iKqjHRAcybU1xUpZcmvu7S2uoDfNXaKELn4isRj2Rh3EXBOMN3I
         uSjREoKCsI5t8AKbxHSMPcveGmK1J9s8iiQPMQ8piLaXLg7eARbZE1pB2nRF7YyvWMSc
         oZBqVui8Ii1lYSXPDizHaI5I9NxjT0ECVx809GZXxtT7m3B8pao75ldselbJS0/h/S+U
         hIWsSaUqYM5UU3IopOztaddH6yXeLWZDXCRhS3G/tKXsZQxKT0sj/+ImtPfrHKB0NHK2
         4VsSy/XbT4cpN/YxLGI7oCb8uxzjl/6T6I0nnEWtrhAftDE5aWrC0tAjkWg2zbWADp8w
         zI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ALcoYp10x9FcpeDcmDwp78wr5UzvY5AhSnD49w1EnHs=;
        b=m2KQvHUyxW8uZKVRucjvia5gqb4SQBQQZJjC5cg55ouNpBK1sXLhz9CNObP7/cLkmP
         XcNvf+2G24q/n37lFIjq8/A0C8Z1T/9GESzWAZoJMbSf4TcddIlRg+xjsFujuY+PN6qW
         jCUoVWdDZjxRYmCUcvIgZxra3C8CHXbMIf8vPbMiDzzIv0d8db1FqIQTEvi5UFGhAqjR
         Uf7L8gyTGf5yu6PQiEDN+9jhaw0WgyRahKtdODUakhxjsW1TJRzo4Uj+OLA3fVdDq4Vw
         RF70X/Xv5PRLq5e603p0VCIuyjARykPfNhbQ2b4rYvZ7C790V3vtCM5+PWPn+SiCW43m
         HR+g==
X-Gm-Message-State: ANhLgQ3Gbdt12m4Ms0OfmGfhlUXNYVbaDh+mMBA4pjCQb8rbTaqn6wd5
        8QQ8iC2dkdI5ciXBtYzhgA==
X-Google-Smtp-Source: ADFU+vukEibRAnv/BOUzkB6kl/EJ/isToaeTK7a27bwPpYmvrf+3y5yRTZnOGjJnluSodJLb7AIfDA==
X-Received: by 2002:a1c:de87:: with SMTP id v129mr681152wmg.68.1585344269552;
        Fri, 27 Mar 2020 14:24:29 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-82-35.as13285.net. [92.23.82.35])
        by smtp.gmail.com with ESMTPSA id h132sm10215141wmf.18.2020.03.27.14.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 14:24:29 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     julia.lawall@lip6.fr
Cc:     boqun.feng@gmail.com, Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org (open list:PROC SYSCTL),
        linux-fsdevel@vger.kernel.org (open list:PROC SYSCTL)
Subject: [PATCH 09/10] kernel/sysctl.c: Replace 1 and 0 by corresponding boolean value
Date:   Fri, 27 Mar 2020 21:23:56 +0000
Message-Id: <20200327212358.5752-10-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327212358.5752-1-jbi.octave@gmail.com>
References: <0/10>
 <20200327212358.5752-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Coccinelle reports a warning

WARNING: Assignment of 0/1 to bool variable

To fix this, values 1 and 0 of first variable
are replaced by true and false respectively.
Given that variable first is of bool type.
This fixes the warnings.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/sysctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ad5b88a53c5a..4132a35e85bd 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -3158,7 +3158,7 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
 			 void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	int err = 0;
-	bool first = 1;
+	bool first = true;
 	size_t left = *lenp;
 	unsigned long bitmap_len = table->maxlen;
 	unsigned long *bitmap = *(unsigned long **) table->data;
@@ -3249,7 +3249,7 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
 			}
 
 			bitmap_set(tmp_bitmap, val_a, val_b - val_a + 1);
-			first = 0;
+			first = false;
 			proc_skip_char(&p, &left, '\n');
 		}
 		kfree(kbuf);
@@ -3281,7 +3281,7 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
 					break;
 			}
 
-			first = 0; bit_b++;
+			first = false; bit_b++;
 		}
 		if (!err)
 			err = proc_put_char(&buffer, &left, '\n');
-- 
2.25.1

