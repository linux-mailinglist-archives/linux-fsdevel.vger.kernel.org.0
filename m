Return-Path: <linux-fsdevel+bounces-5394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D0880B1DC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 04:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74AC1F2148B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 03:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22978136D;
	Sat,  9 Dec 2023 03:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pEoza8wV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8A110FC
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 19:15:26 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5c210e34088so2238089a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Dec 2023 19:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702091726; x=1702696526; darn=vger.kernel.org;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=2b+6n+ULng3a579Szt1kcCIxHSrZ+D7LmH/Z+vqyyTE=;
        b=pEoza8wVnM6tjIXWzzXHyURLxumLQKhtVzfubbHMHLXafo2aNEaDG1BKQ6qKIcjqDs
         PBizxwWF777KEHW4PdK2suQqyYH+3EsToGtXPnPDKV40E4CCvzzmTGmT7Ysgev9/RbKz
         j3mnjTIxzaK46S1EEvPtDI3j7Y/N6siH5PWGzL8CHn3ocgcD57KfSfja+wD1nyiyjeCP
         ZzfLXRBoE+yBTbAY6njOwXDki228RkGszl44Upz9uCcBaPbLU8CHlOnQeavbIHx84lkj
         1V8tljMWPcVkl4GVwI7X1g3OP9IDEckBY0lFz+PMH+xqYh3x9zhN6a7eR4sAgfUtpc0O
         fCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702091726; x=1702696526;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2b+6n+ULng3a579Szt1kcCIxHSrZ+D7LmH/Z+vqyyTE=;
        b=lpZh0xil7EhGCpVMgJWuU8I3cC1Y8KOyH1qvIK6JsZaiPPiUtZ/hhmtMaMukbFwtxK
         6ybxRdx70LHT7uhg7cKQMCNmkNcwAUV98wt5lNrD0d2GriV9nThdJ2oNXdUVkaU2F680
         VvTIWmtjRstQn/kDkTEM/ylEvkHMlqyhk6xMXYx6/g1+LbsiQNMEMev9oeom8E8kGsdj
         fz2RlGUfsLwZP3aAX4Uu6whslMwvND2u4bF02t41HPOAGUcXvm1kYG3nFkmB12Eln3V+
         dp/WKI8Uxfsf1QaciQDe5c00Zje2IPGN/Bh/EZFAxZYRl8HTC5jH/QHCC2cSde6oyUtn
         ZudA==
X-Gm-Message-State: AOJu0Yzlm82RooS1zjA2zl1gsk1velRN+mfnIJvvukG69oLfOwglES7o
	VB3en9uUDY1khbMoTI6JD64wSw==
X-Google-Smtp-Source: AGHT+IEaUnkmb6VMOC1ZmV7RhknH3M28z+3B6TqVq+yqgnnJz1v02mq63uTBtrSHn4oV4teABtH6uA==
X-Received: by 2002:a05:6a20:f390:b0:190:6920:e14b with SMTP id qr16-20020a056a20f39000b001906920e14bmr1018200pzb.122.1702091725612;
        Fri, 08 Dec 2023 19:15:25 -0800 (PST)
Received: from localhost ([2804:14d:7e39:8470:4c58:a216:27d2:2ff])
        by smtp.gmail.com with ESMTPSA id x22-20020a056a00271600b006be5af77f06sm2330693pfv.2.2023.12.08.19.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 19:15:25 -0800 (PST)
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
 <20231122-arm64-gcs-v7-24-201c483bd775@kernel.org>
User-agent: mu4e 1.10.8; emacs 29.1
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton
 <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, Suzuki K
 Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, Oleg
 Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees
 Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, "Rick P.
 Edgecombe" <rick.p.edgecombe@intel.com>, Deepak Gupta
 <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, Szabolcs Nagy
 <Szabolcs.Nagy@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Florian Weimer <fweimer@redhat.com>, Christian
 Brauner <brauner@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v7 24/39] arm64/signal: Set up and restore the GCS
 context for signal handlers
In-reply-to: <20231122-arm64-gcs-v7-24-201c483bd775@kernel.org>
Date: Sat, 09 Dec 2023 00:15:22 -0300
Message-ID: <8734wcgj79.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Mark Brown <broonie@kernel.org> writes:

> +static bool gcs_signal_cap_valid(u64 addr, u64 val)
> +{
> +	/*
> +	 * The top bit should be set, this is an invalid address for
> +	 * EL0 and will only be set for caps created by signals.
> +	 */
> +	if (!(val & GCS_SIGNAL_CAP_FLAG))
> +		return false;
> +
> +	/* The rest should be a standard architectural cap token. */
> +	val &= ~GCS_SIGNAL_CAP_FLAG;
> +
> +	/* The cap must have the low bits set to a token value */
> +	if (GCS_CAP_TOKEN(val) != 0)
> +		return false;

I found the comment above a little confusing, since the if condition
actually checks that low bits aren't set at all. Perhaps reword to
something like "The token value of a signal cap must be 0"?

> +
> +	/* The cap must store the VA the cap was stored at */
> +	if (GCS_CAP_ADDR(addr) != GCS_CAP_ADDR(val))
> +		return false;
> +
> +	return true;
> +}
> +#endif
> +
>  /*
>   * Do a signal return; undo the signal stack. These are aligned to 128-bit.
>   */
> @@ -815,6 +847,45 @@ static int restore_sigframe(struct pt_regs *regs,
>  	return err;
>  }
>  
> +#ifdef CONFIG_ARM64_GCS
> +static int gcs_restore_signal(void)
> +{
> +	u64 gcspr_el0, cap;
> +	int ret;
> +
> +	if (!system_supports_gcs())
> +		return 0;
> +
> +	if (!(current->thread.gcs_el0_mode & PR_SHADOW_STACK_ENABLE))
> +		return 0;
> +
> +	gcspr_el0 = read_sysreg_s(SYS_GCSPR_EL0);
> +
> +	/*
> +	 * GCSPR_EL0 should be pointing at a capped GCS, read the cap...
> +	 */
> +	gcsb_dsync();
> +	ret = copy_from_user(&cap, (__user void*)gcspr_el0, sizeof(cap));
> +	if (ret)
> +		return -EFAULT;
> +
> +	/*
> +	 * ...then check that the cap is the actual GCS before
> +	 * restoring it.
> +	 */
> +	if (!gcs_signal_cap_valid(gcspr_el0, cap))
> +		return -EINVAL;
> +
> +	current->thread.gcspr_el0 = gcspr_el0 + sizeof(cap);
> +	write_sysreg_s(current->thread.gcspr_el0, SYS_GCSPR_EL0);

At this point, there's an inactive but valid cap just below the GCS.
Over time, as different signals are received when the GCSPR is pointing
at different locations of the stack, there could be a number of valid
inactive caps available for misuse.

I'm still not proficient enough in GCS to know how exactly this could be
abused (e.g., somehow writing the desired return location right above
one of these inactive caps and arranging for GCSPR to point to the cap
before returning from a signal) but to be safe or paranoid, perhaps zero
the location of the cap before returning?

> +
> +	return 0;
> +}
> +
> +#else
> +static int gcs_restore_signal(void) { return 0; }
> +#endif
> +
>  SYSCALL_DEFINE0(rt_sigreturn)
>  {
>  	struct pt_regs *regs = current_pt_regs();
> @@ -841,6 +912,9 @@ SYSCALL_DEFINE0(rt_sigreturn)
>  	if (restore_altstack(&frame->uc.uc_stack))
>  		goto badframe;
>  
> +	if (gcs_restore_signal())
> +		goto badframe;
> +
>  	return regs->regs[0];
>  
>  badframe:
> @@ -1071,7 +1145,50 @@ static int get_sigframe(struct rt_sigframe_user_layout *user,
>  	return 0;
>  }
>  
> -static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
> +#ifdef CONFIG_ARM64_GCS
> +
> +static int gcs_signal_entry(__sigrestore_t sigtramp, struct ksignal *ksig)

The ksig argument is unused, so it can be removed.

> +{
> +	unsigned long __user *gcspr_el0;
> +	int ret = 0;
> +
> +	if (!system_supports_gcs())
> +		return 0;
> +
> +	if (!task_gcs_el0_enabled(current))
> +		return 0;
> +
> +	/*
> +	 * We are entering a signal handler, current register state is
> +	 * active.
> +	 */
> +	gcspr_el0 = (unsigned long __user *)read_sysreg_s(SYS_GCSPR_EL0);
> +
> +	/*
> +	 * Push a cap and the GCS entry for the trampoline onto the GCS.
> +	 */
> +	put_user_gcs((unsigned long)sigtramp, gcspr_el0 - 2, &ret);
> +	put_user_gcs(GCS_SIGNAL_CAP(gcspr_el0 - 1), gcspr_el0 - 1, &ret);
> +	if (ret != 0)
> +		return ret;
> +
> +	gcsb_dsync();
> +
> +	gcspr_el0 -= 2;
> +	write_sysreg_s((unsigned long)gcspr_el0, SYS_GCSPR_EL0);
> +
> +	return 0;
> +}
> +#else
> +
> +static int gcs_signal_entry(__sigrestore_t sigtramp, struct ksignal *ksig)
> +{
> +	return 0;
> +}
> +
> +#endif
> +
> +static int setup_return(struct pt_regs *regs, struct ksignal *ksig,
>  			 struct rt_sigframe_user_layout *user, int usig)

Since the ksig argument isn't used by gcs_signal_entry(), setup_return()
can keep the ka argument and the changes below from ka to ksic->ka are
unnecessary.

>  {
>  	__sigrestore_t sigtramp;
> @@ -1079,7 +1196,7 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
>  	regs->regs[0] = usig;
>  	regs->sp = (unsigned long)user->sigframe;
>  	regs->regs[29] = (unsigned long)&user->next_frame->fp;
> -	regs->pc = (unsigned long)ka->sa.sa_handler;
> +	regs->pc = (unsigned long)ksig->ka.sa.sa_handler;
>  
>  	/*
>  	 * Signal delivery is a (wacky) indirect function call in
> @@ -1119,12 +1236,14 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
>  		sme_smstop();
>  	}
>  
> -	if (ka->sa.sa_flags & SA_RESTORER)
> -		sigtramp = ka->sa.sa_restorer;
> +	if (ksig->ka.sa.sa_flags & SA_RESTORER)
> +		sigtramp = ksig->ka.sa.sa_restorer;
>  	else
>  		sigtramp = VDSO_SYMBOL(current->mm->context.vdso, sigtramp);
>  
>  	regs->regs[30] = (unsigned long)sigtramp;
> +
> +	return gcs_signal_entry(sigtramp, ksig);
>  }
>  
>  static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
> @@ -1147,7 +1266,7 @@ static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
>  	err |= __save_altstack(&frame->uc.uc_stack, regs->sp);
>  	err |= setup_sigframe(&user, regs, set);
>  	if (err == 0) {
> -		setup_return(regs, &ksig->ka, &user, usig);
> +		err = setup_return(regs, ksig, &user, usig);
>  		if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
>  			err |= copy_siginfo_to_user(&frame->info, &ksig->info);
>  			regs->regs[1] = (unsigned long)&frame->info;
> diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
> index 02f8f6046c10..6f51429c5a46 100644
> --- a/arch/arm64/mm/gcs.c
> +++ b/arch/arm64/mm/gcs.c
> @@ -6,6 +6,7 @@
>  #include <linux/types.h>
>  
>  #include <asm/cpufeature.h>
> +#include <asm/gcs.h>
>  #include <asm/page.h>

This is #include isn't needed by this patch. Probably better as part of
another one.

-- 
Thiago

