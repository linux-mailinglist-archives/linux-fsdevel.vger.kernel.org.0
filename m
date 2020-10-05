Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12AC2830E7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Oct 2020 09:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgJEHdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Oct 2020 03:33:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgJEHdA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Oct 2020 03:33:00 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B3A2205F4;
        Mon,  5 Oct 2020 07:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601883179;
        bh=gu2e4JQFDSqeZWow6iyo4Sn010Xx6I+yVapiH4qL/Pg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rRppAU54V8DEObp+MMdOt/Qh6/tYptGxCZD0d0JUBUsgfjFRXBYR9T5DRxj3l7S37
         MwsFewTjq6L/jeLT6JBFXNLQs8oMquIF/iKYT0EyoFb76l/4ucdWZqUZpBV5Z1a8sh
         78sT/k94nxu5ViB56a1MsSarM7FzjYQx1SkG4Vb4=
Date:   Mon, 5 Oct 2020 10:32:42 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Alejandro Colomar <colomar.6.4.3@gmail.com>
Cc:     mtk.manpages@gmail.com, akpm@linux-foundation.org, arnd@arndb.de,
        bp@alien8.de, catalin.marinas@arm.com, cl@linux.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        david@redhat.com, elena.reshetova@intel.com, hpa@zytor.com,
        idan.yaniv@ibm.com, jejb@linux.ibm.com, kirill@shutemov.name,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        linux-riscv@lists.infradead.org, luto@kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, peterz@infradead.org, rppt@linux.ibm.com,
        shuah@kernel.org, tglx@linutronix.de, tycho@tycho.ws,
        viro@zeniv.linux.org.uk, will@kernel.org, willy@infradead.org,
        x86@kernel.org
Subject: Re: [PATCH] man2: new page describing memfd_secret() system call
Message-ID: <20201005073242.GA4251@kernel.org>
References: <20200924133513.1589-1-rppt@kernel.org>
 <efb6d051-2104-af26-bfb0-995f4716feb2@gmail.com>
 <94cf1b3a-e191-a896-a27d-cd7649cb2c59@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94cf1b3a-e191-a896-a27d-cd7649cb2c59@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Alex,

On Sat, Oct 03, 2020 at 11:32:43AM +0200, Alejandro Colomar wrote:
> Hi Mike and Michael,

I'll add the note to the man page, thanks!

> Ping. :)
> 
> Thanks,
> 
> Alex
> 
> On 2020-09-24 16:55, Alejandro Colomar wrote:
> > * Mike Rapoport:
> >  > +.PP
> >  > +.IR Note :
> >  > +There is no glibc wrapper for this system call; see NOTES.
> > 
> > You added a reference to NOTES, but then in notes there is nothing about
> > it.  I guess you wanted to add the following to NOTES (taken from
> > membarrier.2):
> > 
> > .PP
> > Glibc does not provide a wrapper for this system call; call it using
> > .BR syscall (2).
> > 
> > Cheers,
> > 
> > Alex

-- 
Sincerely yours,
Mike.
