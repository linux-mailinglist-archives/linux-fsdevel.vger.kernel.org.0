Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0710F190856
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 09:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgCXIy1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 04:54:27 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38165 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgCXIy1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 04:54:27 -0400
Received: by mail-pj1-f66.google.com with SMTP id m15so1142226pje.3;
        Tue, 24 Mar 2020 01:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=AX6pvyW36VYxdhbcJ7NY2GZcvFUSsP1GTN2RViF8G7Y=;
        b=jjtxgFPjP0XI7X603OuXDyscIH0QbP4zjp0du6D/cgb/jHVPILKH3KGOL7nhVYDAdr
         BeDDacT5TQtN0HqK815WDe/FB9o5vbE340CtKRKkMT8jpjQ5ZSSlValk6hiQPTU20Inw
         cuxk9zVZbC+jila0X5uWNhaF3ar/mZ2/mfvu5YIdMIaYD1+fkpZcwfDyetbLMmqxddT4
         WWa5uyYzCGDmU095ttk4ni+mvDiPvSDRnpGVdhckh+gLRFq7S8Hjj89OJGOBx7Kzqjom
         Sth9EoTAAyEjW1LLz9OQdPHUPde5yQmiqA+e2u5JVd/89s4YnnkK5dhWYYrLj9viO+wM
         HBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=AX6pvyW36VYxdhbcJ7NY2GZcvFUSsP1GTN2RViF8G7Y=;
        b=ZLew4HMLBb9AxPZqJNvorTZOYwrLD+Kfjh0HcDsxK7965liKKR5KaXNQcwxWA8z+Es
         ZMsrOGJpbkySdkpGG+nupD9SOzBglpDq87CSBl9uBQd0ljVPuQV57KwAz8Dz8JBE1JM/
         X/8AJrSQ5+ULLbxVhakik5GgJQyiqBmZDTJxnC5i3MkG68v9JJtHMzEqQn4sEVXnzH3M
         24/f1RJqYP3uYnzDiQxHILRIPLhthWB38H6Xv+yF9jtxGWcneQcuXHkggTeU9VVfhwmj
         TXNP6JSMyW/ESpeFjvFAqdEpUPqgs5oxCZ2szbKQmr+QBbeGlXBX3jwIvZNccrjkEQ+K
         6xxw==
X-Gm-Message-State: ANhLgQ3PNZNBdBjKxO94vqQ8VWulCnQ6xrs/kc9VL14GVPG0p3wRXbwn
        O4oQjmGy1Gl3kUTyCC+cl/1eaE9H
X-Google-Smtp-Source: ADFU+vvIuVTTxHyKgEzCyA/Lbfk93DlamjfOFopC5+FhsCBW5H4GMO1fhbhjH3uo8/3wJ9hE2sQS2Q==
X-Received: by 2002:a17:902:8f8e:: with SMTP id z14mr26000685plo.195.1585040066562;
        Tue, 24 Mar 2020 01:54:26 -0700 (PDT)
Received: from localhost (14-202-190-183.tpgi.com.au. [14.202.190.183])
        by smtp.gmail.com with ESMTPSA id bx1sm1758873pjb.5.2020.03.24.01.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 01:54:26 -0700 (PDT)
Date:   Tue, 24 Mar 2020 18:54:20 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v11 5/8] powerpc/64: make buildable without CONFIG_COMPAT
To:     linuxppc-dev@lists.ozlabs.org, Michal Suchanek <msuchanek@suse.de>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Richter <erichte@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Luiz Duarte <gustavold@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michael Neuling <mikey@neuling.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20200225173541.1549955-1-npiggin@gmail.com>
        <cover.1584620202.git.msuchanek@suse.de>
        <4b7058eb0f5558fb7e2cee1b8f7cf99ebd03084e.1584620202.git.msuchanek@suse.de>
In-Reply-To: <4b7058eb0f5558fb7e2cee1b8f7cf99ebd03084e.1584620202.git.msuchanek@suse.de>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1585039733.dm1rivvych.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Michal Suchanek's on March 19, 2020 10:19 pm:
> diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
> index 4b0152108f61..a264989626fd 100644
> --- a/arch/powerpc/kernel/signal.c
> +++ b/arch/powerpc/kernel/signal.c
> @@ -247,7 +247,6 @@ static void do_signal(struct task_struct *tsk)
>  	sigset_t *oldset =3D sigmask_to_save();
>  	struct ksignal ksig =3D { .sig =3D 0 };
>  	int ret;
> -	int is32 =3D is_32bit_task();
> =20
>  	BUG_ON(tsk !=3D current);
> =20
> @@ -277,7 +276,7 @@ static void do_signal(struct task_struct *tsk)
> =20
>  	rseq_signal_deliver(&ksig, tsk->thread.regs);
> =20
> -	if (is32) {
> +	if (is_32bit_task()) {
>          	if (ksig.ka.sa.sa_flags & SA_SIGINFO)
>  			ret =3D handle_rt_signal32(&ksig, oldset, tsk);
>  		else

Unnecessary?

> diff --git a/arch/powerpc/kernel/syscall_64.c b/arch/powerpc/kernel/sysca=
ll_64.c
> index 87d95b455b83..2dcbfe38f5ac 100644
> --- a/arch/powerpc/kernel/syscall_64.c
> +++ b/arch/powerpc/kernel/syscall_64.c
> @@ -24,7 +24,6 @@ notrace long system_call_exception(long r3, long r4, lo=
ng r5,
>  				   long r6, long r7, long r8,
>  				   unsigned long r0, struct pt_regs *regs)
>  {
> -	unsigned long ti_flags;
>  	syscall_fn f;
> =20
>  	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
> @@ -68,8 +67,7 @@ notrace long system_call_exception(long r3, long r4, lo=
ng r5,
> =20
>  	local_irq_enable();
> =20
> -	ti_flags =3D current_thread_info()->flags;
> -	if (unlikely(ti_flags & _TIF_SYSCALL_DOTRACE)) {
> +	if (unlikely(current_thread_info()->flags & _TIF_SYSCALL_DOTRACE)) {
>  		/*
>  		 * We use the return value of do_syscall_trace_enter() as the
>  		 * syscall number. If the syscall was rejected for any reason
> @@ -94,7 +92,7 @@ notrace long system_call_exception(long r3, long r4, lo=
ng r5,
>  	/* May be faster to do array_index_nospec? */
>  	barrier_nospec();
> =20
> -	if (unlikely(ti_flags & _TIF_32BIT)) {
> +	if (unlikely(is_32bit_task())) {

Problem is, does this allow the load of ti_flags to be used for both
tests, or does test_bit make it re-load?

This could maybe be fixed by testing if(IS_ENABLED(CONFIG_COMPAT) &&

Other than these, the patches all look pretty good to me.

Thanks,
Nick
=
