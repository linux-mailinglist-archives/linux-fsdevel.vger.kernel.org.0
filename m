Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18DA919D101
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 09:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388221AbgDCHQv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 03:16:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34422 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732205AbgDCHQv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 03:16:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id v23so163950pfm.1;
        Fri, 03 Apr 2020 00:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=/Min6FGvBBhn5d4HChhwbbt9mp9eJSWu4vYPC1VQ1bY=;
        b=B+j0ye362hcPnhZvtHnMeAMi7Fq/7tt9Ul0Z/nqH/1E7RzI235255HyBwfcMANOo5B
         iqZf6D3D5aDpQ1HZwmyaEOJXVPYejenKImr0QoaKpsS0LA490f2TUAjg8jUcR+XG68gP
         J0c8NqwMaRwCsbVn0D9L+hgcykeyUrEEUSZl4QLkLVXk9A3aExcW5R7YC+t7Wu4AP61v
         c89J31eelZaffV4YhP9kRx+wKrNFGX7eJFJQ7KD6cgnYrj79ppY5Uh4R2PoX76fftjzl
         //1+w85/olJJkRfJke3aecSd8VRSVDP6KlJcDsyjmPBoPbc/M3FFoAlte1+7fS5NFt5K
         +KlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=/Min6FGvBBhn5d4HChhwbbt9mp9eJSWu4vYPC1VQ1bY=;
        b=W9R7kCeEUJIF7ipft5nReMZwBDJjNkqVAXT1mpRV0Gs/xt+/svjmL3lFiMIfmQ70dh
         DINirmUr+M8AvkSYGEtmlAK6z1GHgF5+q2yxhEuqr3twWz+GzeDwtuKb/PUa+TWXv/I+
         ZdBV2MHKaZOHqpCHjWjsct9No65xgLLSLyxwquK/GqqicE7EGERjn3CDlGOtjyIYplOF
         C5TC+sf02skoNqaymk21+NOduVbLO+9GFIOYyw1Mq8jc2phHkWE/kzBDru2PtkJx5Ngk
         N6FgNsEOrZkbtB3f+oDskAI4sjzckx7XWzDAKoQijoFvK6jBFbfGumfJGvBSC1pyZpDX
         P2xg==
X-Gm-Message-State: AGi0PuYAhYUdkngGYCyLq4YoU1JtHCNfRJG/XUIUF5qibg5vBo/5mMCX
        8grWhx6DKLQIzxx+arYek4A=
X-Google-Smtp-Source: APiQypI29WpLJ7yRRLDxGnJ1qIIkGrkN4zERLo3YJfqcNCW07ekUordv1tE/e0nwGNZDivwYK5G7qA==
X-Received: by 2002:aa7:97a7:: with SMTP id d7mr7097386pfq.194.1585898209651;
        Fri, 03 Apr 2020 00:16:49 -0700 (PDT)
Received: from localhost (60-241-117-97.tpgi.com.au. [60.241.117.97])
        by smtp.gmail.com with ESMTPSA id b70sm5265916pfb.6.2020.04.03.00.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 00:16:48 -0700 (PDT)
Date:   Fri, 03 Apr 2020 17:16:43 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v11 5/8] powerpc/64: make buildable without CONFIG_COMPAT
To:     Michal =?iso-8859-1?q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
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
        linuxppc-dev@lists.ozlabs.org, Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michael Neuling <mikey@neuling.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        <1585039733.dm1rivvych.astroid@bobo.none>
        <20200324193055.GG25468@kitsune.suse.cz>
In-Reply-To: <20200324193055.GG25468@kitsune.suse.cz>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1585898018.8y4vw9c8hc.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Michal Such=C3=A1nek's on March 25, 2020 5:30 am:
> On Tue, Mar 24, 2020 at 06:54:20PM +1000, Nicholas Piggin wrote:
>> Michal Suchanek's on March 19, 2020 10:19 pm:
>> > diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal=
.c
>> > index 4b0152108f61..a264989626fd 100644
>> > --- a/arch/powerpc/kernel/signal.c
>> > +++ b/arch/powerpc/kernel/signal.c
>> > @@ -247,7 +247,6 @@ static void do_signal(struct task_struct *tsk)
>> >  	sigset_t *oldset =3D sigmask_to_save();
>> >  	struct ksignal ksig =3D { .sig =3D 0 };
>> >  	int ret;
>> > -	int is32 =3D is_32bit_task();
>> > =20
>> >  	BUG_ON(tsk !=3D current);
>> > =20
>> > @@ -277,7 +276,7 @@ static void do_signal(struct task_struct *tsk)
>> > =20
>> >  	rseq_signal_deliver(&ksig, tsk->thread.regs);
>> > =20
>> > -	if (is32) {
>> > +	if (is_32bit_task()) {
>> >          	if (ksig.ka.sa.sa_flags & SA_SIGINFO)
>> >  			ret =3D handle_rt_signal32(&ksig, oldset, tsk);
>> >  		else
>>=20
>> Unnecessary?
>>=20
>> > diff --git a/arch/powerpc/kernel/syscall_64.c b/arch/powerpc/kernel/sy=
scall_64.c
>> > index 87d95b455b83..2dcbfe38f5ac 100644
>> > --- a/arch/powerpc/kernel/syscall_64.c
>> > +++ b/arch/powerpc/kernel/syscall_64.c
>> > @@ -24,7 +24,6 @@ notrace long system_call_exception(long r3, long r4,=
 long r5,
>> >  				   long r6, long r7, long r8,
>> >  				   unsigned long r0, struct pt_regs *regs)
>> >  {
>> > -	unsigned long ti_flags;
>> >  	syscall_fn f;
>> > =20
>> >  	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
>> > @@ -68,8 +67,7 @@ notrace long system_call_exception(long r3, long r4,=
 long r5,
>> > =20
>> >  	local_irq_enable();
>> > =20
>> > -	ti_flags =3D current_thread_info()->flags;
>> > -	if (unlikely(ti_flags & _TIF_SYSCALL_DOTRACE)) {
>> > +	if (unlikely(current_thread_info()->flags & _TIF_SYSCALL_DOTRACE)) {
>> >  		/*
>> >  		 * We use the return value of do_syscall_trace_enter() as the
>> >  		 * syscall number. If the syscall was rejected for any reason
>> > @@ -94,7 +92,7 @@ notrace long system_call_exception(long r3, long r4,=
 long r5,
>> >  	/* May be faster to do array_index_nospec? */
>> >  	barrier_nospec();
>> > =20
>> > -	if (unlikely(ti_flags & _TIF_32BIT)) {
>> > +	if (unlikely(is_32bit_task())) {
>>=20
>> Problem is, does this allow the load of ti_flags to be used for both
>> tests, or does test_bit make it re-load?
>>=20
>> This could maybe be fixed by testing if(IS_ENABLED(CONFIG_COMPAT) &&
> Both points already discussed here:

Agh, I'm hopeless.

I don't think it really resolves this issue. But probably don't have time
to look at generated asm, and might never because it won't really hit
LE unless we add a 32-bit ABI. It's pretty minor though either way.

Sorry for being difficult, I really do like your patches :)

Thanks,
Nick
=
