Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86F1CE7EF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2019 05:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfJ2EFh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Oct 2019 00:05:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37291 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfJ2EFh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Oct 2019 00:05:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id u9so3821204pfn.4;
        Mon, 28 Oct 2019 21:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=6kfMSy0YgXJLyBlk1+ds2GJPOLdmrFH2Txe8Vx2BEAo=;
        b=qMcnvSdtU0oU4QbZESXTMDIDXuhTMtdCoSPB57JMG8PEt6fskTqfW3V9WDHRC9h2Xo
         rMVOMLKx2elTTyiFOtFxlX/QTnbr7lAxkGOBG5I84zs62pturUoRi/kaYGtdUXEwcj+7
         Dkh6qXE2Bm9E6Fwao9zdZV8CZn9nI3YK9BADEeHYj/gttkyxvIpJ0iQ2/hpqQX4zac5X
         iHFOe7A4liELhYdVype5HpQ3nXZudc+rgUkr9kHqT32rtYEWMCnt8wbEaYc6xC0fjRLT
         WYjXaos6ptmwTIg2NYbLRVankZHB1dZaRUH63trWBpyAibRnZv5CEQEx9zbGDvFg9LsG
         VniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6kfMSy0YgXJLyBlk1+ds2GJPOLdmrFH2Txe8Vx2BEAo=;
        b=anQlJR7dC+wWrxX9RZNqfqxvEUalqs6KtXfSAta8ctFzt00U0nIidq+bB99KtVT8Me
         eDsBEpok8+nrUfmp3Qg42Q6uKJF/dVXu+7jkuA6aNqucxIaK9tVyXS/DYgdvvJKRggcU
         SeWnohl7Y4oeu2me8uHoSeNQ8htrUYTGciF+b/f8kf/hWwcY6W/MYsvbXTMyPtpRaKoB
         5afA+nEDet2dtTa+WkYDO7pCU/AmeRMEQM1g86LpV1ZgUxyl2QZGF7umvKado/lN2HW/
         J1Zuyi49Opw5XwAn/qf5fkdoCISSGkRmLhGm4KcifIPZIi/v0xIYFsHrzmRY6FkJlDmt
         /lyw==
X-Gm-Message-State: APjAAAWZM2MAnLcjWYUYyOODiE6vGniPzzcnTDPFXyJN6FE3zlBQbsbq
        +9zAboR5qfTmhNQAe+8ergKRJQ3IQ1Q=
X-Google-Smtp-Source: APXvYqxsjIyyj4Ra1iYRvCc5o+ssppErTK1FGHOLkdks6DLomEu0wqnIqE1NHZl7JVzVhCvp+kgCXA==
X-Received: by 2002:a63:c40e:: with SMTP id h14mr24406732pgd.254.1572321936001;
        Mon, 28 Oct 2019 21:05:36 -0700 (PDT)
Received: from saurav ([27.62.167.137])
        by smtp.gmail.com with ESMTPSA id s18sm6102396pfc.120.2019.10.28.21.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 21:05:35 -0700 (PDT)
Date:   Tue, 29 Oct 2019 09:35:29 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] fs: buffer.c: Fix use true/false for bool type
Message-ID: <20191029040529.GA7625@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use true/false for bool return type of has_bh_in_lru().

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 fs/buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 86a38b979323..66a9fe8310c7 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1385,10 +1385,10 @@ static bool has_bh_in_lru(int cpu, void *dummy)
 	
 	for (i = 0; i < BH_LRU_SIZE; i++) {
 		if (b->bhs[i])
-			return 1;
+			return true;
 	}
 
-	return 0;
+	return false;
 }
 
 void invalidate_bh_lrus(void)
-- 
2.20.1

