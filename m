Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3A3F141836
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2020 16:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgARPE4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 10:04:56 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36504 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbgARPE4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 10:04:56 -0500
Received: by mail-pg1-f194.google.com with SMTP id k3so13183485pgc.3;
        Sat, 18 Jan 2020 07:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fPQcBNF9U7OWCQib9kgGE/dYlANKsa7PGFewHadUAy8=;
        b=rkb60wDnK0sSyNu6uhvU+9+6xIz/unq/M80zRTv5wt/ln5VIPA3VLcg0dlC/SWWup3
         t1lNQJ2Dqz5j4aWA8clL7/CZ41WnxDAoSsw8NT2v3ThlaeTFnHVHp060IRMrzHrZ8gco
         ra3/6fQlVTVw3me3YHS1bBO8ZCZDJZfmQTBSb2qIK8U0GqfMIrLjGbo+6w3cFrJQ0OKE
         R0m7agICE1fI6XBx0k+6nERCZamN4stwCgY09Ki2hkJCsOb/xiucN6HkpiFwnK3hWGTo
         grIPAkH4GAml42SIWE/vbSVAzUP2gjAbczq1aFs1oyq3eVAf8KV6gP2FwjXJ6Ut/dPp/
         ksqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fPQcBNF9U7OWCQib9kgGE/dYlANKsa7PGFewHadUAy8=;
        b=Upi00SM9qUBJC5RgJ5JC1187ZEO3Ni+syEAv9WckGxM2AK15jZoPZakFZi4DsfLn9k
         hRhg1V3zQ+hHj06eT7Hwb5zPHIZ9DHswjS2lyNuQy4Ux+0MC01L5K7CqJNSynjNtkgs3
         QMQQKXa+p8m9oQVZ99emrWpIjofuIQ7E5+oUmPeXSzNaDY1n10SBjNmm9NuyFAi//swD
         M7Hl5OOxKEGC7iSoEuB8c/JrFBvM32/6OSOHo9YsGZtED16RYY3eQZdlt+w4guplABZG
         KIVqEk5Nd5fLxHzZvD1JW2Pg+uSrhL8Jn9NvVkNMt9EME06gQDuez/sZlyR9KM3HvMkd
         lymQ==
X-Gm-Message-State: APjAAAXVgPWUbYfx1Itv4LOpEj39L1kK+BJaKHLZGT+wS6NRF9SSTIEa
        AJMwO8jPg3fggPHEOdBjxTiG9CrK
X-Google-Smtp-Source: APXvYqykwTE2F400WclhAwySaYLb+f0r7k1CJWpwcXTzTbRciitQeBuVnWIw92DqT8yFk8ectk2GmA==
X-Received: by 2002:aa7:988e:: with SMTP id r14mr8615328pfl.126.1579359895476;
        Sat, 18 Jan 2020 07:04:55 -0800 (PST)
Received: from localhost.localdomain ([221.146.116.86])
        by smtp.gmail.com with ESMTPSA id v10sm32072078pgk.24.2020.01.18.07.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 07:04:54 -0800 (PST)
From:   Namjae Jeon <linkinjeon@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        namjae.jeon@samsung.com, Namjae Jeon <linkinjeon@gmail.com>
Subject: [PATCH v11 12/14] exfat: add exfat in fs/Kconfig and fs/Makefile
Date:   Sun, 19 Jan 2020 00:03:46 +0900
Message-Id: <20200118150348.9972-13-linkinjeon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200118150348.9972-1-linkinjeon@gmail.com>
References: <20200118150348.9972-1-linkinjeon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Namjae Jeon <namjae.jeon@samsung.com>

Add exfat in fs/Kconfig and fs/Makefile.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
---
 fs/Kconfig  | 3 ++-
 fs/Makefile | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index a3f97ca2bd46..2f14a04ad91d 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -140,9 +140,10 @@ endmenu
 endif # BLOCK
 
 if BLOCK
-menu "DOS/FAT/NT Filesystems"
+menu "DOS/FAT/EXFAT/NT Filesystems"
 
 source "fs/fat/Kconfig"
+source "fs/exfat/Kconfig"
 source "fs/ntfs/Kconfig"
 
 endmenu
diff --git a/fs/Makefile b/fs/Makefile
index 007377f28090..17eb9d6ac886 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_HUGETLBFS)		+= hugetlbfs/
 obj-$(CONFIG_CODA_FS)		+= coda/
 obj-$(CONFIG_MINIX_FS)		+= minix/
 obj-$(CONFIG_FAT_FS)		+= fat/
+obj-$(CONFIG_EXFAT_FS)		+= exfat/
 obj-$(CONFIG_BFS_FS)		+= bfs/
 obj-$(CONFIG_ISO9660_FS)	+= isofs/
 obj-$(CONFIG_HFSPLUS_FS)	+= hfsplus/ # Before hfs to find wrapped HFS+
-- 
2.17.1

