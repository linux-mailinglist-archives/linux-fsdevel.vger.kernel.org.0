Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEDEA1680C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 15:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgBUOvW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 09:51:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55426 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgBUOvW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:51:22 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j59e6-0006ov-S2; Fri, 21 Feb 2020 14:51:14 +0000
Date:   Fri, 21 Feb 2020 15:51:14 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/19] fsinfo: Add syscalls to other arches [ver #16]
Message-ID: <20200221145114.satmwy7u6mqfluzs@wittgenstein>
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
 <158204551308.3299825.11782813238111590104.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <158204551308.3299825.11782813238111590104.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 05:05:13PM +0000, David Howells wrote:
> Add the fsinfo syscall to the other arches.

Over the last couple of kernel releases we have established the
convention that we wire-up a syscall for all arches at the same time and
not e.g. x86 and then the other separately.

> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  arch/alpha/kernel/syscalls/syscall.tbl      |    1 +
>  arch/arm/tools/syscall.tbl                  |    1 +
>  arch/arm64/include/asm/unistd.h             |    2 +-
>  arch/arm64/include/asm/unistd32.h           |    2 +-
>  arch/ia64/kernel/syscalls/syscall.tbl       |    1 +
>  arch/m68k/kernel/syscalls/syscall.tbl       |    2 ++
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
>  16 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
> index 36d42da7466a..961750417ef2 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -477,3 +477,4 @@
>  # 545 reserved for clone3
>  547	common	openat2				sys_openat2
>  548	common	pidfd_getfd			sys_pidfd_getfd
> +549	common	fsinfo				sys_fsinfo
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index 4d1cf74a2caa..e6b9dfe01471 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -451,3 +451,4 @@
>  435	common	clone3				sys_clone3
>  437	common	openat2				sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
> +439	common	fsinfo				sys_fsinfo
> diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
> index 1dd22da1c3a9..75f04a1023be 100644
> --- a/arch/arm64/include/asm/unistd.h
> +++ b/arch/arm64/include/asm/unistd.h
> @@ -38,7 +38,7 @@
>  #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
>  #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
>  
> -#define __NR_compat_syscalls		439
> +#define __NR_compat_syscalls		440
>  #endif
>  
>  #define __ARCH_WANT_SYS_CLONE
> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index c1c61635f89c..7d1225de47e6 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -873,7 +873,7 @@ __SYSCALL(__NR_fsopen, sys_fsopen)
>  __SYSCALL(__NR_fsconfig, sys_fsconfig)
>  #define __NR_fsmount 432
>  __SYSCALL(__NR_fsmount, sys_fsmount)
> -#define __NR_fspick 433
> +#define __NR_fspick 434
>  __SYSCALL(__NR_fspick, sys_fspick)
>  #define __NR_pidfd_open 434
>  __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
> diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
> index 042911e670b8..9018a3a6b067 100644
> --- a/arch/ia64/kernel/syscalls/syscall.tbl
> +++ b/arch/ia64/kernel/syscalls/syscall.tbl
> @@ -358,3 +358,4 @@
>  # 435 reserved for clone3
>  437	common	openat2				sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
> +439	common	fsinfo				sys_fsinfo
> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
> index f4f49fcb76d0..10172bb6ba1f 100644
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -437,3 +437,5 @@
>  435	common	clone3				__sys_clone3
>  437	common	openat2				sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
> +# 435 reserved for clone3
> +439	common	fsinfo				sys_fsinfo
> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
> index 4c67b11f9c9e..58665073c1f0 100644
> --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> @@ -443,3 +443,4 @@
>  435	common	clone3				sys_clone3
>  437	common	openat2				sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
> +439	common	fsinfo				sys_fsinfo
> diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
> index 1f9e8ad636cc..1f07a89473c3 100644
> --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> @@ -376,3 +376,4 @@
>  435	n32	clone3				__sys_clone3
>  437	n32	openat2				sys_openat2
>  438	n32	pidfd_getfd			sys_pidfd_getfd
> +439	n32	fsinfo				sys_fsinfo
> diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
> index c0b9d802dbf6..3c853ca54901 100644
> --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> @@ -352,3 +352,4 @@
>  435	n64	clone3				__sys_clone3
>  437	n64	openat2				sys_openat2
>  438	n64	pidfd_getfd			sys_pidfd_getfd
> +439	n64	fsinfo				sys_fsinfo
> diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
> index ac586774c980..727f54542bf4 100644
> --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> @@ -425,3 +425,4 @@
>  435	o32	clone3				__sys_clone3
>  437	o32	openat2				sys_openat2
>  438	o32	pidfd_getfd			sys_pidfd_getfd
> +439	o32	fsinfo				sys_fsinfo
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> index 52a15f5cd130..2e9576638d80 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -435,3 +435,4 @@
>  435	common	clone3				sys_clone3_wrapper
>  437	common	openat2				sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
> +439	common	fsinfo				sys_fsinfo
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index 35b61bfc1b1a..397190734ca7 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -519,3 +519,4 @@
>  435	nospu	clone3				ppc_clone3
>  437	common	openat2				sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
> +439	common	fsinfo				sys_fsinfo
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index bd7bd3581a0f..e9340d712dcd 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -440,3 +440,4 @@
>  435  common	clone3			sys_clone3			sys_clone3
>  437  common	openat2			sys_openat2			sys_openat2
>  438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
> +439  common	fsinfo			sys_fsinfo			sys_fsinfo
> diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
> index c7a30fcd135f..7bb5ec284fbb 100644
> --- a/arch/sh/kernel/syscalls/syscall.tbl
> +++ b/arch/sh/kernel/syscalls/syscall.tbl
> @@ -440,3 +440,4 @@
>  # 435 reserved for clone3
>  437	common	openat2				sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
> +439	common	fsinfo				sys_fsinfo
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> index f13615ecdecc..a902b757ace2 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -483,3 +483,4 @@
>  # 435 reserved for clone3
>  437	common	openat2			sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
> +439	common	fsinfo				sys_fsinfo
> diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
> index 85a9ab1bc04d..f82702a7ab38 100644
> --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> @@ -408,3 +408,4 @@
>  435	common	clone3				sys_clone3
>  437	common	openat2				sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd
> +439	common	fsinfo				sys_fsinfo
> 
> 
