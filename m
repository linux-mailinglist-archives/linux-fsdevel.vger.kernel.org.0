Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA0C6CAC78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 19:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjC0R4j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 13:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjC0R4Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:56:25 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDB34481;
        Mon, 27 Mar 2023 10:55:46 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id y19so5662714pgk.5;
        Mon, 27 Mar 2023 10:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679939742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTZpI//Tzxb69PVqP+6KSGMc/N99I4Rh6kzXUg6Qf3c=;
        b=KzJQ4Zoyh25lshRcEk9Mk4u3QKPhuPrEVuIW6/OcqBI/6jeJ6kxr+KuXjsy6ElQBo0
         sMReFt0dNEHFIOMCmqK27UbaRXW327gZ2dar1/V1mFTk8BzQU9RHt1bRCt2KKcJW1gK7
         qVmN28OHzRK2QsEL31t13tsKl0B11hgz8ioqV/f527m9KQMVd6EOsiCWtH3UTrGzqHRA
         YwsSsBZ7PeW+SWilcpZ/7A+nXAQHU0DZzBQe6LxcD7+fO+sgL0D75D0gbHeAqCwJUX51
         T0tHdj9igY/VgQP2ikyA5+uGafrY1Op2gxA6rP0rD+XA34AoHj+EVI8E0+KMeGgP/tJ8
         nZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679939742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTZpI//Tzxb69PVqP+6KSGMc/N99I4Rh6kzXUg6Qf3c=;
        b=EheoQudfzb2EYbdgKyfXt4LqIfqmhRDPApAv5btf0LqVN6wq3vrfBgRA2+l7kcnGNx
         rqcBoN7liwPFKs8hy49eMKab37Vp1r2QJQZtzDlEx/rOykfoL1jx/v5h5mfjFwBHhZ+F
         baDJZKAmyHvrvwSLhpWMNIOPMBx2f4dfas5hwHzu5qAmmNnw+B27WzGo/ahcC/3E67ck
         p8BrZZycreLE3MDnbqVObX6VlbnH5/f7pPM78t0w8doKxEwfh/SkgelmQXvNKv0YOe5y
         yapMCqzZpqpua4NVC6SP3jvcFmDcbDn9/iIuhdI7uGfIfRX/pvv3PQYsklDDM8mZPMFz
         5wQg==
X-Gm-Message-State: AAQBX9cbpsKfKwlwE+IkP3yx1g6wz+iDS2RkNaS27z2s12duwNiDR9ux
        0jSYoPNEbvbfEfOmeYSj8jQ=
X-Google-Smtp-Source: AKy350aeueLyYZm0lpV8z+wxw14Zvaw/JyArvQbpSEtpyZYeq4g9vBC4XC7PIRQkwQuMfQZOY8/lbg==
X-Received: by 2002:a62:7b10:0:b0:625:c048:2f81 with SMTP id w16-20020a627b10000000b00625c0482f81mr11838977pfc.32.1679939741671;
        Mon, 27 Mar 2023 10:55:41 -0700 (PDT)
Received: from carrot.. (i223-217-34-84.s42.a014.ap.plala.or.jp. [223.217.34.84])
        by smtp.gmail.com with ESMTPSA id x8-20020aa79188000000b0062622ae3648sm19214784pfa.78.2023.03.27.10.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 10:55:40 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs@vger.kernel.org,
        syzbot <syzbot+b08ebcc22f8f3e6be43a@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] nilfs2: fix potential UAF of struct nilfs_sc_info in nilfs_segctor_thread()
Date:   Tue, 28 Mar 2023 02:53:18 +0900
Message-Id: <20230327175318.8060-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <00000000000000660d05f7dfa877@google.com>
References: <00000000000000660d05f7dfa877@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The finalization of nilfs_segctor_thread() can race with
nilfs_segctor_kill_thread() which terminates that thread, potentially
causing a use-after-free BUG as KASAN detected.

At the end of nilfs_segctor_thread(), it assigns NULL to "sc_task" member
of "struct nilfs_sc_info" to indicate the thread has finished, and then
notifies nilfs_segctor_kill_thread() of this using waitqueue
"sc_wait_task" on the struct nilfs_sc_info.

However, here, immediately after the NULL assignment to "sc_task",
it is possible that nilfs_segctor_kill_thread() will detect it and return
to continue the deallocation, freeing the nilfs_sc_info structure before
the thread does the notification.

This fixes the issue by protecting the NULL assignment to "sc_task" and
its notification, with spinlock "sc_state_lock" of the struct
nilfs_sc_info.  Since nilfs_segctor_kill_thread() does a final check to
see if "sc_task" is NULL with "sc_state_lock" locked, this can eliminate
the race.

Reported-by: syzbot+b08ebcc22f8f3e6be43a@syzkaller.appspotmail.com
Link: https://lkml.kernel.org/r/00000000000000660d05f7dfa877@google.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/segment.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 19446a8243d7..6ad41390fa74 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2609,11 +2609,10 @@ static int nilfs_segctor_thread(void *arg)
 	goto loop;
 
  end_thread:
-	spin_unlock(&sci->sc_state_lock);
-
 	/* end sync. */
 	sci->sc_task = NULL;
 	wake_up(&sci->sc_wait_task); /* for nilfs_segctor_kill_thread() */
+	spin_unlock(&sci->sc_state_lock);
 	return 0;
 }
 
-- 
2.34.1

