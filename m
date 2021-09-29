Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F202941C00A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 09:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244671AbhI2Hlk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 03:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244657AbhI2Hlj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 03:41:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC1EC06161C;
        Wed, 29 Sep 2021 00:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VkS0cByfycR7IUntKmzAdGZYgQquvhdpPBQ2pD9v+cM=; b=mKSPGDpxkeRqEwh5TlZm4fZA2O
        0ABC1F6qO7GglhEWW5N+wBKyl9AAPlkDYsHfEGLSk9vQ2TBuC8x1vnTJaTzT81NSLd7JupEAs5+k5
        QSeZuXJ5I/3ePl7muEEi+tpiPmCMIrrisFx1Vr270buugAIkfBEhBTyase4hpvyVmqAil4ZRpAnB7
        lghBHps1rpNJzWuOaZ/Ii+dmvLTf1p3vJRi8R6IIaQ+faluqeA1biQra4y/eoI/bPNwhU6yS0ug7/
        uZ/slWJCpqeTyEStYf8zDAqYzw3cLkuaa+RnbfQc6chDsWfraJ92fCNe/eFAj7eiHJFrH7fpQCf4e
        AnBmu8vQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVUBw-006fNy-C1; Wed, 29 Sep 2021 07:39:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8ACE930029A;
        Wed, 29 Sep 2021 09:39:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 404E52BBF9839; Wed, 29 Sep 2021 09:39:47 +0200 (CEST)
Date:   Wed, 29 Sep 2021 09:39:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+488ddf8087564d6de6e2@syzkaller.appspotmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        will@kernel.org, x86@kernel.org
Subject: Re: [syzbot] upstream test error: KASAN: invalid-access Read in
 __entry_tramp_text_end
Message-ID: <YVQYQzP/vqNWm/hO@hirez.programming.kicks-ass.net>
References: <000000000000a3cf8605cb2a1ec0@google.com>
 <CACT4Y+aS6w1gFuMVY1fnAG0Yp0XckQTM+=tUHkOuxHUy2mkxrg@mail.gmail.com>
 <20210921165134.GE35846@C02TD0UTHF1T.local>
 <CACT4Y+ZjRgb57EV6mvC-bVK0uT0aPXUjtZJabuWasYcshKNcgw@mail.gmail.com>
 <20210927170122.GA9201@C02TD0UTHF1T.local>
 <20210927171812.GB9201@C02TD0UTHF1T.local>
 <CACT4Y+actfuftwMMOGXmEsLYbnCnqcZ2gJGeoMLsFCUNE-AxcQ@mail.gmail.com>
 <20210928103543.GF1924@C02TD0UTHF1T.local>
 <20210929013637.bcarm56e4mqo3ndt@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929013637.bcarm56e4mqo3ndt@treble>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 28, 2021 at 06:36:37PM -0700, Josh Poimboeuf wrote:
> On Tue, Sep 28, 2021 at 11:35:43AM +0100, Mark Rutland wrote:
> > > In the other x86 thread Josh Poimboeuf suggested to use asm goto to a
> > > cold part of the function instead of .fixup:
> > > https://lore.kernel.org/lkml/20210927234543.6waods7rraxseind@treble/
> > > This sounds like a more reliable solution that will cause less
> > > maintenance burden. Would it work for arm64 as well?
> > 
> > Maybe we can use that when CC_HAS_ASM_GOTO_OUTPUT is avaiable, but in
> > general we can't rely on asm goto supporting output arguments (and IIRC
> > GCC doesn't support that at all), so we'd still have to support the
> > current fixup scheme.

gcc-11 has it

> Even without CC_HAS_ASM_GOTO_OUTPUT it should still be possible to hack
> something together if you split the original insn asm and the extable
> asm into separate statements, like:
> 
> diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
> index 6b52182e178a..8f62469f2027 100644
> --- a/arch/x86/include/asm/msr.h
> +++ b/arch/x86/include/asm/msr.h
> @@ -137,20 +139,21 @@ static inline unsigned long long native_read_msr_safe(unsigned int msr,
>  {
>  	DECLARE_ARGS(val, low, high);
>  
> +	*err = 0;
> +	asm volatile("417: rdmsr\n"
> +		     : EAX_EDX_RET(val, low, high)
> +		     : "c" (msr));
> +	asm_volatile_goto(_ASM_EXTABLE(417b, %l[Efault]) :::: Efault);

That's terrible :-) Could probably do with a comment, but might just
work..

> +
> +done:
>  	if (tracepoint_enabled(read_msr))
>  		do_trace_read_msr(msr, EAX_EDX_VAL(val, low, high), *err);
>  	return EAX_EDX_VAL(val, low, high);
> +
> +Efault:
> +	*err = -EIO;
> +	ZERO_ARGS(val, low, high);
> +	goto done;
>  }
>  
>  /* Can be uninlined because referenced by paravirt */
> 
