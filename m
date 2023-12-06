Return-Path: <linux-fsdevel+bounces-4985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A14D5806FEB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 13:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CFD61F213D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 12:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A185A36AE8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 12:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J3zB7Ifa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19A410EA
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 02:37:17 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db584b8fb9cso5977225276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 02:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701859037; x=1702463837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iVIa5cg328sO4f63WvwXvkSZbx/mUmzDkh+gAL5+Ahc=;
        b=J3zB7IfaNdCJnb/481Bb+YzU5Ah6AMBuAJidOqRQU9cgrF1R4FaR8tCPnCnIBtVdQE
         IperrvS0vn5GxHC/qu0wNV2RFYis5gEx3Do6+ZOnAratB1lR6bLxREjKUU1bMXre6c1x
         M6Z/DnIL7NPRg+c2g0wdFT5LGzKFmI8Mw03xEZJE9BZgd9FPPdQSiBOPCF/HY3TwF9xk
         yPAqabrheVyubUf258wNB/NABUqcBxxNtDrauN/2deBRu5HSTJPaH7Pj2cmYdKHsBtR3
         6Nm8HDys4X5KhLfOAx1+B0jIwjOHy+FwMQBsECaCPXAe5JZKehLOFi7iy8/MTsPaQeqj
         FnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701859037; x=1702463837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVIa5cg328sO4f63WvwXvkSZbx/mUmzDkh+gAL5+Ahc=;
        b=C8GwWgWBkNxhoiLWMXPl4yB/if/Wm+4jmKueRcov66O5LOLi4LvAI/X7GAOECU2s4j
         LM20j5m+qAJ39/OB5ZwzV8jk35EgfF2Fh8yNNyS8B5xLxq+6Cbi59XA3uQwR11BRIQBX
         fb9k4OiqrhUNMWaLZK/HIT1Uz6qym+KEMMt5lgVdWvFMCLU9qCXI9+YLOTOwl/ew75oR
         KnfCVKDh7l0RhylE9BN79IExdIkH3oKJeQL6n7QLJwyMXtAirUtcQOG/WhFffCCE6/wy
         eSsWxGVcfhUsgKv1mrf3GgYvv+5sxWr2S+Kft1GupYfXds9zBj1HO1XLX5AiNQhfjvN3
         llow==
X-Gm-Message-State: AOJu0YzhBVKPd6S4otWuaaXa+o7KLazmvxY8M/mwp2ClZOsQSiIJB89O
	WmuzHPOCq570wIoc5cB4A9mwnPRz18s=
X-Google-Smtp-Source: AGHT+IGkgKbxoygTMvEFVetsgh/4I8+posq2zTqpEUJ0xsC7qcK0racQMhZFneM9yrLm1+Uko2/h58wIowE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:73f6:b5e2:415:6ba5])
 (user=surenb job=sendgmr) by 2002:a25:e097:0:b0:db3:fa34:50b0 with SMTP id
 x145-20020a25e097000000b00db3fa3450b0mr4837ybg.4.1701859036922; Wed, 06 Dec
 2023 02:37:16 -0800 (PST)
Date: Wed,  6 Dec 2023 02:36:59 -0800
In-Reply-To: <20231206103702.3873743-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231206103702.3873743-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231206103702.3873743-6-surenb@google.com>
Subject: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org, 
	aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com, 
	david@redhat.com, ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com, 
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org, 
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com, 
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com, 
	jdduke@google.com, surenb@google.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Add tests for new UFFDIO_MOVE ioctl which uses uffd to move source
into destination buffer while checking the contents of both after
the move. After the operation the content of the destination buffer
should match the original source buffer's content while the source
buffer should be zeroed. Separate tests are designed for PMD aligned and
unaligned cases because they utilize different code paths in the kernel.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/mm/uffd-common.c     |  24 +++
 tools/testing/selftests/mm/uffd-common.h     |   1 +
 tools/testing/selftests/mm/uffd-unit-tests.c | 189 +++++++++++++++++++
 3 files changed, 214 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index fb3bbc77fd00..b0ac0ec2356d 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -631,6 +631,30 @@ int copy_page(int ufd, unsigned long offset, bool wp)
 	return __copy_page(ufd, offset, false, wp);
 }
 
+int move_page(int ufd, unsigned long offset, unsigned long len)
+{
+	struct uffdio_move uffdio_move;
+
+	if (offset + len > nr_pages * page_size)
+		err("unexpected offset %lu and length %lu\n", offset, len);
+	uffdio_move.dst = (unsigned long) area_dst + offset;
+	uffdio_move.src = (unsigned long) area_src + offset;
+	uffdio_move.len = len;
+	uffdio_move.mode = UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
+	uffdio_move.move = 0;
+	if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
+		/* real retval in uffdio_move.move */
+		if (uffdio_move.move != -EEXIST)
+			err("UFFDIO_MOVE error: %"PRId64,
+			    (int64_t)uffdio_move.move);
+		wake_range(ufd, uffdio_move.dst, len);
+	} else if (uffdio_move.move != len) {
+		err("UFFDIO_MOVE error: %"PRId64, (int64_t)uffdio_move.move);
+	} else
+		return 1;
+	return 0;
+}
+
 int uffd_open_dev(unsigned int flags)
 {
 	int fd, uffd;
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 774595ee629e..cb055282c89c 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -119,6 +119,7 @@ void wp_range(int ufd, __u64 start, __u64 len, bool wp);
 void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args);
 int __copy_page(int ufd, unsigned long offset, bool retry, bool wp);
 int copy_page(int ufd, unsigned long offset, bool wp);
+int move_page(int ufd, unsigned long offset, unsigned long len);
 void *uffd_poll_thread(void *arg);
 
 int uffd_open_dev(unsigned int flags);
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index debc423bdbf4..d8091523c2df 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -23,6 +23,9 @@
 #define  MEM_ALL  (MEM_ANON | MEM_SHMEM | MEM_SHMEM_PRIVATE | \
 		   MEM_HUGETLB | MEM_HUGETLB_PRIVATE)
 
+#define ALIGN_UP(x, align_to) \
+	((__typeof__(x))((((unsigned long)(x)) + ((align_to)-1)) & ~((align_to)-1)))
+
 struct mem_type {
 	const char *name;
 	unsigned int mem_flag;
@@ -1064,6 +1067,178 @@ static void uffd_poison_test(uffd_test_args_t *targs)
 	uffd_test_pass();
 }
 
+static void
+uffd_move_handle_fault_common(struct uffd_msg *msg, struct uffd_args *args,
+			      unsigned long len)
+{
+	unsigned long offset;
+
+	if (msg->event != UFFD_EVENT_PAGEFAULT)
+		err("unexpected msg event %u", msg->event);
+
+	if (msg->arg.pagefault.flags &
+	    (UFFD_PAGEFAULT_FLAG_WP | UFFD_PAGEFAULT_FLAG_MINOR | UFFD_PAGEFAULT_FLAG_WRITE))
+		err("unexpected fault type %llu", msg->arg.pagefault.flags);
+
+	offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
+	offset &= ~(len-1);
+
+	if (move_page(uffd, offset, len))
+		args->missing_faults++;
+}
+
+static void uffd_move_handle_fault(struct uffd_msg *msg,
+				   struct uffd_args *args)
+{
+	uffd_move_handle_fault_common(msg, args, page_size);
+}
+
+static void uffd_move_pmd_handle_fault(struct uffd_msg *msg,
+				       struct uffd_args *args)
+{
+	uffd_move_handle_fault_common(msg, args, read_pmd_pagesize());
+}
+
+static void
+uffd_move_test_common(uffd_test_args_t *targs, unsigned long chunk_size,
+		      void (*handle_fault)(struct uffd_msg *msg, struct uffd_args *args))
+{
+	unsigned long nr;
+	pthread_t uffd_mon;
+	char c;
+	unsigned long long count;
+	struct uffd_args args = { 0 };
+	char *orig_area_src, *orig_area_dst;
+	unsigned long step_size, step_count;
+	unsigned long src_offs = 0;
+	unsigned long dst_offs = 0;
+
+	/* Prevent source pages from being mapped more than once */
+	if (madvise(area_src, nr_pages * page_size, MADV_DONTFORK))
+		err("madvise(MADV_DONTFORK) failure");
+
+	if (uffd_register(uffd, area_dst, nr_pages * page_size,
+			  true, false, false))
+		err("register failure");
+
+	args.handle_fault = handle_fault;
+	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
+		err("uffd_poll_thread create");
+
+	step_size = chunk_size / page_size;
+	step_count = nr_pages / step_size;
+
+	if (chunk_size > page_size) {
+		char *aligned_src = ALIGN_UP(area_src, chunk_size);
+		char *aligned_dst = ALIGN_UP(area_dst, chunk_size);
+
+		if (aligned_src != area_src || aligned_dst != area_dst) {
+			src_offs = (aligned_src - area_src) / page_size;
+			dst_offs = (aligned_dst - area_dst) / page_size;
+			step_count--;
+		}
+		orig_area_src = area_src;
+		orig_area_dst = area_dst;
+		area_src = aligned_src;
+		area_dst = aligned_dst;
+	}
+
+	/*
+	 * Read each of the pages back using the UFFD-registered mapping. We
+	 * expect that the first time we touch a page, it will result in a missing
+	 * fault. uffd_poll_thread will resolve the fault by moving source
+	 * page to destination.
+	 */
+	for (nr = 0; nr < step_count * step_size; nr += step_size) {
+		unsigned long i;
+
+		/* Check area_src content */
+		for (i = 0; i < step_size; i++) {
+			count = *area_count(area_src, nr + i);
+			if (count != count_verify[src_offs + nr + i])
+				err("nr %lu source memory invalid %llu %llu\n",
+				    nr + i, count, count_verify[src_offs + nr + i]);
+		}
+
+		/* Faulting into area_dst should move the page or the huge page */
+		for (i = 0; i < step_size; i++) {
+			count = *area_count(area_dst, nr + i);
+			if (count != count_verify[dst_offs + nr + i])
+				err("nr %lu memory corruption %llu %llu\n",
+				    nr, count, count_verify[dst_offs + nr + i]);
+		}
+
+		/* Re-check area_src content which should be empty */
+		for (i = 0; i < step_size; i++) {
+			count = *area_count(area_src, nr + i);
+			if (count != 0)
+				err("nr %lu move failed %llu %llu\n",
+				    nr, count, count_verify[src_offs + nr + i]);
+		}
+	}
+	if (step_size > page_size) {
+		area_src = orig_area_src;
+		area_dst = orig_area_dst;
+	}
+
+	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
+		err("pipe write");
+	if (pthread_join(uffd_mon, NULL))
+		err("join() failed");
+
+	if (args.missing_faults != step_count || args.minor_faults != 0)
+		uffd_test_fail("stats check error");
+	else
+		uffd_test_pass();
+}
+
+static void uffd_move_test(uffd_test_args_t *targs)
+{
+	uffd_move_test_common(targs, page_size, uffd_move_handle_fault);
+}
+
+static void uffd_move_pmd_test(uffd_test_args_t *targs)
+{
+	uffd_move_test_common(targs, read_pmd_pagesize(),
+			      uffd_move_pmd_handle_fault);
+}
+
+static int prevent_hugepages(const char **errmsg)
+{
+	/* This should be done before source area is populated */
+	if (madvise(area_src, nr_pages * page_size, MADV_NOHUGEPAGE)) {
+		/* Ignore only if CONFIG_TRANSPARENT_HUGEPAGE=n */
+		if (errno != EINVAL) {
+			if (errmsg)
+				*errmsg = "madvise(MADV_NOHUGEPAGE) failed";
+			return -errno;
+		}
+	}
+	return 0;
+}
+
+static int request_hugepages(const char **errmsg)
+{
+	/* This should be done before source area is populated */
+	if (madvise(area_src, nr_pages * page_size, MADV_HUGEPAGE)) {
+		if (errmsg) {
+			*errmsg = (errno == EINVAL) ?
+				"CONFIG_TRANSPARENT_HUGEPAGE is not set" :
+				"madvise(MADV_HUGEPAGE) failed";
+		}
+		return -errno;
+	}
+	return 0;
+}
+
+struct uffd_test_case_ops uffd_move_test_case_ops = {
+	.post_alloc = prevent_hugepages,
+};
+
+struct uffd_test_case_ops uffd_move_test_pmd_case_ops = {
+	.post_alloc = request_hugepages,
+};
+
 /*
  * Test the returned uffdio_register.ioctls with different register modes.
  * Note that _UFFDIO_ZEROPAGE is tested separately in the zeropage test.
@@ -1141,6 +1316,20 @@ uffd_test_case_t uffd_tests[] = {
 		.mem_targets = MEM_ALL,
 		.uffd_feature_required = 0,
 	},
+	{
+		.name = "move",
+		.uffd_fn = uffd_move_test,
+		.mem_targets = MEM_ANON,
+		.uffd_feature_required = UFFD_FEATURE_MOVE,
+		.test_case_ops = &uffd_move_test_case_ops,
+	},
+	{
+		.name = "move-pmd",
+		.uffd_fn = uffd_move_pmd_test,
+		.mem_targets = MEM_ANON,
+		.uffd_feature_required = UFFD_FEATURE_MOVE,
+		.test_case_ops = &uffd_move_test_pmd_case_ops,
+	},
 	{
 		.name = "wp-fork",
 		.uffd_fn = uffd_wp_fork_test,
-- 
2.43.0.rc2.451.g8631bc7472-goog


