Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB542696443
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 14:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjBNNIg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 08:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjBNNIf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:08:35 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F0425E33
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 05:08:32 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id y2so4786749qvo.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 05:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d7iD43RuVySzDimpnmaP4LT4xXO0J3BUtoo0lGShArc=;
        b=pO1vKw910NGD+QvW3upj9bxB+96r0/YxhOOdt/cELSkVPjWrEljUmf4XzD4mfOYpew
         mqe2Yjn7WzmsgmuQM2wW/81XJ2G2fokcqcNwWs/H9Fu489nfYXGUhGj4e3xl5zgLMOYm
         UJjcBuIJVGeXNeRUGaYNE1s/nth54SN/PQHuBITj6lOBsEqiLg5aLbCCXIx8ug61XhyE
         3QVAJ+hK7P7o/N91LrfoPIvvi9ilW/dlQKNrfqi6v5s90uuWMB3zlqDpGIHP3/4XVYY9
         Jw0SHhZ/j5AYRFvwGemJejg7ozx8VOL6jGe3G/+UregpoDgy4Tx/o3rdV/4YpmWxj1rs
         XWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7iD43RuVySzDimpnmaP4LT4xXO0J3BUtoo0lGShArc=;
        b=DiyDnu+EKjJeOX15/dKHPv0awE3efUs0y1nB++t5JIaCCUWhzqREwS+gaeR9/FvknY
         6ZbhOyHK1wO3w4C+MvkipghgorhbWiUPdUQBU6nrYPaxU5HxM45TN8cud09gXq99Lfpd
         S88CdR2dzGeWbDxERDw8BvGcqss6ss5NynYb78iJ6RTNR5iRjbHVWFZ7R9efl+Mky9Tr
         WhHv6HCSzLsLrfIkaeh6+6f2Wznp3vzpx3nOteGIO/QqxfY06E5F+02QxwaO2Vy3oZxT
         PvIBa/v7D2fWvhGSkHg7wb8nRZ3wZN6vf//AUIVyRQ7PxwAG/BaQdUbv8Eo9VvYH2u2d
         l0tg==
X-Gm-Message-State: AO0yUKUXGCJ2Hp5inkQyJ3HxBJX3G478DBZ/VoX00E++TCLvwRYH0fCx
        eT09G28bCAd6sPl1TBQ9jQ+BCDPDikGwRoqCMEjVnA==
X-Google-Smtp-Source: AK7set/9NH3fHFal9QJ7z9f3vQC37YYM4w0VMhx4GLZZxCPRYzbFY5ZgZZBs0cL/X7/6SUX4p6gBRLnG5NbumKf4IRQ=
X-Received: by 2002:a0c:db07:0:b0:56e:986f:cc09 with SMTP id
 d7-20020a0cdb07000000b0056e986fcc09mr196862qvk.44.1676380111529; Tue, 14 Feb
 2023 05:08:31 -0800 (PST)
MIME-Version: 1.0
References: <20230207035139.272707-1-shiyn.lin@gmail.com> <CA+CK2bBt0Gujv9BdhghVkbFRirAxCYXbpH-nquccPsKGnGwOBQ@mail.gmail.com>
 <CANOhDtU3J8SUCzKtKvPPPrUHyo+LV5npNObHtYP_AK4W3LomDw@mail.gmail.com>
 <CA+CK2bAWnzqKDTjBbxXOvURwr7nWmf8q-mzD1x-ztwbWVQBQKA@mail.gmail.com>
 <Y+Z8ymNYc+vJMBx8@strix-laptop> <62c44d12-933d-ee66-ef50-467cd8d30a58@redhat.com>
In-Reply-To: <62c44d12-933d-ee66-ef50-467cd8d30a58@redhat.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 14 Feb 2023 08:07:54 -0500
Message-ID: <CA+CK2bB-dArab6scZU6tD7vnBBqbn9NwWbfwnddBzTxUmmhOfQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] Introduce Copy-On-Write to Page Table
To:     David Hildenbrand <david@redhat.com>
Cc:     Chih-En Lin <shiyn.lin@gmail.com>,
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
        "Zach O'Keefe" <zokeefe@google.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 14, 2023 at 4:58 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 10.02.23 18:20, Chih-En Lin wrote:
> > On Fri, Feb 10, 2023 at 11:21:16AM -0500, Pasha Tatashin wrote:
> >>>>> Currently, copy-on-write is only used for the mapped memory; the child
> >>>>> process still needs to copy the entire page table from the parent
> >>>>> process during forking. The parent process might take a lot of time and
> >>>>> memory to copy the page table when the parent has a big page table
> >>>>> allocated. For example, the memory usage of a process after forking with
> >>>>> 1 GB mapped memory is as follows:
> >>>>
> >>>> For some reason, I was not able to reproduce performance improvements
> >>>> with a simple fork() performance measurement program. The results that
> >>>> I saw are the following:
> >>>>
> >>>> Base:
> >>>> Fork latency per gigabyte: 0.004416 seconds
> >>>> Fork latency per gigabyte: 0.004382 seconds
> >>>> Fork latency per gigabyte: 0.004442 seconds
> >>>> COW kernel:
> >>>> Fork latency per gigabyte: 0.004524 seconds
> >>>> Fork latency per gigabyte: 0.004764 seconds
> >>>> Fork latency per gigabyte: 0.004547 seconds
> >>>>
> >>>> AMD EPYC 7B12 64-Core Processor
> >>>> Base:
> >>>> Fork latency per gigabyte: 0.003923 seconds
> >>>> Fork latency per gigabyte: 0.003909 seconds
> >>>> Fork latency per gigabyte: 0.003955 seconds
> >>>> COW kernel:
> >>>> Fork latency per gigabyte: 0.004221 seconds
> >>>> Fork latency per gigabyte: 0.003882 seconds
> >>>> Fork latency per gigabyte: 0.003854 seconds
> >>>>
> >>>> Given, that page table for child is not copied, I was expecting the
> >>>> performance to be better with COW kernel, and also not to depend on
> >>>> the size of the parent.
> >>>
> >>> Yes, the child won't duplicate the page table, but fork will still
> >>> traverse all the page table entries to do the accounting.
> >>> And, since this patch expends the COW to the PTE table level, it's not
> >>> the mapped page (page table entry) grained anymore, so we have to
> >>> guarantee that all the mapped page is available to do COW mapping in
> >>> the such page table.
> >>> This kind of checking also costs some time.
> >>> As a result, since the accounting and the checking, the COW PTE fork
> >>> still depends on the size of the parent so the improvement might not
> >>> be significant.
> >>
> >> The current version of the series does not provide any performance
> >> improvements for fork(). I would recommend removing claims from the
> >> cover letter about better fork() performance, as this may be
> >> misleading for those looking for a way to speed up forking. In my
> >
> >  From v3 to v4, I changed the implementation of the COW fork() part to do
> > the accounting and checking. At the time, I also removed most of the
> > descriptions about the better fork() performance. Maybe it's not enough
> > and still has some misleading. I will fix this in the next version.
> > Thanks.
> >
> >> case, I was looking to speed up Redis OSS, which relies on fork() to
> >> create consistent snapshots for driving replicates/backups. The O(N)
> >> per-page operation causes fork() to be slow, so I was hoping that this
> >> series, which does not duplicate the VA during fork(), would make the
> >> operation much quicker.
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
> optimizations) and evaluating it accordingly. It's certainly "cleaner",
> such that we only have to mess with unsharing and not with other
> accounting/pinning/mapcount thingies. But it also highlights how
> intrusive even this basic deduplication approach already is -- and that
> most benefits of the original approach requires even more complexity on top.
>
> I am not quite sure if the benefit is worth the price (I am not to
> decide and I would like to hear other options).
>
> My quick thoughts after skimming over the core parts of this series
>
> (1) forgetting to break COW on a PTE in some pgtable walker feels quite
>      likely (meaning that it might be fairly error-prone) and forgetting
>      to break COW on a PTE table, accidentally modifying the shared
>      table.
> (2) break_cow_pte() can fail, which means that we can fail some
>      operations (possibly silently halfway through) now. For example,
>      looking at your change_pte_range() change, I suspect it's wrong.
> (3) handle_cow_pte_fault() looks quite complicated and needs quite some
>      double-checking: we temporarily clear the PMD, to reset it
>      afterwards. I am not sure if that is correct. For example, what
>      stops another page fault stumbling over that pmd_none() and
>      allocating an empty page table? Maybe there are some locking details
>      missing or they are very subtle such that we better document them. I
>     recall that THP played quite some tricks to make such cases work ...
>
> >
> >>> Actually, at the RFC v1 and v2, we proposed the version of skipping
> >>> those works, and we got a significant improvement. You can see the
> >>> number from RFC v2 cover letter [1]:
> >>> "In short, with 512 MB mapped memory, COW PTE decreases latency by 93%
> >>> for normal fork"
> >>
> >> I suspect the 93% improvement (when the mapcount was not updated) was
> >> only for VAs with 4K pages. With 2M mappings this series did not
> >> provide any benefit is this correct?
> >
> > Yes. In this case, the COW PTE performance is similar to the normal
> > fork().
>
>
> The thing with THP is, that during fork(), we always allocate a backup
> PTE table, to be able to PTE-map the THP whenever we have to. Otherwise
> we'd have to eventually fail some operations we don't want to fail --
> similar to the case where break_cow_pte() could fail now due to -ENOMEM
> although we really don't want to fail (e.g., change_pte_range() ).
>
> I always considered that wasteful, because in many scenarios, we'll
> never ever split a THP and possibly waste memory.

Yes, it does sound wasteful for a pretty rare corner case that
combines splitting THP in a process, and not having enough memory to
allocate PTE page tables.

> Optimizing that for THP (e.g., don't always allocate backup THP, have
> some global allocation backup pool for splits + refill when
> close-to-empty) might provide similar fork() improvements, both in speed
> and memory consumption when it comes to anonymous memory.

This sounds like a reasonable way to optimize the fork performance for
processes with large RSS, which in most cases would have 2M THP
mappings. When you say global pool, do you mean per machine, per
cgroup, or per process?

Pasha

>
> --
> Thanks,
>
> David / dhildenb
>
>
