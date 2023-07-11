Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4A874F726
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 19:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjGKRYT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 13:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbjGKRXs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:23:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319C5A6;
        Tue, 11 Jul 2023 10:23:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE24D61596;
        Tue, 11 Jul 2023 17:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D7BC433C8;
        Tue, 11 Jul 2023 17:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689096226;
        bh=zRaRZODsK04vezweUZ+H0PPfgi1k3wqQi7324zxQ/28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PZNeD789rxo/FRL8fguXIaEhIdcb3NoIGN+R9irixNbC8LsCXOFUznWzq9WmhX658
         ctLKt4COOixyfu+iv7gv3l9QC8KiJ43LdgPgDcE1w2J7wMHlQWTmN6JkCU9QtffkJi
         ofqDiuh+IIRXiX99OJNPoCjVQaYVaBtzcSdXCqRv0PuGoSZCDfIZHVpkMCK9Y2t1GI
         vvkbRprIdu8vTrPKKD7IRTCrO4yEdFk+gpmFbTGc26mgSAZvKXM3tPq/RUsz8NXAKQ
         Vua2j8OnCVr7Lflg091O7i0d7MqnHEfpV0YZTlcSdv52fPNSg3ivTTA+lEvAAClYgQ
         Rul1HsweoxsXQ==
Date:   Tue, 11 Jul 2023 19:23:24 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
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
Subject: Re: [PATCH v4 4/5] tools headers UAPI: Sync files changed by new
 fchmodat2 syscall
Message-ID: <ZK2QDCrlB/3dyiDy@example.org>
References: <cover.1689074739.git.legion@kernel.org>
 <cover.1689092120.git.legion@kernel.org>
 <22294b3b68050a70eaaa962eff46b8672bc2f7e8.1689092120.git.legion@kernel.org>
 <CAM9d7chAqGwy0WmR67TucFjRq+Aa7zQnayvwMCqd5-meVHkP5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chAqGwy0WmR67TucFjRq+Aa7zQnayvwMCqd5-meVHkP5g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 11, 2023 at 10:19:35AM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Jul 11, 2023 at 9:18 AM Alexey Gladkov <legion@kernel.org> wrote:
> >
> > From: Palmer Dabbelt <palmer@sifive.com>
> >
> > That add support for this new syscall in tools such as 'perf trace'.
> >
> > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> > Signed-off-by: Alexey Gladkov <legion@kernel.org>
> > ---
> >  tools/include/uapi/asm-generic/unistd.h             | 5 ++++-
> >  tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl | 2 ++
> >  tools/perf/arch/powerpc/entry/syscalls/syscall.tbl  | 2 ++
> >  tools/perf/arch/s390/entry/syscalls/syscall.tbl     | 2 ++
> >  tools/perf/arch/x86/entry/syscalls/syscall_64.tbl   | 2 ++
> >  5 files changed, 12 insertions(+), 1 deletion(-)
> 
> It'd be nice if you route this patch separately through the
> perf tools tree.  We can add this after the kernel change
> is accepted.

Sure. No problem.

> >
> > diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
> > index dd7d8e10f16d..76b5922b0d39 100644
> > --- a/tools/include/uapi/asm-generic/unistd.h
> > +++ b/tools/include/uapi/asm-generic/unistd.h
> > @@ -817,8 +817,11 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
> >  #define __NR_set_mempolicy_home_node 450
> >  __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
> >
> > +#define __NR_fchmodat2 452
> > +__SYSCALL(__NR_fchmodat2, sys_fchmodat2)
> > +
> >  #undef __NR_syscalls
> > -#define __NR_syscalls 451
> > +#define __NR_syscalls 453
> >
> >  /*
> >   * 32 bit systems traditionally used different
> > diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
> > index 3f1886ad9d80..434728af4eaa 100644
> > --- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
> > +++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
> > @@ -365,3 +365,5 @@
> >  448    n64     process_mrelease                sys_process_mrelease
> >  449    n64     futex_waitv                     sys_futex_waitv
> >  450    common  set_mempolicy_home_node         sys_set_mempolicy_home_node
> > +# 451 reserved for cachestat
> > +452    n64     fchmodat2                       sys_fchmodat2
> > diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> > index a0be127475b1..6b70b6705bd7 100644
> > --- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> > +++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> > @@ -537,3 +537,5 @@
> >  448    common  process_mrelease                sys_process_mrelease
> >  449    common  futex_waitv                     sys_futex_waitv
> >  450    nospu   set_mempolicy_home_node         sys_set_mempolicy_home_node
> > +# 451 reserved for cachestat
> > +452    common  fchmodat2                       sys_fchmodat2
> > diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> > index b68f47541169..0ed90c9535b0 100644
> > --- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> > +++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> > @@ -453,3 +453,5 @@
> >  448  common    process_mrelease        sys_process_mrelease            sys_process_mrelease
> >  449  common    futex_waitv             sys_futex_waitv                 sys_futex_waitv
> >  450  common    set_mempolicy_home_node sys_set_mempolicy_home_node     sys_set_mempolicy_home_node
> > +# 451 reserved for cachestat
> > +452  common    fchmodat2               sys_fchmodat2                   sys_fchmodat2
> > diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> > index c84d12608cd2..a008724a1f48 100644
> > --- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> > +++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> > @@ -372,6 +372,8 @@
> >  448    common  process_mrelease        sys_process_mrelease
> >  449    common  futex_waitv             sys_futex_waitv
> >  450    common  set_mempolicy_home_node sys_set_mempolicy_home_node
> > +# 451 reserved for cachestat
> > +452    common  fchmodat2               sys_fchmodat2
> >
> >  #
> >  # Due to a historical design error, certain syscalls are numbered differently
> > --
> > 2.33.8
> >
> 

-- 
Rgrds, legion

