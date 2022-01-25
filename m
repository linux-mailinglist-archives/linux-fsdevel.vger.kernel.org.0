Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00DF49B4BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 14:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576009AbiAYNPq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 08:15:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58553 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1575900AbiAYNNs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643116426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6LhuCKNpl5Mr5FmOdMXfKw0fCGKJWmNXvJmUdv5fZjE=;
        b=RVDF6DULdY8r6g5HTqqmUUq+/RAR51+Sd5l3N2brPpgGoLUDz4POYjd87EaJrkUxsqwT7C
        PLl7z+VoUmvq7uQK9s7SEw3VPQTn9VleF58pAsd6eAiHyLzZQuunM+oKQd+RheWgcK8RqU
        ojPaTw/9IjtIFOphdGBdTakbC3Z+ujA=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-TKKTTYHxOY-DKL_IHBYFYQ-1; Tue, 25 Jan 2022 08:13:45 -0500
X-MC-Unique: TKKTTYHxOY-DKL_IHBYFYQ-1
Received: by mail-ot1-f71.google.com with SMTP id q4-20020a056830018400b0059eb82177ceso5757166ota.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jan 2022 05:13:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6LhuCKNpl5Mr5FmOdMXfKw0fCGKJWmNXvJmUdv5fZjE=;
        b=pG39i1bjhryz0yLjQRoZRKQGnS7cknAJKqhOpXW5oNYjUd8R3dtwCavQXXNNOq8HZR
         XP+DHB+iebCeFNllNRAtsPz3Sh6ERQLuB0gbET7CrZAHBu8XFozdxTP8L8UF3qnsKY9b
         oYk8+guhYVRoXzT20s+Wb5faF5Urzta6c4J02D+652MSMRme2UhfjRKWrlIouGXtuKhO
         WSf2tC1VUP8Eypu07lMq9ueWhx4kXytTweoYbuge+IBkaaYC2aZCu5WdhaGVZv5wgEjq
         oIuAdTAaoo/tZzCnN/E0ebLvXfKRwQaTIdxtIvLD5YvkOHSakNICKKAlFIyEBwSuG2vS
         UTxA==
X-Gm-Message-State: AOAM530yE0unRflWg7lMYHZNHtETD6jppV4f8INBAOlEn+GuvWmD2YFV
        7ht1tOBYRM0gW1bx8rrJ4QH1yvJhtkclUszhDlRmsR6/QVAaYBVVPHAaWUWd660/yNf9mL8RO/9
        kFuUyXBlpYsZBLvvtyH/DmCPOIw==
X-Received: by 2002:a9d:7cc9:: with SMTP id r9mr14981847otn.202.1643116424266;
        Tue, 25 Jan 2022 05:13:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy3GCBYRnmoVjmAeeOLFh58KLE5ElzDvK61FBrcsepiQ8dGKOKmIx17szD8N7OkhaOHVyXWbw==
X-Received: by 2002:a9d:7cc9:: with SMTP id r9mr14981840otn.202.1643116424079;
        Tue, 25 Jan 2022 05:13:44 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id s3sm3168988otg.67.2022.01.25.05.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 05:13:43 -0800 (PST)
From:   trix@redhat.com
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] namei: cleanup double word in comment
Date:   Tue, 25 Jan 2022 05:13:40 -0800
Message-Id: <20220125131340.1109125-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'to'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index fa9be370c6702..61c87d4cdc5cd 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -797,7 +797,7 @@ static bool try_to_unlazy(struct nameidata *nd)
  * @seq: seq number to check @dentry against
  * Returns: true on success, false on failure
  *
- * Similar to to try_to_unlazy(), but here we have the next dentry already
+ * Similar to try_to_unlazy(), but here we have the next dentry already
  * picked by rcu-walk and want to legitimize that in addition to the current
  * nd->path and nd->root for ref-walk mode.  Must be called from rcu-walk context.
  * Nothing should touch nameidata between try_to_unlazy_next() failure and
-- 
2.26.3

