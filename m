Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A3C74A733
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 00:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjGFWu5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 18:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjGFWuz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:50:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233D81BCA
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jul 2023 15:50:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c5fc972760eso1234426276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jul 2023 15:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688683853; x=1691275853;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dr4h9VGDfsn/VMT+xHDPiOp9dXBZSKUD38K7YaReMD4=;
        b=oG6cUbXqueLNKCE01QfHG46TYxjrnSczrRs1z4fAd0XehnlwpZ6QzxEJt4W2Ue3oTg
         jmIlcVMPOO3wBc5Jmpx0+P7PdoVG9zHOG4l9JNotEr1VVRKn8UBqflwPIUBZiM7amwz3
         tHjgfEOpZHvakwUYyo/kFliQBAwyxEYaH9p9Krdz4uCEX03XtWL0k4huwPf4JMBUWiuJ
         vH0FF8WK3+d9dnq2JbKxfTWxmC9bR4z1x++0EIg8VN51Y6zcrk9sFkWFs+n0Ee8WaTrI
         T/JjfeQ68QMFZsZ0wuD8e82BwZ+qeWxNN+55lMptu2IruYWfXF6lh4uEunTtWoQohPkt
         /enw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688683853; x=1691275853;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dr4h9VGDfsn/VMT+xHDPiOp9dXBZSKUD38K7YaReMD4=;
        b=fYblUvYJJFKh9hivMBpGeYsIVXiiKF79GCRSRV73YnZvwldKardITjjz3FLlHJa8gV
         BEmU6xmITNmYZarT/9cIrU0P3h3/JLl9FyLM5bzmj7rziyF7kb/C14VUT9WgG0ul/6qJ
         c9bGVjg8eFPaWoxd+D8NijK5esBRowzqXcGCVtK2M0/ZGMcAELE31OK9asi5myuBkXr0
         2lE+zOkVHCiFBqL/iOYSFVmO5d7Kp2FFHbxYzEuvo1zLWvEumIDji1FlSF9ZmWJB6PLm
         lFaaXFooE3zjKNjmSbpHhts0PwdVhZBTwsV9J6HJQ3BJTkDt5r+BrZfkQhRFFXHV9ZHA
         DShA==
X-Gm-Message-State: ABy/qLYWQU1V4qbxCdanyJwG6C2406r7nTIN3Aor+p3WLe6s/oWqQcA+
        An4P9zS/n0x+SMpwt0MaWIVDSWB0U116VlABLfTl
X-Google-Smtp-Source: APBJJlEl5yfZInV23tQIGQwzZqjUhDMQjVJrb/6PeQU7rd1hzOOT/WdC6F9gqXpUHWmfYN6lE3AUVfAUoi1up8aCXiJW
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:bec3:2b1c:87a:fca2])
 (user=axelrasmussen job=sendgmr) by 2002:a25:c70e:0:b0:c67:e177:100a with
 SMTP id w14-20020a25c70e000000b00c67e177100amr19507ybe.4.1688683853333; Thu,
 06 Jul 2023 15:50:53 -0700 (PDT)
Date:   Thu,  6 Jul 2023 15:50:30 -0700
In-Reply-To: <20230706225037.1164380-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230706225037.1164380-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230706225037.1164380-3-axelrasmussen@google.com>
Subject: [PATCH v3 2/8] mm: userfaultfd: check for start + len overflow in validate_range
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Geffon <bgeffon@google.com>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Peter Xu <peterx@redhat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Yu Zhao <yuzhao@google.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Most userfaultfd ioctls take a `start + len` range as an argument.
We have the validate_range helper to check that such ranges are valid.
However, some (but not all!) ioctls *also* check that `start + len`
doesn't wrap around (overflow).

Just check for this in validate_range. This saves some repetitive code,
and adds the check to some ioctls which weren't bothering to check for
it before.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 7cecd49e078b..2e84684c46f0 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1306,6 +1306,8 @@ static __always_inline int validate_range(struct mm_struct *mm,
 		return -EINVAL;
 	if (len > task_size - start)
 		return -EINVAL;
+	if (start + len <= start)
+		return -EINVAL;
 	return 0;
 }
 
@@ -1760,14 +1762,8 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
 	ret = validate_range(ctx->mm, uffdio_copy.dst, uffdio_copy.len);
 	if (ret)
 		goto out;
-	/*
-	 * double check for wraparound just in case. copy_from_user()
-	 * will later check uffdio_copy.src + uffdio_copy.len to fit
-	 * in the userland range.
-	 */
+
 	ret = -EINVAL;
-	if (uffdio_copy.src + uffdio_copy.len <= uffdio_copy.src)
-		goto out;
 	if (uffdio_copy.mode & ~(UFFDIO_COPY_MODE_DONTWAKE|UFFDIO_COPY_MODE_WP))
 		goto out;
 	if (uffdio_copy.mode & UFFDIO_COPY_MODE_WP)
@@ -1927,11 +1923,6 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 		goto out;
 
 	ret = -EINVAL;
-	/* double check for wraparound just in case. */
-	if (uffdio_continue.range.start + uffdio_continue.range.len <=
-	    uffdio_continue.range.start) {
-		goto out;
-	}
 	if (uffdio_continue.mode & ~(UFFDIO_CONTINUE_MODE_DONTWAKE |
 				     UFFDIO_CONTINUE_MODE_WP))
 		goto out;
-- 
2.41.0.255.g8b1d071c50-goog

