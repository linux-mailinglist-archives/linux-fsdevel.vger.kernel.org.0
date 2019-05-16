Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9622077E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 15:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfEPNBu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 09:01:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38749 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbfEPNBu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 09:01:50 -0400
Received: by mail-ed1-f67.google.com with SMTP id w11so5164864edl.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 06:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r1iQciWp3rnEpgh8TpCcKJM6TDpU29RFPn+9UzuvYMQ=;
        b=ELBg28hfmTYlxXBZH3WOGlCMksiB65oW4YqMqhE9ShloqtsN5eXfI/owQnQPj6REUF
         xNqYGTR3fM75lRydGmDzmdRouMM6v1RCkbc9JgApe6Ptv4EEy9ElqsyupAvTTD6dknnn
         QSLZ7DTjqwBrjZwQBw9FcsEx5NBGFDnGlhZi330/TJ7WTPCjW/mzX8OyIX97e7ww7/eN
         HI95WQ0cpJQ1KzZplQqjGzNeZIG/ohdit3uZaiA86RaPN/nrA5d5lZIIfskxp1ZsZr/L
         TVKCMfSHzbY0E45o8SU2rFuaMrGPkugw2TDTw8gpVWy/1fttD7knKzkWRmJU8lJMzD9P
         R6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r1iQciWp3rnEpgh8TpCcKJM6TDpU29RFPn+9UzuvYMQ=;
        b=gSVKzfQdon3uFI2fqSyKZbeGsb5CkSxNNppRAwHWbP+U0AyDHukROUdx8I4+3PUke6
         529cH1LWSfiy5Tgse+7qPurOLy0XX0THIJcpU5MeEG2dLPbGLA7KJl8JxtWl0K1o1QdP
         24mrMTkQA1oC5Smee6dEimy4az3/bO1796o895EMUkGDuDsekUDmut0e0pY/JUx/Z8aR
         ljgqwOzIX1ZqWuHbGx2/hRsA37p5Ru2MmL4F0Mna5Zrh0U2BCX6d11tMPw+t0405F6Ug
         qVcj6YowThDjzHZFwwgDDSt3SBz51jxHxxF52V5n8brnIymbcF7aQOmTkl6dQV5MRANh
         Pw3Q==
X-Gm-Message-State: APjAAAVoGItzH9wRjN1NSn52tuVgjAuh3+uh8iCsaj3RDV96rJpDjIZA
        iG2KJOxGqUv76i8VJ6lNbesNyQ==
X-Google-Smtp-Source: APXvYqwmA3jQqJLRFzHQdiiYVUQe2PA79b6j7hidEBFLjxY2eph5vQoJEuid0U4gxgvJSLvNBdKucw==
X-Received: by 2002:a50:b329:: with SMTP id q38mr38179428edd.246.1558011707982;
        Thu, 16 May 2019 06:01:47 -0700 (PDT)
Received: from brauner.io ([193.96.224.243])
        by smtp.gmail.com with ESMTPSA id t25sm1080908ejx.8.2019.05.16.06.01.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 16 May 2019 06:01:46 -0700 (PDT)
Date:   Thu, 16 May 2019 15:01:45 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] uapi: Wire up the mount API syscalls on non-x86
 arches [ver #2]
Message-ID: <20190516130144.pxtwmambov2bpsup@brauner.io>
References: <155800752418.4037.9567789434648701032.stgit@warthog.procyon.org.uk>
 <155800755482.4037.14407450837395686732.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <155800755482.4037.14407450837395686732.stgit@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 12:52:34PM +0100, David Howells wrote:
> Wire up the mount API syscalls on non-x86 arches.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Christian Brauner <christian@brauner.io>

> ---
> 
>  arch/alpha/kernel/syscalls/syscall.tbl      |    6 ++++++
>  arch/arm/tools/syscall.tbl                  |    6 ++++++
>  arch/arm64/include/asm/unistd.h             |    2 +-
>  arch/arm64/include/asm/unistd32.h           |   12 ++++++++++++
>  arch/ia64/kernel/syscalls/syscall.tbl       |    6 ++++++
>  arch/m68k/kernel/syscalls/syscall.tbl       |    6 ++++++
>  arch/microblaze/kernel/syscalls/syscall.tbl |    6 ++++++
>  arch/mips/kernel/syscalls/syscall_n32.tbl   |    6 ++++++
>  arch/mips/kernel/syscalls/syscall_n64.tbl   |    6 ++++++
>  arch/mips/kernel/syscalls/syscall_o32.tbl   |    6 ++++++
>  arch/parisc/kernel/syscalls/syscall.tbl     |    6 ++++++
>  arch/powerpc/kernel/syscalls/syscall.tbl    |    6 ++++++
>  arch/s390/kernel/syscalls/syscall.tbl       |    6 ++++++
>  arch/sh/kernel/syscalls/syscall.tbl         |    6 ++++++
>  arch/sparc/kernel/syscalls/syscall.tbl      |    6 ++++++
>  arch/xtensa/kernel/syscalls/syscall.tbl     |    6 ++++++
>  include/uapi/asm-generic/unistd.h           |   14 +++++++++++++-
>  17 files changed, 110 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
> index 165f268beafc..9e7704e44f6d 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -467,3 +467,9 @@
>  535	common	io_uring_setup			sys_io_uring_setup
>  536	common	io_uring_enter			sys_io_uring_enter
>  537	common	io_uring_register		sys_io_uring_register
> +538	common	open_tree			sys_open_tree
> +539	common	move_mount			sys_move_mount
> +540	common	fsopen				sys_fsopen
> +541	common	fsconfig			sys_fsconfig
> +542	common	fsmount				sys_fsmount
> +543	common	fspick				sys_fspick
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index 0393917eaa57..aaf479a9e92d 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -441,3 +441,9 @@
>  425	common	io_uring_setup			sys_io_uring_setup
>  426	common	io_uring_enter			sys_io_uring_enter
>  427	common	io_uring_register		sys_io_uring_register
> +428	common	open_tree			sys_open_tree
> +429	common	move_mount			sys_move_mount
> +430	common	fsopen				sys_fsopen
> +431	common	fsconfig			sys_fsconfig
> +432	common	fsmount				sys_fsmount
> +433	common	fspick				sys_fspick
> diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
> index f2a83ff6b73c..70e6882853c0 100644
> --- a/arch/arm64/include/asm/unistd.h
> +++ b/arch/arm64/include/asm/unistd.h
> @@ -44,7 +44,7 @@
>  #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
>  #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
>  
> -#define __NR_compat_syscalls		428
> +#define __NR_compat_syscalls		434
>  #endif
>  
>  #define __ARCH_WANT_SYS_CLONE
> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index 23f1a44acada..c39e90600bb3 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -874,6 +874,18 @@ __SYSCALL(__NR_io_uring_setup, sys_io_uring_setup)
>  __SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
>  #define __NR_io_uring_register 427
>  __SYSCALL(__NR_io_uring_register, sys_io_uring_register)
> +#define __NR_open_tree 428
> +__SYSCALL(__NR_open_tree, sys_open_tree)
> +#define __NR_move_mount 429
> +__SYSCALL(__NR_move_mount, sys_move_mount)
> +#define __NR_fsopen 430
> +__SYSCALL(__NR_fsopen, sys_fsopen)
> +#define __NR_fsconfig 431
> +__SYSCALL(__NR_fsconfig, sys_fsconfig)
> +#define __NR_fsmount 432
> +__SYSCALL(__NR_fsmount, sys_fsmount)
> +#define __NR_fspick 433
> +__SYSCALL(__NR_fspick, sys_fspick)
>  
>  /*
>   * Please add new compat syscalls above this comment and update
> diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
> index 56e3d0b685e1..e01df3f2f80d 100644
> --- a/arch/ia64/kernel/syscalls/syscall.tbl
> +++ b/arch/ia64/kernel/syscalls/syscall.tbl
> @@ -348,3 +348,9 @@
>  425	common	io_uring_setup			sys_io_uring_setup
>  426	common	io_uring_enter			sys_io_uring_enter
>  427	common	io_uring_register		sys_io_uring_register
> +428	common	open_tree			sys_open_tree
> +429	common	move_mount			sys_move_mount
> +430	common	fsopen				sys_fsopen
> +431	common	fsconfig			sys_fsconfig
> +432	common	fsmount				sys_fsmount
> +433	common	fspick				sys_fspick
> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
> index df4ec3ec71d1..7e3d0734b2f3 100644
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -427,3 +427,9 @@
>  425	common	io_uring_setup			sys_io_uring_setup
>  426	common	io_uring_enter			sys_io_uring_enter
>  427	common	io_uring_register		sys_io_uring_register
> +428	common	open_tree			sys_open_tree
> +429	common	move_mount			sys_move_mount
> +430	common	fsopen				sys_fsopen
> +431	common	fsconfig			sys_fsconfig
> +432	common	fsmount				sys_fsmount
> +433	common	fspick				sys_fspick
> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
> index 4964947732af..26339e417695 100644
> --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> @@ -433,3 +433,9 @@
>  425	common	io_uring_setup			sys_io_uring_setup
>  426	common	io_uring_enter			sys_io_uring_enter
>  427	common	io_uring_register		sys_io_uring_register
> +428	common	open_tree			sys_open_tree
> +429	common	move_mount			sys_move_mount
> +430	common	fsopen				sys_fsopen
> +431	common	fsconfig			sys_fsconfig
> +432	common	fsmount				sys_fsmount
> +433	common	fspick				sys_fspick
> diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
> index 9392dfe33f97..0e2dd68ade57 100644
> --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> @@ -366,3 +366,9 @@
>  425	n32	io_uring_setup			sys_io_uring_setup
>  426	n32	io_uring_enter			sys_io_uring_enter
>  427	n32	io_uring_register		sys_io_uring_register
> +428	n32	open_tree			sys_open_tree
> +429	n32	move_mount			sys_move_mount
> +430	n32	fsopen				sys_fsopen
> +431	n32	fsconfig			sys_fsconfig
> +432	n32	fsmount				sys_fsmount
> +433	n32	fspick				sys_fspick
> diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
> index cd0c8aa21fba..5eebfa0d155c 100644
> --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> @@ -342,3 +342,9 @@
>  425	n64	io_uring_setup			sys_io_uring_setup
>  426	n64	io_uring_enter			sys_io_uring_enter
>  427	n64	io_uring_register		sys_io_uring_register
> +428	n64	open_tree			sys_open_tree
> +429	n64	move_mount			sys_move_mount
> +430	n64	fsopen				sys_fsopen
> +431	n64	fsconfig			sys_fsconfig
> +432	n64	fsmount				sys_fsmount
> +433	n64	fspick				sys_fspick
> diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
> index e849e8ffe4a2..3cc1374e02d0 100644
> --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> @@ -415,3 +415,9 @@
>  425	o32	io_uring_setup			sys_io_uring_setup
>  426	o32	io_uring_enter			sys_io_uring_enter
>  427	o32	io_uring_register		sys_io_uring_register
> +428	o32	open_tree			sys_open_tree
> +429	o32	move_mount			sys_move_mount
> +430	o32	fsopen				sys_fsopen
> +431	o32	fsconfig			sys_fsconfig
> +432	o32	fsmount				sys_fsmount
> +433	o32	fspick				sys_fspick
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> index fe8ca623add8..c9e377d59232 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -424,3 +424,9 @@
>  425	common	io_uring_setup			sys_io_uring_setup
>  426	common	io_uring_enter			sys_io_uring_enter
>  427	common	io_uring_register		sys_io_uring_register
> +428	common	open_tree			sys_open_tree
> +429	common	move_mount			sys_move_mount
> +430	common	fsopen				sys_fsopen
> +431	common	fsconfig			sys_fsconfig
> +432	common	fsmount				sys_fsmount
> +433	common	fspick				sys_fspick
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index 00f5a63c8d9a..103655d84b4b 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -509,3 +509,9 @@
>  425	common	io_uring_setup			sys_io_uring_setup
>  426	common	io_uring_enter			sys_io_uring_enter
>  427	common	io_uring_register		sys_io_uring_register
> +428	common	open_tree			sys_open_tree
> +429	common	move_mount			sys_move_mount
> +430	common	fsopen				sys_fsopen
> +431	common	fsconfig			sys_fsconfig
> +432	common	fsmount				sys_fsmount
> +433	common	fspick				sys_fspick
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index 061418f787c3..e822b2964a83 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -430,3 +430,9 @@
>  425  common	io_uring_setup		sys_io_uring_setup              sys_io_uring_setup
>  426  common	io_uring_enter		sys_io_uring_enter              sys_io_uring_enter
>  427  common	io_uring_register	sys_io_uring_register           sys_io_uring_register
> +428  common	open_tree		sys_open_tree			sys_open_tree
> +429  common	move_mount		sys_move_mount			sys_move_mount
> +430  common	fsopen			sys_fsopen			sys_fsopen
> +431  common	fsconfig		sys_fsconfig			sys_fsconfig
> +432  common	fsmount			sys_fsmount			sys_fsmount
> +433  common	fspick			sys_fspick			sys_fspick
> diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
> index 480b057556ee..016a727d4357 100644
> --- a/arch/sh/kernel/syscalls/syscall.tbl
> +++ b/arch/sh/kernel/syscalls/syscall.tbl
> @@ -430,3 +430,9 @@
>  425	common	io_uring_setup			sys_io_uring_setup
>  426	common	io_uring_enter			sys_io_uring_enter
>  427	common	io_uring_register		sys_io_uring_register
> +428	common	open_tree			sys_open_tree
> +429	common	move_mount			sys_move_mount
> +430	common	fsopen				sys_fsopen
> +431	common	fsconfig			sys_fsconfig
> +432	common	fsmount				sys_fsmount
> +433	common	fspick				sys_fspick
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> index a1dd24307b00..e047480b1605 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -473,3 +473,9 @@
>  425	common	io_uring_setup			sys_io_uring_setup
>  426	common	io_uring_enter			sys_io_uring_enter
>  427	common	io_uring_register		sys_io_uring_register
> +428	common	open_tree			sys_open_tree
> +429	common	move_mount			sys_move_mount
> +430	common	fsopen				sys_fsopen
> +431	common	fsconfig			sys_fsconfig
> +432	common	fsmount				sys_fsmount
> +433	common	fspick				sys_fspick
> diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
> index 30084eaf8422..5fa0ee1c8e00 100644
> --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> @@ -398,3 +398,9 @@
>  425	common	io_uring_setup			sys_io_uring_setup
>  426	common	io_uring_enter			sys_io_uring_enter
>  427	common	io_uring_register		sys_io_uring_register
> +428	common	open_tree			sys_open_tree
> +429	common	move_mount			sys_move_mount
> +430	common	fsopen				sys_fsopen
> +431	common	fsconfig			sys_fsconfig
> +432	common	fsmount				sys_fsmount
> +433	common	fspick				sys_fspick
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index dee7292e1df6..a87904daf103 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -832,9 +832,21 @@ __SYSCALL(__NR_io_uring_setup, sys_io_uring_setup)
>  __SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
>  #define __NR_io_uring_register 427
>  __SYSCALL(__NR_io_uring_register, sys_io_uring_register)
> +#define __NR_open_tree 428
> +__SYSCALL(__NR_open_tree, sys_open_tree)
> +#define __NR_move_mount 429
> +__SYSCALL(__NR_move_mount, sys_move_mount)
> +#define __NR_fsopen 430
> +__SYSCALL(__NR_fsopen, sys_fsopen)
> +#define __NR_fsconfig 431
> +__SYSCALL(__NR_fsconfig, sys_fsconfig)
> +#define __NR_fsmount 432
> +__SYSCALL(__NR_fsmount, sys_fsmount)
> +#define __NR_fspick 433
> +__SYSCALL(__NR_fspick, sys_fspick)
>  
>  #undef __NR_syscalls
> -#define __NR_syscalls 428
> +#define __NR_syscalls 434
>  
>  /*
>   * 32 bit systems traditionally used different
> 
