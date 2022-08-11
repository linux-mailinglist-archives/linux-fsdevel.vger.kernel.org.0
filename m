Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E0458F7E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 08:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiHKGuB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 02:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbiHKGuA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:50:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B488B98F;
        Wed, 10 Aug 2022 23:49:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2F4BB81ECD;
        Thu, 11 Aug 2022 06:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C60C433D6;
        Thu, 11 Aug 2022 06:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660200595;
        bh=nqJm+oBAG4nwtxVy6XW19Cq4t610ItQ+9KHptzLd5cw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I7fQ4dsGGwFGm4V3/IaCXSsIUhTDDD69apZZPRnQXPCLIhvyBw22aHvQOp/l1+lT3
         SEGDkDuRFmqJhPL/gWV8jR96mc0wyHmuv7acoT87ilyA2aWbu1m/TnvKAiMdQEz8zn
         F27GVd6nR5YVkilwqnumtYH/caN+qlgsF/K3NQNTggqiKpWWUYpKv8ZHn8Aw5CXwbb
         6cRKFfk+dErYwd45E+4TR/3lPtGWTmZTxNPLYHzbnQSYhq5mbER/logkjyOHtcrEHI
         5OKsY7B0BVEdUjVFHr4QTPXhcFlkFl3Qk6TkIsz2sDX6VUU9DwEDxvCuhyL6PuOvGs
         68IJ4wzPQeISw==
Date:   Thu, 11 Aug 2022 09:49:33 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 4/5] userfaultfd: update documentation to describe
 /dev/userfaultfd
Message-ID: <YvSmfcO2b8haJhEe@kernel.org>
References: <20220808175614.3885028-1-axelrasmussen@google.com>
 <20220808175614.3885028-5-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808175614.3885028-5-axelrasmussen@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 08, 2022 at 10:56:13AM -0700, Axel Rasmussen wrote:
> Explain the different ways to create a new userfaultfd, and how access
> control works for each way.
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  Documentation/admin-guide/mm/userfaultfd.rst | 41 ++++++++++++++++++--
>  Documentation/admin-guide/sysctl/vm.rst      |  3 ++
>  2 files changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
> index 6528036093e1..a76c9dc1865b 100644
> --- a/Documentation/admin-guide/mm/userfaultfd.rst
> +++ b/Documentation/admin-guide/mm/userfaultfd.rst
> @@ -17,7 +17,10 @@ of the ``PROT_NONE+SIGSEGV`` trick.
>  Design
>  ======
>  
> -Userfaults are delivered and resolved through the ``userfaultfd`` syscall.
> +Userspace creates a new userfaultfd, initializes it, and registers one or more
> +regions of virtual memory with it. Then, any page faults which occur within the
> +region(s) result in a message being delivered to the userfaultfd, notifying
> +userspace of the fault.
>  
>  The ``userfaultfd`` (aside from registering and unregistering virtual
>  memory ranges) provides two primary functionalities:
> @@ -34,12 +37,11 @@ The real advantage of userfaults if compared to regular virtual memory
>  management of mremap/mprotect is that the userfaults in all their
>  operations never involve heavyweight structures like vmas (in fact the
>  ``userfaultfd`` runtime load never takes the mmap_lock for writing).
> -
>  Vmas are not suitable for page- (or hugepage) granular fault tracking
>  when dealing with virtual address spaces that could span
>  Terabytes. Too many vmas would be needed for that.
>  
> -The ``userfaultfd`` once opened by invoking the syscall, can also be
> +The ``userfaultfd``, once created, can also be
>  passed using unix domain sockets to a manager process, so the same
>  manager process could handle the userfaults of a multitude of
>  different processes without them being aware about what is going on
> @@ -50,6 +52,39 @@ is a corner case that would currently return ``-EBUSY``).
>  API
>  ===
>  
> +Creating a userfaultfd
> +----------------------
> +
> +There are two ways to create a new userfaultfd, each of which provide ways to
> +restrict access to this functionality (since historically userfaultfds which
> +handle kernel page faults have been a useful tool for exploiting the kernel).
> +
> +The first way, supported since userfaultfd was introduced, is the
> +userfaultfd(2) syscall. Access to this is controlled in several ways:
> +
> +- Any user can always create a userfaultfd which traps userspace page faults
> +  only. Such a userfaultfd can be created using the userfaultfd(2) syscall
> +  with the flag UFFD_USER_MODE_ONLY.
> +
> +- In order to also trap kernel page faults for the address space, then either

                                    I think "then" is excessive here ^

> +  the process needs the CAP_SYS_PTRACE capability, or the system must have
> +  vm.unprivileged_userfaultfd set to 1. By default, vm.unprivileged_userfaultfd
> +  is set to 0.
> +
> +The second way, added to the kernel more recently, is by opening and issuing a

Maybe:

..., is by opening /dev/userfaultfd and issuing USERFAULTFD_IOC_NEW ioctl
to it.

> +USERFAULTFD_IOC_NEW ioctl to /dev/userfaultfd. This method yields equivalent
> +userfaultfds to the userfaultfd(2) syscall.
> +
> +Unlike userfaultfd(2), access to /dev/userfaultfd is controlled via normal
> +filesystem permissions (user/group/mode), which gives fine grained access to
> +userfaultfd specifically, without also granting other unrelated privileges at
> +the same time (as e.g. granting CAP_SYS_PTRACE would do). Users who have access
> +to /dev/userfaultfd can always create userfaultfds that trap kernel page faults;
> +vm.unprivileged_userfaultfd is not considered.
> +
> +Initializing a userfaultfd
> +--------------------------
> +
>  When first opened the ``userfaultfd`` must be enabled invoking the
>  ``UFFDIO_API`` ioctl specifying a ``uffdio_api.api`` value set to ``UFFD_API`` (or
>  a later API version) which will specify the ``read/POLLIN`` protocol
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index f74f722ad702..b3e40b42e1b3 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -927,6 +927,9 @@ calls without any restrictions.
>  
>  The default value is 0.
>  
> +Another way to control permissions for userfaultfd is to use
> +/dev/userfaultfd instead of userfaultfd(2). See
> +Documentation/admin-guide/mm/userfaultfd.rst.
>  
>  user_reserve_kbytes
>  ===================
> -- 
> 2.37.1.559.g78731f0fdb-goog
> 

-- 
Sincerely yours,
Mike.
