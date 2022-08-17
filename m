Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2FF59793C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 23:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242397AbiHQVsQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 17:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242340AbiHQVrx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:47:53 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F7BAB076
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 14:47:42 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-333f0d49585so84368257b3.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 14:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=jMyZorWE6E22hV3NDdjIMErSuhZAX9bJlMRQ4lfwoQk=;
        b=kmf5TPe5TDihxUks/W6HE9xnDr7EKu9fX5X/rvsm0Ya68c0awpeJBVGH0nzmUKuYJ8
         rE8tjpC3S/ed1CEBFsuxhHdeIjP56/BSB5drqGzrmIJXsqSJBNKymt6+K0z6vPXyWx3i
         0tBuuyCs3uyC0x5ddlwxY2lKwN7wUGTezJaC4PMmelE9aNTy46ALdXCVGFD99eosR85J
         gV9LNz5Sca6lRKdL7jFoNuTCrfmAaL+Lx/NKNp5PuCO/vmUdvXCvKOciNBepvGWehlrZ
         8nDB0O42+9TdWUts8kxMGVRvWkzlxt6ohWl6fGZIeamEURvXy40mRJONvGqeYX0aNkb3
         QEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=jMyZorWE6E22hV3NDdjIMErSuhZAX9bJlMRQ4lfwoQk=;
        b=L8UuxXJQgUbPeUC0zVYHgeAlDUxPSmosua9+cm4FhOgpnS3aZPhndb0afOejrJ351W
         WTxkefr9IMUrJ84ZzTGv8vspZxInzCednBTEgwM0hUiOJM8aUgm/QV7m/7r4L2wOB1n+
         DSn9a8tmH4iVPXZwQG9RmYUKRGjuWZNX73HrD62PO7YrrVPd/F6fBy79xaYUfFL6Fa6n
         Y2ddVKHIgYdSihM14EUcd1oHT4n4GmADk1GB8L4Kxw3KT0jRn2S1ULbYq76f6sqAohuT
         SL3rzMbO3X5fcweoOpqxIzwKMLrAZb1UkrwiZIhIUhCLnbN+niGScMP16lMZmMis0f8X
         roeA==
X-Gm-Message-State: ACgBeo1o3ZfhN3TPsks45aeIuvwVyNcXT/aZgk/4cdpZYe9764PUMfvE
        HCydPwExguHioHhPOTtUSmaqGr564qjPkvuOUhf6
X-Google-Smtp-Source: AA6agR6aBMm/RqNkrbkKOZWC8FO8iRne3LMJ4YFzZ+fs5wAz7NO45vvRzpcivQOY2FdD/cwWt1QvlitSsbytGa9Pxd0v
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:2f41:f176:4bac:b729])
 (user=axelrasmussen job=sendgmr) by 2002:a81:1dd1:0:b0:335:dd05:372c with
 SMTP id d200-20020a811dd1000000b00335dd05372cmr159548ywd.342.1660772862105;
 Wed, 17 Aug 2022 14:47:42 -0700 (PDT)
Date:   Wed, 17 Aug 2022 14:47:27 -0700
In-Reply-To: <20220817214728.489904-1-axelrasmussen@google.com>
Message-Id: <20220817214728.489904-5-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220817214728.489904-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v6 4/5] userfaultfd: update documentation to describe /dev/userfaultfd
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Explain the different ways to create a new userfaultfd, and how access
control works for each way.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 Documentation/admin-guide/mm/userfaultfd.rst | 41 ++++++++++++++++++--
 Documentation/admin-guide/sysctl/vm.rst      |  3 ++
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 6528036093e1..83f31919ebb3 100644
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
@@ -34,12 +37,11 @@ The real advantage of userfaults if compared to regular virtual memory
 management of mremap/mprotect is that the userfaults in all their
 operations never involve heavyweight structures like vmas (in fact the
 ``userfaultfd`` runtime load never takes the mmap_lock for writing).
-
 Vmas are not suitable for page- (or hugepage) granular fault tracking
 when dealing with virtual address spaces that could span
 Terabytes. Too many vmas would be needed for that.
 
-The ``userfaultfd`` once opened by invoking the syscall, can also be
+The ``userfaultfd``, once created, can also be
 passed using unix domain sockets to a manager process, so the same
 manager process could handle the userfaults of a multitude of
 different processes without them being aware about what is going on
@@ -50,6 +52,39 @@ is a corner case that would currently return ``-EBUSY``).
 API
 ===
 
+Creating a userfaultfd
+----------------------
+
+There are two ways to create a new userfaultfd, each of which provide ways to
+restrict access to this functionality (since historically userfaultfds which
+handle kernel page faults have been a useful tool for exploiting the kernel).
+
+The first way, supported since userfaultfd was introduced, is the
+userfaultfd(2) syscall. Access to this is controlled in several ways:
+
+- Any user can always create a userfaultfd which traps userspace page faults
+  only. Such a userfaultfd can be created using the userfaultfd(2) syscall
+  with the flag UFFD_USER_MODE_ONLY.
+
+- In order to also trap kernel page faults for the address space, either the
+  process needs the CAP_SYS_PTRACE capability, or the system must have
+  vm.unprivileged_userfaultfd set to 1. By default, vm.unprivileged_userfaultfd
+  is set to 0.
+
+The second way, added to the kernel more recently, is by opening
+/dev/userfaultfd and issuing a USERFAULTFD_IOC_NEW ioctl to it. This method
+yields equivalent userfaultfds to the userfaultfd(2) syscall.
+
+Unlike userfaultfd(2), access to /dev/userfaultfd is controlled via normal
+filesystem permissions (user/group/mode), which gives fine grained access to
+userfaultfd specifically, without also granting other unrelated privileges at
+the same time (as e.g. granting CAP_SYS_PTRACE would do). Users who have access
+to /dev/userfaultfd can always create userfaultfds that trap kernel page faults;
+vm.unprivileged_userfaultfd is not considered.
+
+Initializing a userfaultfd
+--------------------------
+
 When first opened the ``userfaultfd`` must be enabled invoking the
 ``UFFDIO_API`` ioctl specifying a ``uffdio_api.api`` value set to ``UFFD_API`` (or
 a later API version) which will specify the ``read/POLLIN`` protocol
diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 9b833e439f09..988f6a4c8084 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -926,6 +926,9 @@ calls without any restrictions.
 
 The default value is 0.
 
+Another way to control permissions for userfaultfd is to use
+/dev/userfaultfd instead of userfaultfd(2). See
+Documentation/admin-guide/mm/userfaultfd.rst.
 
 user_reserve_kbytes
 ===================
-- 
2.37.1.595.g718a3a8f04-goog

