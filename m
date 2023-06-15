Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363A6731AEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 16:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344942AbjFOOM4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 10:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344929AbjFOOMp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:12:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D162953;
        Thu, 15 Jun 2023 07:12:33 -0700 (PDT)
Received: from localhost.localdomain (unknown [119.155.33.163])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4A6AF6606F74;
        Thu, 15 Jun 2023 15:12:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686838352;
        bh=P9YCBV1QZ95F3uqEp5i9HYUF9tuHDwaQOv3IScV4z0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E5gfS0PT7X0Y+vqsFeXenWrwrvluBLvAPBrZs3LVVK+s1d5dYHEQMZWOi/GfDW7lb
         nUHDuzZAz/DOZiwmFhWYWx7aL0B8p0i8iYnrwi4EkTJNGbeKUAY+/ZuLCzpDl0L1JM
         PbuGpHWiT6tPaXZL/7dkVRYAVJmpZ8qLqvLvmH2pcVtx2JCE00dEkvHvPxhenrHHoC
         sVwkevcHYx7HaYgl6GqmNIxdlz7s2OsvJtszkCn9oMVM8p05+u5cRpIicxZvrME/pF
         tBA11+YyC9loHAHH9NAqOmPLj8jNQf2XZapA0XX6Q1A+XZcTvBRk092i2RgOyH8E4p
         ymi3uoAI0lu+w==
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
Subject: [PATCH v19 3/5] tools headers UAPI: Update linux/fs.h with the kernel sources
Date:   Thu, 15 Jun 2023 19:11:42 +0500
Message-Id: <20230615141144.665148-4-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615141144.665148-1-usama.anjum@collabora.com>
References: <20230615141144.665148-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

New IOCTL and macros has been added in the kernel sources. Update the
tools header file as well.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes in v19:
- Update fs.h accourding to precious patch
---
 tools/include/uapi/linux/fs.h | 53 +++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index b7b56871029c..a9fb44db84a3 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -305,4 +305,57 @@ typedef int __bitwise __kernel_rwf_t;
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
 			 RWF_APPEND)
 
+/* Pagemap ioctl */
+#define PAGEMAP_SCAN	_IOWR('f', 16, struct pm_scan_arg)
+
+/* Bits are set in flags of the page_region and masks in pm_scan_args */
+#define PAGE_IS_WRITTEN		(1 << 0)
+#define PAGE_IS_FILE		(1 << 1)
+#define PAGE_IS_PRESENT		(1 << 2)
+#define PAGE_IS_SWAPPED		(1 << 3)
+
+/*
+ * struct page_region - Page region with flags
+ * @start:	Start of the region
+ * @len:	Length of the region in pages
+ * @bitmap:	Bits sets for the region
+ */
+struct page_region {
+	__u64 start;
+	__u64 len;
+	__u64 flags;
+};
+
+/*
+ * struct pm_scan_arg - Pagemap ioctl argument
+ * @size:		Size of the structure
+ * @flags:		Flags for the IOCTL
+ * @start:		Starting address of the region
+ * @len:		Length of the region (All the pages in this length are included)
+ * @vec:		Address of page_region struct array for output
+ * @vec_len:		Length of the page_region struct array
+ * @max_pages:		Optional max return pages
+ * @required_mask:	Required mask - All of these bits have to be set in the PTE
+ * @anyof_mask:		Any mask - Any of these bits are set in the PTE
+ * @excluded_mask:	Exclude mask - None of these bits are set in the PTE
+ * @return_mask:	Bits that are to be reported in page_region
+ */
+struct pm_scan_arg {
+	__u64 size;
+	__u64 flags;
+	__u64 start;
+	__u64 len;
+	__u64 vec;
+	__u64 vec_len;
+	__u64 max_pages;
+	__u64 required_mask;
+	__u64 anyof_mask;
+	__u64 excluded_mask;
+	__u64 return_mask;
+};
+
+/* Supported flags */
+#define PM_SCAN_OP_GET	(1 << 0)
+#define PM_SCAN_OP_WP	(1 << 1)
+
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.39.2

