Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D9750C38B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 01:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbiDVWie (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 18:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbiDVWhz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:37:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF84E288812
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 14:30:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z15-20020a25bb0f000000b00613388c7d99so8273622ybg.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 14:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BoyidSMyUmqDlYzeEP7zIQ3rGwHdvB7avXDVy08761s=;
        b=i6OlZZVuB93oXNW0rTUa3oTx5Wl6MFZGMztF7zW6l8uv5ZXP4VZ9/BlQ/fIJ2bNj5S
         czzlvWKkurK9uKgLUtRxQx52c1k65fe/FZAngeSjsnDddI45UExXmV5LwP9IrqFxD2IL
         rtOStuM0sMGjHQrlSNKyNGZRZVNEsl2JeX44VJMGESx5Y7WYCCaPLOPxkCwlFNBhKVDk
         Qw8fn7GcIem22OY4dCLEKW72OsbVeJfMJDIVUycXbzEA3IIOpcnx7NgdQXCA8ZQAouml
         KftTE01eZE8W63qMuu8ZiPsmT/z34kLTk6gjP+7TIvUM+Wt/kSuOwHlhRL1JNn39s4sE
         62UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BoyidSMyUmqDlYzeEP7zIQ3rGwHdvB7avXDVy08761s=;
        b=FcH2tIcpKIYmW5gVp+GtZcN449aqA6gTQLZJR9KL1nRvp/zLilHKGcoVSyxHRx7RQa
         AoQK29r5zbZS0nZ6qs+QwxR+aaVeohFwdcun8ZoTmcnVceHk61z+3ttbOb+7cgo9Q77F
         +DkKP9Iz9yQSJWquCg6dOWMA3NPhsAKfA3M7p6n/QEJStJvy6gql13wmgjduC2de3Rmd
         klf+sgro9TVtnQjn2C7c8/JDm+1iBeTm37gBDtLFAQOYHEd3LnBKrWy0Zef1aUULVvns
         d2Ff+Kq44ps3pwI7TWyUto3vfdf1PPsFIqyqSk/0pHNbIeMBIw8N0EO7ncKDdbabxA2D
         BU8g==
X-Gm-Message-State: AOAM530BVScP1iyfm5z/KRIXLnMJSBtQr9Y2vZIHQjP0s7hLNrT2b861
        xtKfFLSBXOsenINX3KpQD/VjgMIepmXgWtNu6hRM
X-Google-Smtp-Source: ABdhPJyyc9freLfS6Q7maf39aEdLRh07bXNJn2H9FTDAgzp1lfS3Y4cI9xMNuZVlhb0cZNxgd4sxJOv/WouvvrTj1H7F
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:7ba6:20ac:a8f7:1dbd])
 (user=axelrasmussen job=sendgmr) by 2002:a81:56d5:0:b0:2f4:c9b2:575f with
 SMTP id k204-20020a8156d5000000b002f4c9b2575fmr6944685ywb.111.1650663000214;
 Fri, 22 Apr 2022 14:30:00 -0700 (PDT)
Date:   Fri, 22 Apr 2022 14:29:43 -0700
In-Reply-To: <20220422212945.2227722-1-axelrasmussen@google.com>
Message-Id: <20220422212945.2227722-5-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220422212945.2227722-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v2 4/6] userfaultfd: update documentation to describe /dev/userfaultfd
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, zhangyi <yi.zhang@huawei.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Explain the different ways to create a new userfaultfd, and how access
control works for each way.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 Documentation/admin-guide/mm/userfaultfd.rst | 38 ++++++++++++++++++--
 Documentation/admin-guide/sysctl/vm.rst      |  3 ++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 6528036093e1..4c079b5377d4 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -17,7 +17,10 @@ of the ``PROT_NONE+SIGSEGV`` trick.
 Design
 ======
 
-Userfaults are delivered and resolved through the ``userfaultfd`` syscall.
+Userspace creates a new userfaultfd, initializes it, and registers one or more
+regions of virtual memory with it. Then, any page faults which occur within the
+region(s) result in a message being delivered to the userfaultfd, notifying
+userspace of the fault.
 
 The ``userfaultfd`` (aside from registering and unregistering virtual
 memory ranges) provides two primary functionalities:
@@ -39,7 +42,7 @@ Vmas are not suitable for page- (or hugepage) granular fault tracking
 when dealing with virtual address spaces that could span
 Terabytes. Too many vmas would be needed for that.
 
-The ``userfaultfd`` once opened by invoking the syscall, can also be
+The ``userfaultfd``, once created, can also be
 passed using unix domain sockets to a manager process, so the same
 manager process could handle the userfaults of a multitude of
 different processes without them being aware about what is going on
@@ -50,6 +53,37 @@ is a corner case that would currently return ``-EBUSY``).
 API
 ===
 
+Creating a userfaultfd
+----------------------
+
+There are two mechanisms to create a userfaultfd. There are various ways to
+restrict this too, since userfaultfds which handle kernel page faults have
+historically been a useful tool for exploiting the kernel.
+
+The first is the userfaultfd(2) syscall. Access to this is controlled in several
+ways:
+
+- By default, the userfaultfd will be able to handle kernel page faults. This
+  can be disabled by passing in UFFD_USER_MODE_ONLY.
+
+- If vm.unprivileged_userfaultfd is 0, then the caller must *either* have
+  CAP_SYS_PTRACE, or pass in UFFD_USER_MODE_ONLY.
+
+- If vm.unprivileged_userfaultfd is 1, then no particular privilege is needed to
+  use this syscall, even if UFFD_USER_MODE_ONLY is *not* set.
+
+Alternatively, userfaultfds can be created by opening /dev/userfaultfd, and
+issuing a USERFAULTFD_IOC_NEW ioctl to this device. Access to this device is
+controlled via normal filesystem permissions (user/group/mode for example) - no
+additional permission (capability/sysctl) is needed to be able to handle kernel
+faults this way. This is useful because it allows e.g. a specific user or group
+to be able to create kernel-fault-handling userfaultfds, without allowing it
+more broadly, or granting more privileges in addition to that particular ability
+(CAP_SYS_PTRACE). In other words, it allows permissions to be minimized.
+
+Initializing up a userfaultfd
+------------------------
+
 When first opened the ``userfaultfd`` must be enabled invoking the
 ``UFFDIO_API`` ioctl specifying a ``uffdio_api.api`` value set to ``UFFD_API`` (or
 a later API version) which will specify the ``read/POLLIN`` protocol
diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index f4804ce37c58..8682d5fbc8ea 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -880,6 +880,9 @@ calls without any restrictions.
 
 The default value is 0.
 
+An alternative to this sysctl / the userfaultfd(2) syscall is to create
+userfaultfds via /dev/userfaultfd. See
+Documentation/admin-guide/mm/userfaultfd.rst.
 
 user_reserve_kbytes
 ===================
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

