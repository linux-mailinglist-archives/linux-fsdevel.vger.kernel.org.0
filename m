Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6324B6B2618
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 15:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjCIOBT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 09:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjCIOAL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:00:11 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DE316326;
        Thu,  9 Mar 2023 05:57:58 -0800 (PST)
Received: from localhost.localdomain (unknown [39.45.145.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8CF0B660304D;
        Thu,  9 Mar 2023 13:57:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678370277;
        bh=xjF06wKtIpjGyLf20IlUgGfd9VWRBSB80gsUXsjOm7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h6tj2UNoGmxsJnXR7rkEUAYxAXDjulvcbJmrMOuysjMwtQ8QaHZoTDdbLKGJ0/yNP
         7bEuDeoVTAKq5MWHIcVhnfLZ3iqWXIcYXM9Jncn2wZzSlhnU2ENMbSh2AKw1w6R5am
         F2/NkVQE0TFAJdx5tuFB8K8W4YYWQ1bA18RxvhACd3KYWJEEgoN+ovMOUX1jxVLbUT
         vXmM3wMO85SZL/wlS/m6ElkKRVwqOJv3z/VT71zyR9ivPDCS3GdAZTDMdNrQi58XmN
         ruBHblisix6PVBpjtzc6CfJHoSlOGuivyQB6bKXvc65lVGL8hPpTWK3OAa858ZB0sc
         Y4oBQdKMYn+Wg==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: [PATCH v11 3/7] userfaultfd: update documentation to describe UFFD_FEATURE_WP_ASYNC
Date:   Thu,  9 Mar 2023 18:57:14 +0500
Message-Id: <20230309135718.1490461-4-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309135718.1490461-1-usama.anjum@collabora.com>
References: <20230309135718.1490461-1-usama.anjum@collabora.com>
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

Explain the difference created by UFFD_FEATURE_WP_ASYNC to the write
protection (UFFDIO_WRITEPROTECT_MODE_WP) mode.

Suggested-by: Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes in v11:
- Update the documentation from reviews entirely from Peter
---
 Documentation/admin-guide/mm/userfaultfd.rst | 21 ++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 7dc823b56ca4..404d8aa8f09f 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -219,6 +219,27 @@ former will have ``UFFD_PAGEFAULT_FLAG_WP`` set, the latter
 you still need to supply a page when ``UFFDIO_REGISTER_MODE_MISSING`` was
 used.
 
+If the userfaultfd context (that has ``UFFDIO_REGISTER_MODE_WP`` registered
+against) has ``UFFD_FEATURE_WP_ASYNC`` feature enabled, it will work in
+async write protection mode.  It can be seen as a more accurate version of
+soft-dirty tracking, meanwhile the results will not be easily affected by
+other operations like vma merging.
+
+Comparing to the generic mode, the async mode will not generate any
+userfaultfd message when the protected memory range is written.  Instead, the
+kernel will automatically resolve the page fault immediately by dropping the
+uffd-wp bit in the pgtables.  The user app can collect the "written/dirty"
+status by looking up the uffd-wp bit for the pages being interested in
+/proc/pagemap.
+
+The page will be under track of uffd-wp async mode until the page is explicitly
+write-protected by ``UFFDIO_WRITEPROTECT`` ioctl with the mode flag
+``UFFDIO_WRITEPROTECT_MODE_WP`` set.  Trying to resolve a page fault that was
+tracked by async mode userfaultfd-wp is invalid.
+
+Currently ``UFFD_FEATURE_WP_ASYNC`` only support anonymous and shmem. Hugetlb is
+not yet supported.
+
 QEMU/KVM
 ========
 
-- 
2.39.2

