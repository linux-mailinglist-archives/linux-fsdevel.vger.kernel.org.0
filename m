Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E127A667E50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 19:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjALSoj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 13:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240565AbjALSn3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:43:29 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FD6395C1;
        Thu, 12 Jan 2023 10:15:52 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id c6so21043552pls.4;
        Thu, 12 Jan 2023 10:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h5xmPZZpsxDAD9C0zb1qoc3jWG8cLDMF9uzRrIE8Z5M=;
        b=MsGsIJV8PkuLfxxK8ujOQj7unxBCu9ywEW8jKUhdVpMH73qzuPv4h7p41McWreWoZd
         asynsJi8kUZBCW0+5RfYTMXLTR6M/2w+XAQ+TTCxrGug5FTUJ77R9cn4oIjTdhKVXKA5
         FVXXaGt5KONFBgybjCZPtRSDrr7vutoK7TLjocf+bibhyRB4vbq48ORnuGt/bCHK5eHB
         XYSTVOKTG8FMxAEKtSvL4rAurD1vGNZTW76scNYLMhyvbYI/0GweCDeCcmQM/p5GJ7Ym
         IaR5Q9P0ZqKehNxRkI+bVwoVcPsMfx6y0hjJPXOdq8pJgt6s2NU2f+fnfX6MzjqOjiwh
         L5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5xmPZZpsxDAD9C0zb1qoc3jWG8cLDMF9uzRrIE8Z5M=;
        b=sQcOG7cCQVV676LOMvA3OQP7uODEj7EPWo7kggdC6uSXUictxrDZGckbHSl3SRLPcd
         2mC+2SA1aaEofLrPptZ4XedwmYdR+swgCdWZBGsojRohhbudOwq4c5iQmLwtyZGyNzSv
         cOyEpPZsYzXvT6dndsqRMerBVWhmepI3gkByujE0m647I+wQUM50+81nIDHywgblIwY1
         ILbpjsl+o0cogBuJuWI8BJ3Mjey2VVKArPhbfMBLhc9P4kp6g8R3CYf/RYtjKg+JLM5O
         qvm5WytXJaWI/14yUlBn3JV64O+DMK7B2GvOhk0zIhTYq0nBb0XldQaNLnaUPOtzZhDM
         iFfw==
X-Gm-Message-State: AFqh2kqYHwsi8+0EmwxNSFM9m0rIZ9NBNFWxOLkR9zjBLlR/sEiCE7rG
        m9n55WQWr+oPzKiHEGp6V9sx+5cBxen8hA==
X-Google-Smtp-Source: AMrXdXt69GN1hSct/IKzxuRgchaNHMLJQEClNzRhc2AS9lIY4IF9PDrYBXlHnT8aRcMLEtJzykTLww==
X-Received: by 2002:a05:6a20:d39a:b0:9d:efbf:6618 with SMTP id iq26-20020a056a20d39a00b0009defbf6618mr93924412pzb.38.1673547342253;
        Thu, 12 Jan 2023 10:15:42 -0800 (PST)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id b5-20020a630c05000000b00477def759cbsm10397806pgl.58.2023.01.12.10.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 10:15:41 -0800 (PST)
Date:   Thu, 12 Jan 2023 10:15:39 -0800
From:   Andrei Vagin <avagin@gmail.com>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
        oleg@redhat.com, peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH 3/3] prctl,syscall_user_dispatch: add a getter for
 configuration info
Message-ID: <Y8BOSwkISphWtEQ5@gmail.com>
References: <20230109153348.5625-1-gregory.price@memverge.com>
 <20230109153348.5625-4-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20230109153348.5625-4-gregory.price@memverge.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 09, 2023 at 10:33:48AM -0500, Gregory Price wrote:
> This patch implements simple getter interface for syscall user dispatch
> configuration info.
> 
> To support checkpoint/resume of a syscall user dispatch process,
> the prctl settings for syscall user dispatch must be fetchable.
> Presently, these settings are write-only, making it impossible to
> implement transparent checkpoint (coordination with the software is
> required).
> 
> As Syscall User Dispatch is explicitly not for secure-container
> development, exposing the configuration state via prctl does not
> violate the original design intent.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> ---
>  .../admin-guide/syscall-user-dispatch.rst     | 18 +++++++
>  include/linux/syscall_user_dispatch.h         |  7 +++
>  include/uapi/linux/prctl.h                    |  3 ++
>  kernel/entry/syscall_user_dispatch.c          | 14 +++++
>  kernel/sys.c                                  |  4 ++
>  .../syscall_user_dispatch/sud_test.c          | 54 +++++++++++++++++++
>  6 files changed, 100 insertions(+)
> 
> diff --git a/Documentation/admin-guide/syscall-user-dispatch.rst b/Documentation/admin-guide/syscall-user-dispatch.rst
> index 60314953c728..8b2c8b6441b7 100644
> --- a/Documentation/admin-guide/syscall-user-dispatch.rst
> +++ b/Documentation/admin-guide/syscall-user-dispatch.rst
> @@ -45,6 +45,10 @@ only the syscall dispatcher address and the userspace key.
>  As the ABI of these intercepted syscalls is unknown to Linux, these
>  syscalls are not instrumentable via ptrace or the syscall tracepoints.
>  
> +A getter interface is supplied for the purpose of userland
> +checkpoint/restore software being able to suspend and restore the
> +current state of the system.
> +
>  Interface
>  ---------
>  
> @@ -73,6 +77,20 @@ thread-wide, without the need to invoke the kernel directly.  selector
>  can be set to SYSCALL_DISPATCH_FILTER_ALLOW or SYSCALL_DISPATCH_FILTER_BLOCK.
>  Any other value should terminate the program with a SIGSYS.
>  
> +
> +A thread can fetch the current Syscall User Dispatch configuration with the following prctl:
> +
> +  prctl(PR_GET_SYSCALL_USER_DISPATCH, <dispatch_config>))
> +
> +<dispatch_config> is a pointer to a ``struct syscall_user_dispatch`` as defined in ``linux/include/linux/syscall_user_dispatch.h``::

syscall_user_dispatch.h isn't a part of uapi, so I am not sure that it
is a good idea to use it here.

For criu, it is much more convinient to have a ptrace interface to get
this sort of parameters. prctl requires to execute a system call from a
context of the target process. It is tricky so we want to minimize a
number of such calls.

Thanks,
Andrei
