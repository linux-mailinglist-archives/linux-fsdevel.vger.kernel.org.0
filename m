Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507BB6FF977
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 20:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbjEKSYk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 14:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238836AbjEKSYi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 14:24:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DD65584
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 11:24:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b922aa3725fso17031560276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 11:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683829475; x=1686421475;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LjUrEJJ1UhaYRGAtGgSCY4PNxG4jgAwHbuTYYPklZWY=;
        b=55rn+NwTS9qkN6o3EHQH9tg5nvgfFAoVfIi3Ps/Vx2UwN/K9+YFrkS/lHydkVA1cxR
         iowaGUww07beE3ntNfoSK93Fb1ceSg9jZe+0OTW9gkOExIsspD5MajhZSLmPMFNhTmMt
         gYuZl1WAugwIYddYiwJQaO7nq+GtN5jEQblGC1v623/h5p5sdc5Fgzt9DS2LFIrWogJ1
         uW449MkphLCiIDXFZtwUGTOaENHChuPdfQqfcJ0QFEkS+4bIncJToGHvvADNkuPgQdkG
         R3TQXk6+FSc/Ziwfvc5dNOcdLIdSb14/ToPdMXENIjkpjZO8fNcFVpbUtLbpkbE1w/zq
         6kkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683829475; x=1686421475;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LjUrEJJ1UhaYRGAtGgSCY4PNxG4jgAwHbuTYYPklZWY=;
        b=GRdMKH+2VozYMjVxparUMQtjAe+/hs1x6kor6/J71xvuuVf/aPKheJma9A71aYJMk5
         3DuKXndrqxqssTkGfN/5ACcDf7xQFld0vkTDRMfBqZ1jPJGgqzoGKmeRiQm0MGL9b+29
         5aVcKoomMxRB890MufVwmGgRSfLVz7+6N+ypxjkNwKhmH0TJtKFJadVT7PiWccOi3N2k
         HQ4xqLBpr2j+GNWp6iXI7yM3Dt1AQ9SaUFfxrS/UrD3FCg2dQm5dNWgpCeTaw61u9Vz+
         QzHPBqVnDMEXwAWeWEVc/YK83LQIoT4yFp20RJ7vUn+Oah8nwxCm09KiCINFwpg048B1
         g+2g==
X-Gm-Message-State: AC+VfDwwB22ruKN0q1sqUXDYJ+eX/cRZrUHaq6G5rKCI9IvR7lIGCfDZ
        XKjhczYpiHpqx6thPrAOoxVnDQbxwojQR7rXYft6
X-Google-Smtp-Source: ACHHUZ5tH1DV1GALQ1Ob1t3RTbPs1BmNd7Keg/peKTDa9epscPLL3nUgdVKOqLkDNSlWMLhG0C8f2l/D/e6LqknAyPsd
X-Received: from axel.svl.corp.google.com ([2620:15c:2d4:203:1119:8675:ddb3:1e7a])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:154f:b0:b78:8bd8:6e77 with
 SMTP id r15-20020a056902154f00b00b788bd86e77mr14316791ybu.8.1683829475459;
 Thu, 11 May 2023 11:24:35 -0700 (PDT)
Date:   Thu, 11 May 2023 11:24:25 -0700
In-Reply-To: <20230511182426.1898675-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230511182426.1898675-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230511182426.1898675-2-axelrasmussen@google.com>
Subject: [PATCH 2/3] selftests/mm: refactor uffd_poll_thread to allow custom
 fault handlers
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Huang Ying <ying.huang@intel.com>,
        James Houghton <jthoughton@google.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Previously, we had "one fault handler to rule them all", which used
several branches to deal with all of the scenarios required by all of
the various tests.

In upcoming patches, I plan to add a new test, which has its own
slightly different fault handling logic. Instead of continuing to add
cruft to the existing fault handler, let's allow tests to define custom
ones, separate from other tests.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/mm/uffd-common.c | 5 ++++-
 tools/testing/selftests/mm/uffd-common.h | 3 +++
 tools/testing/selftests/mm/uffd-stress.c | 6 ++----
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 61c6250adf93..c9756dbffe7d 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -499,6 +499,9 @@ void *uffd_poll_thread(void *arg)
 	int ret;
 	char tmp_chr;
 
+	if (!args->handle_fault)
+		args->handle_fault = uffd_handle_page_fault;
+
 	pollfd[0].fd = uffd;
 	pollfd[0].events = POLLIN;
 	pollfd[1].fd = pipefd[cpu*2];
@@ -527,7 +530,7 @@ void *uffd_poll_thread(void *arg)
 			err("unexpected msg event %u\n", msg.event);
 			break;
 		case UFFD_EVENT_PAGEFAULT:
-			uffd_handle_page_fault(&msg, args);
+			args->handle_fault(&msg, args);
 			break;
 		case UFFD_EVENT_FORK:
 			close(uffd);
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 6068f2346b86..b28d88b9937e 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -77,6 +77,9 @@ struct uffd_args {
 	unsigned long missing_faults;
 	unsigned long wp_faults;
 	unsigned long minor_faults;
+
+	/* A custom fault handler; defaults to uffd_handle_page_fault. */
+	void (*handle_fault)(struct uffd_msg *msg, struct uffd_args *args);
 };
 
 struct uffd_test_ops {
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index f1ad9eef1c3a..47e1464935a8 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -199,10 +199,8 @@ static int stress(struct uffd_args *args)
 				   locking_thread, (void *)cpu))
 			return 1;
 		if (bounces & BOUNCE_POLL) {
-			if (pthread_create(&uffd_threads[cpu], &attr,
-					   uffd_poll_thread,
-					   (void *)&args[cpu]))
-				return 1;
+			if (pthread_create(&uffd_threads[cpu], &attr, uffd_poll_thread, &args[cpu]))
+				err("uffd_poll_thread create");
 		} else {
 			if (pthread_create(&uffd_threads[cpu], &attr,
 					   uffd_read_thread,
-- 
2.40.1.606.ga4b1b128d6-goog

