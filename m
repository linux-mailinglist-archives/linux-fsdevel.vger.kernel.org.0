Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEA9383C66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 20:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239306AbhEQShK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 14:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbhEQShI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 14:37:08 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2595DC061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 11:35:52 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n3so3663732plf.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 11:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wqJ1xSTew63qqczYAjdusvy3qG1VX8/J1KmQjEgHR2E=;
        b=wzggP5LYyy6xcx78afLXLuoSyO6Jpdc8UUfFCeszwbtEaOLwo9DLdDmq35c8yvJlth
         xqRPQ6xJ4VAxWxnYcSFFDwrIJCVsNSddLG2VGmgPljldL7eAJMAKuoSjYg7ActQBq170
         ik/umiKp27tWePVoxVvLBWRRzSW7WyhtvOOJwlzCdBeTDNKBbXE4Jv5/vbleol3xTabV
         p6WUdhLXMdjFmw5A2Wf+2OiV7rAf1A/I0TQLBaFqp1Lu/Xs+sgF+2jmsEoIXL8G5xM50
         J+rz55A8IfZCvV5UJVsPayjXB8K1RwiHgEM28oFQ6HNvd4oZEwfYVFVpsvlpBnNLhLyi
         TSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wqJ1xSTew63qqczYAjdusvy3qG1VX8/J1KmQjEgHR2E=;
        b=cmzzzZ18t9WcOCTYPTvTxAmPntKe4MV0zBOIrFd+Ppn5x8XbS41tQ1cvIYZz4rv7La
         3oUPXLuQE5dQgSnkMYNXnomdYr7IAbqJKmt4A/YjkhDuVTCI/ANEf4/ULnPIzpCnJmhi
         gy30AgcHOAEsa0SXei7RIFIcO8rIJ5VLPbrBlyvDe/po/9AlypvjhSuDIyjBVvjZoGdm
         fyDGktdq0zROI3Bj+oDqLLizYA11tJV2b5ZUqlRXNYX/45FB3rEpim0Bldf4JIWzLasd
         IwaSBgh1IqKY4vAJZRAXe/4pkoU76xjPuGs9wfZu9oigCXEGJ3QHrp1crZCCbE4Iy+g7
         WmCg==
X-Gm-Message-State: AOAM5337AmdM5zzdPJ4z0LVBZXn3Qssg6Y4qMCJcl+zubJsdVrRvUn1c
        d1elqViWV689j7I7dpI5ewPyOGYILC7GNA==
X-Google-Smtp-Source: ABdhPJzxGzNmjENobhO+XXGjAEx2gIv30W5taF3FejDx2NhwHe24Qj7Rc+xUML3UFY6qpj8wm/PeFQ==
X-Received: by 2002:a17:902:26c:b029:ef:96e9:1471 with SMTP id 99-20020a170902026cb02900ef96e91471mr1205309plc.63.1621276545877;
        Mon, 17 May 2021 11:35:45 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:19a9])
        by smtp.gmail.com with ESMTPSA id v15sm5498763pfm.187.2021.05.17.11.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 11:35:44 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH RERESEND v9 1/9] iov_iter: add copy_struct_from_iter()
Date:   Mon, 17 May 2021 11:35:19 -0700
Message-Id: <80b5f8bc277912222121f6ab9a9796d7f20998eb.1621276134.git.osandov@fb.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621276134.git.osandov@fb.com>
References: <cover.1621276134.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is essentially copy_struct_from_user() but for an iov_iter.

Suggested-by: Aleksa Sarai <cyphar@cyphar.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 include/linux/uio.h |  1 +
 lib/iov_iter.c      | 91 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index d3ec87706d75..cbaf6b3bfcbc 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -129,6 +129,7 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
 size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
+int copy_struct_from_iter(void *dst, size_t ksize, struct iov_iter *i);
 
 size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index c701b7a187f2..129f264416ff 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -995,6 +995,97 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 }
 EXPORT_SYMBOL(copy_page_from_iter);
 
+/**
+ * copy_struct_from_iter - copy a struct from an iov_iter
+ * @dst: Destination buffer.
+ * @ksize: Size of @dst struct.
+ * @i: Source iterator.
+ *
+ * Copies a struct from an iov_iter in a way that guarantees
+ * backwards-compatibility for struct arguments in an iovec (as long as the
+ * rules for copy_struct_from_user() are followed).
+ *
+ * The source struct is assumed to be stored in the current segment of the
+ * iov_iter, and its size is the size of the current segment. The iov_iter must
+ * be positioned at the beginning of the current segment.
+ *
+ * The recommended usage is something like the following:
+ *
+ *   int do_foo(struct iov_iter *i)
+ *   {
+ *     size_t usize = iov_iter_single_seg_count(i);
+ *     struct foo karg;
+ *     int err;
+ *
+ *     if (usize > PAGE_SIZE)
+ *       return -E2BIG;
+ *     if (usize < FOO_SIZE_VER0)
+ *       return -EINVAL;
+ *     err = copy_struct_from_iter(&karg, sizeof(karg), i);
+ *     if (err)
+ *       return err;
+ *
+ *     // ...
+ *   }
+ *
+ * Returns 0 on success or one of the following errors:
+ *  * -E2BIG:  (size of current segment > @ksize) and there are non-zero
+ *             trailing bytes in the current segment.
+ *  * -EFAULT: access to userspace failed.
+ *  * -EINVAL: the iterator is not at the beginning of the current segment.
+ *
+ * On success, the iterator is advanced to the next segment. On error, the
+ * iterator is not advanced.
+ */
+int copy_struct_from_iter(void *dst, size_t ksize, struct iov_iter *i)
+{
+	size_t usize;
+	int ret;
+
+	if (i->iov_offset != 0)
+		return -EINVAL;
+	if (iter_is_iovec(i)) {
+		usize = i->iov->iov_len;
+		might_fault();
+		if (copyin(dst, i->iov->iov_base, min(ksize, usize)))
+			return -EFAULT;
+		if (usize > ksize) {
+			ret = check_zeroed_user(i->iov->iov_base + ksize,
+						usize - ksize);
+			if (ret < 0)
+				return ret;
+			else if (ret == 0)
+				return -E2BIG;
+		}
+	} else if (iov_iter_is_kvec(i)) {
+		usize = i->kvec->iov_len;
+		memcpy(dst, i->kvec->iov_base, min(ksize, usize));
+		if (usize > ksize &&
+		    memchr_inv(i->kvec->iov_base + ksize, 0, usize - ksize))
+			return -E2BIG;
+	} else if (iov_iter_is_bvec(i)) {
+		char *p;
+
+		usize = i->bvec->bv_len;
+		p = kmap_local_page(i->bvec->bv_page);
+		memcpy(dst, p + i->bvec->bv_offset, min(ksize, usize));
+		if (usize > ksize &&
+		    memchr_inv(p + i->bvec->bv_offset + ksize, 0,
+			       usize - ksize)) {
+			kunmap_local(p);
+			return -E2BIG;
+		}
+		kunmap_local(p);
+	} else {
+		return -EFAULT;
+	}
+	if (usize < ksize)
+		memset(dst + usize, 0, ksize - usize);
+	iov_iter_advance(i, usize);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(copy_struct_from_iter);
+
 static size_t pipe_zero(size_t bytes, struct iov_iter *i)
 {
 	struct pipe_inode_info *pipe = i->pipe;
-- 
2.31.1

