Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1D7BEA6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 04:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfIZCKJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 22:10:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43867 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfIZCKJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 22:10:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id q17so480695wrx.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2019 19:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IGlN+heuyTZ+mY6VztfGn4UabzYzGl/zkHtT6rP7TzI=;
        b=jx9E7DGFNiOvZGgMp0oAfuSA9agiLMJS/iqPQWmyxBo1PJ/M2eF1zjVes5QBo33x+6
         z4HQmpKxK8MoxE6ruCzpZqZ9t4DWGmyZ6F19rfkMCAvWd0v0JE/n4+yDEWydX/xMalX8
         s1gwjBQZHzkinUwcfZd00j9OT0l68VYNHf++6u9FsIXiJ6z3/MzDPYPQahgQEe1LFqWA
         YVFiv0+edk/5DZlq/OabVOENsTXyGVTTwu4omOAZcQgXGvuH0ffkuZorU8dj5tcv+h1Q
         gCDJY3gmlGoBO1hNeDLDL1lje1Ia+kg6hnGHcS6hD8kXg6lQeq0PTGS9v6D6famw/D4j
         TjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IGlN+heuyTZ+mY6VztfGn4UabzYzGl/zkHtT6rP7TzI=;
        b=CrKpLP7DoI4IAy9dB3pT5LSmHTeSLiGXNV+Fk3aCAOEeaaiZ87VKz5qFxjfRHZ93yo
         4DYh3+TlNfSYn/C71fU2G/+xO4AzYqheOh1/VWPUs5Hb3fP2fi/NfqpbqvtTBa8SDF8t
         u1WDODaHbGJTQEX5w3WtA/ZsveXqMFf8KZ/f6Zi61vaWGDs+tXTAnhcX986DLG7o+RDs
         xQc1m6KaL1uYhhF00mvMv1hYWSFcGmb5J3u4txGguevTfDdBw+2bLleBHoGxgIC8OqhU
         ZgYMuXSYf0PVyX7PggxhP/TWgJFt7T9KawuMcVBeJNPkGpdAmOMJvw3AovbfOaqoOy+R
         4cDw==
X-Gm-Message-State: APjAAAXS6vOFYeltzsSvtRfp5+6ZuIW5wx08b5FH0VZ+fR7JTWyWyWLF
        AgUoQFQGik1gecFPQ7b4GQRPXReyGE0=
X-Google-Smtp-Source: APXvYqwj8f1IHdifiiaFuKPEatnSCR7Xi+WTvnZ/Adiuyh8puGX3sY2lBqWW7L3cwGMmG0zBdFKdEw==
X-Received: by 2002:a5d:51d2:: with SMTP id n18mr872226wrv.10.1569463806948;
        Wed, 25 Sep 2019 19:10:06 -0700 (PDT)
Received: from Bfire.plexistor.com ([217.70.210.43])
        by smtp.googlemail.com with ESMTPSA id o19sm968751wro.50.2019.09.25.19.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 19:10:06 -0700 (PDT)
From:   Boaz Harrosh <boaz@plexistor.com>
X-Google-Original-From: Boaz Harrosh <boazh@netapp.com>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matt Benjamin <mbenjami@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Sagi Manole <sagim@netapp.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 02/16] MAINTAINERS: Add the ZUFS maintainership
Date:   Thu, 26 Sep 2019 05:07:11 +0300
Message-Id: <20190926020725.19601-3-boazh@netapp.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926020725.19601-1-boazh@netapp.com>
References: <20190926020725.19601-1-boazh@netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ZUFS sitting in the fs/zuf/ directory is maintained
by Netapp. (I added my email)

I keep this as separate patch as this file might be
a source of conflicts

Signed-off-by: Boaz Harrosh <boazh@netapp.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a50e97a63bc8..8703871c1505 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17867,6 +17867,12 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	mm/zswap.c
 
+ZUFS ZERO COPY USER-MODE FILESYSTEM
+M:	Boaz Harrosh <boazh@netapp.com>
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+F:	fs/zuf/
+
 THE REST
 M:	Linus Torvalds <torvalds@linux-foundation.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.21.0

