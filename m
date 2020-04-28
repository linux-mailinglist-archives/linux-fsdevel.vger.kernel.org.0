Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD301BBF7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 15:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgD1N2N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 09:28:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbgD1N2M (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:28:12 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 439F5206F0;
        Tue, 28 Apr 2020 13:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588080492;
        bh=e2h+YGX8UNd7RGu9S/wztUu2W9Zxes42cCR7ChuzclQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IaFvCu6krhFeoqDRhlxn4Rt0HIxMcHkb8PJJjF/01l9E9bBbYc0uSUxxo5MRegT8S
         rcMlMNwdwADZCmdFUqk1E3PWHt/iQ+TBzEOqu6W95E2Gppu3nhQV4pELCaIVMxuAMr
         VdBgg/Q/DMYyELaZHTFaB9/B+wUhZEkt8jkDc01A=
Date:   Tue, 28 Apr 2020 14:28:05 +0100
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
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
Message-ID: <20200428132804.GF6791@willie-the-truck>
References: <20200316165055.31179-1-broonie@kernel.org>
 <20200422154436.GJ4898@sirena.org.uk>
 <20200422162954.GF3585@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422162954.GF3585@gaia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 22, 2020 at 05:29:54PM +0100, Catalin Marinas wrote:
> On Wed, Apr 22, 2020 at 04:44:36PM +0100, Mark Brown wrote:
> > On Mon, Mar 16, 2020 at 04:50:42PM +0000, Mark Brown wrote:
> > > This patch series implements support for ARMv8.5-A Branch Target
> > > Identification (BTI), which is a control flow integrity protection
> > > feature introduced as part of the ARMv8.5-A extensions.
> > 
> > I've not resent this since the branch is still sitting in the arm64 tree
> > but it's also not in -next at the minute - is there anything you're
> > waiting for from my end here?
> 
> It's up to Will whether he wants a new series posted. The for-next/bti
> branch is complete AFAICT, only that normally we start queueing stuff
> (and push to -next) around -rc3.

I'm happy either way, but it would be nice to base other BTI patches on
top of this branch. Mark -- is it easier for you to refresh the series
against v5.7-rc3, or leave it like it is? Please just let me know either
way.

Thanks,

Will
