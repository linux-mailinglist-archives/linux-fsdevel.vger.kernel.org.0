Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1211277E76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Sep 2020 05:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgIYDRn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 23:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgIYDRn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 23:17:43 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD86C0613CE;
        Thu, 24 Sep 2020 20:17:43 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id y14so1326341pgf.12;
        Thu, 24 Sep 2020 20:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GFhOebCIVY9305umoTHvyuGYwsJV7rqPqIthGX4066Y=;
        b=lJr5rVS3EHxw7jY5nSbP0lDOufZ3OYt81hsRe4vEKPh5mkgo5R6V2ImQs63ybWj9ou
         Uc/JRqJGGWCfmpELAgT4nF4CSrS4RsYbyeS0wt/oikMzJpcKI7DNDVh7cr65S9Wu+ndl
         pwSDknuOcJrirX8ibSiX7zUhuEvY7U9eljIXXMXIb0EJ32lksyNHe4aNfodGgh6ccdwD
         G+xusewxepvO2j3nhb68FMgXOBEkXHL3n3OmkP9dVBPw903QGBEk6X0uMDPxpvPIbZNd
         cot8LU8Vwsr17W3j95Ja2UcklUR4nmbUv+Uw2U9cx40vOpT+JdI3X8vS2eVBWVzUOzpT
         p7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GFhOebCIVY9305umoTHvyuGYwsJV7rqPqIthGX4066Y=;
        b=rnqKE9Vp85V/uZCdMhjEasND1uHgRKXexyUa6sduJqD9eBSz1FZT4ESyVnFcCU1+6e
         fyExINFGktOK+lPZpxvIQZgEH1io0N38oiF25wOX9TqxwdK2QJ2djHj/F00vYmikqfE9
         LBe3nSKvYh7djVtd3wVmsN6s6VwhXs7zSqBrHcyDfjUiw3EFqeSti7N9Podhci+J3+fL
         1Lc688RT+qVL0m9O1XBtLU/z86LYhZboatxOvUZao3b1KqEV7OwZJzs0cJQhyl+Jk4Y5
         pgitJ1LZwdss8P11XgS5wTqYATpw+MAEZOu6TlwcCweEsk9uY7jjf9Bn2GANupwbnq3U
         P0uA==
X-Gm-Message-State: AOAM531yy5S3Ud6sRxdrnk++4kKZZyJimEgZ+aEwlC/is1e4utUOxP4y
        caOHSdyNu23SUkMC7uDiYg==
X-Google-Smtp-Source: ABdhPJw2GBAhsIYaFs411dNpDI2mdHzFkUhXnUlpJEvv7vaTnJVMEsS2nmAMJGAB/FT71UsRTOHR1A==
X-Received: by 2002:a05:6a00:2b1:b029:142:440b:fca9 with SMTP id q17-20020a056a0002b1b0290142440bfca9mr2190544pfs.15.1601003863194;
        Thu, 24 Sep 2020 20:17:43 -0700 (PDT)
Received: from localhost.localdomain ([47.242.131.39])
        by smtp.gmail.com with ESMTPSA id i9sm803697pfo.138.2020.09.24.20.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 20:17:42 -0700 (PDT)
From:   Pujin Shi <shipujin.t@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shipujin.t@gmail.com
Subject: [PATCH] fs/d_path.c: Supply missing internal.h include file
Date:   Fri, 25 Sep 2020 11:16:51 +0800
Message-Id: <20200925031651.1318-1-shipujin.t@gmail.com>
X-Mailer: git-send-email 2.18.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the header file containing a function's prototype isn't included by
the sourcefile containing the associated function, the build system
complains of missing prototypes.

Fixes the following W=1 kernel build warning(s):

fs/d_path.c:311:7: warning: no previous prototype for ‘simple_dname’ [-Wmissing-prototypes]

Signed-off-by: Pujin Shi <shipujin.t@gmail.com>
---
 fs/d_path.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/d_path.c b/fs/d_path.c
index 0f1fc1743302..745dc1f77787 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/prefetch.h>
 #include "mount.h"
+#include "internal.h"
 
 static int prepend(char **buffer, int *buflen, const char *str, int namelen)
 {
-- 
2.18.1

