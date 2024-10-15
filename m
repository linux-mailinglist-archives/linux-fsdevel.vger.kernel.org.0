Return-Path: <linux-fsdevel+bounces-31990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 852D999EE01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 15:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A35E1F220CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885A328691;
	Tue, 15 Oct 2024 13:40:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BBE1B2181;
	Tue, 15 Oct 2024 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999601; cv=none; b=cU8Xe3L8AqrDqk5x2CqjKX51mX45OJs7A8tVFI0eRAkaKm4aH8lwC7CWcXVY3vKciHwEuzJY+cHdbqA/8n6cY3fIguR45EkW9Zp5YZPDyWAPqidI7IBAlEbjeBNA1cAa0x6xRw5u3DRHXzFhspmUe29bt1szevlp7Cae5z+lCIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999601; c=relaxed/simple;
	bh=SkNyj+3crdzW7cJachTesaxxbmUIxu0p5toJvApTMaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEnDKo5RzBvFoe19n1l/Ctg0c1LQsbwN88reDxDfdZ3qEGxza61g3ZZNTvh9gxcEw82O9MxbIiY5dOaSYAD3sAQ/hryPCxTKdSjymxf2iGpmIzAYHXFmMntOhdQ/quNc2gbQm/hOqxnim1bEoy6NEW0Nr9cqbqIxQPEuNNaLezI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 911ABFEC;
	Tue, 15 Oct 2024 06:40:28 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C40753F51B;
	Tue, 15 Oct 2024 06:39:54 -0700 (PDT)
Date: Tue, 15 Oct 2024 14:39:49 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>,
	linux-arm-kernel@lists.infradead.org, nd@arm.com,
	akpm@linux-foundation.org, aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com, bp@alien8.de,
	broonie@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com,
	hpa@zytor.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com, tglx@linutronix.de, x86@kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 19/30] arm64: add POE signal support
Message-ID: <Zw5wpTWgNC+aC+Vk@e133380.arm.com>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
 <20240822151113.1479789-20-joey.gouly@arm.com>
 <47e1537f-5b60-4541-aed1-a20e804c137d@arm.com>
 <20241009144301.GA12453@willie-the-truck>
 <20241014171023.GA18295@willie-the-truck>
 <20241015095911.GA3777204@e124191.cambridge.arm.com>
 <20241015114116.GA19334@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015114116.GA19334@willie-the-truck>

On Tue, Oct 15, 2024 at 12:41:16PM +0100, Will Deacon wrote:
> On Tue, Oct 15, 2024 at 10:59:11AM +0100, Joey Gouly wrote:
> > On Mon, Oct 14, 2024 at 06:10:23PM +0100, Will Deacon wrote:
> > > Kevin, Joey,
> > > 
> > > On Wed, Oct 09, 2024 at 03:43:01PM +0100, Will Deacon wrote:
> > > > On Tue, Sep 24, 2024 at 01:27:58PM +0200, Kevin Brodsky wrote:
> > > > > On 22/08/2024 17:11, Joey Gouly wrote:
> > > > > > @@ -1178,6 +1237,9 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
> > > > > >  		sme_smstop();
> > > > > >  	}
> > > > > >  
> > > > > > +	if (system_supports_poe())
> > > > > > +		write_sysreg_s(POR_EL0_INIT, SYS_POR_EL0);
> > > > > 
> > > > > At the point where setup_return() is called, the signal frame has
> > > > > already been written to the user stack. In other words, we write to the
> > > > > user stack first, and then reset POR_EL0. This may be problematic,
> > > > > especially if we are using the alternate signal stack, which the
> > > > > interrupted POR_EL0 may not grant access to. In that situation uaccess
> > > > > will fail and we'll end up with a SIGSEGV.
> > > > > 
> > > > > This issue has already been discussed on the x86 side, and as it happens
> > > > > patches to reset PKRU early [1] have just landed. I don't think this is
> > > > > a blocker for getting this series landed, but we should try and align
> > > > > with x86. If there's no objection, I'm planning to work on a counterpart
> > > > > to the x86 series (resetting POR_EL0 early during signal delivery).
> > > > 
> > > > Did you get a chance to work on that? It would be great to land the
> > > > fixes for 6.12, if possible, so that the first kernel release with POE
> > > > support doesn't land with known issues.
> > > 
> > > Looking a little more at this, I think we have quite a weird behaviour
> > > on arm64 as it stands. It looks like we rely on the signal frame to hold
> > > the original POR_EL0 so, if for some reason we fail to allocate space
> > > for the POR context, I think we'll return back from the signal with
> > > POR_EL0_INIT. That seems bad?
> > 
> > If we don't allocate space for POR_EL0, I think the program recieves SIGSGEV?
> > 
> > setup_sigframe_layout()
> >         if (system_supports_poe()) {
> >                 err = sigframe_alloc(user, &user->poe_offset,
> >                                      sizeof(struct poe_context));
> >                 if (err)
> >                         return err;
> >         }
> > 
> > Through get_sigframe() and setup_rt_frame(), that eventually hets here:
> > 
> > handle_signal()
> > 	ret = setup_rt_frame(usig, ksig, oldset, regs);
> > 
> > 	[..]
> > 
> >         signal_setup_done(ret, ksig, test_thread_flag(TIF_SINGLESTEP));
> > 
> > void signal_setup_done(int failed, struct ksignal *ksig, int stepping)                                                                                                                         
> > {                                                                                                                                                                                              
> >         if (failed)                                                                                                                                                                            
> >                 force_sigsegv(ksig->sig);                                                                                                                                                      
> >         else                                                                                                                                                                                   
> >                 signal_delivered(ksig, stepping);                                                                                                                                              
> > }  
> > 
> > So I think it's "fine"?
> 
> Ah, yes, sorry about that. I got confused by the conditional push in
> setup_sigframe():
> 
> 	if (system_supports_poe() && err == 0 && user->poe_offset) {
> 		...
> 
> which gives the wrong impression that the POR is somehow optional, even
> if the CPU supports POE. So we should drop that check of
> 'user->poe_offset' as it cannot be NULL here.

From memory and a quick glance at the code:

For other "conditionally unconditional" things, we don't have a
corresponding check on user->foo.

For conditional stuff, non-NULLness of user->foo is used to track
whether we decided to dump the corresponding record; for consistency
here, if we have system_supports_poe() && err == 0, then that's
sufficient (though in prior versions of this code, POR_EL0 dumping was
conditional and so the extra check did do something...)


In any case, if some allocation fails then we splat out with a SIGSEGV
before modifying the user task state to deliver the signal (in
setup_return() etc.)

If The user's POR_EL0 value is being clobbered before we get here, we
would save the wrong value -- so the code would be broken anyway.


So, as Joey says, this is probably fine, but the user->poe_offset check
looks superfluous.  The kernel will splat on us here and kill the thread
if it's NULL anyway.

[...]

Cheers
---Dave

