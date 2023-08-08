Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DFB774524
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 20:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjHHSht (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 14:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjHHSh1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:37:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE8A38BF6;
        Tue,  8 Aug 2023 09:39:03 -0700 (PDT)
Received: from localhost.localdomain (unknown [59.103.218.230])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 59FAF6607200;
        Tue,  8 Aug 2023 11:43:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691491428;
        bh=w6fRj7IgTvvx5EsyHLfunAonFs0TRl2SHloFjajvkUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rn3PHXT/5jiKxoyKdjxgrMliM1yxwpVXBPZ3vXKzcp9IIr3nOwpoTKsJL+iZe8OLQ
         4yux5CdWX+FrM7u5yeiXadjHWMbk90jxsr3DFPacC9UwHwTRUgbNa+oksKSCvJ3z8N
         WYPHe2P60IKmO+nn0fcFRQoXio8xxlqFnnNjvEpjdrmMWN5gQ0QO+FkfZ2yUi9j8gv
         NLskLQZ9KAklSK6Uf7ZIeZ8etmI9IftSdEMWU07K+U3UdMGjN4UDnJg16f4LUc2EDU
         QX/YASdYnr47fQkZWW2n6feQw76YiY+pQ3y65Ivf4bNLWZPA/xJEfw1H28YhxgErbt
         D3nQ7VQXQF8bQ==
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
Subject: [PATCH v27 4/6] tools headers UAPI: Update linux/fs.h with the kernel sources
Date:   Tue,  8 Aug 2023 15:43:07 +0500
Message-Id: <20230808104309.357852-5-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230808104309.357852-1-usama.anjum@collabora.com>
References: <20230808104309.357852-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

New IOCTL and macros has been added in the kernel sources. Update the
tools header file as well.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes in v27:
- Comment updates in fs.h

Changes in v26:
- Update according to tools/include/uapi/linux/fs.h

Changes in v21:
- Update tools/include/uapi/linux/fs.h

Changes in v19:
- Update fs.h according to precious patch
---
 tools/include/uapi/linux/fs.h | 59 +++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index b7b56871029c5..1c9d38af1015e 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -305,4 +305,63 @@ typedef int __bitwise __kernel_rwf_t;
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
 			 RWF_APPEND)
 
+/* Pagemap ioctl */
+#define PAGEMAP_SCAN	_IOWR('f', 16, struct pm_scan_arg)
+
+/* Bits are set in flags of the page_region and masks in pm_scan_args */
+#define PAGE_IS_WPALLOWED	(1 << 0)
+#define PAGE_IS_WRITTEN		(1 << 1)
+#define PAGE_IS_FILE		(1 << 2)
+#define PAGE_IS_PRESENT		(1 << 3)
+#define PAGE_IS_SWAPPED		(1 << 4)
+#define PAGE_IS_PFNZERO		(1 << 5)
+#define PAGE_IS_HUGE		(1 << 6)
+
+/*
+ * struct page_region - Page region with flags
+ * @start:	Start of the region
+ * @end:	End of the region (exclusive)
+ * @categories:	PAGE_IS_* category bitmask for the region
+ */
+struct page_region {
+	__u64 start;
+	__u64 end;
+	__u64 categories;
+};
+
+/* Flags for PAGEMAP_SCAN ioctl */
+#define PM_SCAN_WP_MATCHING	(1 << 0)	/* Write protect the pages matched. */
+#define PM_SCAN_CHECK_WPASYNC	(1 << 1)	/* Abort the scan when a non-WP-enabled page is found. */
+
+/*
+ * struct pm_scan_arg - Pagemap ioctl argument
+ * @size:		Size of the structure
+ * @flags:		Flags for the IOCTL
+ * @start:		Starting address of the region
+ * @end:		Ending address of the region
+ * @walk_end		Address where the scan stopped (written by kernel).
+ *			walk_end == end informs that the scan completed on entire range.
+ * @vec:		Address of page_region struct array for output
+ * @vec_len:		Length of the page_region struct array
+ * @max_pages:		Optional limit for number of returned pages (0 = disabled)
+ * @category_inverted:	PAGE_IS_* categories which values match if 0 instead of 1
+ * @category_mask:	Skip pages for which any category doesn't match
+ * @category_anyof_mask: Skip pages for which no category matches
+ * @return_mask:	PAGE_IS_* categories that are to be reported in `page_region`s returned
+ */
+struct pm_scan_arg {
+	__u64 size;
+	__u64 flags;
+	__u64 start;
+	__u64 end;
+	__u64 walk_end;
+	__u64 vec;
+	__u64 vec_len;
+	__u64 max_pages;
+	__u64 category_inverted;
+	__u64 category_mask;
+	__u64 category_anyof_mask;
+	__u64 return_mask;
+};
+
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.39.2

