Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045136968AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 17:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjBNQAI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 11:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbjBNP74 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:59:56 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E1C4EF8;
        Tue, 14 Feb 2023 07:59:37 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id w14-20020a17090a5e0e00b00233d3b9650eso8385688pjf.4;
        Tue, 14 Feb 2023 07:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3g86130uxQggxNGw5hMsuR1xjKf2UnEXUI3pZWrB+zM=;
        b=QcKhuLxD8asj0kZsWaPRbgWs2XT8VLb30pfsTaOckvDJupF88yC7qaFi3lWZfyPGcW
         mI0LuhqYrA1R7D9TGQ6Bt8eEPIzxPUTb6URIIp1f6CeSu52KX8S+0wOxy6luHIoH9oy6
         lqyK+n4FdsbErGo78uljdTf0rJzHvyrYTS91XK7E3iRUcik4GlAf66kKQ8KN8YYeMjvx
         Jqw5T8L9gyFKqWQq9YhZIVsPw/fmdmgm2KZffUOHVCdI2SZwBkHWAlwjZX+tBlzklw5R
         7juv7VtVsSwuiMwz9w/9e7m5YtPEdc8QdJU16ZpiAxbD8cr54wTIBQ0CIkDAAB3d30Ts
         /h/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3g86130uxQggxNGw5hMsuR1xjKf2UnEXUI3pZWrB+zM=;
        b=5iPhHdIDmzc2ltKpTx6aQSAA8Z3P3pOPhyPWKy2bY0skiXJQp5FkDsVJ3y7glx9sZ+
         BZzr7OkIEM79fNx35xdqycQhnkCCiwdb13j4J6BczusUY5bb0drxfwdfv2Lw6Z2KPGKc
         qrNqE0BKaIIsVO/KxrrIAqAHddzF9wWmZFxiPMzkySNCVfEY8ATpzEEjsBWD2scPAIri
         CzsGMboxJIe/cGFVdtiqvMB8oWcxSSvWgICqhUjb9tuk9FqjmxBLwkzO9CJpykLdNhb8
         LWLq5ceMc3Z1o/TJ4rtVic+AGRIbYtOmBclZfjMguXAVWaRPRXt4GDAIrxJ+sTBs9lAY
         3fkQ==
X-Gm-Message-State: AO0yUKWNRPRfw/tkX5o3FoGe3yGrfkjmDIHJkeiSrKa1/0CMRpi69pW+
        zm+IsnXBUFg1kd7eoo45Pdo=
X-Google-Smtp-Source: AK7set/tJsqtwlyKqGqi+ILx69c+tzsbCCp7rep+puceR0LRE9p78Ievlg5P9dVL/lKi+YWzbiIzdQ==
X-Received: by 2002:a17:90b:3806:b0:233:be3d:8a49 with SMTP id mq6-20020a17090b380600b00233be3d8a49mr2979380pjb.11.1676390377060;
        Tue, 14 Feb 2023 07:59:37 -0800 (PST)
Received: from strix-laptop (2001-b011-20e0-1465-11be-7287-d61f-f938.dynamic-ip6.hinet.net. [2001:b011:20e0:1465:11be:7287:d61f:f938])
        by smtp.gmail.com with ESMTPSA id mp6-20020a17090b190600b00233c9eb64f3sm5862366pjb.47.2023.02.14.07.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 07:59:36 -0800 (PST)
Date:   Tue, 14 Feb 2023 23:59:26 +0800
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <namit@vmware.com>, Barry Song <baohua@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zach O'Keefe <zokeefe@google.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Juergen Gross <jgross@suse.com>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Li kunyu <kunyu@nfschina.com>,
        Minchan Kim <minchan@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        Barret Rhoden <brho@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alexey Gladkov <legion@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
Subject: Re: [PATCH v4 00/14] Introduce Copy-On-Write to Page Table
Message-ID: <Y+uv3iTajGoOuNMO@strix-laptop>
References: <20230207035139.272707-1-shiyn.lin@gmail.com>
 <CA+CK2bBt0Gujv9BdhghVkbFRirAxCYXbpH-nquccPsKGnGwOBQ@mail.gmail.com>
 <CANOhDtU3J8SUCzKtKvPPPrUHyo+LV5npNObHtYP_AK4W3LomDw@mail.gmail.com>
 <CA+CK2bAWnzqKDTjBbxXOvURwr7nWmf8q-mzD1x-ztwbWVQBQKA@mail.gmail.com>
 <Y+Z8ymNYc+vJMBx8@strix-laptop>
 <62c44d12-933d-ee66-ef50-467cd8d30a58@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62c44d12-933d-ee66-ef50-467cd8d30a58@redhat.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 14, 2023 at 10:58:30AM +0100, David Hildenbrand wrote:
> On 10.02.23 18:20, Chih-En Lin wrote:
> > On Fri, Feb 10, 2023 at 11:21:16AM -0500, Pasha Tatashin wrote:
> > > > > > Currently, copy-on-write is only used for the mapped memory; the child
> > > > > > process still needs to copy the entire page table from the parent
> > > > > > process during forking. The parent process might take a lot of time and
> > > > > > memory to copy the page table when the parent has a big page table
> > > > > > allocated. For example, the memory usage of a process after forking with
> > > > > > 1 GB mapped memory is as follows:
> > > > > 
> > > > > For some reason, I was not able to reproduce performance improvements
> > > > > with a simple fork() performance measurement program. The results that
> > > > > I saw are the following:
> > > > > 
> > > > > Base:
> > > > > Fork latency per gigabyte: 0.004416 seconds
> > > > > Fork latency per gigabyte: 0.004382 seconds
> > > > > Fork latency per gigabyte: 0.004442 seconds
> > > > > COW kernel:
> > > > > Fork latency per gigabyte: 0.004524 seconds
> > > > > Fork latency per gigabyte: 0.004764 seconds
> > > > > Fork latency per gigabyte: 0.004547 seconds
> > > > > 
> > > > > AMD EPYC 7B12 64-Core Processor
> > > > > Base:
> > > > > Fork latency per gigabyte: 0.003923 seconds
> > > > > Fork latency per gigabyte: 0.003909 seconds
> > > > > Fork latency per gigabyte: 0.003955 seconds
> > > > > COW kernel:
> > > > > Fork latency per gigabyte: 0.004221 seconds
> > > > > Fork latency per gigabyte: 0.003882 seconds
> > > > > Fork latency per gigabyte: 0.003854 seconds
> > > > > 
> > > > > Given, that page table for child is not copied, I was expecting the
> > > > > performance to be better with COW kernel, and also not to depend on
> > > > > the size of the parent.
> > > > 
> > > > Yes, the child won't duplicate the page table, but fork will still
> > > > traverse all the page table entries to do the accounting.
> > > > And, since this patch expends the COW to the PTE table level, it's not
> > > > the mapped page (page table entry) grained anymore, so we have to
> > > > guarantee that all the mapped page is available to do COW mapping in
> > > > the such page table.
> > > > This kind of checking also costs some time.
> > > > As a result, since the accounting and the checking, the COW PTE fork
> > > > still depends on the size of the parent so the improvement might not
> > > > be significant.
> > > 
> > > The current version of the series does not provide any performance
> > > improvements for fork(). I would recommend removing claims from the
> > > cover letter about better fork() performance, as this may be
> > > misleading for those looking for a way to speed up forking. In my
> > 
> >  From v3 to v4, I changed the implementation of the COW fork() part to do
> > the accounting and checking. At the time, I also removed most of the
> > descriptions about the better fork() performance. Maybe it's not enough
> > and still has some misleading. I will fix this in the next version.
> > Thanks.
> > 
> > > case, I was looking to speed up Redis OSS, which relies on fork() to
> > > create consistent snapshots for driving replicates/backups. The O(N)
> > > per-page operation causes fork() to be slow, so I was hoping that this
> > > series, which does not duplicate the VA during fork(), would make the
> > > operation much quicker.
> > 
> > Indeed, at first, I tried to avoid the O(N) per-page operation by
> > deferring the accounting and the swap stuff to the page fault. But,
> > as I mentioned, it's not suitable for the mainline.
> > 
> > Honestly, for improving the fork(), I have an idea to skip the per-page
> > operation without breaking the logic. However, this will introduce the
> > complicated mechanism and may has the overhead for other features. It
> > might not be worth it. It's hard to strike a balance between the
> > over-complicated mechanism with (probably) better performance and data
> > consistency with the page status. So, I would focus on the safety and
> > stable approach at first.
> 
> Yes, it is most probably possible, but complexity, robustness and
> maintainability have to be considered as well.
> 
> Thanks for implementing this approach (only deduplication without other
> optimizations) and evaluating it accordingly. It's certainly "cleaner", such
> that we only have to mess with unsharing and not with other
> accounting/pinning/mapcount thingies. But it also highlights how intrusive
> even this basic deduplication approach already is -- and that most benefits
> of the original approach requires even more complexity on top.
> 
> I am not quite sure if the benefit is worth the price (I am not to decide
> and I would like to hear other options).

I'm looking at the discussion of page table sharing in 2002 [1]. 
It looks like in 2002 ~ 2006, there also have some patches try to
improve fork().

After that, I also saw one thread which is about another shared page
table patch's benchmark. I can't find the original patch though [2].
But, I found the probably same patch in 2005 [3], it also mentioned
the previous benchmark discussion:

"
For those familiar with the shared page table patch I did a couple of years
ago, this patch does not implement copy-on-write page tables for private
mappings.  Analysis showed the cost and complexity far outweighed any
potential benefit.
"

However, it might be different right now. For example, the implemetation
. We have split page table lock now, so we don't have to consider the
page_table_share_lock thing. Also, presently, we have different use
cases (shells [2] v.s. VM cloning and fuzzing) to consider.

Nonetheless, I still think the discussion can provide some of the mind
to us.

BTW, It seems like the 2002 patch [1] is different from the 2002 [2]
and 2005 [3].

[1] https://lkml.iu.edu/hypermail/linux/kernel/0202.2/0102.html
[2] https://lore.kernel.org/linux-mm/3E02FACD.5B300794@digeo.com/
[3] https://lore.kernel.org/linux-mm/7C49DFF721CB4E671DB260F9@%5B10.1.1.4%5D/T/#u

> My quick thoughts after skimming over the core parts of this series
> 
> (1) forgetting to break COW on a PTE in some pgtable walker feels quite
>     likely (meaning that it might be fairly error-prone) and forgetting
>     to break COW on a PTE table, accidentally modifying the shared
>     table.

Maybe I should also handle arch/ and others parts.
I will keep looking at where I missed.

> (2) break_cow_pte() can fail, which means that we can fail some
>     operations (possibly silently halfway through) now. For example,
>     looking at your change_pte_range() change, I suspect it's wrong.

Maybe I should add WARN_ON() and skip the failed COW PTE.

> (3) handle_cow_pte_fault() looks quite complicated and needs quite some
>     double-checking: we temporarily clear the PMD, to reset it
>     afterwards. I am not sure if that is correct. For example, what
>     stops another page fault stumbling over that pmd_none() and
>     allocating an empty page table? Maybe there are some locking details
>     missing or they are very subtle such that we better document them. I
>    recall that THP played quite some tricks to make such cases work ...

I think that holding mmap_write_lock may be enough (I added
mmap_assert_write_locked() in the fault function btw). But, I might
be wrong. I will look at the THP stuff to see how they work. Thanks.

Thanks for the review.

> > 
> > > > Actually, at the RFC v1 and v2, we proposed the version of skipping
> > > > those works, and we got a significant improvement. You can see the
> > > > number from RFC v2 cover letter [1]:
> > > > "In short, with 512 MB mapped memory, COW PTE decreases latency by 93%
> > > > for normal fork"
> > > 
> > > I suspect the 93% improvement (when the mapcount was not updated) was
> > > only for VAs with 4K pages. With 2M mappings this series did not
> > > provide any benefit is this correct?
> > 
> > Yes. In this case, the COW PTE performance is similar to the normal
> > fork().
> 
> 
> The thing with THP is, that during fork(), we always allocate a backup PTE
> table, to be able to PTE-map the THP whenever we have to. Otherwise we'd
> have to eventually fail some operations we don't want to fail -- similar to
> the case where break_cow_pte() could fail now due to -ENOMEM although we
> really don't want to fail (e.g., change_pte_range() ).
> 
> I always considered that wasteful, because in many scenarios, we'll never
> ever split a THP and possibly waste memory.
> 
> Optimizing that for THP (e.g., don't always allocate backup THP, have some
> global allocation backup pool for splits + refill when close-to-empty) might
> provide similar fork() improvements, both in speed and memory consumption
> when it comes to anonymous memory.

When collapsing huge pages, do/can they reuse those PTEs for backup?
So, we don't have to allocate the PTE or maintain the pool.

Thanks,
Chih-En Lin
