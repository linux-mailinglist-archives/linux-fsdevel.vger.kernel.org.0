Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA502ED733
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 02:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfKDBqW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Nov 2019 20:46:22 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:35594 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728709AbfKDBqV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:46:21 -0500
Received: from mr4.cc.vt.edu (mr4.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xA41kLfC009965
        for <linux-fsdevel@vger.kernel.org>; Sun, 3 Nov 2019 20:46:21 -0500
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xA41kFgD026218
        for <linux-fsdevel@vger.kernel.org>; Sun, 3 Nov 2019 20:46:21 -0500
Received: by mail-qt1-f200.google.com with SMTP id i1so16590185qtj.19
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Nov 2019 17:46:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=t2ehr98/+rTL7PfDpH8Ry/AJxdIjjPlUhdGTTfS2sb8=;
        b=nGCxqAoB/abuMgQECQ14a5PfLh/mXU8aZ6gepk0PtBSI+/wmTWZfZEcW6DufdntcyV
         jttzAgealuFMHyoIxiL3SRwcOM0GQ87oEy8YG6sRCZgLMPtGebgzC1FTk0dIGAMYPb8U
         TlwG2cL17DYQf54bfUti6c0QoYVg5dO6ldSd/U7ZkyL7Z2gG0wVO1kngswB3oD4xiKoJ
         MS2lSBGcejShwUMbvGkEVq+n+3Pa7giAgs1LSkYw1N6QqS+1P80BQ7C8j1Xc4XHTtCgr
         N+7pKHdcBYH9BncnVmaULWMATgm37+2buWiO94gpWAofsWwHYKHZTRuv4jiThWDpPIkC
         IARQ==
X-Gm-Message-State: APjAAAU331vqZUVMgRZPViCVatkKaKky78YC4N+IH+ttNiiMKRmqbau+
        xracnWN4ptQ0RaCe3yKIDXLPl/PK7rMRraY6K5lb5LKT4GOK2ey+3thaWHyWfrBTEM8LoaQGXh0
        DH0U4sELL5kk1C6eEsgugqK56wtOuPbAjfxgl
X-Received: by 2002:a05:620a:147c:: with SMTP id j28mr981927qkl.26.1572831975751;
        Sun, 03 Nov 2019 17:46:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqwmwjNIr9K00FS6v/P5pCflkjocTlPkPXDpcvEsmRL8Nav7frFQIOeb/vbYK9VsqWlId1xUiA==
X-Received: by 2002:a05:620a:147c:: with SMTP id j28mr981912qkl.26.1572831975498;
        Sun, 03 Nov 2019 17:46:15 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id d2sm8195354qkg.77.2019.11.03.17.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 17:46:14 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/10] staging: exfat: Clean up return codes - remove unused codes
Date:   Sun,  3 Nov 2019 20:45:02 -0500
Message-Id: <20191104014510.102356-7-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
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
2.24.0.rc1

