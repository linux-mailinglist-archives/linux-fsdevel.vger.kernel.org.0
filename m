Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE9C5A2122
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 08:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245168AbiHZGqW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 02:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245114AbiHZGqS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 02:46:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF607D21C4;
        Thu, 25 Aug 2022 23:46:06 -0700 (PDT)
Received: from lenovo.Home (unknown [39.53.61.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 74A016601EC5;
        Fri, 26 Aug 2022 07:46:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661496365;
        bh=4yvSwL7fk15687RDM21em8u33dCjiZyepG9X3yowxF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UJ731p7BYeJ6Kai5kB5cooRilHpcsGymeCDygp3UhG784Aj8+XlOuZ0ywcanrGW58
         KAAItzV1w0jVDmEJ4qkIdkAMLgLpdWgdzeU7z25o52qyr0YtTBXqj1j6Cu5HNqcXJL
         D9QOHuCaMGRFf/Flp8NDns2y2P5vl+ch+sAN4jl4RusqNKrYPYdChbByghxrdTJZ0y
         bjIZbUDV/oQoeWGfodRcx+8NyylssXy5ePh9XNoigZ+7mXeZQqZ7ktSjczCSvcRcdW
         Hwq55NzJn+3OOchn6wGxJ5jIan7t46QeVD8k4DrwBO9LyZYblSaxysW87cRoWYytiW
         O20FAxj2AzyMw==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        linux-fsdevel@vger.kernel.org (open list:PROC FILESYSTEM),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH v3 3/4] selftests: vm: add pagemap ioctl tests
Date:   Fri, 26 Aug 2022 11:45:34 +0500
Message-Id: <20220826064535.1941190-4-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220826064535.1941190-1-usama.anjum@collabora.com>
References: <20220826064535.1941190-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add pagemap ioctl tests. Add several different types of tests to judge
the correction of the interface.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
TAP version 13
1..44
ok 1 sanity_tests no cmd specified
ok 2 sanity_tests wrong flag specified
ok 3 sanity_tests reserved field specified specified
ok 4 sanity_tests wrong cmd specified
ok 5 sanity_tests mixture of correct and wrong cmds
ok 6 sanity_tests Clear area with larger vec size 1 22
ok 7 Page testing: all new pages must be soft dirty
ok 8 Page testing: all pages must not be soft dirty
ok 9 Page testing: all pages dirty other than first and the last one
ok 10 Page testing: only middle page dirty
ok 11 Page testing: only two middle pages dirty
ok 12 Page testing: only get 2 dirty pages and clear them as well
ok 13 Page testing: Range clear only
ok 14 Large Page testing: all new pages must be soft dirty
ok 15 Large Page testing: all pages must not be soft dirty
ok 16 Large Page testing: all pages dirty other than first and the last one
ok 17 Large Page testing: only middle page dirty
ok 18 Large Page testing: only two middle pages dirty
ok 19 Large Page testing: only get 2 dirty pages and clear them as well
ok 20 Large Page testing: Range clear only
ok 21 Huge page testing: all new pages must be soft dirty
ok 22 Huge page testing: all pages must not be soft dirty
ok 23 Huge page testing: all pages dirty other than first and the last one
ok 24 Huge page testing: only middle page dirty
ok 25 Huge page testing: only two middle pages dirty
ok 26 Huge page testing: only get 2 dirty pages and clear them as well
ok 27 Huge page testing: Range clear only
ok 28 Performance Page testing: page isn't dirty
ok 29 Performance Page testing: all pages must not be soft dirty
ok 30 Performance Page testing: all pages dirty other than first and the last one
ok 31 Performance Page testing: only middle page dirty
ok 32 Performance Page testing: only two middle pages dirty
ok 33 Performance Page testing: only get 2 dirty pages and clear them as well
ok 34 Performance Page testing: Range clear only
ok 35 hpage_unit_tests all new huge page must be dirty
ok 36 hpage_unit_tests all the huge page must not be dirty
ok 37 hpage_unit_tests all the huge page must be dirty and clear
ok 38 hpage_unit_tests only middle page dirty
ok 39 hpage_unit_tests clear first half of huge page
ok 40 hpage_unit_tests clear first half of huge page with limited buffer
ok 41 hpage_unit_tests clear second half huge page
ok 42 unmapped_region_tests Get dirty pages
ok 43 unmapped_region_tests Get dirty pages
ok 44 Test test_simple
 # Totals: pass:44 fail:0 xfail:0 xpass:0 skip:0 error:0

Changes in v3:
- Add another test to do sanity of flags

Changes in v2:
- Update the tests to use the ioctl interface instead of syscall
---
 tools/testing/selftests/vm/.gitignore      |   1 +
 tools/testing/selftests/vm/Makefile        |   2 +
 tools/testing/selftests/vm/pagemap_ioctl.c | 649 +++++++++++++++++++++
 3 files changed, 652 insertions(+)
 create mode 100644 tools/testing/selftests/vm/pagemap_ioctl.c

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index 31e5eea2a9b9..334fde556499 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -16,6 +16,7 @@ mremap_dontunmap
 mremap_test
 on-fault-limit
 transhuge-stress
+pagemap_ioctl
 protection_keys
 protection_keys_32
 protection_keys_64
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 266e965e724c..4296c3268f64 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -51,6 +51,7 @@ TEST_GEN_FILES += on-fault-limit
 TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += userfaultfd
+TEST_GEN_PROGS += pagemap_ioctl
 TEST_GEN_PROGS += soft-dirty
 TEST_GEN_PROGS += split_huge_page_test
 TEST_GEN_FILES += ksm_tests
@@ -98,6 +99,7 @@ TEST_FILES += va_128TBswitch.sh
 include ../lib.mk
 
 $(OUTPUT)/madv_populate: vm_util.c
+$(OUTPUT)/pagemap_ioctl: vm_util.c
 $(OUTPUT)/soft-dirty: vm_util.c
 $(OUTPUT)/split_huge_page_test: vm_util.c
 
diff --git a/tools/testing/selftests/vm/pagemap_ioctl.c b/tools/testing/selftests/vm/pagemap_ioctl.c
new file mode 100644
index 000000000000..7775247b9cdc
--- /dev/null
+++ b/tools/testing/selftests/vm/pagemap_ioctl.c
@@ -0,0 +1,649 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <errno.h>
+#include <malloc.h>
+#include <asm-generic/unistd.h>
+#include "vm_util.h"
+#include "../kselftest.h"
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <sys/ioctl.h>
+
+#define TEST_ITERATIONS 10000
+#define PAGEMAP "/proc/self/pagemap"
+int pagemap_fd;
+
+static long pagemap_ioctl(void *start, int len, unsigned int cmd, loff_t *vec,
+			  int vec_len, int flag)
+{
+	struct pagemap_sd_args arg;
+	int ret;
+
+	arg.start = (uintptr_t)start;
+	arg.len = len;
+	arg.vec = (uintptr_t)vec;
+	arg.vec_len = vec_len;
+	arg.flags = flag;
+	arg.__reserved = 0;
+
+	ret = ioctl(pagemap_fd, cmd, &arg);
+
+	return ret;
+}
+
+static long pagemap_ioctl_res(void *start, int len, unsigned int cmd, loff_t *vec,
+			      int vec_len, int flag, int res)
+{
+	struct pagemap_sd_args arg;
+	int ret;
+
+	arg.start = (uintptr_t)start;
+	arg.len = len;
+	arg.vec = (uintptr_t)vec;
+	arg.vec_len = vec_len;
+	arg.flags = flag;
+	arg.__reserved = res;
+
+	ret = ioctl(pagemap_fd, cmd, &arg);
+
+	return ret;
+}
+
+int sanity_tests(int page_size)
+{
+	char *mem;
+	int mem_size, vec_size, ret;
+	loff_t *vec;
+
+	/* 1. wrong operation */
+	vec_size = 100;
+	mem_size = page_size;
+
+	vec = malloc(sizeof(loff_t) * vec_size);
+	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (!mem || !vec)
+		ksft_exit_fail_msg("error nomem\n");
+
+	ksft_test_result(pagemap_ioctl(mem, mem_size, 0, vec, vec_size, 0) < 0,
+			 "%s no cmd specified\n", __func__);
+	ksft_test_result(pagemap_ioctl(mem, mem_size, PAGEMAP_SD_GET_AND_CLEAR, vec, vec_size, 8)
+			 < 0, "%s wrong flag specified\n", __func__);
+	ksft_test_result(pagemap_ioctl_res(mem, mem_size, PAGEMAP_SD_GET_AND_CLEAR, vec, vec_size, 8, 10)
+			 < 0, "%s reserved field specified specified\n", __func__);
+	ksft_test_result(pagemap_ioctl(mem, mem_size, 0x01000000, vec, vec_size, 0) < 0,
+			 "%s wrong cmd specified\n", __func__);
+	ksft_test_result(pagemap_ioctl(mem, mem_size, PAGEMAP_SD_GET | 0xFF,
+			 vec, vec_size, 0) < 0,
+			 "%s mixture of correct and wrong cmds\n", __func__);
+
+	/* 2. Clear area with larger vec size */
+	ret = pagemap_ioctl(mem, mem_size, PAGEMAP_SD_GET_AND_CLEAR,
+			    vec, vec_size, 0);
+	ksft_test_result(ret >= 0, "%s Clear area with larger vec size %d %d\n", __func__, ret, errno);
+
+	free(vec);
+	munmap(mem, mem_size);
+	return 0;
+}
+
+void *gethugepage(int map_size)
+{
+	int ret;
+	char *map;
+	size_t hpage_len = read_pmd_pagesize();
+
+	map = memalign(hpage_len, map_size);
+	if (!map)
+		ksft_exit_fail_msg("memalign failed %d %s\n", errno, strerror(errno));
+
+	ret = madvise(map, map_size, MADV_HUGEPAGE);
+	if (ret)
+		ksft_exit_fail_msg("madvise failed %d %d %s\n", ret, errno, strerror(errno));
+
+	memset(map, 0, map_size);
+
+	if (check_huge(map))
+		return map;
+
+	free(map);
+	return NULL;
+
+}
+
+int hpage_unit_tests(int page_size)
+{
+	char *map;
+	int i, ret;
+	size_t hpage_len = read_pmd_pagesize();
+	size_t num_pages = 1;
+	int map_size = hpage_len * num_pages;
+	int vec_size = map_size/page_size;
+	loff_t *vec, *vec2;
+
+	vec = malloc(sizeof(loff_t) * vec_size);
+	vec2 = malloc(sizeof(loff_t) * vec_size);
+	if (!vec || !vec2)
+		ksft_exit_fail_msg("malloc failed\n");
+
+	map = gethugepage(map_size);
+	if (map) {
+		// 1. all new huge page must be dirty
+		ret = pagemap_ioctl(map, map_size, PAGEMAP_SD_GET_AND_CLEAR, vec, vec_size, 0);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		for (i = 0; i < vec_size; i++)
+			if (vec[i] != i * page_size)
+				break;
+
+		ksft_test_result(i == vec_size, "%s all new huge page must be dirty\n", __func__);
+
+		// 2. all the huge page must not be dirty
+		ret = pagemap_ioctl(map, map_size, PAGEMAP_SD_GET, vec, vec_size, 0);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ksft_test_result(ret == 0, "%s all the huge page must not be dirty\n", __func__);
+
+		// 3. all the huge page must be dirty and clear dirty as well
+		memset(map, -1, map_size);
+		ret = pagemap_ioctl(map, map_size, PAGEMAP_SD_GET_AND_CLEAR, vec, vec_size, 0);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		for (i = 0; i < vec_size; i++)
+			if (vec[i] != i * page_size)
+				break;
+
+		ksft_test_result(ret == vec_size && i == vec_size,
+				 "%s all the huge page must be dirty and clear\n", __func__);
+
+		// 4. only middle page dirty
+		free(map);
+		map = gethugepage(map_size);
+		clear_softdirty();
+		map[vec_size/2 * page_size]++;
+
+		ret = pagemap_ioctl(map, map_size, PAGEMAP_SD_GET, vec, vec_size, 0);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		for (i = 0; i < vec_size; i++) {
+			if (vec[i] == vec_size/2 * page_size)
+				break;
+		}
+		ksft_test_result(vec[i] == vec_size/2 * page_size,
+				 "%s only middle page dirty\n", __func__);
+
+		free(map);
+	} else {
+		ksft_test_result_skip("all new huge page must be dirty\n");
+		ksft_test_result_skip("all the huge page must not be dirty\n");
+		ksft_test_result_skip("all the huge page must be dirty and clear\n");
+		ksft_test_result_skip("only middle page dirty\n");
+	}
+
+	// 5. clear first half of huge page
+	map = gethugepage(map_size);
+	if (map) {
+		ret = pagemap_ioctl(map, map_size/2, PAGEMAP_SD_CLEAR, NULL, 0, 0);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ret = pagemap_ioctl(map, map_size, PAGEMAP_SD_GET, vec, vec_size, 0);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		for (i = 0; i < vec_size/2; i++)
+			if (vec[i] != (i + vec_size/2) * page_size)
+				break;
+
+		ksft_test_result(i == vec_size/2 && ret == vec_size/2,
+				 "%s clear first half of huge page\n", __func__);
+		free(map);
+	} else {
+		ksft_test_result_skip("clear first half of huge page\n");
+	}
+
+	// 6. clear first half of huge page with limited buffer
+	map = gethugepage(map_size);
+	if (map) {
+		ret = pagemap_ioctl(map, map_size, PAGEMAP_SD_GET_AND_CLEAR, vec, vec_size/2, 0);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ret = pagemap_ioctl(map, map_size, PAGEMAP_SD_GET, vec, vec_size, 0);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		for (i = 0; i < vec_size/2; i++)
+			if (vec[i] != (i + vec_size/2) * page_size)
+				break;
+
+		ksft_test_result(i == vec_size/2 && ret == vec_size/2,
+				 "%s clear first half of huge page with limited buffer\n",
+				 __func__);
+		free(map);
+	} else {
+		ksft_test_result_skip("clear first half of huge page with limited buffer\n");
+	}
+
+	// 7. clear second half of huge page
+	map = gethugepage(map_size);
+	if (map) {
+		memset(map, -1, map_size);
+		ret = pagemap_ioctl(map + map_size/2, map_size/2, PAGEMAP_SD_CLEAR, NULL, 0, 0);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		ret = pagemap_ioctl(map, map_size, PAGEMAP_SD_GET, vec, vec_size, 0);
+		if (ret < 0)
+			ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+		for (i = 0; i < vec_size/2; i++)
+			if (vec[i] != i * page_size)
+				break;
+
+		ksft_test_result(i == vec_size/2, "%s clear second half huge page\n", __func__);
+		free(map);
+	} else {
+		ksft_test_result_skip("clear second half huge page\n");
+	}
+
+	free(vec);
+	free(vec2);
+	return 0;
+}
+
+int base_tests(char *prefix, char *mem, int mem_size, int page_size, int skip)
+{
+	int vec_size, i, j, ret, dirty_pages, dirty_pages2;
+	loff_t *vec, *vec2;
+
+	if (skip) {
+		ksft_test_result_skip("%s all new pages must be soft dirty\n", prefix);
+		ksft_test_result_skip("%s all pages must not be soft dirty\n", prefix);
+		ksft_test_result_skip("%s all pages dirty other than first and the last one\n",
+				      prefix);
+		ksft_test_result_skip("%s only middle page dirty\n", prefix);
+		ksft_test_result_skip("%s only two middle pages dirty\n", prefix);
+		ksft_test_result_skip("%s only get 2 dirty pages and clear them as well\n", prefix);
+		ksft_test_result_skip("%s Range clear only\n", prefix);
+		return 0;
+	}
+
+	vec_size = mem_size/page_size;
+	vec = malloc(sizeof(loff_t) * vec_size);
+	vec2 = malloc(sizeof(loff_t) * vec_size);
+
+	/* 1. all new pages must be soft dirty and clear the range for next test */
+	dirty_pages = pagemap_ioctl(mem, mem_size, PAGEMAP_SD_GET_AND_CLEAR, vec, vec_size - 2, 0);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	dirty_pages2 = pagemap_ioctl(mem, mem_size, PAGEMAP_SD_GET_AND_CLEAR, vec2, vec_size, 0);
+	if (dirty_pages2 < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages2, errno, strerror(errno));
+
+	for (i = 0; i < dirty_pages; i++)
+		if (vec[i] != i * page_size)
+			break;
+	for (j = 0; j < dirty_pages2; j++)
+		if (vec2[j] != (j + vec_size - 2) * page_size)
+			break;
+
+	ksft_test_result(dirty_pages == vec_size - 2 && i == dirty_pages &&
+			 dirty_pages2 == 2 && j == dirty_pages2,
+			 "%s all new pages must be soft dirty\n", prefix);
+
+	// 2. all pages must not be soft dirty
+	dirty_pages = pagemap_ioctl(mem, mem_size, PAGEMAP_SD_GET, vec, vec_size, 0);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	ksft_test_result(dirty_pages == 0, "%s all pages must not be soft dirty\n", prefix);
+
+	// 3. all pages dirty other than first and the last one
+	memset(mem + page_size, -1, (mem_size - (2 * page_size)));
+
+	dirty_pages = pagemap_ioctl(mem, mem_size, PAGEMAP_SD_GET, vec, vec_size, 0);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	ksft_test_result(dirty_pages >= vec_size - 2 && dirty_pages <= vec_size,
+			 "%s all pages dirty other than first and the last one\n", prefix);
+
+	// 4. only middle page dirty
+	clear_softdirty();
+	mem[vec_size/2 * page_size]++;
+
+	dirty_pages = pagemap_ioctl(mem, mem_size, PAGEMAP_SD_GET, vec, vec_size, 0);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	for (i = 0; i < vec_size; i++) {
+		if (vec[i] == vec_size/2 * page_size)
+			break;
+	}
+	ksft_test_result(vec[i] == vec_size/2 * page_size,
+			 "%s only middle page dirty\n", prefix);
+
+	// 5. only two middle pages dirty and walk over only middle pages
+	clear_softdirty();
+	mem[vec_size/2 * page_size]++;
+	mem[(vec_size/2 + 1) * page_size]++;
+
+	dirty_pages = pagemap_ioctl(&mem[vec_size/2 * page_size], 2 * page_size,
+				    PAGEMAP_SD_GET, vec, vec_size, 0);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	ksft_test_result(dirty_pages == 2 && vec[0] == 0 && vec[1] == page_size,
+			 "%s only two middle pages dirty\n", prefix);
+
+	/* 6. only get 2 dirty pages and clear them as well */
+	memset(mem, -1, mem_size);
+
+	/* get and clear second and third pages */
+	ret = pagemap_ioctl(mem + page_size, 2 * page_size, PAGEMAP_SD_GET_AND_CLEAR, vec, 2, 0);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	dirty_pages = pagemap_ioctl(mem, mem_size, PAGEMAP_SD_GET, vec2, vec_size, 0);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	for (i = 0; i < vec_size - 2; i++) {
+		if (i == 0 && (vec[i] != 0 || vec2[i] != 0))
+			break;
+		else if (i == 1 && (vec[i] != page_size || vec2[i] != (i + 2) * page_size))
+			break;
+		else if (i > 1 && (vec2[i] != (i + 2) * page_size))
+			break;
+	}
+
+	ksft_test_result(dirty_pages == vec_size - 2 && i == vec_size - 2,
+			 "%s only get 2 dirty pages and clear them as well\n", prefix);
+	/* 7. Range clear only */
+	memset(mem, -1, mem_size);
+	dirty_pages = pagemap_ioctl(mem, mem_size, PAGEMAP_SD_CLEAR, NULL, 0, 0);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	dirty_pages2 = pagemap_ioctl(mem, mem_size, PAGEMAP_SD_GET, vec, vec_size, 0);
+	if (dirty_pages2 < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages2, errno, strerror(errno));
+
+	ksft_test_result(dirty_pages == 0 && dirty_pages2 == 0, "%s Range clear only\n",
+			 prefix);
+
+	free(vec);
+	free(vec2);
+	return 0;
+}
+
+int performance_base_tests(char *prefix, char *mem, int mem_size, int page_size, int skip)
+{
+	int vec_size, i, ret, dirty_pages, dirty_pages2;
+	loff_t *vec, *vec2;
+
+	if (skip) {
+		ksft_test_result_skip("%s all new pages must be soft dirty\n", prefix);
+		ksft_test_result_skip("%s all pages must not be soft dirty\n", prefix);
+		ksft_test_result_skip("%s all pages dirty other than first and the last one\n",
+				      prefix);
+		ksft_test_result_skip("%s only middle page dirty\n", prefix);
+		ksft_test_result_skip("%s only two middle pages dirty\n", prefix);
+		ksft_test_result_skip("%s only get 2 dirty pages and clear them as well\n", prefix);
+		ksft_test_result_skip("%s Range clear only\n", prefix);
+		return 0;
+	}
+
+	vec_size = mem_size/page_size;
+	vec = malloc(sizeof(loff_t) * vec_size);
+	vec2 = malloc(sizeof(loff_t) * vec_size);
+
+	/* 1. all new pages must be soft dirty and clear the range for next test */
+	dirty_pages = pagemap_ioctl(mem, mem_size, PAGEMAP_SD_GET_AND_CLEAR,
+				    vec, vec_size - 2, PAGEMAP_SD_NO_REUSED_REGIONS);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	dirty_pages2 = pagemap_ioctl(mem, mem_size, PAGEMAP_SD_GET_AND_CLEAR,
+				     vec2, vec_size, PAGEMAP_SD_NO_REUSED_REGIONS);
+	if (dirty_pages2 < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages2, errno, strerror(errno));
+
+	ksft_test_result(dirty_pages == 0 && dirty_pages2 == 0,
+			 "%s page isn't dirty\n", prefix);
+
+	// 2. all pages must not be soft dirty
+	dirty_pages = pagemap_ioctl(mem, mem_size, PAGEMAP_SD_GET,
+				    vec, vec_size, PAGEMAP_SD_NO_REUSED_REGIONS);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	ksft_test_result(dirty_pages == 0, "%s all pages must not be soft dirty\n", prefix);
+
+	// 3. all pages dirty other than first and the last one
+	memset(mem + page_size, -1, (mem_size - 2 * page_size));
+
+	dirty_pages = pagemap_ioctl(mem, mem_size, PAGEMAP_SD_GET,
+				    vec, vec_size, PAGEMAP_SD_NO_REUSED_REGIONS);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	for (i = 0; i < dirty_pages; i++) {
+		if (vec[i] != (i + 1) * page_size)
+			break;
+	}
+
+	ksft_test_result(dirty_pages == vec_size - 2 && i == vec_size - 2,
+			 "%s all pages dirty other than first and the last one\n", prefix);
+
+	// 4. only middle page dirty
+	clear_softdirty();
+	mem[vec_size/2 * page_size]++;
+
+	dirty_pages = pagemap_ioctl(mem, mem_size, PAGEMAP_SD_GET,
+				    vec, vec_size, PAGEMAP_SD_NO_REUSED_REGIONS);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	for (i = 0; i < vec_size; i++) {
+		if (vec[i] == vec_size/2 * page_size)
+			break;
+	}
+	ksft_test_result(vec[i] == vec_size/2 * page_size,
+			 "%s only middle page dirty\n", prefix);
+
+	// 5. only two middle pages dirty and walk over only middle pages
+	clear_softdirty();
+	mem[vec_size/2 * page_size]++;
+	mem[(vec_size/2 + 1) * page_size]++;
+
+	dirty_pages = pagemap_ioctl(&mem[vec_size/2 * page_size], 2 * page_size,
+				    PAGEMAP_SD_GET, vec, vec_size, PAGEMAP_SD_NO_REUSED_REGIONS);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	ksft_test_result(dirty_pages == 2 && vec[0] == 0 && vec[1] == page_size,
+			 "%s only two middle pages dirty\n", prefix);
+
+	/* 6. only get 2 dirty pages and clear them as well */
+	memset(mem, -1, mem_size);
+
+	/* get and clear second and third pages */
+	ret = pagemap_ioctl(mem + page_size, 2 * page_size, PAGEMAP_SD_GET_AND_CLEAR,
+			    vec, 2, PAGEMAP_SD_NO_REUSED_REGIONS);
+	if (ret < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
+
+	dirty_pages = pagemap_ioctl(mem, mem_size, PAGEMAP_SD_GET,
+				    vec2, vec_size, PAGEMAP_SD_NO_REUSED_REGIONS);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	for (i = 0; i < vec_size - 2; i++) {
+		if (i == 0 && (vec[i] != 0 || vec2[i] != 0))
+			break;
+		else if (i == 1 && (vec[i] != page_size || vec2[i] != (i + 2) * page_size))
+			break;
+		else if (i > 1 && (vec2[i] != (i + 2) * page_size))
+			break;
+	}
+
+	ksft_test_result(dirty_pages == vec_size - 2 && i == vec_size - 2,
+			 "%s only get 2 dirty pages and clear them as well\n", prefix);
+
+	/* 7. Range clear only */
+	memset(mem, -1, mem_size);
+	dirty_pages = pagemap_ioctl(mem, mem_size, PAGEMAP_SD_CLEAR,
+				    NULL, 0, PAGEMAP_SD_NO_REUSED_REGIONS);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	dirty_pages2 = pagemap_ioctl(mem, mem_size, PAGEMAP_SD_GET,
+				     vec, vec_size, PAGEMAP_SD_NO_REUSED_REGIONS);
+	if (dirty_pages2 < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages2, errno, strerror(errno));
+
+	ksft_test_result(dirty_pages == 0 && dirty_pages2 == 0, "%s Range clear only\n",
+			 prefix);
+
+	free(vec);
+	free(vec2);
+	return 0;
+}
+
+int unmapped_region_tests(int page_size)
+{
+	void *start = (void *)0x10000000;
+	int dirty_pages, len = 0x00040000;
+	int vec_size = len / page_size;
+	loff_t *vec = malloc(sizeof(loff_t) * vec_size);
+
+	/* 1. Get dirty pages */
+	dirty_pages = pagemap_ioctl(start, len, PAGEMAP_SD_GET, vec, vec_size, 0);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	ksft_test_result(dirty_pages >= 0, "%s Get dirty pages\n", __func__);
+
+	/* 2. Clear dirty bit of whole address space */
+	dirty_pages = pagemap_ioctl(0, 0x7FFFFFFF, PAGEMAP_SD_CLEAR, NULL, 0, 0);
+	if (dirty_pages < 0)
+		ksft_exit_fail_msg("error %d %d %s\n", dirty_pages, errno, strerror(errno));
+
+	ksft_test_result(dirty_pages == 0, "%s Get dirty pages\n", __func__);
+
+	free(vec);
+	return 0;
+}
+
+static void test_simple(int page_size)
+{
+	int i;
+	char *map;
+	loff_t *vec = NULL;
+
+	map = aligned_alloc(page_size, page_size);
+	if (!map)
+		ksft_exit_fail_msg("mmap failed\n");
+
+	clear_softdirty();
+
+	for (i = 0 ; i < TEST_ITERATIONS; i++) {
+		if (pagemap_ioctl(map, page_size, PAGEMAP_SD_GET, vec, 1, 0) == 1) {
+			ksft_print_msg("dirty bit was 1, but should be 0 (i=%d)\n", i);
+			break;
+		}
+
+		clear_softdirty();
+		// Write something to the page to get the dirty bit enabled on the page
+		map[0]++;
+
+		if (pagemap_ioctl(map, page_size, PAGEMAP_SD_GET, vec, 1, 0) == 0) {
+			ksft_print_msg("dirty bit was 0, but should be 1 (i=%d)\n", i);
+			break;
+		}
+
+		clear_softdirty();
+	}
+	free(map);
+
+	ksft_test_result(i == TEST_ITERATIONS, "Test %s\n", __func__);
+}
+
+int main(int argc, char **argv)
+{
+	int page_size = getpagesize();
+	size_t hpage_len = read_pmd_pagesize();
+	char *mem, *map;
+	int mem_size;
+
+	ksft_print_header();
+	ksft_set_plan(44);
+
+	pagemap_fd = open(PAGEMAP, O_RDWR);
+	if (pagemap_fd < 0)
+		return -EINVAL;
+
+	/* 1. Sanity testing */
+	sanity_tests(page_size);
+
+	/* 2. Normal page testing */
+	mem_size = 10 * page_size;
+	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (!mem)
+		ksft_exit_fail_msg("error nomem\n");
+
+	base_tests("Page testing:", mem, mem_size, page_size, 0);
+
+	munmap(mem, mem_size);
+
+	/* 3. Large page testing */
+	mem_size = 512 * 10 * page_size;
+	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (!mem)
+		ksft_exit_fail_msg("error nomem\n");
+
+	base_tests("Large Page testing:", mem, mem_size, page_size, 0);
+
+	munmap(mem, mem_size);
+
+	/* 4. Huge page testing */
+	map = gethugepage(hpage_len);
+	if (check_huge(map))
+		base_tests("Huge page testing:", map, hpage_len, page_size, 0);
+	else
+		base_tests("Huge page testing:", NULL, 0, 0, 1);
+
+	free(map);
+
+	/* 5. Normal page testing */
+	mem_size = 10 * page_size;
+	mem = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (!mem)
+		ksft_exit_fail_msg("error nomem\n");
+
+	performance_base_tests("Performance Page testing:", mem, mem_size, page_size, 0);
+
+	munmap(mem, mem_size);
+
+	/* 6. Huge page tests */
+	hpage_unit_tests(page_size);
+
+	/* 7. Unmapped address test */
+	unmapped_region_tests(page_size);
+
+	/* 8. Iterative test */
+	test_simple(page_size);
+
+	close(pagemap_fd);
+	return ksft_exit_pass();
+}
-- 
2.30.2

