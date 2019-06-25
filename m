Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA7C5281F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 11:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbfFYJbp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 05:31:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38836 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbfFYJbm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:31:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so17045175wrs.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2019 02:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Toj+LJIB4PKggH1iYkdWD6WYjNSZkZdJZmfKxIdgNOM=;
        b=biXWqakyslc/OXZwQ+Upfk9PMvx5lMCOSMIB9fOiT62/BwStJIEMD8hhIZj64MC0iE
         R+eAmt4ZBd4HuMpLGKvl8S1MyHBeUXhkemkQPn4vbEzZkbQg9NB89HDEsZfolFZoSwQM
         kq7QCAlLW1Zsar5w4f6WMp6HbV2Lez1WCwh9/MdwukTSm4jTDcCJGDi0R3j0192Rrlu1
         44Yqs6Prjl0MKH9QYjBdWb9s1g/bnJYImDb8HU8SqasCKChi/efEoWsGE/FLjEgGi3k2
         WGBCIlsap9oBn2dTHFkdkLFb0ijKBsJHiyG3srWMby0xQf1hMq+CirMTZJhYCegyludE
         NEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Toj+LJIB4PKggH1iYkdWD6WYjNSZkZdJZmfKxIdgNOM=;
        b=ulFQD6QQcUALEe/cxFWdH/MGlm0Bo3hKQzHhlv5zkCP/xhY2TIuz+Tusznnr+OfvYX
         BR+NhZtoCk9WfKIN2taIcJk0jqYK0xlL5+hUw3BudnQcJj0T8Fn2nAwDzs1NKSEKXJb8
         rb7y3JDb9A6OVNSiAzqssexwXtC7nX4PuIhs5NQ2Wzwgi5nHfGbbP2UvBtt6Qo9M4I1J
         ZMB8YPPz9coqcb7PZ5j3EDWekqVoLOHQ/q2j7MU1BcgDSpg4FzjN3Q9LH4sPhzMHHnbQ
         zAfyOfJZXDrvpCJi4woXBbuPoiAux73/wvPgUAaYwr9oK067Qg+Sl0KsVZwNXU5+gMvN
         VmWA==
X-Gm-Message-State: APjAAAWIS9sb8EBb7WL0gGx4KE7voqOs64g41u9oUZ8NcS/X4EljSbUa
        zkiEUKGQqHqcbZNRNuAjPRy/7Q==
X-Google-Smtp-Source: APXvYqx3pLQItdPselIyeEnN0nT5U01EEfJwpGcin9np6Y2GdTYDM+GrxpQmsENZMBQMi4hmSOPOqw==
X-Received: by 2002:a5d:4489:: with SMTP id j9mr70765943wrq.15.1561455098468;
        Tue, 25 Jun 2019 02:31:38 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id f2sm19221175wrq.48.2019.06.25.02.31.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 02:31:37 -0700 (PDT)
Date:   Tue, 25 Jun 2019 11:31:37 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/25] fsinfo: Add syscalls to other arches [ver #14]
Message-ID: <20190625093136.rxljcdgruca37cuh@brauner.io>
References: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
 <156138534520.25627.6299627770679918852.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <156138534520.25627.6299627770679918852.stgit@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 03:09:05PM +0100, David Howells wrote:
> Add the fsinfo syscall to the other arches.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  arch/alpha/kernel/syscalls/syscall.tbl      |    1 +
>  arch/arm/tools/syscall.tbl                  |    1 +
>  arch/arm64/include/asm/unistd.h             |    2 +-

I think you missed

arch/arm64/include/asm/unistd32.h

?

>  arch/ia64/kernel/syscalls/syscall.tbl       |    1 +
>  arch/m68k/kernel/syscalls/syscall.tbl       |    1 +
>  arch/microblaze/kernel/syscalls/syscall.tbl |    1 +
>  arch/mips/kernel/syscalls/syscall_n32.tbl   |    1 +
>  arch/mips/kernel/syscalls/syscall_n64.tbl   |    1 +
>  arch/mips/kernel/syscalls/syscall_o32.tbl   |    1 +
>  arch/parisc/kernel/syscalls/syscall.tbl     |    1 +
>  arch/powerpc/kernel/syscalls/syscall.tbl    |    1 +
>  arch/s390/kernel/syscalls/syscall.tbl       |    1 +
>  arch/sh/kernel/syscalls/syscall.tbl         |    1 +
>  arch/sparc/kernel/syscalls/syscall.tbl      |    1 +
>  arch/xtensa/kernel/syscalls/syscall.tbl     |    1 +
>  15 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
> index 9e7704e44f6d..624d01c3c8eb 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -473,3 +473,4 @@
>  541	common	fsconfig			sys_fsconfig
>  542	common	fsmount				sys_fsmount
>  543	common	fspick				sys_fspick
> +544	common	fsinfo				sys_fsinfo
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index aaf479a9e92d..ad608b49808c 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -447,3 +447,4 @@
>  431	common	fsconfig			sys_fsconfig
>  432	common	fsmount				sys_fsmount
>  433	common	fspick				sys_fspick
> +434	common	fsinfo				sys_fsinfo
> diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
> index 70e6882853c0..e8f7d95a1481 100644
> --- a/arch/arm64/include/asm/unistd.h
> +++ b/arch/arm64/include/asm/unistd.h
> @@ -44,7 +44,7 @@
>  #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
>  #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
>  
> -#define __NR_compat_syscalls		434
> +#define __NR_compat_syscalls		435
>  #endif
>  
>  #define __ARCH_WANT_SYS_CLONE
> diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
> index e01df3f2f80d..68314763ad16 100644
> --- a/arch/ia64/kernel/syscalls/syscall.tbl
> +++ b/arch/ia64/kernel/syscalls/syscall.tbl
> @@ -354,3 +354,4 @@
>  431	common	fsconfig			sys_fsconfig
>  432	common	fsmount				sys_fsmount
>  433	common	fspick				sys_fspick
> +434	common	fsinfo				sys_fsinfo
> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
> index 7e3d0734b2f3..ee73a7534b1b 100644
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -433,3 +433,4 @@
>  431	common	fsconfig			sys_fsconfig
>  432	common	fsmount				sys_fsmount
>  433	common	fspick				sys_fspick
> +434	common	fsinfo				sys_fsinfo
> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
> index 26339e417695..7bc067f4b713 100644
> --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> @@ -439,3 +439,4 @@
>  431	common	fsconfig			sys_fsconfig
>  432	common	fsmount				sys_fsmount
>  433	common	fspick				sys_fspick
> +434	common	fsinfo				sys_fsinfo
> diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
> index 0e2dd68ade57..29b76bd67cc0 100644
> --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> @@ -372,3 +372,4 @@
>  431	n32	fsconfig			sys_fsconfig
>  432	n32	fsmount				sys_fsmount
>  433	n32	fspick				sys_fspick
> +434	n32	fsinfo				sys_fsinfo
> diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
> index 5eebfa0d155c..349fb30bb8b5 100644
> --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> @@ -348,3 +348,4 @@
>  431	n64	fsconfig			sys_fsconfig
>  432	n64	fsmount				sys_fsmount
>  433	n64	fspick				sys_fspick
> +434	n64	fsinfo				sys_fsinfo
> diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
> index 3cc1374e02d0..71057426b503 100644
> --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> @@ -421,3 +421,4 @@
>  431	o32	fsconfig			sys_fsconfig
>  432	o32	fsmount				sys_fsmount
>  433	o32	fspick				sys_fspick
> +434	o32	fsinfo				sys_fsinfo
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> index c9e377d59232..32cff48a1ebd 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -430,3 +430,4 @@
>  431	common	fsconfig			sys_fsconfig
>  432	common	fsmount				sys_fsmount
>  433	common	fspick				sys_fspick
> +434	common	fsinfo				sys_fsinfo
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index 103655d84b4b..e5755eb6fb84 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -515,3 +515,4 @@
>  431	common	fsconfig			sys_fsconfig
>  432	common	fsmount				sys_fsmount
>  433	common	fspick				sys_fspick
> +434	common	fsinfo				sys_fsinfo
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index e822b2964a83..bcd54116e107 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -436,3 +436,4 @@
>  431  common	fsconfig		sys_fsconfig			sys_fsconfig
>  432  common	fsmount			sys_fsmount			sys_fsmount
>  433  common	fspick			sys_fspick			sys_fspick
> +434	common	fsinfo			sys_fsinfo			sys_fsinfo
> diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
> index 016a727d4357..0320a5c63cbd 100644
> --- a/arch/sh/kernel/syscalls/syscall.tbl
> +++ b/arch/sh/kernel/syscalls/syscall.tbl
> @@ -436,3 +436,4 @@
>  431	common	fsconfig			sys_fsconfig
>  432	common	fsmount				sys_fsmount
>  433	common	fspick				sys_fspick
> +434	common	fsinfo				sys_fsinfo
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> index e047480b1605..f81b1f9402bd 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -479,3 +479,4 @@
>  431	common	fsconfig			sys_fsconfig
>  432	common	fsmount				sys_fsmount
>  433	common	fspick				sys_fspick
> +434	common	fsinfo				sys_fsinfo
> diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
> index 5fa0ee1c8e00..729795148850 100644
> --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> @@ -404,3 +404,4 @@
>  431	common	fsconfig			sys_fsconfig
>  432	common	fsmount				sys_fsmount
>  433	common	fspick				sys_fspick
> +434	common	fsinfo				sys_fsinfo
> 
