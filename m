Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17327188D73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 19:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgCQSt0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 14:49:26 -0400
Received: from foss.arm.com ([217.140.110.172]:41546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgCQSt0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 14:49:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5557831B;
        Tue, 17 Mar 2020 11:49:25 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F9F53F67D;
        Tue, 17 Mar 2020 11:49:22 -0700 (PDT)
Date:   Tue, 17 Mar 2020 18:49:20 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
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
Message-ID: <20200317184920.GI632169@arrakis.emea.arm.com>
References: <20200316165055.31179-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316165055.31179-1-broonie@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 16, 2020 at 04:50:42PM +0000, Mark Brown wrote:
> Daniel Kiss (1):
>   mm: smaps: Report arm64 guarded pages in smaps
> 
> Dave Martin (11):
>   ELF: UAPI and Kconfig additions for ELF program properties
>   ELF: Add ELF program property parsing support
>   arm64: Basic Branch Target Identification support
>   elf: Allow arch to tweak initial mmap prot flags
>   arm64: elf: Enable BTI at exec based on ELF program properties
>   arm64: BTI: Decode BYTPE bits when printing PSTATE
>   arm64: unify native/compat instruction skipping
>   arm64: traps: Shuffle code to eliminate forward declarations
>   arm64: BTI: Reset BTYPE when skipping emulated instructions
>   KVM: arm64: BTI: Reset BTYPE when skipping emulated instructions
>   arm64: BTI: Add Kconfig entry for userspace BTI
> 
> Mark Brown (1):
>   arm64: mm: Display guarded pages in ptdump

I provisionally pushed this patches to linux-next (and arm64
for-next/bti).

I'm not sure whether they'll make it into 5.7 yet (still missing acks on
the fs/* changes) but at least they'll get some wider exposure,
especially as they go outside arch/arm64/.

-- 
Catalin
