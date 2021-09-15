Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE6A40C007
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 09:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbhIOHFK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 03:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhIOHFK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:05:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0881C061574;
        Wed, 15 Sep 2021 00:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=xRexORlxlpSmmPQ2VemF90E+SWhy7i1/m1bX7rSd2nk=; b=KoIB+YbvzUAPZywXg+BLeMZY1z
        fs0NZnlOkeF6jjQUAYl5WsIYaZhHgfKSUDnlFjwQglFNbJ5RVtDndDcom/6T0dkA+4qFlqNqjvRBV
        odEFv0cY/AzqUkGyfrXqIu6rIUp9txkVeyfulDat9pqM6JKkaIYBJ1U1D64hPkjwpG1z42rtCnPsX
        ULCmLTXRpwTZMjmGTqyJSBzwWyIUbHpJw8ov7j2j48L5CDx5InaHAaSEmOKMr4jLwuQR9G/QVYrO+
        LzYumvJp3jtMDGYmuusa/KDCmRK76kf55Vut1CTZRwkAtZ5rc9nB5FLL6rq9uTJ6GhrJ65zKmszSV
        frEKlROw==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQOwP-00FRZJ-OT; Wed, 15 Sep 2021 07:03:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 04/11] unicode: mark the version field in struct unicode_map unsigned
Date:   Wed, 15 Sep 2021 08:59:59 +0200
Message-Id: <20210915070006.954653-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210915070006.954653-1-hch@lst.de>
References: <20210915070006.954653-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

unicode version tripplets are always unsigned.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 include/linux/unicode.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index 6a392cd9f076d..0744f81c4b5fc 100644
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

