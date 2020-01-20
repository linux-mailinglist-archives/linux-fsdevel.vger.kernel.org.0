Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57900142B2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 13:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgATMp1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 07:45:27 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33200 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbgATMp0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:45:26 -0500
Received: by mail-pj1-f66.google.com with SMTP id u63so6263694pjb.0;
        Mon, 20 Jan 2020 04:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YTSkWilOLRF6V3z56tKv6EWQoi4FR+bzO8K2u7fBynY=;
        b=OdMVTStYfrXChBqmnfJ629Uq0P+eFx2uUHHCaxaP3sFDKgBFm6wChqV6c2W5ly5W12
         oSuoM/F3yRZh90LrrEBsHd9C27jumg6nIHXGoVoZ2cAu3r3w1K1E7L9iYNUlCrVM2hzZ
         6gY/dNlHYtdGQYBycnRfs8M5JVyMLfh1eKTR+rI//OcK67N99aOqyhpRcrXBK3sz6pVB
         nNJB3KBZrXsKGUnzWplEfNeIbd9uerfSle3D6C/JtWgmbm+uhs4OxxWBui5ciw+tpgEg
         xgIz8l/Re2xIzZtNVT4WJKNPeTjxGhk2nlEW/mqm7IJ3tZuvhVNBDCribiMgVAYwUEKF
         gJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YTSkWilOLRF6V3z56tKv6EWQoi4FR+bzO8K2u7fBynY=;
        b=DFre1kSz4kwjwt5CSPab8WU/1Zfimds0QZc2E6CED60iEy/el16ewZwXfYgPlOgpMi
         PkUtYebH0gyKBY6ztPoKrQ1xQ4GRQepqJH7kI9BnR6jxkQxQ0rrpBti1YPNPNDvptziY
         Ud0QG0Z2c8o55xp8k7q9ekomSbvTzOPDrRGOqAmD5b1d7JeSrgTgW1XhjsYp5f1lN9Yt
         F1hXVCR0hW2F160EnreiBuqGG6ltr/MoVUUfwZnrTgSIMBMI4lnhDik5+4aVsC8u6tpW
         FqKKvJ03ixOr8fP0JhjfY98MreIZLgzC3iVvBEIlQFIoQXNBtIhjAqj5GeO5Xan4eT2y
         n/qA==
X-Gm-Message-State: APjAAAVezrgRkhWdRYo7wu2RL47BqvB0voJy2KU/rX7KP1An8sxUbHFF
        6RbyPCHlqRGJmZFTzcqTQwvpPKHe
X-Google-Smtp-Source: APXvYqxd0oXGORIfEG97hNGG8umq2iZdctoQrNTlL4XbSyq7N9woK2GyH2x1OO48NI5IQnoeH+rjqA==
X-Received: by 2002:a17:902:9f98:: with SMTP id g24mr15053032plq.325.1579524325619;
        Mon, 20 Jan 2020 04:45:25 -0800 (PST)
Received: from localhost.localdomain ([221.146.116.86])
        by smtp.gmail.com with ESMTPSA id h3sm39184590pfo.132.2020.01.20.04.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 04:45:25 -0800 (PST)
From:   Namjae Jeon <linkinjeon@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        namjae.jeon@samsung.com, Namjae Jeon <linkinjeon@gmail.com>
Subject: [PATCH v12 12/13] MAINTAINERS: add exfat filesystem
Date:   Mon, 20 Jan 2020 21:44:27 +0900
Message-Id: <20200120124428.17863-13-linkinjeon@gmail.com>
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

Add myself and Sungjong Seo as exfat maintainer.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 024be46a2b91..fae86a2b4116 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6300,6 +6300,13 @@ F:	include/trace/events/mdio.h
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

