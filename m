Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C2F1C092F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 23:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgD3V0c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 17:26:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgD3V0c (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:26:32 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0E112166E;
        Thu, 30 Apr 2020 21:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588281991;
        bh=uWky6TNBymUqSLkL11ZzartRuKqUlPuvanXrysasMkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uerb66Arhg5vhl7hcybSXvksTonsCmKFdJefGcHkKMVr/lMrnQV3W1SU6xQoz+pI0
         RE39P+64BgmzRvjs0ZSjXa8yV5+5WfUx7KSDiyjU+TsaTP7CBSjQ5f3B4Np6V13L2B
         OaGgWhEyi+eZlWVYMSp1aRYwZqusI1Vbyq7Sa8fI=
Date:   Thu, 30 Apr 2020 22:26:24 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu " <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v10 00/13] arm64: Branch Target Identification support
Message-ID: <20200430212623.GA802@willie-the-truck>
References: <20200316165055.31179-1-broonie@kernel.org>
 <20200422154436.GJ4898@sirena.org.uk>
 <20200422162954.GF3585@gaia>
 <20200428132804.GF6791@willie-the-truck>
 <20200428151205.GH5677@sirena.org.uk>
 <20200428151815.GB12697@willie-the-truck>
 <20200428155808.GJ5677@sirena.org.uk>
 <20200428160141.GD12697@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428160141.GD12697@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 05:01:43PM +0100, Will Deacon wrote:
> On Tue, Apr 28, 2020 at 04:58:12PM +0100, Mark Brown wrote:
> > On Tue, Apr 28, 2020 at 04:18:16PM +0100, Will Deacon wrote:
> > > On Tue, Apr 28, 2020 at 04:12:05PM +0100, Mark Brown wrote:
> > 
> > > > It's probably easier for me if you just use the existing branch, I've
> > > > already got a branch based on a merge down.
> > 
> > > Okey doke, I'll funnel that in the direction of linux-next then. It does
> > > mean that any subsequent patches for 5.8 that depend on BTI will need to
> > > be based on this branch, so as long as you're ok with that then it's fine
> > > by me (since I won't be able to apply patches if they refer to changes
> > > introduced in the recent merge window).
> > 
> > That's not a problem, that's what I've got already and if I try to send
> > everything based off -rc3 directly the series would get unmanagably
> > large.  Actually unless you think it's a bad idea I think what I'll do
> > is go and send out a couple of the preparatory changes (the insn updates
> > and the last bit of annotation conversions) separately for that branch
> > while I finalize the revisions of the main BTI kernel bit, hopefully
> > that'll make the review a bit more approachable.
> 
> Okey doke, sounds good to me. I'm queuing stuff atm, so as long you tell
> me what I need to apply things against then we should be good.

Just a heads up: I've renamed for-next/bti to for-next/bti-user, so it
doesn't get confusing with the pending in-kernel BTI patches. All the commit
SHAs remain unchanged.

Will
