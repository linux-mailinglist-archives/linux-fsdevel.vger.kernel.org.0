Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A88D339C26
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 06:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhCMFWv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Mar 2021 00:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhCMFWS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Mar 2021 00:22:18 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F071DC061574;
        Fri, 12 Mar 2021 21:22:17 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id m7so5569971qtq.11;
        Fri, 12 Mar 2021 21:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mRBD7zfsLyF5l53ekqZCiqj3vLccHxkyKELD6CUnroM=;
        b=S2jVWj+YwAU462jjwWx8GsSxwgj2xkNrlsH/+E6359s8DqyL862l3KaRGpJH9bbbGq
         1kBaXo3vbcXx6vlQuY7cf65ZqwPANIPon+hqhBhQua2JbzpWQDsXyJaLCUbWJ92Jiema
         g6IFHz7+tU0pHobnlsOG1ZrWuwFOaSXCAynN6IhNc+oOVjr2YmbBKfjD7YcEwZ3B9+IK
         WrlqFRB3mPuyHcW8mixH8asetK0qkW/0rpA9DNaRb1KhPsOIf+25eWNTIAEo4esq31Ja
         V9OQ9bPk/QnqiNbLv+6g1/gjSVBrFiUpVhd66/nbVMP5jKTTwUvXvWCVP7+MgLIY7dzO
         hDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mRBD7zfsLyF5l53ekqZCiqj3vLccHxkyKELD6CUnroM=;
        b=WgnsAd6RX+Ko5oFvqZd4HTU6S2Ch8HWdmYP1lVQ3nCyldTe3kAgDAYWSPY5dBXglI+
         MKaNWXO+mY85Pg1Yf+Bco6CN4qIOgRcA4sd8X5xGecEElRHO/f6uMKSpafw8YkAJXzdT
         pyFItQWTEYcH7JV7GpFozuWeShEX47DdLtoyC4pczb2m0X4xkovzw5sZlq+4jix+/iQ2
         sCkInuU4S7UZuSuYdYB4wB8sm3rBoqsw8X0JnH2BoJLFCLpbJhQ6BBiRR8hm4+8FgBnW
         Dx9Om98pTJRNWNwgzOFwN5yCheRrwH7pNHRVIW4DhvTdQEiUC9W3GNoGP4fVlNBybPRr
         PeKA==
X-Gm-Message-State: AOAM531kqERGUdSNzF5o/aN2RjxCINsFWQigV+lZagy8Mp+xrEGzqPgf
        uIYxFVOj1Qnaj1eOzzz3lud50xdWCEdZu+R7
X-Google-Smtp-Source: ABdhPJwIOwuQki4prL8eZ5gz1ziqQu8VqyrsHQYZEQBgznjgFclHfkPutS168CKsHwOcFMPz+EobMw==
X-Received: by 2002:ac8:4f10:: with SMTP id b16mr4137863qte.235.1615612937111;
        Fri, 12 Mar 2021 21:22:17 -0800 (PST)
Received: from localhost.localdomain ([37.19.198.104])
        by smtp.gmail.com with ESMTPSA id h7sm5949126qkk.41.2021.03.12.21.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 21:22:16 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] include: linux: Fix a typo in the file fs.h
Date:   Sat, 13 Mar 2021 10:49:55 +0530
Message-Id: <20210313051955.18343-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

s/varous/various/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ec8f3ddf4a6a..c37a17c32d74 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1051,7 +1051,7 @@ bool opens_in_grace(struct net *);
  * FIXME: should we create a separate "struct lock_request" to help distinguish
  * these two uses?
  *
- * The varous i_flctx lists are ordered by:
+ * The various i_flctx lists are ordered by:
  *
  * 1) lock owner
  * 2) lock range start
--
2.26.2

