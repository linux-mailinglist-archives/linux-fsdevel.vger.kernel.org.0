Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC2FE76C63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2019 17:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfGZPI6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 11:08:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43544 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbfGZPI5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:08:57 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so17887678pld.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2019 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dWQZR/3W1JJGAqPUD7hTWyfWfaLoNTQhqklPLc/rCo0=;
        b=aHKVCn8Yp9k/O48xxeey02lLJNycfqq+nT8pu97tqLat8sXh6527ZcHjiLMjFGs8ZZ
         SzpXGhN97m6q7LoR5xxBb5fekgPrddIS2ckjFbLcS/b41a8DTKGviU3TjgY2guZy2wOV
         N7hTZrckEmKJ55qJ5XLQRPA1RD8Ilyo39Glr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dWQZR/3W1JJGAqPUD7hTWyfWfaLoNTQhqklPLc/rCo0=;
        b=RU8p9tZTPmymESCqKkKTizMPccIuAR/2y+XwhtTIGrtSzfFWfL9cLm+19WDpJyxhWL
         dV+/sT+sD/1eE0NDA0VEZdrpsSuYVu+6dEzK+Jhn0DMDduOBr5nhllrav3xbvXIhlZAo
         SpObozoDjZLpx+btj93SWyxxndIX/lL0WCCfsnh3/4sp+1AK561WHj2n2hyXqU5aottc
         8DBTzTvOOt+wWwJcJdjazNDaHMBJZUCueMD6ntsTOnAeKFURJM0BCw2aEttxLR1QpZ+W
         XgOoT0zAapYvdGvab3bhvwuFImRfEoQLOrNk9rVp9u/e+DtjPRrYm+hcLupUpHJfbE8/
         WShA==
X-Gm-Message-State: APjAAAXsJ76hdlV0EDXWRrimzXr+aZnXR7l3J98hc4n9D5vHQLwUvVH8
        2hMSRz8t1w4XZt77yullbRc=
X-Google-Smtp-Source: APXvYqzXibXZSd6IWrSK+XtEpTCaIi3keajeQLn0VdiXnOjUc33BTq98H530Us64OhTV+XaDB3T7Bw==
X-Received: by 2002:a17:902:7791:: with SMTP id o17mr98018495pll.27.1564153736559;
        Fri, 26 Jul 2019 08:08:56 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id k36sm54802352pgl.42.2019.07.26.08.08.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 08:08:55 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, joaodias@google.com, joelaf@google.com,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, minchan@kernel.org,
        namhyung@google.com, Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        tkjos@google.com, Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, wvw@google.com
Subject: [PATCH v2 2/2] doc: Update documentation for page_idle virtual address indexing
Date:   Fri, 26 Jul 2019 11:08:44 -0400
Message-Id: <20190726150845.95720-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190726150845.95720-1-joel@joelfernandes.org>
References: <20190726150845.95720-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch updates the documentation with the new page_idle tracking
feature which uses virtual address indexing.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../admin-guide/mm/idle_page_tracking.rst     | 43 ++++++++++++++++---
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/mm/idle_page_tracking.rst b/Documentation/admin-guide/mm/idle_page_tracking.rst
index df9394fb39c2..1eeac78c94a7 100644
--- a/Documentation/admin-guide/mm/idle_page_tracking.rst
+++ b/Documentation/admin-guide/mm/idle_page_tracking.rst
@@ -19,10 +19,14 @@ It is enabled by CONFIG_IDLE_PAGE_TRACKING=y.
 
 User API
 ========
+There are 2 ways to access the idle page tracking API. One uses physical
+address indexing, another uses a simpler virtual address indexing scheme.
 
-The idle page tracking API is located at ``/sys/kernel/mm/page_idle``.
-Currently, it consists of the only read-write file,
-``/sys/kernel/mm/page_idle/bitmap``.
+Physical address indexing
+-------------------------
+The idle page tracking API for physical address indexing using page frame
+numbers (PFN) is located at ``/sys/kernel/mm/page_idle``.  Currently, it
+consists of the only read-write file, ``/sys/kernel/mm/page_idle/bitmap``.
 
 The file implements a bitmap where each bit corresponds to a memory page. The
 bitmap is represented by an array of 8-byte integers, and the page at PFN #i is
@@ -74,6 +78,31 @@ See :ref:`Documentation/admin-guide/mm/pagemap.rst <pagemap>` for more
 information about ``/proc/pid/pagemap``, ``/proc/kpageflags``, and
 ``/proc/kpagecgroup``.
 
+Virtual address indexing
+------------------------
+The idle page tracking API for virtual address indexing using virtual page
+frame numbers (VFN) is located at ``/proc/<pid>/page_idle``. It is a bitmap
+that follows the same semantics as ``/sys/kernel/mm/page_idle/bitmap``
+except that it uses virtual instead of physical frame numbers.
+
+This idle page tracking API does not need deal with PFN so it does not require
+prior lookups of ``pagemap`` in order to find if page is idle or not. This is
+an advantage on some systems where looking up PFN is considered a security
+issue.  Also in some cases, this interface could be slightly more reliable to
+use than physical address indexing, since in physical address indexing, address
+space changes can occur between reading the ``pagemap`` and reading the
+``bitmap``, while in virtual address indexing, the process's ``mmap_sem`` is
+held for the duration of the access.
+
+To estimate the amount of pages that are not used by a workload one should:
+
+ 1. Mark all the workload's pages as idle by setting corresponding bits in
+    ``/proc/<pid>/page_idle``.
+
+ 2. Wait until the workload accesses its working set.
+
+ 3. Read ``/proc/<pid>/page_idle`` and count the number of bits set.
+
 .. _impl_details:
 
 Implementation Details
@@ -99,10 +128,10 @@ When a dirty page is written to swap or disk as a result of memory reclaim or
 exceeding the dirty memory limit, it is not marked referenced.
 
 The idle memory tracking feature adds a new page flag, the Idle flag. This flag
-is set manually, by writing to ``/sys/kernel/mm/page_idle/bitmap`` (see the
-:ref:`User API <user_api>`
-section), and cleared automatically whenever a page is referenced as defined
-above.
+is set manually, by writing to ``/sys/kernel/mm/page_idle/bitmap`` for physical
+addressing or by writing to ``/proc/<pid>/page_idle`` for virtual
+addressing (see the :ref:`User API <user_api>` section), and cleared
+automatically whenever a page is referenced as defined above.
 
 When a page is marked idle, the Accessed bit must be cleared in all PTEs it is
 mapped to, otherwise we will not be able to detect accesses to the page coming
-- 
2.22.0.709.g102302147b-goog

