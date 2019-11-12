Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEBBF86BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 03:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfKLCLH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 21:11:07 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:48076 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727093AbfKLCLH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 21:11:07 -0500
Received: from mr2.cc.vt.edu (mr2.cc.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xAC2B635011605
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 21:11:06 -0500
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xAC2B1X9031499
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 21:11:06 -0500
Received: by mail-qt1-f198.google.com with SMTP id g13so2682666qtq.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 18:11:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=CcYLAh/UyTxqCQmL3RjWyYe/kNKV5YS8PJV7/eSFSes=;
        b=MOoYYUMi9OdZgh/RAom3GOeIbqVX34fWIdWARajvxECZKDtSb0ylVMXshYZTvEm1LD
         /OZGkAMkQawAeeRHH0TkjiSwj0wm9FKVEX2hcNPN4vw1L/KaoDMaOmnFk1fy5D8LodJ1
         pH8Ke++rkery3MDuIgcSseRqCtfcIUtdSHHjJ+pu6M1B1VPDMwLYsM6C58CwmZP7AAeL
         PXyhhiRSPGPbpLgHJkATy5WBuCe8G8lBdFgiiPHIpPZhqhD7uJA4O5+osZApBiAJdFY0
         i635QUFqJssYH+kDC+nrDwSY+0ZBiodI1Y31JHg1mvU7vP4ZEsY6GSgU/ECpoUNoerzR
         5kwQ==
X-Gm-Message-State: APjAAAXQdKIwicBIU3IZJ0bo7PMe/NsxtaoaMB3gb7G5OmIlaOA/aZo6
        dn64uAR3GhJlwXJnn/ZiFTxfNI1mNJNj2mZCuBxqE2M+kUkX7zw1mTRsN8Pf+sNm4B4k/nd60ZR
        9AzsbfahusTyIw6kERuQm8lJXD4bgegfWmHhJ
X-Received: by 2002:a37:782:: with SMTP id 124mr13629138qkh.142.1573524660753;
        Mon, 11 Nov 2019 18:11:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZYuxGedyB7a+wA/llda6YOy1P21HsSw35yYTNEbYtMJL30UKBF+x5CPddS8qesmICNXkDXw==
X-Received: by 2002:a37:782:: with SMTP id 124mr13629129qkh.142.1573524660504;
        Mon, 11 Nov 2019 18:11:00 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id o195sm8004767qke.35.2019.11.11.18.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 18:10:58 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     gregkh@linuxfoundation.org
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 9/9] staging: exfat: Correct return code
Date:   Mon, 11 Nov 2019 21:09:57 -0500
Message-Id: <20191112021000.42091-10-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112021000.42091-1-Valdis.Kletnieks@vt.edu>
References: <20191112021000.42091-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use -ENOTEMPTY rather than -EEXIST for attempting to remove
a directory that still has files in it.

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat_super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index a97a61a60517..e2254d45ef6e 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -2167,7 +2167,7 @@ static int ffsRemoveDir(struct inode *inode, struct file_id_t *fid)
 	clu_to_free.flags = fid->flags;
 
 	if (!is_dir_empty(sb, &clu_to_free)) {
-		ret = -EEXIST;
+		ret = -ENOTEMPTY;
 		goto out;
 	}
 
-- 
2.24.0

