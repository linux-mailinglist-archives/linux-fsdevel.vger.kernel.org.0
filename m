Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AC551048F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 18:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353544AbiDZQxI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 12:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353353AbiDZQv3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:51:29 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E1C4ECDE
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 09:46:55 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id e194so20747742iof.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 09:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nGoQA4PseSMoDB9HLCqlZ/CtlZ9MNnC5N8+D59h5w8o=;
        b=QnD/GAUE7CCosj6Br3twZxRnNYr08rmMRUz4OvX6q9jQkOBisUBMikIxBXEke6gIxl
         HDdrX0BRG0q0xgvMNTMpX+sEHvqA54rAFblk/g6oJw6KfoQVAtYNWdoWWuoAgU2e8wvP
         b1JNpyVhx3OhWzMDxCKoDnl7Ib0SKcaHb2rf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nGoQA4PseSMoDB9HLCqlZ/CtlZ9MNnC5N8+D59h5w8o=;
        b=eBUVbJh28TgCziMAp+j6m/k/EMiYwH5103UzBEV9bcKCM5s8Uv6cyQL7yJ0cPT7ezs
         5G2o7biIb0ndv6fqRn4QQtq0E03/zQDpxj0VKx7IkW981YcE9jY24o2i1M/wP9V7OHQi
         rhY+ASLM/4pKvLbl39eM6J6rSeq2F2NgQQMH3/ZhPo2HNujy8TDIEWVJvlF177o3QT+7
         0SCVKBrbT9WAu6qoCRkVzZYKj2tD9k/GvOBp0NOOMK3GXnQXaR+Y1/RStZ2H/9jyKE3g
         B3hacSSwTHOGDTubqWNWAOo1gH7ZNzuemkOcuWs7jsT9m7L5w5QHiLFYyMU0UUMH6We4
         A9Mg==
X-Gm-Message-State: AOAM530qFecd7mtXX/bKNdIpDUx6UPzkHz69g/+qdMSfh3uIJ1LL4976
        8URAPmJLkE79EpdP+01IKWEA4A==
X-Google-Smtp-Source: ABdhPJwPUPDVAA6bhrjdmMl4qGGItt/zCCVnRl2EYeNJyvy+lZ5cwh07B5Ma0VIQ8LppwKw6p06/RQ==
X-Received: by 2002:a05:6638:2182:b0:323:a610:3eaf with SMTP id s2-20020a056638218200b00323a6103eafmr10541408jaj.204.1650991614619;
        Tue, 26 Apr 2022 09:46:54 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id u12-20020a056e02170c00b002cc27d7fe26sm8832029ill.22.2022.04.26.09.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 09:46:54 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] userfaultfd: update documentation to describe
 /dev/userfaultfd
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
Cc:     linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220422212945.2227722-1-axelrasmussen@google.com>
 <20220422212945.2227722-5-axelrasmussen@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <fc320218-bef1-c373-e6a6-afa2f6c4b56c@linuxfoundation.org>
Date:   Tue, 26 Apr 2022 10:46:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220422212945.2227722-5-axelrasmussen@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/22/22 3:29 PM, Axel Rasmussen wrote:
> Explain the different ways to create a new userfaultfd, and how access
> control works for each way.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>   Documentation/admin-guide/mm/userfaultfd.rst | 38 ++++++++++++++++++--
>   Documentation/admin-guide/sysctl/vm.rst      |  3 ++
>   2 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
> index 6528036093e1..4c079b5377d4 100644
> --- a/Documentation/admin-guide/mm/userfaultfd.rst
> +++ b/Documentation/admin-guide/mm/userfaultfd.rst
> @@ -17,7 +17,10 @@ of the ``PROT_NONE+SIGSEGV`` trick.
>   Design
>   ======
>   
> -Userfaults are delivered and resolved through the ``userfaultfd`` syscall.

Please keep this sentence in there and rephrase it to indicate how it was
done in the past.

Also explain here why this new approach is better than the syscall approach
before getting into the below details.

> +Userspace creates a new userfaultfd, initializes it, and registers one or more
> +regions of virtual memory with it. Then, any page faults which occur within the
> +region(s) result in a message being delivered to the userfaultfd, notifying
> +userspace of the fault.
>   
>   The ``userfaultfd`` (aside from registering and unregistering virtual
>   memory ranges) provides two primary functionalities:
> @@ -39,7 +42,7 @@ Vmas are not suitable for page- (or hugepage) granular fault tracking
>   when dealing with virtual address spaces that could span
>   Terabytes. Too many vmas would be needed for that.>   
> -The ``userfaultfd`` once opened by invoking the syscall, can also be
> +The ``userfaultfd``, once created, can also be

This is sentence is too short and would look odd. Combine the sentences
so it renders well in the generated doc.

>   passed using unix domain sockets to a manager process, so the same
>   manager process could handle the userfaults of a multitude of
>   different processes without them being aware about what is going on
> @@ -50,6 +53,37 @@ is a corner case that would currently return ``-EBUSY``).
>   API
>   ===
>   
> +Creating a userfaultfd
> +----------------------
> +
> +There are two mechanisms to create a userfaultfd. There are various ways to
> +restrict this too, since userfaultfds which handle kernel page faults have
> +historically been a useful tool for exploiting the kernel.
> +
> +The first is the userfaultfd(2) syscall. Access to this is controlled in several
> +ways:
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
> +Alternatively, userfaultfds can be created by opening /dev/userfaultfd, and
> +issuing a USERFAULTFD_IOC_NEW ioctl to this device. Access to this device is

New ioctl? I thought we are moving away from using ioctls?

> +controlled via normal filesystem permissions (user/group/mode for example) - no
> +additional permission (capability/sysctl) is needed to be able to handle kernel
> +faults this way. This is useful because it allows e.g. a specific user or group
> +to be able to create kernel-fault-handling userfaultfds, without allowing it
> +more broadly, or granting more privileges in addition to that particular ability
> +(CAP_SYS_PTRACE). In other words, it allows permissions to be minimized.
> +
> +Initializing up a userfaultfd
> +------------------------
> +

This will generate doc warn very likley - extend the dashes to the
entire length of the subtitle.

>   When first opened the ``userfaultfd`` must be enabled invoking the
>   ``UFFDIO_API`` ioctl specifying a ``uffdio_api.api`` value set to ``UFFD_API`` (or
>   a later API version) which will specify the ``read/POLLIN`` protocol
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index f4804ce37c58..8682d5fbc8ea 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -880,6 +880,9 @@ calls without any restrictions.
>   
>   The default value is 0.
>   
> +An alternative to this sysctl / the userfaultfd(2) syscall is to create
> +userfaultfds via /dev/userfaultfd. See
> +Documentation/admin-guide/mm/userfaultfd.rst.
>   
>   user_reserve_kbytes
>   ===================
> 

thanks,
-- Shuah
