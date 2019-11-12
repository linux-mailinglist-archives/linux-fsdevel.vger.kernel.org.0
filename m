Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E61FF86B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 03:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfKLCKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 21:10:49 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:48026 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727159AbfKLCKr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 21:10:47 -0500
Received: from mr2.cc.vt.edu (mr2.cc.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xAC2Ak5F011528
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 21:10:46 -0500
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xAC2Afjm030694
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 21:10:46 -0500
Received: by mail-qv1-f71.google.com with SMTP id m12so7523849qvv.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 18:10:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=uphTJK2IDaoRqiwK0hx3G7xcHeFWsEZMUn5zNKoPI0w=;
        b=pMDB2Hm8p4/c0tdcSShb4ULn6GfENZfvqKh2xfw+nsGvb+ta+XPulYYnrWo/58/K03
         TzNfc37hmZBbFEum51AKHBk9yW4QHX7CujobCM/960Pa4YcLNNQQFeugDRUVkUFfR3qf
         +2sBGK6mFvDj/CBy26Djt6+0+GSQDtcJXyGW1Lo07NpG0XtVg2qypvvCVZjf6Kg9rH/9
         KtbzEIB0s4rK9Z7VJMWAI+HSdip6MP2V5DMyx4Hz1Y/G+wCBIANf6Xtm4d+5YxYdLKQ/
         BhmT0IF4tU60R68EcFRf7XobF+nyj7mlcaieYrvjY7Vm90F0y3kVTKacV08dqdXLT9PO
         bmXA==
X-Gm-Message-State: APjAAAXcgwAuCBZ6gKJeZqulUhsbytn8Jg/Tb78kTN+PCGxqoO1cOi6E
        Rbe6ev8qKmQGp239EG3771v0j1eN1XUAwW9IE+icriz/6SSRuWL8Ylapsc1KAG7Uky9p3VYeEP9
        doUSWO54lqkoCjoiZJJ4vWiTk+dMSr6lzdtHM
X-Received: by 2002:a0c:a998:: with SMTP id a24mr25872135qvb.117.1573524641378;
        Mon, 11 Nov 2019 18:10:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqyP9wpj6EloB26bcXsuYqLDNDs33pV7zPD64rSvVFKAnI1TcwuvnpFunMC2Bkhe+5aVicw5Fw==
X-Received: by 2002:a0c:a998:: with SMTP id a24mr25872127qvb.117.1573524641133;
        Mon, 11 Nov 2019 18:10:41 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id o195sm8004767qke.35.2019.11.11.18.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 18:10:40 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     gregkh@linuxfoundation.org
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/9] staging: exfat: Clean up return codes - remove unused codes
Date:   Mon, 11 Nov 2019 21:09:54 -0500
Message-Id: <20191112021000.42091-7-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112021000.42091-1-Valdis.Kletnieks@vt.edu>
References: <20191112021000.42091-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are 6 FFS_* error values not used at all. Remove them.

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 443fafe1d89d..b3fc9bb06c24 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -210,12 +210,6 @@ static inline u16 get_row_index(u16 i)
 
 /* return values */
 #define FFS_SUCCESS             0
-#define FFS_MOUNTED             3
-#define FFS_NOTMOUNTED          4
-#define FFS_ALIGNMENTERR        5
-#define FFS_SEMAPHOREERR        6
-#define FFS_NOTOPENED           12
-#define FFS_MAXOPENED           13
 
 #define NUM_UPCASE              2918
 
-- 
2.24.0

