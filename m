Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA7C6FF97A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 20:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbjEKSY6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 14:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238903AbjEKSYj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 14:24:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE304558D
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 11:24:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7e65b34aso16106013276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 11:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683829477; x=1686421477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pXR2gVK9OA+wwjaEDZ+OSGVT3sLd4z3OrzMBakd4aKc=;
        b=uljCWBeUfmKO+5Of2CDGdnripKh0c8Rzx0Uw+3mUJQMB0vkRyYLVzF+n17pnlhk/Gx
         5bJy3V1jOgdbwhD+IzTsmSPyo+npOvf5g9Bg01qvgjSMD6eTNJAt18pXpgDdOP/1R0pG
         f7W9dTJmQptgBrJNb6rZO42eQOqXUPeL3PmdMoDvsc0jIKFazxlaZQy6iFcTAKrcyb2g
         Vd4Xof1tpuhpdbe6fUAhZyOPuYJwlVtphMWQs8q/tSYp7h7umSFg6RazMw4joPD08IQq
         U+PE0b8W/rQAZMz7pnNUhXYfuSp6KyH2zv92pJQFwOvAqZixv97KJ+4OltRNsi03yCWr
         atQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683829477; x=1686421477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pXR2gVK9OA+wwjaEDZ+OSGVT3sLd4z3OrzMBakd4aKc=;
        b=RIrkmnruJNYZU5l3cjEFAmEe68XcvGpj4E6gHlCSFFBB0zaHyfnPTOwnob3S17uccR
         rz5f608ruQBvwWnXIhBnzl+e8HwWjgeRg0ID7MEcOKDMRiiqQFRoIg7E/q5M6t4z196K
         Pl34nmJ1RO8da2tHuCT+t64HKyVqJtOO8Mae7XJa4DDAoMN9dH/wlQCmTeJMajCF1VSB
         4zbPQFC90gZcZSCxGyOyP18JSEEQ9yzADkreiAeG0vUiRmKJy7lfwxlcogAHH5rz4eDm
         IWCequ7UoSNc+ld/IW3Y6V/KMEJCcJshSScxxYCYFEHxbcWfxOc9zXoRehx/jdnw6UHa
         +TOQ==
X-Gm-Message-State: AC+VfDxfc/sa2gbXXAxs+1hezb8SDnuL8XYhqWg+BqbSoiz1I2m10roG
        HebJsGiLA/nea0GOCvBU2cHii8hN3fLo0rrQ/T0o
X-Google-Smtp-Source: ACHHUZ6/k8WRFVr95FNBEjmhvpwsN42OkGFLi7clqHCCS0gOIKkyVoZZe1vIA3bGUQMYYdRD+oFyrl83UA1YRSgN8vJE
X-Received: from axel.svl.corp.google.com ([2620:15c:2d4:203:1119:8675:ddb3:1e7a])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:114e:b0:b4a:3896:bc17 with
 SMTP id p14-20020a056902114e00b00b4a3896bc17mr9915667ybu.0.1683829477159;
 Thu, 11 May 2023 11:24:37 -0700 (PDT)
Date:   Thu, 11 May 2023 11:24:26 -0700
In-Reply-To: <20230511182426.1898675-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230511182426.1898675-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230511182426.1898675-3-axelrasmussen@google.com>
Subject: [PATCH 3/3] selftests/mm: add uffd unit test for UFFDIO_SIGBUS
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

The test is pretty basic, and exercises UFFDIO_SIGBUS straightforwardly.
We register a region with userfaultfd, in missing fault mode. For each
fault, we either issue UFFDIO_ZEROPAGE (odd pages) or UFFDIO_SIGBUS
(even pages). We read each page in the region, and assert that the odd
pages are zeroed as expected, and the even pages yield a SIGBUS as
expected.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 114 ++++++++++++++++++-
 1 file changed, 110 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 269c86768a02..3eb5a6f9b51f 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -881,13 +881,13 @@ static void retry_uffdio_zeropage(int ufd,
 	}
 }
 
-static bool do_uffdio_zeropage(int ufd, bool has_zeropage)
+static bool do_uffdio_zeropage(int ufd, bool has_zeropage, bool test_retry, unsigned long offset)
 {
 	struct uffdio_zeropage uffdio_zeropage = { 0 };
 	int ret;
 	__s64 res;
 
-	uffdio_zeropage.range.start = (unsigned long) area_dst;
+	uffdio_zeropage.range.start = (unsigned long) area_dst + offset;
 	uffdio_zeropage.range.len = page_size;
 	uffdio_zeropage.mode = 0;
 	ret = ioctl(ufd, UFFDIO_ZEROPAGE, &uffdio_zeropage);
@@ -901,7 +901,7 @@ static bool do_uffdio_zeropage(int ufd, bool has_zeropage)
 	} else if (has_zeropage) {
 		if (res != page_size)
 			err("UFFDIO_ZEROPAGE unexpected size");
-		else
+		else if (test_retry)
 			retry_uffdio_zeropage(ufd, &uffdio_zeropage);
 		return true;
 	} else
@@ -938,7 +938,7 @@ static void uffd_zeropage_test(uffd_test_args_t *args)
 		/* Ignore the retval; we already have it */
 		uffd_register_detect_zeropage(uffd, area_dst_alias, page_size);
 
-	if (do_uffdio_zeropage(uffd, has_zeropage))
+	if (do_uffdio_zeropage(uffd, has_zeropage, true, 0))
 		for (i = 0; i < page_size; i++)
 			if (area_dst[i] != 0)
 				err("data non-zero at offset %d\n", i);
@@ -952,6 +952,106 @@ static void uffd_zeropage_test(uffd_test_args_t *args)
 	uffd_test_pass();
 }
 
+static void do_uffdio_sigbus(int uffd, unsigned long offset)
+{
+	struct uffdio_sigbus uffdio_sigbus = { 0 };
+	int ret;
+	__s64 res;
+
+	uffdio_sigbus.range.start = (unsigned long) area_dst + offset;
+	uffdio_sigbus.range.len = page_size;
+	uffdio_sigbus.mode = 0;
+	ret = ioctl(uffd, UFFDIO_SIGBUS, &uffdio_sigbus);
+	res = uffdio_sigbus.updated;
+
+	if (ret)
+		err("UFFDIO_SIGBUS error: %"PRId64, (int64_t)res);
+	else if (res != page_size)
+		err("UFFDIO_SIGBUS unexpected size: %"PRId64, (int64_t)res);
+}
+
+static void uffd_sigbus_ioctl_handle_fault(
+	struct uffd_msg *msg, struct uffd_args *args)
+{
+	unsigned long offset;
+
+	if (msg->event != UFFD_EVENT_PAGEFAULT)
+		err("unexpected msg event %u", msg->event);
+
+	if (msg->arg.pagefault.flags &
+	    (UFFD_PAGEFAULT_FLAG_WP | UFFD_PAGEFAULT_FLAG_MINOR))
+		err("unexpected fault type %llu", msg->arg.pagefault.flags);
+
+	offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
+	offset &= ~(page_size-1);
+
+	/* Odd pages -> zeropage; even pages -> sigbus. */
+	if (offset & page_size) {
+		if (!do_uffdio_zeropage(uffd, true, false, offset))
+			err("UFFDIO_ZEROPAGE failed");
+	} else {
+		do_uffdio_sigbus(uffd, offset);
+	}
+}
+
+static void uffd_sigbus_ioctl_test(uffd_test_args_t *targs)
+{
+	pthread_t uffd_mon;
+	char c;
+	struct uffd_args args = { 0 };
+	struct sigaction act = { 0 };
+	unsigned long nr_sigbus = 0;
+	unsigned long nr;
+
+	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
+
+	if (!uffd_register_detect_zeropage(uffd, area_dst, nr_pages * page_size))
+		err("register failed: no zeropage support");
+
+	args.handle_fault = uffd_sigbus_ioctl_handle_fault;
+	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
+		err("uffd_poll_thread create");
+
+	sigbuf = &jbuf;
+	act.sa_sigaction = sighndl;
+	act.sa_flags = SA_SIGINFO;
+	if (sigaction(SIGBUS, &act, 0))
+		err("sigaction");
+
+	for (nr = 0; nr < nr_pages; ++nr) {
+		unsigned long offset = nr * page_size;
+		const char *bytes = (const char *) area_dst + offset;
+		const char *i;
+
+		if (sigsetjmp(*sigbuf, 1)) {
+			/*
+			 * Access below triggered a SIGBUS, which was caught by
+			 * sighndl, which then jumped here. Count this SIGBUS,
+			 * and move on to next page.
+			 */
+			++nr_sigbus;
+			continue;
+		}
+
+		for (i = bytes; i < bytes + page_size; ++i) {
+			if (*i)
+				err("nonzero byte in area_dst (%p) at %p: %u",
+				    area_dst, i, *i);
+		}
+	}
+
+	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
+		err("pipe write");
+	if (pthread_join(uffd_mon, NULL))
+		err("pthread_join()");
+
+	if (nr_sigbus != nr_pages / 2)
+		err("expected to receive %lu SIGBUS, actually received %lu",
+		    nr_pages / 2, nr_sigbus);
+
+	uffd_test_pass();
+}
+
 /*
  * Test the returned uffdio_register.ioctls with different register modes.
  * Note that _UFFDIO_ZEROPAGE is tested separately in the zeropage test.
@@ -1127,6 +1227,12 @@ uffd_test_case_t uffd_tests[] = {
 		UFFD_FEATURE_PAGEFAULT_FLAG_WP |
 		UFFD_FEATURE_WP_HUGETLBFS_SHMEM,
 	},
+	{
+		.name = "sigbus-ioctl",
+		.uffd_fn = uffd_sigbus_ioctl_test,
+		.mem_targets = MEM_ALL & ~(MEM_HUGETLB | MEM_HUGETLB_PRIVATE),
+		.uffd_feature_required = UFFD_FEATURE_SIGBUS_IOCTL,
+	},
 };
 
 static void usage(const char *prog)
-- 
2.40.1.606.ga4b1b128d6-goog

