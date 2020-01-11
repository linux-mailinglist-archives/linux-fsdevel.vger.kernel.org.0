Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84825138153
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2020 13:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgAKMOf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jan 2020 07:14:35 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53156 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbgAKMOe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jan 2020 07:14:34 -0500
Received: by mail-pj1-f67.google.com with SMTP id a6so2113206pjh.2;
        Sat, 11 Jan 2020 04:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gu2ibxt9IusIRe4xp3l3i73y94wbInkbEdTzlnDJ/Hc=;
        b=tjzy0T/KSZ3UjlaLBTfw2/8lFtiZm3+yjrQHbuZ3t6/zmAFh+0Vy8rpYf/FWb2erRW
         PxFq93aqRmY60ABG7XFvYcQ2jKWiFHUnUAgxeyqTJUfCE6n848KhjWxdqjigPKDyd9tE
         MXMnoZ70HuKCY0Q12TVntc+8vAfxIlLIo4HzR2hTgy+GHLCjWYRPiidFkza8LQGGUh5f
         H+MEhPHhi8SZLqQROf9W6q29sm0HgZKXa95sPMHp4wv8SGHE5BUV0wGQqx+KRxtJFE93
         xQuV7U+DmmnYfBdvwDaLjIVfdEPI8u06ncyiOEKzhgLEYrLXHedUbej2xJg9wKZe8uYA
         s1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gu2ibxt9IusIRe4xp3l3i73y94wbInkbEdTzlnDJ/Hc=;
        b=M0bnyeaxtwVUODNoc08EpSt1Ur3ZM65pwdDYr0b9AgQPr9R2J+6Jdsrr6GjUUSmb1u
         N1poQyXfNIRtmtS9p6E5hh+G1CO8jf1XHZrUO5Y8uEtH8K/c4rWcvg+nc7mlT2MSxUz7
         3/1aq7ZWpU/9iQZgPHu67gvAfSkRIuplNO23ncjQSXxE+ig8q8UCcf9l5UMsJzHdh/nY
         xMDzUKub73Q5x+r+soxK1AA1QwyOLJiUlPldIHmFdRADVy2g1lEHAlUBMHjIj7lMzdPm
         ean+yOetNg8mBM4v+IaCOVHqKG8N5PC1HgKUkGNUwIIYfrMPs0FRMOlIFduxzvY9hAXP
         bAVg==
X-Gm-Message-State: APjAAAUoNImv2TLcBIfm/E9XiqC2BqhbRXCkep+j2qFpTohVt4tJrF4W
        dp0FP3aWmy58/sFQwulbmqWlB0aU
X-Google-Smtp-Source: APXvYqwQ7aNRjEnfjZKONGUaZ9HVJML5GxucrnI6Y3/wARh9a3H12o1je3NDZm5+BOYgAiU1XwTQtQ==
X-Received: by 2002:a17:902:24:: with SMTP id 33mr4343218pla.212.1578744873684;
        Sat, 11 Jan 2020 04:14:33 -0800 (PST)
Received: from localhost.localdomain ([221.146.116.86])
        by smtp.gmail.com with ESMTPSA id 7sm6868513pfx.52.2020.01.11.04.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2020 04:14:33 -0800 (PST)
From:   Namjae Jeon <linkinjeon@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, amir73il@gmail.com,
        Namjae Jeon <linkinjeon@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH] staging: exfat: make staging/exfat and fs/exfat mutually exclusive
Date:   Sat, 11 Jan 2020 21:14:19 +0900
Message-Id: <20200111121419.22669-1-linkinjeon@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Namjae Jeon <namjae.jeon@samsung.com>

Make staging/exfat and fs/exfat mutually exclusive to select the one
between two same filesystem.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
---
 drivers/staging/exfat/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/exfat/Kconfig b/drivers/staging/exfat/Kconfig
index 292a19dfcaf5..9a0fccec65d9 100644
--- a/drivers/staging/exfat/Kconfig
+++ b/drivers/staging/exfat/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config STAGING_EXFAT_FS
 	tristate "exFAT fs support"
-	depends on BLOCK
+	depends on BLOCK && !EXFAT_FS
 	select NLS
 	help
 	  This adds support for the exFAT file system.
-- 
2.17.1

