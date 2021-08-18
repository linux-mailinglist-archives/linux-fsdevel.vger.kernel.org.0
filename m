Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7843F063D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 16:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbhHROQm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 10:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239995AbhHROOu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:14:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160F7C061158;
        Wed, 18 Aug 2021 07:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=z4MCNHhCspLoQHSiqkbpMAHembWOXPJmB4CL3aOqh6g=; b=COcvMN76XdyCfAhgJuQ6dMLnms
        g2IC3e0WnV44+jc6XPYsI2NMnGfT7OMvlRZWG4Cb99F62uWbMbl1iUGWNqX0UH4RYk0nbaWDFzCq6
        mOB2nUeAmCS07Vir/rd8JTwGFshFfRRHQ44JW6pWbwPgCcMzspHj/JZYZ6XFJRuI6AVyZEV6m8aAG
        SgeTDqVXx9vg8onhQra9ltQA8brZFPxwYyoRILGm0keb3gtJeZ/pGx0oNu+5Im7s1sSQBhURkBUZ3
        EeeLqXbCKT4rzRIYDlKZXnB1D1ElKy433b2PcBXyH8WgVx6fJ+JR93nORvhtY9uUCpT3nXQ5G6L+g
        rQ7wDHwQ==;
Received: from [2001:4bb8:188:1b1:5a9e:9f39:5a86:b20c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGMIE-003uZE-Pc; Wed, 18 Aug 2021 14:12:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 04/11] unicode: mark the version field in struct unicode_map unsigned
Date:   Wed, 18 Aug 2021 16:06:44 +0200
Message-Id: <20210818140651.17181-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818140651.17181-1-hch@lst.de>
References: <20210818140651.17181-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

unicode version tripplets are always unsigned.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/unicode.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index 6a392cd9f076..0744f81c4b5f 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -6,7 +6,7 @@
 #include <linux/dcache.h>
 
 struct unicode_map {
-	int version;
+	unsigned int version;
 };
 
 int utf8_validate(const struct unicode_map *um, const struct qstr *str);
-- 
2.30.2

