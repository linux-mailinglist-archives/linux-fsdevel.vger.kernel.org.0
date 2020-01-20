Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCCD0142B31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 13:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgATMpc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 07:45:32 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45225 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbgATMpa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:45:30 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so15479071pgk.12;
        Mon, 20 Jan 2020 04:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=riQeoCpIjGKHvSbMIa1Ue7ypVDo9yukWYqavka5JSLY=;
        b=n28hu2Op6ZundRS9FWFQ/PyAW0+C1OGbWn3juvgTK3QzjElBXjoWCXlkgfQgpB5VGr
         jICqI1oSn9LO+Vpxor3NGPetoHplDQ82DiEyvhICQad5SAr4sqV9TIjUU7Cka+xRjFJn
         zjijJZ69il/DzQttGmew8Lm/zdUkVguPHWJwzoIsG0giqI2Xt6Nca8tiL204U3Pm3ifp
         xfmhWf3aKV9brMJJYxgMIrokcoZrK6/C2KElvrRn6aZXYPqVZz5VBw+SFEI5LNiwry9v
         fz5zNtOlNNMIdXkhO8+YNp5JWEZ6fD8GjqCJdV5hdBLUt8fqAxWwMLZis72YFhDW/5Hj
         R/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=riQeoCpIjGKHvSbMIa1Ue7ypVDo9yukWYqavka5JSLY=;
        b=LEaIa+ifzCtHryjJmYazulnSlDMmVnQWvLJmvsqVWAXZRoM9ZCwobyfF32wTRpTkXR
         lDRKphwd7UygxEuZsots8xm05kFhLvp0m/mRCxGJXHyRcw218YnFMhFTeVG0ifV6Mx4d
         xgL/LEoDIoi1ZFSz23QSZuPqAJ9H/Rt7dsbCVs5kx+fnzcoO89JlnNxXsaQBInuPSs8e
         4Il9jjWqV+T3s/6yqb4ItC6M2J+mLfQ9awMK60XtdRuyk/fZJSfJiMuUatScmIqPutbC
         +Gkt5qO4hD4zx3u/FtlozjIDGgrufOrQmWtHvL+PIgAKQ/+qZ44qFfTf92l651d0xmkm
         ZueQ==
X-Gm-Message-State: APjAAAVHnoaUWUhX6a/yoGswlIXo1smU1TTMVgrQ8ke+LbdQUghzjkIl
        rbpRKTKdIpFKFMpUuLybr6s0l2yr
X-Google-Smtp-Source: APXvYqz8geIWlfVrrsh3UQfdDyE+o51ycF781dC+UTAT5pS18x9VwS6T5zvdtBEs9Ig4T2ZRUzPqJQ==
X-Received: by 2002:a63:31d1:: with SMTP id x200mr55867061pgx.405.1579524329897;
        Mon, 20 Jan 2020 04:45:29 -0800 (PST)
Received: from localhost.localdomain ([221.146.116.86])
        by smtp.gmail.com with ESMTPSA id h3sm39184590pfo.132.2020.01.20.04.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 04:45:29 -0800 (PST)
From:   Namjae Jeon <linkinjeon@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        namjae.jeon@samsung.com, Namjae Jeon <linkinjeon@gmail.com>
Subject: [PATCH v12 13/13] staging: exfat: make staging/exfat and fs/exfat mutually exclusive
Date:   Mon, 20 Jan 2020 21:44:28 +0900
Message-Id: <20200120124428.17863-14-linkinjeon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120124428.17863-1-linkinjeon@gmail.com>
References: <20200120124428.17863-1-linkinjeon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Namjae Jeon <namjae.jeon@samsung.com>

Make staging/exfat and fs/exfat mutually exclusive to select the one
between two same filesystem.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

