Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6858B262F99
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 16:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbgIIOMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 10:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730273AbgIINHp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 09:07:45 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F30C061573;
        Wed,  9 Sep 2020 06:07:50 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 67so2012741pgd.12;
        Wed, 09 Sep 2020 06:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l/LRvYVAOKtqURaUwND/u+OqQE4NIsYK9mO14jedKw0=;
        b=iPLT9TuOiQxJCTc104sFUmTZlM86Nqk9+uPt7yOjzR52cklKdMquF7R5lbePKGhqXu
         f9uHBGvsaWLyLjist4Sd32WyBh84ScHQFwZiQyPVG6oSlZQNNcZHNo2jCDzPaQv6oXN8
         38eUuHcP8kjuN8gNrSTLbCa/E33vqbfNhiVDheRBZQ5gCZjVhRzYOQpFbeQ664sdiZsD
         YVwxvvjuhU8MBXUGw4DVcg6G+xW1WHoJJjKnLHElT8WZdD88itgusGoLdsd5iVIA8Jee
         E82dfsHv9Ff4/9ZpV5UIcROqw+XGWbXS8eK7GrMkXbQDcifwRzc31PRk9lxW7QdV6HRm
         vCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l/LRvYVAOKtqURaUwND/u+OqQE4NIsYK9mO14jedKw0=;
        b=U+ZC17M5Iapa8MBN3lrfXwaAcvlMqMQLXPb/+DiQpcM7BqFNGaycWMtQXkjQrl27Ek
         LIklLUOD1m4bXnR3syI7zyihaOD3L01mn8W+MFkyBaMyiGoVqYtHPcCYUvYuikpRiO3M
         tv1NzFOz0wGnlfqeXwEX//bj3iKW5uddvBuAUAtPWZkBMniuTJokKLfBeVqVPLG5VDDw
         M6IQv/MwXz+bYg5UWiOXjJoC/Dcm4Faf8rVDDJjFRygaUcnB9jAJZgZyr8k9m+Lpgswr
         vao576r7zI4RPyOMa3Y+kpTbOr7xH9qiSvzZbzqgNL2hGnZ3Owp0JWIaB3b96kzmYW+i
         ksAA==
X-Gm-Message-State: AOAM533KCFwejg818DrxYn1gXjhi82e4ZpDtLLGfax1+baFTBa9veuo4
        lNqyD9mJYnYOQjybexbsTwW/8k2sfmh5cF7Y
X-Google-Smtp-Source: ABdhPJzuCTpu++I4HhPcfcaFCoYpkyOCAXu/nwUhUobuP1+VodiagGec1MKPJDQlk9vCZ9sSdsvMeA==
X-Received: by 2002:aa7:8512:0:b029:13c:1611:653e with SMTP id v18-20020aa785120000b029013c1611653emr859886pfn.16.1599656869521;
        Wed, 09 Sep 2020 06:07:49 -0700 (PDT)
Received: from ubuntu.localdomain ([47.75.194.237])
        by smtp.gmail.com with ESMTPSA id x3sm2297753pgg.54.2020.09.09.06.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 06:07:49 -0700 (PDT)
From:   ownia <o451686892@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ownia <o451686892@gmail.com>
Subject: [PATCH] fs/read_write.c: remove extra space
Date:   Wed,  9 Sep 2020 06:07:42 -0700
Message-Id: <20200909130742.81895-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: ownia <o451686892@gmail.com>
---
 fs/read_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 5db58b8c78d0..4cdbf45ced98 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1497,7 +1497,7 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 	if (retval < 0)
 		goto fput_in;
 	if (count > MAX_RW_COUNT)
-		count =  MAX_RW_COUNT;
+		count = MAX_RW_COUNT;
 
 	/*
 	 * Get output file, and verify that it is ok..
-- 
2.25.1

