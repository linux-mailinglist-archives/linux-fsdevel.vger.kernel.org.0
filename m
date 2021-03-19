Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2BD342851
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 23:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhCSWDB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 18:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhCSWCw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 18:02:52 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532BAC06175F;
        Fri, 19 Mar 2021 15:02:52 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id y5so2983529qkl.9;
        Fri, 19 Mar 2021 15:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VaoARf1mLHnIGXwJpOXA9mAhtZD0YHjrlT9KRRAUBGc=;
        b=Rv6wtUl0rRtzTOPH6R4YB3HRUd919pvxyxZHbL+lN1hx18/CxQaoJsunPFJI++ZnaU
         L0rhKxSkq4drpokusf7xoLQgdCcmFyXhrmP0slSd02N7TEb3qqqcPs8XSf/MAKkWaORY
         nehpNSDMBYn2h1BNR/D4YcYSTZGz8bIpY0hAHiiFAI94a6RGB4ENpJwf1eL7P3it2QKQ
         plx23s8G5HbAXmkOcVcLb7WFB3o1yZ/WCOJd5Mjh0/b/kRdkYDUzSOl+MhYkAznZFCUY
         BW7UGf5R03G5oclssznNoqbXQDwSC5Q0kqBmDRQNESlcpPLb+pqlqQ7D7rlIi7+nYoNf
         rXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VaoARf1mLHnIGXwJpOXA9mAhtZD0YHjrlT9KRRAUBGc=;
        b=iVb281kwKusCFrEX7pD+GMD7iY3AqrYRTXAHgzSf8dFKwHm1+/Fcnp6XqkjkND5XA1
         pKvuetw7NhAh2Fyiiuzfzjjm1os92AH6z/YdvJoJhAR2lL/BACRDEQYqLs/0XPuas+Bc
         VMW4aPyyT+qBLDg6iipt79AdB5U+AkKu9u15XilU0uUbm3o1JWEr6kG2cPwozbWTACCZ
         M7SY3610vm+ucIF4PWwWpl72Hh/MqRVxw1xLzeH8hkRJcrEm5dCUvT0pxE5wU5Aw92IK
         8AbxU9AW0jDrEoO2LMn+fYwajRkKu6BnaLSOO+r6HK0VirhgJUqovrioOEQC8VATeYew
         cbQQ==
X-Gm-Message-State: AOAM531tx8UzffGdvsFO3Llcmkj1lnJFgzHzD2oJYxPiNg3XK9TXsZte
        0BLhfw5svvRc3zY2df8q5pw=
X-Google-Smtp-Source: ABdhPJzG4TakqX0xVx0xUaCg5K4kr6YqkakIqoYe9rR6K4Wq7MzyKEy8eI9mbovmoUbxeQYWFg/o5g==
X-Received: by 2002:a05:620a:16d4:: with SMTP id a20mr738742qkn.410.1616191371666;
        Fri, 19 Mar 2021 15:02:51 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.27])
        by smtp.gmail.com with ESMTPSA id v5sm4638081qtq.26.2021.03.19.15.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 15:02:51 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] binfmt_misc: Trivial spello fix
Date:   Sat, 20 Mar 2021 03:30:34 +0530
Message-Id: <20210319220034.15876-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


s/delimeter/delimiter/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Al, please don't fret over this trivialities. I am trying to make sense the
 change I am making.

 fs/binfmt_misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index e1eae7ea823a..1e4a59af41eb 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -297,7 +297,7 @@ static Node *create_entry(const char __user *buffer, size_t count)
 	if (copy_from_user(buf, buffer, count))
 		goto efault;

-	del = *p++;	/* delimeter */
+	del = *p++;	/* delimiter */

 	pr_debug("register: delim: %#x {%c}\n", del, del);

--
2.26.2

