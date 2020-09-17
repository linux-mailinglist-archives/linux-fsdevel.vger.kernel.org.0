Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EA326D371
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 08:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgIQGKf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 02:10:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgIQGKc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 02:10:32 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCCDC206DC;
        Thu, 17 Sep 2020 06:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600322465;
        bh=2eXxBCNlIdy/NmilmfE2zcnstt/gSlJAZ4p0990VyuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eSqETZ6e9aUM8TBVL4kfjQtcwF6oBMWwsHru29dQWN3+qfwISbA5tb9PZQF37FhLQ
         ktVNOjoz7kC5FyqYgvEn0gVLPLqRwiIgxxazN2flKq0QRH6x3joT7iU3g25yeUFQUt
         zpnGR4vSdvi7tnn1Ka2batJdt48um4JpgTP6zlJA=
Date:   Thu, 17 Sep 2020 09:00:52 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-riscv@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v5 0/5] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20200917060052.GN2142832@kernel.org>
References: <20200916073539.3552-1-rppt@kernel.org>
 <20200916162020.0d68c2bd6711024cfcaa8bd7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916162020.0d68c2bd6711024cfcaa8bd7@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 04:20:20PM -0700, Andrew Morton wrote:
> On Wed, 16 Sep 2020 10:35:34 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > This is an implementation of "secret" mappings backed by a file descriptor. 
> > I've dropped the boot time reservation patch for now as it is not strictly
> > required for the basic usage and can be easily added later either with or
> > without CMA.
> 
> It seems early days for this, especially as regards reviewer buyin. 
> But I'll toss it in there to get it some additional testing.

Thanks!

> A test suite in tools/testging/selftests/ would be helpful, especially
> for arch maintainers.

I'll look into it.

> I assume that user-facing manpage alterations are planned?

Of course.

-- 
Sincerely yours,
Mike.
