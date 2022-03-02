Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22AF4CA9E3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 17:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240976AbiCBQMj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 11:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239458AbiCBQMi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:12:38 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5973CB92E;
        Wed,  2 Mar 2022 08:11:54 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id p8so2328355pfh.8;
        Wed, 02 Mar 2022 08:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rqjAwReHv4OR7mYsT5etlrN8Eh3Kjp+z7Ky+T2IUaEg=;
        b=eFhR3U14smputqGxx6Caa7v19Ws9oHUcSIJYzxmxeUkughMnuMY5MxwjDBrj4nmzlR
         gWkLzliBfmD3/bTvWXpsYcGf6kOMAzwWfXP85Wzr0djP+cHhqed3T6bm0iK74phKn2ZU
         cwJpSmNmuYZST/IC6kmCYOdt8J+3AHapMOF7VApCf6YM/lIQQYeIgnfLLLe+ZcoDYQOO
         U/9TG8Z0xs/I7F04jZwN9lS5QORQuJBgQl9K6ZN0aUQ/bd1MNK6IIc/jWW+JDNCsuofW
         3hsYzsMRUcqZ5c5IYQqNp5mq0P9LnKl67wh0Ba2s9gcP0xqg7hEZdYw51yo706zqlw9y
         cn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rqjAwReHv4OR7mYsT5etlrN8Eh3Kjp+z7Ky+T2IUaEg=;
        b=Q1ROz57ryXt5UYREaAdI+qJg6sPI3eGC+muU0EtgJaCKfnRVc1yZZA5sw53JzknHIP
         Prve+gehNUPLJic0WFWOF6nZxISiWpQj3d0+9rSxf0ilgkS8M5F1FUXH/D2yS3zL5A8B
         dEHpAoYb2lDmc+ZgxiEYB6MKLYBVoqQOTvaySLtl9pvYQoEuL/q3byMq7UFWDVsVYay7
         MTIz4BOrBg3lxn+L8TRE7tCLm4ZRjxqCJaQCgleG7hRkWRU+lT5WC8wgCgnovphtdtt4
         Ubf8xqnPPW/nA+SLygPJvfzfa80RUpUM1ij3bEc2xN9y3YoDwCeKTSaOXFk5zpJVfvVt
         P7kA==
X-Gm-Message-State: AOAM531xi7trdFnedRvNJd40k7fNcvOKPBbniVHpx7L5KXl4R0k6EhJP
        p7vDaLadPRZ+gKJO5rg8ZDo=
X-Google-Smtp-Source: ABdhPJxXfOvebzgkOzuyHmiHPzOUEp4mLCS8w+BcalJev3JX+XHkm9xHho5WVyg6E0fyjGmUtHvu2w==
X-Received: by 2002:a63:1113:0:b0:378:deae:5840 with SMTP id g19-20020a631113000000b00378deae5840mr8381753pgl.87.1646237514175;
        Wed, 02 Mar 2022 08:11:54 -0800 (PST)
Received: from jxt.. ([103.150.185.227])
        by smtp.gmail.com with ESMTPSA id d10-20020a63360a000000b0037947abe4bbsm2809382pga.34.2022.03.02.08.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 08:11:53 -0800 (PST)
From:   YI <afctgo@gmail.com>
X-Google-Original-From: YI <uuuuuu@protonmail.com>
To:     trivial@kernel.org
Cc:     YI <afctgo@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Kalesh Singh <kaleshsingh@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Colin Cross <ccross@google.com>,
        Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH] docs: proc.rst: fix wrong time unit
Date:   Thu,  3 Mar 2022 00:11:16 +0800
Message-Id: <20220302161122.3984304-1-uuuuuu@protonmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: YI <afctgo@gmail.com>

Dear Trivial Patch Monkey, 

This commit fixes a small documentaion problem reported in
https://bugzilla.kernel.org/show_bug.cgi?id=194593.

Some fields in the file /proc/$pid/stat represent time.
Their units are clock_t, not jiffies as stated in the documentation.
This commit fixes https://bugzilla.kernel.org/show_bug.cgi?id=194593.

Reported-by: hujunjie
Signed-off-by: YI <afctgo@gmail.com>
---
 Documentation/filesystems/proc.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 061744c436d9..433ad4623630 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -340,10 +340,10 @@ It's slow but very precise.
   cmin_flt      number of minor faults with child's
   maj_flt       number of major faults
   cmaj_flt      number of major faults with child's
-  utime         user mode jiffies
-  stime         kernel mode jiffies
-  cutime        user mode jiffies with child's
-  cstime        kernel mode jiffies with child's
+  utime         user mode processor time (clock_t)
+  stime         kernel mode processor time (clock_t)
+  cutime        user mode processor time (clock_t) with child's
+  cstime        kernel mode processor time (clock_t) with child's
   priority      priority level
   nice          nice level
   num_threads   number of threads
@@ -370,8 +370,8 @@ It's slow but very precise.
   rt_priority   realtime priority
   policy        scheduling policy (man sched_setscheduler)
   blkio_ticks   time spent waiting for block IO
-  gtime         guest time of the task in jiffies
-  cgtime        guest time of the task children in jiffies
+  gtime         guest time of the task in processor time (clock_t)
+  cgtime        guest time of the task children in processor time (clock_t)
   start_data    address above which program data+bss is placed
   end_data      address below which program data+bss is placed
   start_brk     address above which program heap can be expanded with brk()
-- 
2.34.1

