Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E38658174A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 18:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239428AbiGZQVt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 12:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239403AbiGZQVl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:21:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B4D27171;
        Tue, 26 Jul 2022 09:21:40 -0700 (PDT)
Received: from localhost.localdomain (unknown [203.135.47.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7894D6601B1C;
        Tue, 26 Jul 2022 17:21:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658852499;
        bh=TmWomaer23vw+1UBA3al27F9ID8ZyZsnkETWciuw1wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JYxDiXjFw2RkNWx91Wt51o8qc6YV+mR0wWrLTDbpoFMfe3Sm/04uV2+UuB+HZoPki
         0LpF4pUQRsSnI+7DxtjBwuPAeLwCQ/qyDdaclFKJ+bERTYT+YUt2uei5lSfeFGo3TF
         T4yPY5Sd28kVEHpcexgG1LJBXgG8JhGY1FeA0KN/RJeEN0o81WkQMhaeSf4Uf3gAc0
         YHeoRBk07uMeOULuahJ+RXY1EBsZwQy+wZa7CouuePJB5SJwdBkw2m+n8DWOZSQR2T
         o7PzSRNNsh1HW9C4vc1+RVy3KIWCebD4CKYXChyycV98zy8R/GX0c102u7g5xE7uPa
         Bq/+E/YbB7zqQ==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        linux-fsdevel@vger.kernel.org (open list:PROC FILESYSTEM),
        linux-api@vger.kernel.org (open list:ABI/API),
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS
        SUBSYSTEM),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        krisman@collabora.com
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 5/5] mm: add process_memwatch syscall documentation
Date:   Tue, 26 Jul 2022 21:18:54 +0500
Message-Id: <20220726161854.276359-6-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220726161854.276359-1-usama.anjum@collabora.com>
References: <20220726161854.276359-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the syscall with explanation of the operations.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 Documentation/admin-guide/mm/soft-dirty.rst | 48 ++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/soft-dirty.rst b/Documentation/admin-guide/mm/soft-dirty.rst
index cb0cfd6672fa..030d75658010 100644
--- a/Documentation/admin-guide/mm/soft-dirty.rst
+++ b/Documentation/admin-guide/mm/soft-dirty.rst
@@ -5,7 +5,12 @@ Soft-Dirty PTEs
 ===============
 
 The soft-dirty is a bit on a PTE which helps to track which pages a task
-writes to. In order to do this tracking one should
+writes to.
+
+Using Proc FS
+-------------
+
+In order to do this tracking one should
 
   1. Clear soft-dirty bits from the task's PTEs.
 
@@ -20,6 +25,47 @@ writes to. In order to do this tracking one should
      64-bit qword is the soft-dirty one. If set, the respective PTE was
      written to since step 1.
 
+Using System Call
+-----------------
+
+process_memwatch system call can be used to find the dirty pages.::
+
+	long process_memwatch(int pidfd, unsigned long start, int len,
+			      unsigned int flags, void *vec, int vec_len);
+
+The pidfd specifies the pidfd of process whose memory needs to be watched.
+The calling process must have PTRACE_MODE_ATTACH_FSCREDS capabilities over
+the process whose pidfd has been specified. It can be zero which means that
+the process wants to watch its own memory. The operation is determined by
+flags. The start argument must be a multiple of the system page size. The
+len argument need not be a multiple of the page size, but since the
+information is returned for the whole pages, len is effectively rounded
+up to the next multiple of the page size.
+
+The vec is output array in which the offsets of the pages are returned.
+Offset is calculated from start address. User lets the kernel know about the
+size of the vec by passing size in vec_len. The system call returns when the
+whole range has been searched or vec is completely filled. The whole range
+isn't cleared if vec fills up completely.
+
+The flags argument specifies the operation to be performed. The MEMWATCH_SD_GET
+and MEMWATCH_SD_CLEAR operations can be used separately or together to perform
+MEMWATCH_SD_GET and MEMWATCH_SD_CLEAR atomically as one operation.::
+
+	MEMWATCH_SD_GET
+		Get the page offsets which are soft dirty.
+
+	MEMWATCH_SD_CLEAR
+		Clear the pages which are soft dirty.
+
+	MEMWATCH_SD_NO_REUSED_REGIONS
+		This optional flag can be specified in combination with other flags.
+		VM_SOFTDIRTY is ignored for the VMAs for performances reasons. This
+		flag shows only those pages dirty which have been written to by the
+		user. All new allocations aren't returned to be dirty.
+
+Explanation
+-----------
 
 Internally, to do this tracking, the writable bit is cleared from PTEs
 when the soft-dirty bit is cleared. So, after this, when the task tries to
-- 
2.30.2

