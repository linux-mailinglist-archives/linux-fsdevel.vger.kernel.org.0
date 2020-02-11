Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1002158EAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 13:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgBKMkl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 07:40:41 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39999 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbgBKMkl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:40:41 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so5452206pfh.7;
        Tue, 11 Feb 2020 04:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GzaIYHmp0DpzcpK5c+5ytTVOgykyH6stYDC5nQl47N0=;
        b=TvOwTmvq6ZwRLexOEuq45X/b6mM2l9dp9PZ9ZZhsWn9v2Xlo0k57dh+4VVeGRZwvb1
         hlW/hM/fCcC4AxyByaas+IVnO2es4C6RDs+vvqXEfUiJDCxzkQOSBit+K3h84XiZnyLd
         LT2vmxb3yaQsifjIRO5cHUQNoYJ2bOflDqXT5pNZmGeMl1Gu86ztusSyeF6BSNuTJUYf
         Uaml7Jz1ijw8AWFKEUfynnggQKAvRaVjxOb54JuopFBg/KTWvisuVMm0LSc9CxgJBOjl
         jhEXiRw4J2K7pUO0+YkBMFoxc7Kq9cn2A8MPxlGAWPbN3+qQyHo25Tdh+X2MQ8GyZ8Uo
         IXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GzaIYHmp0DpzcpK5c+5ytTVOgykyH6stYDC5nQl47N0=;
        b=fRp6jyAB738Yz8gwRSJm6hFXBoXxb+/DiU8M/1ivv+s/EAiQK5jMgwdPbTwjw1T07S
         +J7F9LFfVoR5ggaxfj6sb3nA29e+Jdwd8SwrWzx+gWaeSdtT1K3U7q8k5Ild/SxCOsy2
         G1mtLvbgtRAWhudcmZXq6a4QEiF4LH75pcfjO5j7omWAS16isc7Lik/NZrY2ajayRw2+
         UVAEb9HjzfP1pxSX+sQ/z5Ro1tiR/QfRQvX98M2oNDbHHf5k5S0x2W+8MPHmHZmgDj51
         xQXvV7ylESIzuIsOlKZ8JLtXlillSVfLI2xmW7wH8ZkIrKGU2bbbninOC2VlQatn9z/D
         htCQ==
X-Gm-Message-State: APjAAAWg78tKA4Sfq+X/iGXo5um3NgJOayKqRr/mvJA0rSQlBTxSJYN3
        foDqTyQS+dAUkK8XbH26QXMpg38hvxs=
X-Google-Smtp-Source: APXvYqxaGPPcjP68gvoKY48cwW/egw4MWMDPPwgFqhZQREs/ICeezHMH2Y0E9Cl+pGoTMn0r7V/dIQ==
X-Received: by 2002:a62:8245:: with SMTP id w66mr3044437pfd.93.1581424840850;
        Tue, 11 Feb 2020 04:40:40 -0800 (PST)
Received: from localhost.localdomain ([2409:4041:69c:214f:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id d1sm3876789pgj.79.2020.02.11.04.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 04:40:40 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.or, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 04/18] staging: exfat: Rename function "ffsLookupFile" to "ffs_lookup_file"
Date:   Tue, 11 Feb 2020 18:08:45 +0530
Message-Id: <20200211123859.10429-5-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211123859.10429-1-pragat.pandya@gmail.com>
References: <20200211123859.10429-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of function "ffsLookupFile" to "ffs_lookup_file"
in source.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat_super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index ba86ca572f32..6082c6e75468 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -534,7 +534,7 @@ static int ffs_sync_vol(struct super_block *sb, bool do_sync)
 /*  File Operation Functions                                            */
 /*----------------------------------------------------------------------*/
 
-static int ffsLookupFile(struct inode *inode, char *path, struct file_id_t *fid)
+static int ffs_lookup_file(struct inode *inode, char *path, struct file_id_t *fid)
 {
 	int ret, dentry, num_entries;
 	struct chain_t dir;
@@ -2279,7 +2279,7 @@ static int exfat_find(struct inode *dir, struct qstr *qname,
 	if (qname->len == 0)
 		return -ENOENT;
 
-	err = ffsLookupFile(dir, (u8 *)qname->name, fid);
+	err = ffs_lookup_file(dir, (u8 *)qname->name, fid);
 	if (err)
 		return -ENOENT;
 
-- 
2.17.1

