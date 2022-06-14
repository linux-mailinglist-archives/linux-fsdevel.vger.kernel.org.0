Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF8B54A7C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 06:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbiFNETl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 00:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiFNETk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 00:19:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7460027B2B;
        Mon, 13 Jun 2022 21:19:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11760615FB;
        Tue, 14 Jun 2022 04:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B41C3411B;
        Tue, 14 Jun 2022 04:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655180378;
        bh=hMmh6MFQYrFpqoANaJzb2dlWl/uq5j7z53GVi4306hE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P6aclL4Uw4zSJgE7oDf/62QoHQtE0QTLOGTlqsxVsoK7yh5xfurO16qH0W68j+zvc
         i2rdQMrYvjdN5w+UJ2pzFMIbeWaiVU6sATQRcOCl5ZJvICkvkBIG8dAYx3a5olsCAv
         2WGJWwixkQj0igXS4YdgYPWbCXT4FQ8tSApi640zyVrftX4GF9dS2qDmYWR/c0VKaj
         4xLzfuT/BxXKpdFlrWitxI8D7VIT90vpcfOqwFAnx57g8W/RlaDRAO70hssXQOygBL
         KXkRyPwwZ9fz63w6Nqc/QPejjVX47g3girluGB8BErjV/aC8PtQjiHxVud5Gi826hn
         dn7LruiUU7TdA==
Date:   Tue, 14 Jun 2022 07:19:26 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
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
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 4/6] userfaultfd: update documentation to describe
 /dev/userfaultfd
Message-ID: <YqgMTq0IEa6u/FXt@kernel.org>
References: <20220601210951.3916598-1-axelrasmussen@google.com>
 <20220601210951.3916598-5-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601210951.3916598-5-axelrasmussen@google.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 01, 2022 at 02:09:49PM -0700, Axel Rasmussen wrote:
> Explain the different ways to create a new userfaultfd, and how access
> control works for each way.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  Documentation/admin-guide/mm/userfaultfd.rst | 40 ++++++++++++++++++--
>  Documentation/admin-guide/sysctl/vm.rst      |  3 ++
>  2 files changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
> index 6528036093e1..9bae1acd431f 100644
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
> @@ -50,6 +52,38 @@ is a corner case that would currently return ``-EBUSY``).
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
> +The first way, supported by older kernels, is the userfaultfd(2) syscall.
> +Access to this is controlled in several ways:
> +
> +- By default, the userfaultfd will be able to handle kernel page faults. This
> +  can be disabled by passing in UFFD_USER_MODE_ONLY.
> +
> +- If vm.unprivileged_userfaultfd is 0, then the caller must *either* have
> +  CAP_SYS_PTRACE, or pass in UFFD_USER_MODE_ONLY.
> +
> +- If vm.unprivileged_userfaultfd is 1, then no particular privilege is needed to
> +  use this syscall, even if UFFD_USER_MODE_ONLY is *not* set.
> +
> +The second way, added to the kernel more recently, is by opening and issuing a
> +USERFAULTFD_IOC_NEW ioctl to /dev/userfaultfd. This method yields equivalent
> +userfaultfds to the userfaultfd(2) syscall; its benefit is in how access to
> +creating userfaultfds is controlled.
> +
> +Access to /dev/userfaultfd is controlled via normal filesystem permissions
> +(user/group/mode for example), which gives fine grained access to userfaultfd
> +specifically, without also granting other unrelated privileges at the same time
> +(as e.g. granting CAP_SYS_PTRACE would do).
> +
> +Initializing up a userfaultfd

I think 'up' is out of place here. It should be "initializing a
userfaultfd" or "setting up a userfaultfd".

> +-----------------------------
> +
>  When first opened the ``userfaultfd`` must be enabled invoking the
>  ``UFFDIO_API`` ioctl specifying a ``uffdio_api.api`` value set to ``UFFD_API`` (or
>  a later API version) which will specify the ``read/POLLIN`` protocol
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index d7374a1e8ac9..e3a952d1fd35 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -927,6 +927,9 @@ calls without any restrictions.
>  
>  The default value is 0.
>  
> +An alternative to this sysctl / the userfaultfd(2) syscall is to create
> +userfaultfds via /dev/userfaultfd. See

Maybe:

Another way to control permissions for userfaultfd is to use
/dev/userfaultfd instead of userfaultfd(2). See ...

> +Documentation/admin-guide/mm/userfaultfd.rst.
>  
>  user_reserve_kbytes
>  ===================
> -- 
> 2.36.1.255.ge46751e96f-goog
> 
> 

-- 
Sincerely yours,
Mike.
