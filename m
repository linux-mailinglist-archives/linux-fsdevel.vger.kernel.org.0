Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B87C5E3739
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 17:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503433AbfJXPzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 11:55:05 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:54766 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2503429AbfJXPzE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:55:04 -0400
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OFt4iA027323
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 11:55:04 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OFswN6022413
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 11:55:04 -0400
Received: by mail-qk1-f198.google.com with SMTP id g65so23837340qkf.19
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 08:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=SyOobOpZYzTvdZYs3cH/N6hV2wYmIbDFbQPOWl3B3yA=;
        b=q6boYxBeH3hetHcKPjv3i+oUoa44uIK33jJ6Pf4zRq49rUnaa37qdHc+9cG4/1Nb99
         neoKM+YlFxN4KwIF1eJrLSGZ+xLPlF85bZCfN/5STSAPK/vKiz7biE4V781vTQRgLq2z
         7q7yauGQCnVQfbjdonHzaAAkOEzxjfNaK+37nXBxHqM9V/pGcTJ3FuwqikbdzEEymHS4
         5R0RJCKCb+sM4/LkLjHjkMOf+etLGrVnc/X+B6u6xNBhmT23vC+BvBDTKUKRYPrvXfi4
         Oz+WyvCI6RPztfiufAqvIX2e12hv4e08UFYdlwk0YYX7KoWxVbJwqcKgZWNhF1otI16W
         126g==
X-Gm-Message-State: APjAAAWxuILKfzWr3NWsxmW29sLbFzEY6aMkCQW7QC9G2XJOqgc8fFd7
        5j1Rj2dn+1/IoE/gmA5KKMauWE7YuAESI9dNt8tSZaX6gimOLJPjBbXdV948soGz2or8Pihejn2
        /H6jCM9+C3K83QAP8DhjAJxJM/zS5Ty5rS7jp
X-Received: by 2002:ae9:eb17:: with SMTP id b23mr14409859qkg.260.1571932498713;
        Thu, 24 Oct 2019 08:54:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyGt4F+8h9pUy2WBpBQilCq7fwxiOziIP1Emg5SoFQw6Gfam/UCq8V3j8x1vTs9jK1ywgMmwQ==
X-Received: by 2002:ae9:eb17:: with SMTP id b23mr14409840qkg.260.1571932498453;
        Thu, 24 Oct 2019 08:54:58 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x133sm12693274qka.44.2019.10.24.08.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:54:57 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] staging: exfat: Clean up return codes - remove unused codes
Date:   Thu, 24 Oct 2019 11:53:25 -0400
Message-Id: <20191024155327.1095907-15-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
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
index 2ca2710601ae..819a21d72c67 100644
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
2.23.0

