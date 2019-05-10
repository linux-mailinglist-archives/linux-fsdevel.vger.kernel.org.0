Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4F95198FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 09:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfEJHZE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 03:25:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45837 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfEJHZE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 03:25:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id i21so2553486pgi.12;
        Fri, 10 May 2019 00:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MxdAiari0nmP4dzXk8y1jGFeEkTXq4eqOJGoyehmXIg=;
        b=S4deC/hCB9MWckQ7p7EvDz7MCjGrl8YSsW+gbeIAUPtPvn/NVkV0jpq3+YnLs+0HM5
         6L3YHqvsUz8azvLbSvXfAILZ+X3c6w3Kzb5VB0LhrqklV+Hq/fyPjB279ApmeAlgLKaa
         RhHdrOkokuhbQTYXqpF3Hlsbqzu6Wkc1aB6BEjbWgKuV0TEPz+8TPURDADd7CJRozhe3
         KquzhfcwsEh7OzsOwWJImDW9qTVMzw7Pbkzi4Hekb+dD27dxFYC0CJHTC1kUcuYGosq5
         xmyseexu3M+Tzdp5ZqYb+j1U4CADmYf817shn+tWjiu6gFZD7O27U8SvaNsXb22eDHgB
         ngcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MxdAiari0nmP4dzXk8y1jGFeEkTXq4eqOJGoyehmXIg=;
        b=miaMqnM2rdpUn/9xD2z9/YgKBpGNlpJV0v2tx5jALcuQwetyn0ev9UJX1F9YP2onl1
         1UVESVOp8MhWF8lh+zCnzpSH8uIuxB2xg3B2uAp62ntGgwMGJ484NM2qPviC3xuSJSOm
         CS/5eDGYSkySLXRBhWobVnGvIIDcRT3uhQLfnZhkh1BadvlbpdO05W7dwbpWMLH0s9l8
         ZgRv7hsri2zizrkpDzhsK+rVEXGwPYABzMd/5znUbjnwmK0ohTIcnbG2QrN1U33Xz4N6
         iYNG6gmb1mP2115WaQngmZlyG+Nb5nM6fUK0+lkWaJLEgHIE66qRAYFuCsGAV2YMrDhf
         OzqA==
X-Gm-Message-State: APjAAAXVm/K9kV72uyMbGGITXuCgsKULX1c3nD99xwyfK7GOkySvV0Fb
        MrKsNdzTXedR1X5UvpJldIE=
X-Google-Smtp-Source: APXvYqymmigac22Jqy6M2hK7+ePaHYrKV0Cx4Y210l9vnI9b0FU2xOOkWf23ZRWm2Tq7zbG6sKZFvQ==
X-Received: by 2002:aa7:8046:: with SMTP id y6mr12066017pfm.251.1557473102856;
        Fri, 10 May 2019 00:25:02 -0700 (PDT)
Received: from localhost ([2601:640:1:34d8:19d3:11c4:475e:3daa])
        by smtp.gmail.com with ESMTPSA id z66sm6289282pfz.83.2019.05.10.00.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 00:25:01 -0700 (PDT)
Date:   Fri, 10 May 2019 00:25:00 -0700
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
Message-ID: <20190510072500.GA1520@yury-thinkpad>
References: <1557158023-23021-1-git-send-email-jsavitz@redhat.com>
 <20190507125430.GA31025@x230.aquini.net>
 <20190508063716.GA3096@yury-thinkpad>
 <87k1ezugqh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1ezugqh.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 10, 2019 at 01:32:22PM +1000, Michael Ellerman wrote:
> Yury Norov <yury.norov@gmail.com> writes:
> > On Tue, May 07, 2019 at 08:54:31AM -0400, Rafael Aquini wrote:
> >> On Mon, May 06, 2019 at 11:53:43AM -0400, Joel Savitz wrote:
> >> > There is currently no easy and architecture-independent way to find the
> >> > lowest unusable virtual address available to a process without
> >> > brute-force calculation. This patch allows a user to easily retrieve
> >> > this value via /proc/<pid>/status.
> >> > 
> >> > Using this patch, any program that previously needed to waste cpu cycles
> >> > recalculating a non-sensitive process-dependent value already known to
> >> > the kernel can now be optimized to use this mechanism.
> >> > 
> >> > Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> >> > ---
> >> >  Documentation/filesystems/proc.txt | 2 ++
> >> >  fs/proc/task_mmu.c                 | 2 ++
> >> >  2 files changed, 4 insertions(+)
> >> > 
> >> > diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
> >> > index 66cad5c86171..1c6a912e3975 100644
> >> > --- a/Documentation/filesystems/proc.txt
> >> > +++ b/Documentation/filesystems/proc.txt
> >> > @@ -187,6 +187,7 @@ read the file /proc/PID/status:
> >> >    VmLib:      1412 kB
> >> >    VmPTE:        20 kb
> >> >    VmSwap:        0 kB
> >> > +  VmTaskSize:	137438953468 kB
> >> >    HugetlbPages:          0 kB
> >> >    CoreDumping:    0
> >> >    THP_enabled:	  1
> >> > @@ -263,6 +264,7 @@ Table 1-2: Contents of the status files (as of 4.19)
> >> >   VmPTE                       size of page table entries
> >> >   VmSwap                      amount of swap used by anonymous private data
> >> >                               (shmem swap usage is not included)
> >> > + VmTaskSize                  lowest unusable address in process virtual memory
> >> 
> >> Can we change this help text to "size of process' virtual address space memory" ?
> >
> > Agree. Or go in other direction and make it VmEnd
> 
> Yeah I think VmEnd would be clearer to folks who aren't familiar with
> the kernel's usage of the TASK_SIZE terminology.
> 
> >> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> >> > index 95ca1fe7283c..0af7081f7b19 100644
> >> > --- a/fs/proc/task_mmu.c
> >> > +++ b/fs/proc/task_mmu.c
> >> > @@ -74,6 +74,8 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
> >> >  	seq_put_decimal_ull_width(m,
> >> >  		    " kB\nVmPTE:\t", mm_pgtables_bytes(mm) >> 10, 8);
> >> >  	SEQ_PUT_DEC(" kB\nVmSwap:\t", swap);
> >> > +	seq_put_decimal_ull_width(m,
> >> > +		    " kB\nVmTaskSize:\t", mm->task_size >> 10, 8);
> >> >  	seq_puts(m, " kB\n");
> >> >  	hugetlb_report_usage(m, mm);
> >> >  }
> >
> > I'm OK with technical part, but I still have questions not answered
> > (or wrongly answered) in v1 and v2. Below is the very detailed
> > description of the concerns I have.
> >
> > 1. What is the exact reason for it? Original version tells about some
> > test that takes so much time that you were able to drink a cup of
> > coffee before it was done. The test as you said implements linear
> > search to find the last page and so is of O(n). If it's only for some
> > random test, I think the kernel can survive without it. Do you have a
> > real example of useful programs that suffer without this information?
> >
> >
> > 2. I have nothing against taking breaks and see nothing weird if
> > ineffective algorithms take time. On my system (x86, Ubuntu) the last
> > mapped region according to /proc/<pid>/maps is:
> > ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0     [vsyscall]
> > So to find the required address, we have to inspect 2559 pages. With a
> > binary search it would take 12 iterations at max. If my calculation is
> > wrong or your environment is completely different - please elaborate.
> 
> I agree it should not be hard to calculate, but at the same time it's
> trivial for the kernel to export the information so I don't see why the
> kernel shouldn't.

Kernel shouldn't do it unless there will be real users of the feature.
Otherwise it's pure bloating.

One possible user of it that I can imagine is mmap(MAP_FIXED). The
documentation is very clear about it:

   Furthermore,  this  option  is  extremely  hazardous (when used on its own),
   because it forcibly removes preexisting mappings, making it easy for a 
   multithreaded  process  to corrupt its own address space.

VmEnd provided by kernel may encourage people to solve their problems
by using MAP_FIXED which is potentially dangerous.

Another scenario of VmEnd is to understand how many top bits of address will
be always zero to allocate them for user's purpose, like smart pointers. It
worth to discuss this usecase with compiler people. If they have interest,
I think it's more straightforward to give them something like:
   int preserve_top_bits(int nbits);

Anything else?
 
> > 3. As far as I can see, Linux currently does not support dynamic
> > TASK_SIZE. It means that for any platform+ABI combination VmTaskSize
> > will be always the same. So VmTaskSize would be effectively useless waste
> > of lines. In fact, TASK SIZE is compiler time information and should
> > be exposed to user in headers. In discussion to v2 Rafael Aquini answered
> > for this concern that TASK_SIZE is a runtime resolved macro. It's
> > true, but my main point is: GCC knows what type of binary it compiles
> > and is able to select proper value. We are already doing similar things
> > where appropriate. Refer for example to my arm64/ilp32 series:
> >
> > arch/arm64/include/uapi/asm/bitsperlong.h:
> > -#define __BITS_PER_LONG 64
> > +#if defined(__LP64__)
> > +/* Assuming __LP64__ will be defined for native ELF64's and not for ILP32. */
> > +#  define __BITS_PER_LONG 64
> > +#elif defined(__ILP32__)
> > +#  define __BITS_PER_LONG 32
> > +#else
> > +#  error "Neither LP64 nor ILP32: unsupported ABI in asm/bitsperlong.h"
> > +#endif
> >
> > __LP64__ and __ILP32__ are symbols provided by GCC to distinguish
> > between ABIs. So userspace is able to take proper __BITS_PER_LONG value
> > at compile time, not at runtime. I think, you can do the same thing for
> > TASK_SIZE.
> 
> No you can't do it at compile time for TASK_SIZE.
> 
> On powerpc a 64-bit program might run on a kernel built with 4K pages
> where TASK_SIZE is 64TB, and that same program can run on a kernel built
> with 64K pages where TASK_SIZE is 4PB.
> 
> And it's not just determined by PAGE_SIZE, that same program might also
> run on an older kernel where TASK_SIZE with 64K pages was 512TB.

OK, understood.
