Return-Path: <linux-fsdevel+bounces-1465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D177DA469
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 02:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD6E1F23B75
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 00:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE4763A4;
	Sat, 28 Oct 2023 00:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wRnrNLho"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15054C6E
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 00:38:33 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220D41BC
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 17:38:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7cc433782so23568187b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 17:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698453509; x=1699058309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BD9lPzNt8hnQJcZ/hWgSWD/y67yszl3sQZlzVb4etk8=;
        b=wRnrNLhowwwCtiquCs34cdBqrU1JXb5Ss+N2lIWxytefgi1RqBRzji+yXiCNmuI6a2
         jC2tjMfyEAVDInZJ0z0offntxZQWshtRnBLUP0WEfWYzyU+Vyu3Qv+ti8qe7KJiHjq2k
         xrWllxJVKdSZFtgbjOZVMnOzaUBGihOSiVSko2XHXipn1Fgqm/7MujSztMZvQW49CloW
         nbWtbW+YF1p97INXPGE3MOTKqmpTUXePC+s1NqWDXwB6HU7DYrZ2n7/qAaLDAsm+FmSv
         sTuKZq+cviYleiA5Gz9RQ7qdALxXER1w2BnldWayez+CiYdXc14Odd0dGwAYxekX4xv7
         c2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698453509; x=1699058309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BD9lPzNt8hnQJcZ/hWgSWD/y67yszl3sQZlzVb4etk8=;
        b=cPF82sDPgj3otmzAOTb3fxDwJbjgI2Yi2rh7uqyPTTWKlYumFmu9Q6S214+bYnxuJv
         pbnUVi/nsNMLzJ23DQNRbL6kdXDSBq/IZYw5hMWsqXa0e7hYIK8xJjxXrJlqiTxXZRKO
         o7buC4BMLObhLYNJs3JOkHpE7ktVnPL5ReVQgwds2NvBUqG0asyDIuxj+h10PWh6j5ME
         laAZIQ+VR4ZPsPx3i07cJihu2wc5h7Ysw3w1F6n8DHSno0Jsg7i7JBAJ5sLtLJuzV4MO
         8oWuXS5u9VHVqzAa6mF4cUzQfO1OPk5e1Jzggj87a7vNeyvjIUPjj9QfdLU3HPdfMt6T
         luqQ==
X-Gm-Message-State: AOJu0Ywob2QS36nJrQfPKx/3NDTDrsh6vv/pSqDzIYV6UExeqspNNW3F
	c7SnZkf+8PxQHIsAZjdLbFCHlk3/ZCk=
X-Google-Smtp-Source: AGHT+IGmeKeXQi4pWbtj4gTgBBjJn+MEaX3ROLUS7uMooi9MoHIQXOo8pDwybtu05kFAWMGKkvzAZguj9E0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:cba3:7e7f:79e4:fa57])
 (user=surenb job=sendgmr) by 2002:a0d:db97:0:b0:5a7:b15a:1a7d with SMTP id
 d145-20020a0ddb97000000b005a7b15a1a7dmr86233ywe.2.1698453509335; Fri, 27 Oct
 2023 17:38:29 -0700 (PDT)
Date: Fri, 27 Oct 2023 17:38:13 -0700
In-Reply-To: <20231028003819.652322-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231028003819.652322-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231028003819.652322-4-surenb@google.com>
Subject: [PATCH v4 3/5] selftests/mm: call uffd_test_ctx_clear at the end of
 the test
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org, 
	aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com, 
	david@redhat.com, hughd@google.com, mhocko@suse.com, axelrasmussen@google.com, 
	rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com, 
	jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com, 
	kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com, 
	surenb@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

uffd_test_ctx_clear() is being called from uffd_test_ctx_init() to unmap
areas used in the previous test run. This approach is problematic because
while unmapping areas uffd_test_ctx_clear() uses page_size and nr_pages
which might differ from one test run to another.
Fix this by calling uffd_test_ctx_clear() after each test is done.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/mm/uffd-common.c     | 4 +---
 tools/testing/selftests/mm/uffd-common.h     | 1 +
 tools/testing/selftests/mm/uffd-stress.c     | 5 ++++-
 tools/testing/selftests/mm/uffd-unit-tests.c | 1 +
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 02b89860e193..583e5a4cc0fd 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -262,7 +262,7 @@ static inline void munmap_area(void **area)
 	*area = NULL;
 }
 
-static void uffd_test_ctx_clear(void)
+void uffd_test_ctx_clear(void)
 {
 	size_t i;
 
@@ -298,8 +298,6 @@ int uffd_test_ctx_init(uint64_t features, const char **errmsg)
 	unsigned long nr, cpu;
 	int ret;
 
-	uffd_test_ctx_clear();
-
 	ret = uffd_test_ops->allocate_area((void **)&area_src, true);
 	ret |= uffd_test_ops->allocate_area((void **)&area_dst, false);
 	if (ret) {
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 7c4fa964c3b0..870776b5a323 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -105,6 +105,7 @@ extern uffd_test_ops_t *uffd_test_ops;
 
 void uffd_stats_report(struct uffd_args *args, int n_cpus);
 int uffd_test_ctx_init(uint64_t features, const char **errmsg);
+void uffd_test_ctx_clear(void);
 int userfaultfd_open(uint64_t *features);
 int uffd_read_msg(int ufd, struct uffd_msg *msg);
 void wp_range(int ufd, __u64 start, __u64 len, bool wp);
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 469e0476af26..7e83829bbb33 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -323,8 +323,10 @@ static int userfaultfd_stress(void)
 		uffd_stats_reset(args, nr_cpus);
 
 		/* bounce pass */
-		if (stress(args))
+		if (stress(args)) {
+			uffd_test_ctx_clear();
 			return 1;
+		}
 
 		/* Clear all the write protections if there is any */
 		if (test_uffdio_wp)
@@ -354,6 +356,7 @@ static int userfaultfd_stress(void)
 
 		uffd_stats_report(args, nr_cpus);
 	}
+	uffd_test_ctx_clear();
 
 	return 0;
 }
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 2709a34a39c5..e7d43c198041 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -1319,6 +1319,7 @@ int main(int argc, char *argv[])
 				continue;
 			}
 			test->uffd_fn(&args);
+			uffd_test_ctx_clear();
 		}
 	}
 
-- 
2.42.0.820.g83a721a137-goog


