Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5213E4B33B7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Feb 2022 09:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbiBLIHb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Feb 2022 03:07:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiBLIHa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Feb 2022 03:07:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44B426AEF;
        Sat, 12 Feb 2022 00:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iHhueysbCF7cZjZhCX5TgtZT8UQe1Vger0YteybGiHM=; b=KZ7FrHGXWuM3vnsfygdkKvajuH
        HuXE9S5PDDVjtgv6hUCvHtMGYSY+2zIHQcfSewF1XUBn+bHq43Ke6pLvf2GXejVcdNm1FRlkezyfX
        L6rzJ8TapkKwrrt03ZG6XcJlXdM5kdTGaiMtsUX2Gv8fmwuga3U4UZ47wxOauG4dbJ9jsYe2M1CEm
        1L+LaBoGdG4As0KICqso/EpU/rIyRtgCJPjBwCHs0nOdx7IHLngoXektapvUKMgUgcUSHCFl2D/2z
        TsBjmjtoT4Jv6hc4ro4Q7IUetKgvTmjSHTXoHXHL6vvZ6eTk9eZJKG3PpqCB+NDBLW/9rD/Q7dt32
        JlxLz67g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nInQi-00B6RH-1w; Sat, 12 Feb 2022 08:06:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3F5B53002C5;
        Sat, 12 Feb 2022 09:06:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 115DD201C872D; Sat, 12 Feb 2022 09:06:49 +0100 (CET)
Date:   Sat, 12 Feb 2022 09:06:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: mmotm 2022-02-11-15-07 uploaded (objtool: ftrace_likely_update)
Message-ID: <YgdqmbK7Irwa2Ryh@hirez.programming.kicks-ass.net>
References: <20220211230819.191B1C340E9@smtp.kernel.org>
 <8074da01-7aa3-9913-1a1e-2ce307ccdbbd@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8074da01-7aa3-9913-1a1e-2ce307ccdbbd@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 11, 2022 at 06:32:06PM -0800, Randy Dunlap wrote:
> on x86_64:
> 
> $ gcc --version
> gcc (SUSE Linux) 7.5.0
> 
> 
> vmlinux.o: warning: objtool: fixup_bad_iret()+0x72: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: noist_exc_debug()+0x30: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: exc_nmi()+0x14e: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: poke_int3_handler()+0x55: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: __sev_get_ghcb()+0x1b: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: __sev_put_ghcb()+0x18: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: __sev_es_ist_exit()+0x2b: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: kernel_exc_vmm_communication()+0x4f: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: rcu_dynticks_eqs_exit()+0x2c: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: rcu_dynticks_eqs_enter()+0x29: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: rcu_eqs_exit.constprop.62()+0x1a: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: rcu_eqs_enter.constprop.63()+0x23: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: rcu_nmi_enter()+0x17: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_nmi_enter()+0x36: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_nmi_exit()+0xa1: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: enter_from_user_mode()+0x4f: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: syscall_enter_from_user_mode()+0x53: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare()+0x4f: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_enter_from_user_mode()+0x4f: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: context_tracking_recursion_enter()+0x67: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: __context_tracking_enter()+0x2c: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: fixup_bad_iret()+0x72: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: noist_exc_debug()+0x30: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: exc_nmi()+0x14e: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: poke_int3_handler()+0x55: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: __sev_get_ghcb()+0x1b: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: __sev_put_ghcb()+0x18: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: __sev_es_ist_exit()+0x2b: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: kernel_exc_vmm_communication()+0x4f: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: rcu_dynticks_eqs_exit()+0x2c: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: rcu_dynticks_eqs_enter()+0x29: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: rcu_eqs_exit.constprop.62()+0x1a: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: rcu_eqs_enter.constprop.63()+0x23: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: rcu_nmi_enter()+0x17: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_nmi_enter()+0x36: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_nmi_exit()+0xa1: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: enter_from_user_mode()+0x4f: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: syscall_enter_from_user_mode()+0x53: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare()+0x4f: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: irqentry_enter_from_user_mode()+0x4f: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: context_tracking_recursion_enter()+0x67: call to ftrace_likely_update() leaves .noinstr.text section
> vmlinux.o: warning: objtool: __context_tracking_enter()+0x2c: call to ftrace_likely_update() leaves .noinstr.text section

Yes, TRACE_BRANCH_PROFILING and PROFILE_ALL_BRANCHES are fundamentally
broken and I have no intention of trying to fix them.

The moment we pull PTI into noinstr C code this will result in insta
boot fail.
