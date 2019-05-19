Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2CD22930
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 May 2019 23:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbfESVbc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 May 2019 17:31:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35392 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbfESVbb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 May 2019 17:31:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id t1so4355959pgc.2;
        Sun, 19 May 2019 14:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1QvxhF/+9LIIOHrV38bI6mtQal4+b3LP9l1bfkvx7IY=;
        b=jecOqlsoe0UEPMv0CSshbDYpQ3KtJyRwtIb94YIsnnZn3qMaFiFTM3T+/t2jmHYa2/
         BYndj78b3sE3SC3sjp5ONXsdlxx0r0YI+jBUyBMVdWbRjqPoPAKTMrmHn2j9kHSLfS5g
         jaEgqkMZsWJk3J4JuggZmcwcuPKUw8WDKwR2CVT464ZbzkoEqvWYpdjXYLthME7pF9Nu
         pi/I3L668FC2nRFXp/r5FILuMwRBroqc5GYO7nScF9OSdaDvxexYrYgDHDOH3P09ilXy
         ffhhK3dELo5EeGR4kq73iQMOthSHvHi6+CKe7Na502Hj8GmQHjYY/rZ4YnYCxj4ACU+2
         hYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1QvxhF/+9LIIOHrV38bI6mtQal4+b3LP9l1bfkvx7IY=;
        b=rVaggeznQi6NbIvOFkoFUj2ZulM2zABo9LGg/fTuRIyXtJSggWkk/2sEWrAvHzs1u0
         peLry5tbgK1A967yVyreK6mi2ZHFV5JZUrytLN32MciPUZwV6EJ51wnKmGhCZHUw360D
         AsHoR7Q+J6JVl5x4N+ypbnJ7RNaB2xE+wfB+R9PFrTp2KHvZbcye4pV5uNsUkUoL3xCE
         BJRPLUq+ucjEFcA5gTPq+NJAqSIdwZAM85g97YxiAa0RLSraGnlKl8k7uEHivzeIDjkt
         VS1sVMA8lBIkmE8/T6c1Ek+5LKwJRvT7P0bs47tg3oCNcHDUT0RiAU7AN2amH0EdKw0A
         bmVg==
X-Gm-Message-State: APjAAAWdqOq3M0JTjdwGiAg7EVFyF0Dm5CCTk6TYudLTNBs106JKLryE
        VbFfnlQfplegY4IgAshmOkE=
X-Google-Smtp-Source: APXvYqyiFz5NeSlT7HFIb3vefXzRbWrhY0OztO6ma+lAPIoJaBXOrQDx+uJsYh/bZCDs2/eKK8g4xw==
X-Received: by 2002:a63:fb45:: with SMTP id w5mr71424656pgj.397.1558301490884;
        Sun, 19 May 2019 14:31:30 -0700 (PDT)
Received: from localhost ([2607:f140:6000:1b:d07:291f:4ccd:776a])
        by smtp.gmail.com with ESMTPSA id 187sm20884427pfv.174.2019.05.19.14.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 May 2019 14:31:30 -0700 (PDT)
Date:   Sun, 19 May 2019 14:31:29 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Rafael Aquini <aquini@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Sandeep Patil <sspatil@android.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] fs/proc: add VmTaskSize field to /proc/$$/status
Message-ID: <20190519213129.GA32053@yury-thinkpad>
References: <1557158023-23021-1-git-send-email-jsavitz@redhat.com>
 <20190507125430.GA31025@x230.aquini.net>
 <20190508063716.GA3096@yury-thinkpad>
 <87k1ezugqh.fsf@concordia.ellerman.id.au>
 <20190510072500.GA1520@yury-thinkpad>
 <87k1ettv91.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1ettv91.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 14, 2019 at 04:17:46PM +1000, Michael Ellerman wrote:
> Yury Norov <yury.norov@gmail.com> writes:
> > On Fri, May 10, 2019 at 01:32:22PM +1000, Michael Ellerman wrote:
> >> Yury Norov <yury.norov@gmail.com> writes:
> >> > On Tue, May 07, 2019 at 08:54:31AM -0400, Rafael Aquini wrote:
> >> >> On Mon, May 06, 2019 at 11:53:43AM -0400, Joel Savitz wrote:
> >> >> > There is currently no easy and architecture-independent way to find the
> >> >> > lowest unusable virtual address available to a process without
> >> >> > brute-force calculation. This patch allows a user to easily retrieve
> >> >> > this value via /proc/<pid>/status.
> >> >> > 
> >> >> > Using this patch, any program that previously needed to waste cpu cycles
> >> >> > recalculating a non-sensitive process-dependent value already known to
> >> >> > the kernel can now be optimized to use this mechanism.
> >> >> > 
> >> >> > Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> >> >> > ---
> >> >> >  Documentation/filesystems/proc.txt | 2 ++
> >> >> >  fs/proc/task_mmu.c                 | 2 ++
> >> >> >  2 files changed, 4 insertions(+)
> >> >> > 
> >> >> > diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
> >> >> > index 66cad5c86171..1c6a912e3975 100644
> >> >> > --- a/Documentation/filesystems/proc.txt
> >> >> > +++ b/Documentation/filesystems/proc.txt
> >> >> > @@ -187,6 +187,7 @@ read the file /proc/PID/status:
> >> >> >    VmLib:      1412 kB
> >> >> >    VmPTE:        20 kb
> >> >> >    VmSwap:        0 kB
> >> >> > +  VmTaskSize:	137438953468 kB
> >> >> >    HugetlbPages:          0 kB
> >> >> >    CoreDumping:    0
> >> >> >    THP_enabled:	  1
> >> >> > @@ -263,6 +264,7 @@ Table 1-2: Contents of the status files (as of 4.19)
> >> >> >   VmPTE                       size of page table entries
> >> >> >   VmSwap                      amount of swap used by anonymous private data
> >> >> >                               (shmem swap usage is not included)
> >> >> > + VmTaskSize                  lowest unusable address in process virtual memory
> >> >> 
> >> >> Can we change this help text to "size of process' virtual address space memory" ?
> >> >
> >> > Agree. Or go in other direction and make it VmEnd
> >> 
> >> Yeah I think VmEnd would be clearer to folks who aren't familiar with
> >> the kernel's usage of the TASK_SIZE terminology.
> >> 
> >> >> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> >> >> > index 95ca1fe7283c..0af7081f7b19 100644
> >> >> > --- a/fs/proc/task_mmu.c
> >> >> > +++ b/fs/proc/task_mmu.c
> >> >> > @@ -74,6 +74,8 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
> >> >> >  	seq_put_decimal_ull_width(m,
> >> >> >  		    " kB\nVmPTE:\t", mm_pgtables_bytes(mm) >> 10, 8);
> >> >> >  	SEQ_PUT_DEC(" kB\nVmSwap:\t", swap);
> >> >> > +	seq_put_decimal_ull_width(m,
> >> >> > +		    " kB\nVmTaskSize:\t", mm->task_size >> 10, 8);
> >> >> >  	seq_puts(m, " kB\n");
> >> >> >  	hugetlb_report_usage(m, mm);
> >> >> >  }
> >> >
> >> > I'm OK with technical part, but I still have questions not answered
> >> > (or wrongly answered) in v1 and v2. Below is the very detailed
> >> > description of the concerns I have.
> >> >
> >> > 1. What is the exact reason for it? Original version tells about some
> >> > test that takes so much time that you were able to drink a cup of
> >> > coffee before it was done. The test as you said implements linear
> >> > search to find the last page and so is of O(n). If it's only for some
> >> > random test, I think the kernel can survive without it. Do you have a
> >> > real example of useful programs that suffer without this information?
> >> >
> >> >
> >> > 2. I have nothing against taking breaks and see nothing weird if
> >> > ineffective algorithms take time. On my system (x86, Ubuntu) the last
> >> > mapped region according to /proc/<pid>/maps is:
> >> > ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0     [vsyscall]
> >> > So to find the required address, we have to inspect 2559 pages. With a
> >> > binary search it would take 12 iterations at max. If my calculation is
> >> > wrong or your environment is completely different - please elaborate.
> >> 
> >> I agree it should not be hard to calculate, but at the same time it's
> >> trivial for the kernel to export the information so I don't see why the
> >> kernel shouldn't.
> >
> > Kernel shouldn't do it unless there will be real users of the feature.
> > Otherwise it's pure bloating.
> 
> A single line or two of code to print a value that's useful information
> for userspace is hardly "bloat".
> 
> I agree it's good to have users for things, but this seems like it's so
> trivial that we should just add it and someone will find a use for it.

Little bloat is still bloat. Trivial useless code is still useless.

If someone finds a use of VmEnd, it should be thoroughly reviewed for
better alternatives.
 
> > One possible user of it that I can imagine is mmap(MAP_FIXED). The
> > documentation is very clear about it:
> >
> >    Furthermore,  this  option  is  extremely  hazardous (when used on its own),
> >    because it forcibly removes preexisting mappings, making it easy for a 
> >    multithreaded  process  to corrupt its own address space.
> >
> > VmEnd provided by kernel may encourage people to solve their problems
> > by using MAP_FIXED which is potentially dangerous.
> 
> There's MAP_FIXED_NOREPLACE now which is not dangerous.

MAP_FIXED_NOREPLACE is still not supported by glibc and not
documented. (Glibc doesn't use mman-common.h that comes from kernel,
and defines all mmap-related stuff in its own bits/mman.h). Therefore
from the point of view of 99% users MAP_FIXED_NOREPLACE doesn't exist.
Bionic defines MAP_FIXED_NOREPLACE but does not document it and doesn't
use.

> Using MAX_FIXED_NOREPLACE and VmEnd would make it relatively easy to do
> a userspace ASLR implementation, so that actually is an argument in
> favour IMHO.

Kernel-supported ASLR works well since 2.6.12. Do you see any
downside of using it?

MAP_RANDOM would be even more handy for userspace ASLR.

VmEnd in current form would break certain userspace programs that
has DEFAULT_MAP_WINDOW != TASK_SIZE. This is the case for 48-bit VA
programs running on 52-bits VA ARM kernel. See 363524d2b1227
(arm64: mm: Introduce DEFAULT_MAP_WINDOW).

> > Another scenario of VmEnd is to understand how many top bits of address will
> > be always zero to allocate them for user's purpose, like smart pointers. It
> > worth to discuss this usecase with compiler people. If they have interest,
> > I think it's more straightforward to give them something like:
> >    int preserve_top_bits(int nbits);
> 
> You mean a syscall?
> 
> With things like hardware pointer tagging / colouring coming along I
> think you're right that using VmEnd and assuming the top bits are never
> used is a bad idea, an explicit interface would be better.
> 
> cheers
