Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47380E11A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 07:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389573AbfJWF2u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 01:28:50 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:44880 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389547AbfJWF2t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 01:28:49 -0400
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9N5Sljv020044
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 01:28:47 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9N5SgYu018571
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 01:28:47 -0400
Received: by mail-qk1-f199.google.com with SMTP id s14so19087856qkg.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2019 22:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ISQDTJmGCoaQ4xeld4Mhg9Q600xoGHfVZT32mcJtg7w=;
        b=Cs2HVsjwWLPfAFQaWkhydUr06jGbnxLG5xDmG14kdp9xcZhnn6ulzDFXb4Rpq6w4wd
         d07rNPt/+WP7SzXy0MnbxHN5wpJUiRrYZDVxQKFKAVkM8C2mgKItv4cSDGGI56sab4z5
         61ZXofuamuWF12O98iqMmJlDuLUIOXgQng7XdPJFQu2Jjj70UGx2uD0dv+9cFgLThzfD
         Lcin0cdHzrh13cCXQ2v3yvcmyxI/94EW3BjiI1OSJ65YNnNUdmXFC97x3EJDPjmDETTM
         VX0xFge+MsuP98L4xLFCKTUW+8Jx9NcvCRokbtlEpmLGEaFJWeKHq2FEvfhrBlTQ/zK7
         gxaQ==
X-Gm-Message-State: APjAAAXLhhGU4hfjoDOBhNxRFQFj1VACPlzaX7hmDE/WjMZLReNg1EEH
        5OL7ZcP2cd20AIP670g0X87sy+DFazJYg2F2DkcBYTMlfpZXM4QJmpxpqbRQOLNgxdxMxtu4act
        Tkrf7Ch5RJutnP7KoRGRs37BjY1+ChWn646q4
X-Received: by 2002:ac8:4a03:: with SMTP id x3mr1713092qtq.117.1571808522466;
        Tue, 22 Oct 2019 22:28:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw5nRxuWdRuBTyicKO9kNgnNeEtVqZyh2Z4Ty5Wd3Rj/224bq/k+ZD4kmE2tsjBWrP+H4/Kvg==
X-Received: by 2002:ac8:4a03:: with SMTP id x3mr1713074qtq.117.1571808522200;
        Tue, 22 Oct 2019 22:28:42 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 14sm10397445qtb.54.2019.10.22.22.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 22:28:41 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valdis.Kletnieks@vt.edu
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] staging: exfat: Update TODO
Date:   Wed, 23 Oct 2019 01:27:51 -0400
Message-Id: <20191023052752.693689-9-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191023052752.693689-1-Valdis.Kletnieks@vt.edu>
References: <20191023052752.693689-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/TODO | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/exfat/TODO b/drivers/staging/exfat/TODO
index b60e50b9cf4e..110c30834bd2 100644
--- a/drivers/staging/exfat/TODO
+++ b/drivers/staging/exfat/TODO
@@ -1,21 +1,17 @@
 exfat_core.c - ffsReadFile - the goto err_out seem to leak a brelse().
 same for ffsWriteFile.
 
-exfat_core.c - fs_sync(sb,0) all over the place looks fishy as hell.
-There's only one place that calls it with a non-zero argument.
-Randomly removing fs_sync() calls is *not* the right answer, especially
-if the removal then leaves a call to fs_set_vol_flags(VOL_CLEAN), as that
-says the file system is clean and synced when we *know* it isn't.
-The proper fix here is to go through and actually analyze how DELAYED_SYNC
-should work, and any time we're setting VOL_CLEAN, ensure the file system
-has in fact been synced to disk.  In other words, changing the 'false' to
-'true' is probably more correct. Also, it's likely that the one current
-place where it actually does an bdev_sync isn't sufficient in the DELAYED_SYNC
-case.
-
 ffsTruncateFile -  if (old_size <= new_size) {
 That doesn't look right. How did it ever work? Are they relying on lazy
 block allocation when actual writes happen? If nothing else, it never
 does the 'fid->size = new_size' and do the inode update....
 
 ffsSetAttr() is just dangling in the breeze, not wired up at all...
+
+exfat_core.c - The original code called fs_sync(sb,0) all over the place,
+with only one place that calls it with a non-zero argument. That's now been
+reversed, but a proper audit of sync and flush-to-disk is certainly needed.
+
+buf_sync(), sync_alloc_bitmap(), and FAT_sync() aren't actually used
+anyplace.  This is probably related to the borked original implementatin
+of fs_sync() that didn't actually do anything either.
-- 
2.23.0

