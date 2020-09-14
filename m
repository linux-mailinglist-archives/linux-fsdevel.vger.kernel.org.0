Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD5E268596
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 09:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgINHRh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 03:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgINHRg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 03:17:36 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48257C06174A;
        Mon, 14 Sep 2020 00:17:34 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id u13so10826390pgh.1;
        Mon, 14 Sep 2020 00:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iRW/FW1Np+YtEGqsmaoeh3JQNR78byaIpaqUOFDmj9Y=;
        b=OR53e58yN4Vt2nmtjeZTTgzgsLKOrdX6/V8qFpA7qtdkM9Fw4DcIRM40ny/4dAutgk
         5VfCW1P/cMyj220H5if+1Smhbc9d+Vif5Yua2DL3hatF14a02WUhfzWE2UyGl3tmS4sI
         zqCQH+mW6Iv3rQRkSpU2IDXmwvFNc//MSaGCKBtoVbdtiv9a4UCdmAQE2gs9tAN3jBNg
         9BV7OBTVFN1FGUNJS+NoSRETaYCAUkYvy6GdBBIcO8PkoGemM8XZjFU0LtlsFFAIFZs5
         64WvhHO08uqGc2gflx0VxWPYJ8nsFtlT8Ck6eD14n8cQHigGO4Kt2gfh5mnhNlEMvWR/
         L5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iRW/FW1Np+YtEGqsmaoeh3JQNR78byaIpaqUOFDmj9Y=;
        b=mgGYnMcgIrB+k0B1z+PIhewwf7GT/R4EtiDPKHuK+5pxG2IuQBEIA/jhQvtDxCYxSD
         9+rYHM1tTMIUEFcEixq8i5EiirVdYmt9btVKA+l1NEFY4oXgrppmIUO4fKGlSW0dg6x+
         Ggw9JIeokj46oNn18EKIVLiPUc/V4/4a7tvORCABKqko+SI+fPoUOGokGJeicxLQsMcW
         tEcQ2wh1xuuS0ko6aqHKAjQ1WR8hwiICqkylb3tlKQEW2EU7Xa8U0M+upaJM7tugKCUv
         05+xNwjek1YmFgj0KU4GXvAV69FScDmgSUfcMwBCkAqELceAt/W/xWdhIgv/odlmWG/z
         71tA==
X-Gm-Message-State: AOAM530qMYCFHRJho6Gsy3j7eIzfsFgQBkAd4YtDNnDzJT/3BJbDcvU8
        vla9Iuu5niIM7wA12sQdQ1s=
X-Google-Smtp-Source: ABdhPJyI5LGGBHnB0nfenW0rXZtgFQB+yWI6Ogal5/cT+Bz6A2USq72Cy+SnkWhUm2wrzAdxfV8igA==
X-Received: by 2002:a17:902:6b49:b029:d0:a5f8:5991 with SMTP id g9-20020a1709026b49b02900d0a5f85991mr13355535plt.7.1600067853554;
        Mon, 14 Sep 2020 00:17:33 -0700 (PDT)
Received: from localhost.localdomain ([45.118.167.204])
        by smtp.googlemail.com with ESMTPSA id v26sm7670516pgo.83.2020.09.14.00.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 00:17:32 -0700 (PDT)
From:   Anmol Karn <anmol.karan123@gmail.com>
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        anmol.karan123@gmail.com,
        syzbot+f7204dcf3df4bb4ce42c@syzkaller.appspotmail.com
Subject: [Linux-kernel-mentees] [PATCH] idr: remove WARN_ON_ONCE() when trying to check id
Date:   Mon, 14 Sep 2020 12:47:24 +0530
Message-Id: <20200914071724.202365-1-anmol.karan123@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

idr_get_next() gives WARN_ON_ONCE() when it gets (id > INT_MAX) true
and this happens when syzbot does fuzzing, and that warning is
expected, but WARN_ON_ONCE() is not required here and, cecking
the condition and returning NULL value would be suffice.

Reference: commit b9959c7a347 ("filldir[64]: remove WARN_ON_ONCE() for bad directory entries")
Reported-and-tested-by: syzbot+f7204dcf3df4bb4ce42c@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=f7204dcf3df4bb4ce42c 
Signed-off-by: Anmol Karn <anmol.karan123@gmail.com>
---
 lib/idr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/idr.c b/lib/idr.c
index 4d2eef0259d2..7c67560c1ecd 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -266,7 +266,7 @@ void *idr_get_next(struct idr *idr, int *nextid)
 	unsigned long id = *nextid;
 	void *entry = idr_get_next_ul(idr, &id);
 
-	if (WARN_ON_ONCE(id > INT_MAX))
+	if (id > INT_MAX)
 		return NULL;
 	*nextid = id;
 	return entry;
-- 
2.28.0
