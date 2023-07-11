Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAAF74F6F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 19:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjGKRVF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 13:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjGKRVC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:21:02 -0400
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2FB2128;
        Tue, 11 Jul 2023 10:20:12 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-47e96ddc863so3763980e0c.0;
        Tue, 11 Jul 2023 10:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689095988; x=1691687988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1E8sshrAsRaTXfo6weNCw3VfVLbTLnqtK1Z13Sm9Os=;
        b=JioxtvJ6bGiiSrfyFO8yP95NKTiLWcFvzOWMbT8bEtMqGkxvChQOSMILPx93uC8NYs
         F91lEmKpQFfBp5FsSU7fIfmiIRnZ46Rj/GyghlglyO+eAJ936xDBT66t2t3+jn7//Jrj
         sWgTHs0cErJhkqlFEubYEr5ITUbxxy78A6Q4cyiA7vn7Lg29hwuuvq2P7Lfy2Uu2g27w
         fOYyEVYRnZbxE1DJxDtISdd4VFF2LemFOsLUsQT8s70pqAA1cH2ZCYPMT+o8QSQLYkoG
         xjqQY0rSgYgTGJ7JDPjQlwfR0mncvli6Q5GJw461aJUSrQ8ply3KJx8xMS9tIz2M++bU
         8YaA==
X-Gm-Message-State: ABy/qLYF0d6IYekG7CsRApXaL+g1v7yOrNS2T/MyG59N5U/MNV5Bu1r7
        PUnm9DfOCaJk1qzs0/AeLxWkyURnj8AUIvjY+xk=
X-Google-Smtp-Source: APBJJlHvjqSOXNmdmDvle0026k90GDtUYnPqvi6JX9yQULKCWL0XAYOjkAe7gIe04qveWs0x8fU9K4aaoqcGOl9T0Z0=
X-Received: by 2002:a05:6122:d15:b0:47a:e101:b25 with SMTP id
 az21-20020a0561220d1500b0047ae1010b25mr6414180vkb.3.1689095987477; Tue, 11
 Jul 2023 10:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689074739.git.legion@kernel.org> <cover.1689092120.git.legion@kernel.org>
 <22294b3b68050a70eaaa962eff46b8672bc2f7e8.1689092120.git.legion@kernel.org>
In-Reply-To: <22294b3b68050a70eaaa962eff46b8672bc2f7e8.1689092120.git.legion@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 11 Jul 2023 10:19:35 -0700
Message-ID: <CAM9d7chAqGwy0WmR67TucFjRq+Aa7zQnayvwMCqd5-meVHkP5g@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] tools headers UAPI: Sync files changed by new
 fchmodat2 syscall
To:     Alexey Gladkov <legion@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Palmer Dabbelt <palmer@sifive.com>,
        James.Bottomley@hansenpartnership.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, axboe@kernel.dk,
        benh@kernel.crashing.org, borntraeger@de.ibm.com, bp@alien8.de,
        catalin.marinas@arm.com, christian@brauner.io, dalias@libc.org,
        davem@davemloft.net, deepa.kernel@gmail.com, deller@gmx.de,
        dhowells@redhat.com, fenghua.yu@intel.com, fweimer@redhat.com,
        geert@linux-m68k.org, glebfm@altlinux.org, gor@linux.ibm.com,
        hare@suse.com, hpa@zytor.com, ink@jurassic.park.msu.ru,
        jhogan@kernel.org, kim.phillips@arm.com, ldv@altlinux.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux@armlinux.org.uk, linuxppc-dev@lists.ozlabs.org,
        luto@kernel.org, mattst88@gmail.com, mingo@redhat.com,
        monstr@monstr.eu, mpe@ellerman.id.au, paulus@samba.org,
        peterz@infradead.org, ralf@linux-mips.org,
        sparclinux@vger.kernel.org, stefan@agner.ch, tglx@linutronix.de,
        tony.luck@intel.com, tycho@tycho.ws, will@kernel.org,
        x86@kernel.org, ysato@users.sourceforge.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Tue, Jul 11, 2023 at 9:18 AM Alexey Gladkov <legion@kernel.org> wrote:
>
> From: Palmer Dabbelt <palmer@sifive.com>
>
> That add support for this new syscall in tools such as 'perf trace'.
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> ---
>  tools/include/uapi/asm-generic/unistd.h             | 5 ++++-
>  tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl | 2 ++
>  tools/perf/arch/powerpc/entry/syscalls/syscall.tbl  | 2 ++
>  tools/perf/arch/s390/entry/syscalls/syscall.tbl     | 2 ++
>  tools/perf/arch/x86/entry/syscalls/syscall_64.tbl   | 2 ++
>  5 files changed, 12 insertions(+), 1 deletion(-)

It'd be nice if you route this patch separately through the
perf tools tree.  We can add this after the kernel change
is accepted.

Thanks,
Namhyung


>
> diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
> index dd7d8e10f16d..76b5922b0d39 100644
> --- a/tools/include/uapi/asm-generic/unistd.h
> +++ b/tools/include/uapi/asm-generic/unistd.h
> @@ -817,8 +817,11 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
>  #define __NR_set_mempolicy_home_node 450
>  __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
>
> +#define __NR_fchmodat2 452
> +__SYSCALL(__NR_fchmodat2, sys_fchmodat2)
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 451
> +#define __NR_syscalls 453
>
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
> index 3f1886ad9d80..434728af4eaa 100644
> --- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
> +++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
> @@ -365,3 +365,5 @@
>  448    n64     process_mrelease                sys_process_mrelease
>  449    n64     futex_waitv                     sys_futex_waitv
>  450    common  set_mempolicy_home_node         sys_set_mempolicy_home_node
> +# 451 reserved for cachestat
> +452    n64     fchmodat2                       sys_fchmodat2
> diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> index a0be127475b1..6b70b6705bd7 100644
> --- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> +++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> @@ -537,3 +537,5 @@
>  448    common  process_mrelease                sys_process_mrelease
>  449    common  futex_waitv                     sys_futex_waitv
>  450    nospu   set_mempolicy_home_node         sys_set_mempolicy_home_node
> +# 451 reserved for cachestat
> +452    common  fchmodat2                       sys_fchmodat2
> diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> index b68f47541169..0ed90c9535b0 100644
> --- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> +++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> @@ -453,3 +453,5 @@
>  448  common    process_mrelease        sys_process_mrelease            sys_process_mrelease
>  449  common    futex_waitv             sys_futex_waitv                 sys_futex_waitv
>  450  common    set_mempolicy_home_node sys_set_mempolicy_home_node     sys_set_mempolicy_home_node
> +# 451 reserved for cachestat
> +452  common    fchmodat2               sys_fchmodat2                   sys_fchmodat2
> diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> index c84d12608cd2..a008724a1f48 100644
> --- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -372,6 +372,8 @@
>  448    common  process_mrelease        sys_process_mrelease
>  449    common  futex_waitv             sys_futex_waitv
>  450    common  set_mempolicy_home_node sys_set_mempolicy_home_node
> +# 451 reserved for cachestat
> +452    common  fchmodat2               sys_fchmodat2
>
>  #
>  # Due to a historical design error, certain syscalls are numbered differently
> --
> 2.33.8
>
