Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28A33143D7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 13:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgAUM6c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 07:58:32 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37282 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729261AbgAUM60 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:58:26 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so1471857pfn.4;
        Tue, 21 Jan 2020 04:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A4hQ2mJAO0fiUhqU81iOZvrCl++1dQEL5/e6TPG2kLY=;
        b=uA5bTtxc1fH/t3QcgP6OY7SN8Zcv06oMprPhNxT9APjATjMr8UoJa3gRb1ZGN5ipzf
         K6VLEr4+KKyg0PJ/arLXQnJnPhekyBKDnyItgWEOnzy0liYa3AtQS0Gw1jSD6RSJZtaC
         ZcBIi+Xsnfltv56sw1/v2l2dhqxz8J/69rZPXkWhN85Yuvn+kZX3fwiQn9aNQT5zrvGZ
         BJPOIJBBU9r1qVkgwa3s+Pk3mXui2+865nRKTWF0cwoSSFwzXXJh3AbrTHSwbo8ejRMR
         2Co3xp9UAB6Gzp+zN7nsoCgzQ5bTkQK6ZR0mqxy9/NJtXu9ngXNK6ghGMQQVIKw5JeKn
         mPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A4hQ2mJAO0fiUhqU81iOZvrCl++1dQEL5/e6TPG2kLY=;
        b=meEPnklq2ZGEg6bT+ca97jCMf4+rIyDUakpwr0Kyu5kr5vi4y+EqWF05LDqOkdCjEu
         A7E+ERYgAzhGvHW84ODwvkfEmola7qBQ20vM+LQnhVU0QjaIw72CJkEUrzzHM/GfFZFK
         3PlotF/lZ7d+FVRXpQLVtWWViwOLCF/Sqz+K7qrK2sPt7EfV2jeRpbcDFKJsaVfwjFrV
         NK0bpLMBN/O8HKS4qq0tSSemwT6G0PbJmi0WopSDkgjXRuj0LbyV6Cskif8R9LY2cn+o
         rn/oRj62WUZhnnK2fqG187PqG6N9Vzmq5C0ly1qKudL/Pfz7bjrP/l1uS6qQ27TYhaAH
         Ql0w==
X-Gm-Message-State: APjAAAXIKYArd14UNyzDE8WX4yfhRemDgBfC0X/rw8CU9FyDDiCA15xv
        /f2yTJppovBNk8/jklkn8tlQiumC
X-Google-Smtp-Source: APXvYqxRjADBfBm+rM//xRDt/l4V8owZ5Tk/EkA7vZiMH2/fb8S76waau9AwO1hS+hyZTlNOTPDhWg==
X-Received: by 2002:a63:de4c:: with SMTP id y12mr5215238pgi.107.1579611505635;
        Tue, 21 Jan 2020 04:58:25 -0800 (PST)
Received: from localhost.localdomain ([221.146.116.86])
        by smtp.gmail.com with ESMTPSA id v4sm43130132pfn.181.2020.01.21.04.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 04:58:25 -0800 (PST)
From:   Namjae Jeon <linkinjeon@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        namjae.jeon@samsung.com, viro@zeniv.linux.org.uk,
        Namjae Jeon <linkinjeon@gmail.com>
Subject: [PATCH v13 12/13] MAINTAINERS: add exfat filesystem
Date:   Tue, 21 Jan 2020 21:57:26 +0900
Message-Id: <20200121125727.24260-13-linkinjeon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200121125727.24260-1-linkinjeon@gmail.com>
References: <20200121125727.24260-1-linkinjeon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Namjae Jeon <namjae.jeon@samsung.com>

Add myself and Sungjong Seo as exfat maintainer.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3465b734c67c..aabf7eb022f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6312,6 +6312,13 @@ F:	include/trace/events/mdio.h
 F:	include/uapi/linux/mdio.h
 F:	include/uapi/linux/mii.h
 
+EXFAT FILE SYSTEM
+M:	Namjae Jeon <namjae.jeon@samsung.com>
+M:	Sungjong Seo <sj1557.seo@samsung.com>
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+F:	fs/exfat/
+
 EXFAT FILE SYSTEM
 M:	Valdis Kletnieks <valdis.kletnieks@vt.edu>
 L:	linux-fsdevel@vger.kernel.org
-- 
2.17.1

