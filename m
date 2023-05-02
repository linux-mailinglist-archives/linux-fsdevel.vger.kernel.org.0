Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508356F4530
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 15:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbjEBNjt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 09:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbjEBNja (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 09:39:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F30C6E87;
        Tue,  2 May 2023 06:38:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D19311FD63;
        Tue,  2 May 2023 13:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683034729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HAg4rxVkAQ9qbbHiRpMQeKxQl0QBkdUCjNX5t2zLxPg=;
        b=ucryHQBDna3EZnuiMh3G9y4iAHPKeJYgG5vW3YRNWNx+RmQanqEifFfVPpU4RuNZvgpLzK
        dMzvFoUWdePAEGbT1Akvg+MJoZuf3pHOAN0HwewEt2EjQLKqfdq4pEq4k4CABGqPdn/hh6
        72u9XPh9PqGjmr7yHuob9GzfKzp2ql8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A245C139D2;
        Tue,  2 May 2023 13:38:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2MHVJmkSUWTOYQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 02 May 2023 13:38:49 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <dchinner@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Jiri Wiesner <jwiesner@suse.de>
Subject: [RFC PATCH 1/3] cgroup: Drop unused function for cgroup_path
Date:   Tue,  2 May 2023 15:38:45 +0200
Message-Id: <20230502133847.14570-2-mkoutny@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230502133847.14570-1-mkoutny@suse.com>
References: <20230502133847.14570-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no current user and there are alternative methods to obtain
task's cgroup path.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cgroup.c | 39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 625d7483951c..55e5f0110e3b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2378,45 +2378,6 @@ int cgroup_path_ns(struct cgroup *cgrp, char *buf, size_t buflen,
 }
 EXPORT_SYMBOL_GPL(cgroup_path_ns);
 
-/**
- * task_cgroup_path - cgroup path of a task in the first cgroup hierarchy
- * @task: target task
- * @buf: the buffer to write the path into
- * @buflen: the length of the buffer
- *
- * Determine @task's cgroup on the first (the one with the lowest non-zero
- * hierarchy_id) cgroup hierarchy and copy its path into @buf.  This
- * function grabs cgroup_mutex and shouldn't be used inside locks used by
- * cgroup controller callbacks.
- *
- * Return value is the same as kernfs_path().
- */
-int task_cgroup_path(struct task_struct *task, char *buf, size_t buflen)
-{
-	struct cgroup_root *root;
-	struct cgroup *cgrp;
-	int hierarchy_id = 1;
-	int ret;
-
-	cgroup_lock();
-	spin_lock_irq(&css_set_lock);
-
-	root = idr_get_next(&cgroup_hierarchy_idr, &hierarchy_id);
-
-	if (root) {
-		cgrp = task_cgroup_from_root(task, root);
-		ret = cgroup_path_ns_locked(cgrp, buf, buflen, &init_cgroup_ns);
-	} else {
-		/* if no hierarchy exists, everyone is in "/" */
-		ret = strscpy(buf, "/", buflen);
-	}
-
-	spin_unlock_irq(&css_set_lock);
-	cgroup_unlock();
-	return ret;
-}
-EXPORT_SYMBOL_GPL(task_cgroup_path);
-
 /**
  * cgroup_attach_lock - Lock for ->attach()
  * @lock_threadgroup: whether to down_write cgroup_threadgroup_rwsem
-- 
2.40.1

