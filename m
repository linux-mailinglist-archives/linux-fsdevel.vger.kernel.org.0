Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1561F975D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 14:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbgFOMzc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 08:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730103AbgFOMxi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:53:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFD2C061A0E;
        Mon, 15 Jun 2020 05:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=igmuI7FT2PlLpNvSIQhC5NOf4lwLGTOJ/vt07sRMgDU=; b=UYpP2zRoXncLqt3zepGTXwUFGY
        m3o7tI7EYQjb+PFj5hZxXSYslnUbaIYI9SSZU4cVXtfnaeZzcS3W3tknfTcojFeL2zC6WMR3DTNr7
        ieSdnRLlu8mOaZdiCJl3V+KfNiEH3g4b6rxECSu/bJwuHSVrzXZqGjYu1/Rv5j5fqD5TrEekA0p9R
        9ZeetgZBz+ze4a+BTMkOXpyqg3MVx8Wv84GuGn4w64BjbyHKq0k2DT6YdRoOyMIkYwMuI7Wy5MmrC
        RRqqvOiEez9hRzFCGEFtR42fzd3vzk2pNgs6dp2Z9s+9q1k5Pdog1IC2kaYZOXAmccEjfCb3QhDr6
        sVVF0F4Q==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkocL-0000qp-K0; Mon, 15 Jun 2020 12:53:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/16] md: remove the kernel version of md_u.h
Date:   Mon, 15 Jun 2020 14:53:12 +0200
Message-Id: <20200615125323.930983-6-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615125323.930983-1-hch@lst.de>
References: <20200615125323.930983-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

mdp_major can just move to drivers/md/md.h.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md.h           |  1 +
 include/linux/raid/md_u.h | 13 -------------
 2 files changed, 1 insertion(+), 13 deletions(-)
 delete mode 100644 include/linux/raid/md_u.h

diff --git a/drivers/md/md.h b/drivers/md/md.h
index 37315a3f28e97d..6f8fff77ce10a5 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -801,6 +801,7 @@ static inline void mddev_check_write_zeroes(struct mddev *mddev, struct bio *bio
 		mddev->queue->limits.max_write_zeroes_sectors = 0;
 }
 
+extern int mdp_major;
 void md_autostart_arrays(int part);
 
 #endif /* _MD_MD_H */
diff --git a/include/linux/raid/md_u.h b/include/linux/raid/md_u.h
deleted file mode 100644
index 8dfec085a20ee1..00000000000000
--- a/include/linux/raid/md_u.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
-   md_u.h : user <=> kernel API between Linux raidtools and RAID drivers
-          Copyright (C) 1998 Ingo Molnar
-	  
-*/
-#ifndef _MD_U_H
-#define _MD_U_H
-
-#include <uapi/linux/raid/md_u.h>
-
-extern int mdp_major;
-#endif 
-- 
2.26.2

