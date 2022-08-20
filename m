Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4A259A9E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 02:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244558AbiHTAGR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 20:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244401AbiHTAGN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:06:13 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE47C59E4;
        Fri, 19 Aug 2022 17:06:12 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id 20so5343736plo.10;
        Fri, 19 Aug 2022 17:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=mALUVzvQkNStgXaHgA3odIsd31YxLLGk1d2u95EoEbw=;
        b=oVeJjDc3RH46Mfe5B8tkD6PdFxEdVoazg8nbQW8oMsw3JPk3gclva8LRuwooFi+Yhh
         UfACsm70DPl4YknurmVAfkFyLXAamAb97UiskrCdJtVzSTyr8X2urqsw9ATZ2dvKEKFF
         7Fz69+byXmQoQrPx2UWpf3cumRScIwLF5Vtwa9JKlCHlU+JBAO/ZkDjjvNoYGFDiQtEv
         hxs4xUDLt6wXUlvj/SN2j2NNZwMxBEh15P4WTc5cwcQHkQlX8U+FJC3zUiV1YwZLLQwK
         aUiTaqwJis86CwvPFaBCY7LfO0Ntl1V1B9r7AJOtEn56f/Wj9Isj3Vp7eOJYUf/BtIJQ
         KBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=mALUVzvQkNStgXaHgA3odIsd31YxLLGk1d2u95EoEbw=;
        b=QePyw8PQZ5o159b1GG5rh6yiB6nWkzOmqKHOXE1o9HTjlgq1maO/kC3ba5HNzqmq6k
         Ii7W3hm12hhEI6v28LqFIyzdXEXJjsnH6dM0+CKfAXmbawvZwEWXH0RJAim66kio26gP
         kN9m4gEtjfjPQSfB/rI20X2Hw1OrV5g7cFD9xNNX84i9dGwM95lnYyJtDzYFcU/C7Wh4
         nmpQt5Ig+s7Y/oOyk8mrxZaks9x2tnLiECY4Y3ZHJtgfFPt2yb1hNs5x1YIVwECGU698
         x7AJPYCxeBnUaSq2Ak0+z6XLDuQ/rbE9swF4X2ZILkNJGw61vRF/RWNl06hh296YpExF
         LUXg==
X-Gm-Message-State: ACgBeo08t+ZcFvES3PUjJ3rPuZQDD0KaPOwiKuRs6jSdhQBq9mqsBhRO
        /LmymIAHjUN7dwsfihva+7MqcqZy4gI=
X-Google-Smtp-Source: AA6agR5CM7J59rSZzXsxpmaVSmGNSqOdihNEvMdBamjMVcEi3uhG6gbUPPwADBu38U+aO5iWNfMhdw==
X-Received: by 2002:a17:902:c411:b0:170:91ff:884b with SMTP id k17-20020a170902c41100b0017091ff884bmr9656022plk.58.1660953971444;
        Fri, 19 Aug 2022 17:06:11 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a2f5])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b0016d93c84049sm3702023pln.54.2022.08.19.17.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 17:06:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/7] kernfs: Make kernfs_drain() skip draining more aggressively
Date:   Fri, 19 Aug 2022 14:05:49 -1000
Message-Id: <20220820000550.367085-6-tj@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820000550.367085-1-tj@kernel.org>
References: <20220820000550.367085-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kernfs_drain() is updated to handle whether draining is necessary or not
rather than its caller. __kernfs_remove() now always calls kernfs_drain()
instead of filtering based on KERNFS_ACTIVATED.

kernfs_drain() now tests kn->active and kernfs_should_drain_open_files() to
determine whether draining is necessary at all. If not, it returns %false
without doing anything. Otherwise, it unlocks kernfs_rwsem and drains as
before and returns %true. The return value isn't used yet.

Using the precise conditions allows skipping more aggressively. This isn't a
meaningful optimization on its own but will enable future stand-alone
kernfs_deactivate() implementation.

While at it, make minor comment updates.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 fs/kernfs/dir.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 8ae44db920d4..f857731598cd 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -460,10 +460,14 @@ void kernfs_put_active(struct kernfs_node *kn)
  * @kn: kernfs_node to drain
  *
  * Drain existing usages and nuke all existing mmaps of @kn.  Mutiple
- * removers may invoke this function concurrently on @kn and all will
+ * callers may invoke this function concurrently on @kn and all will
  * return after draining is complete.
+ *
+ * RETURNS:
+ * %false if nothing needed to be drained; otherwise, %true. On %true return,
+ * kernfs_rwsem has been released and re-acquired.
  */
-static void kernfs_drain(struct kernfs_node *kn)
+static bool kernfs_drain(struct kernfs_node *kn)
 	__releases(&kernfs_root(kn)->kernfs_rwsem)
 	__acquires(&kernfs_root(kn)->kernfs_rwsem)
 {
@@ -472,6 +476,16 @@ static void kernfs_drain(struct kernfs_node *kn)
 	lockdep_assert_held_write(&root->kernfs_rwsem);
 	WARN_ON_ONCE(kernfs_active(kn));
 
+	/*
+	 * Skip draining if already fully drained. This avoids draining and its
+	 * lockdep annotations for nodes which have never been activated
+	 * allowing embedding kernfs_remove() in create error paths without
+	 * worrying about draining.
+	 */
+	if (atomic_read(&kn->active) == KN_DEACTIVATED_BIAS &&
+	    kernfs_should_drain_open_files(kn))
+		return false;
+
 	up_write(&root->kernfs_rwsem);
 
 	if (kernfs_lockdep(kn)) {
@@ -480,7 +494,6 @@ static void kernfs_drain(struct kernfs_node *kn)
 			lock_contended(&kn->dep_map, _RET_IP_);
 	}
 
-	/* but everyone should wait for draining */
 	wait_event(root->deactivate_waitq,
 		   atomic_read(&kn->active) == KN_DEACTIVATED_BIAS);
 
@@ -493,6 +506,8 @@ static void kernfs_drain(struct kernfs_node *kn)
 		kernfs_drain_open_files(kn);
 
 	down_write(&root->kernfs_rwsem);
+
+	return true;
 }
 
 /**
@@ -1370,23 +1385,14 @@ static void __kernfs_remove(struct kernfs_node *kn)
 		pos = kernfs_leftmost_descendant(kn);
 
 		/*
-		 * kernfs_drain() drops kernfs_rwsem temporarily and @pos's
+		 * kernfs_drain() may drop kernfs_rwsem temporarily and @pos's
 		 * base ref could have been put by someone else by the time
 		 * the function returns.  Make sure it doesn't go away
 		 * underneath us.
 		 */
 		kernfs_get(pos);
 
-		/*
-		 * Drain iff @kn was activated.  This avoids draining and
-		 * its lockdep annotations for nodes which have never been
-		 * activated and allows embedding kernfs_remove() in create
-		 * error paths without worrying about draining.
-		 */
-		if (kn->flags & KERNFS_ACTIVATED)
-			kernfs_drain(pos);
-		else
-			WARN_ON_ONCE(atomic_read(&kn->active) != KN_DEACTIVATED_BIAS);
+		kernfs_drain(pos);
 
 		/*
 		 * kernfs_unlink_sibling() succeeds once per node.  Use it
-- 
2.37.2

