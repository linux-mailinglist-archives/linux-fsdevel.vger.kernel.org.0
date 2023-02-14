Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A38F696DB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 20:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjBNTRq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 14:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjBNTRo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 14:17:44 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B53526879;
        Tue, 14 Feb 2023 11:17:41 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d8-20020a17090ad98800b002344fa17c8bso469797pjv.5;
        Tue, 14 Feb 2023 11:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G6VI4UtKMXGf1NILxkcNf7EW/7unsO+N5Ql2yHcyswI=;
        b=RD75b2TbvISNpQa3I0LdGHwJUdi6tx3O6Uqz1DY/dlHboU15NvSDsBv8Lq1f72CV8P
         F7ApiY7xk9aklr/3IwN3wHEQhzw2Xh0CpapfVgCAsdxo+h1tm2hPwuL6XlR3TH29OcHc
         AunP9G4sloIKw138O9BYP8/EVaVl5nKcS1wWYJJ9BRt4hcxSrBZ03FLk2yrrCeS78g0e
         pdPTY5RwZ55QsWpUh03LCfzaFie5td3diC3UQ6NxPJ/eXLDrh7egh3y23ZIfxvk8T2PG
         Yx8ziVNHlt1m7wSbU/WG2Lc4124UhOS1BjYtxLKL0Tj+qwcevi7ivzeLGFeZWdWUHkUL
         0LOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6VI4UtKMXGf1NILxkcNf7EW/7unsO+N5Ql2yHcyswI=;
        b=XkQG5TuYuu5MRpSxlfF9mWOQlEBXwSwkrHMiu5eZWwAbPu+ceqWq2GVmeR39DJpJOv
         L7rw6qgRyfTDhb6gzEQtvuO4Nlx1Dr6xHoX8GfLaVdRX3RaDzfA35u1PEEa0hm6dWi+3
         DUugrAh9+5cX5TdiqAgKWkHEDh8Ks1afujeTwXpSvC52C7kQ8dcq+9g/6YUOYncqbb0Z
         lp52xSKeQyKUlLBMLMfSj5onDxvZfUVf0zlbIR32lCk2pp3oM/uN627Npk+Joo8Z5oL+
         D8pObPvOhOLa3ak6wBgV//ppIm/Vsosg+qlotvwSHUUduqSh1PUmwK2DqgbmfzPXueFT
         pKLg==
X-Gm-Message-State: AO0yUKXsXoiJQTrJDhGekeiEziI8gftLqfOR9XLqdn3zHz5bXU9q1CFP
        OAQbEo8zmKL1fDzkLYrgqP0=
X-Google-Smtp-Source: AK7set+cZzS5QlAok+A3hUaDau+IPIxcFuWKmquBgdY6gCbMbiInMO7ULCrCSY5QJmWyZW0RRRY2IA==
X-Received: by 2002:a05:6a20:914a:b0:bc:d601:ebfc with SMTP id x10-20020a056a20914a00b000bcd601ebfcmr4361736pzc.54.1676402260776;
        Tue, 14 Feb 2023 11:17:40 -0800 (PST)
Received: from strix-laptop (2001-b011-20e0-1465-11be-7287-d61f-f938.dynamic-ip6.hinet.net. [2001:b011:20e0:1465:11be:7287:d61f:f938])
        by smtp.gmail.com with ESMTPSA id h18-20020a656392000000b004fb4489969bsm9231927pgv.49.2023.02.14.11.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 11:17:40 -0800 (PST)
Date:   Wed, 15 Feb 2023 03:17:30 +0800
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     David Hildenbrand <david@redhat.com>,
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
Message-ID: <Y+veStmKQa5o3A6j@strix-laptop>
References: <20230207035139.272707-1-shiyn.lin@gmail.com>
 <CA+CK2bBt0Gujv9BdhghVkbFRirAxCYXbpH-nquccPsKGnGwOBQ@mail.gmail.com>
 <CANOhDtU3J8SUCzKtKvPPPrUHyo+LV5npNObHtYP_AK4W3LomDw@mail.gmail.com>
 <CA+CK2bAWnzqKDTjBbxXOvURwr7nWmf8q-mzD1x-ztwbWVQBQKA@mail.gmail.com>
 <Y+Z8ymNYc+vJMBx8@strix-laptop>
 <62c44d12-933d-ee66-ef50-467cd8d30a58@redhat.com>
 <Y+uv3iTajGoOuNMO@strix-laptop>
 <CA+CK2bCKOONeipaYNQJSPTicej1DW0OWvw97r0TbG7oRtxVGnQ@mail.gmail.com>
 <Y+vV9YaiEIUQaW65@strix-laptop>
 <CA+CK2bDYHT4m=we7jbLWxneZTnBt2wJd2Msw67V97c1nNq-KZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bDYHT4m=we7jbLWxneZTnBt2wJd2Msw67V97c1nNq-KZQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 14, 2023 at 01:52:16PM -0500, Pasha Tatashin wrote:
> On Tue, Feb 14, 2023 at 1:42 PM Chih-En Lin <shiyn.lin@gmail.com> wrote:
> >
> > On Tue, Feb 14, 2023 at 11:30:26AM -0500, Pasha Tatashin wrote:
> > > > > The thing with THP is, that during fork(), we always allocate a backup PTE
> > > > > table, to be able to PTE-map the THP whenever we have to. Otherwise we'd
> > > > > have to eventually fail some operations we don't want to fail -- similar to
> > > > > the case where break_cow_pte() could fail now due to -ENOMEM although we
> > > > > really don't want to fail (e.g., change_pte_range() ).
> > > > >
> > > > > I always considered that wasteful, because in many scenarios, we'll never
> > > > > ever split a THP and possibly waste memory.
> > > > >
> > > > > Optimizing that for THP (e.g., don't always allocate backup THP, have some
> > > > > global allocation backup pool for splits + refill when close-to-empty) might
> > > > > provide similar fork() improvements, both in speed and memory consumption
> > > > > when it comes to anonymous memory.
> > > >
> > > > When collapsing huge pages, do/can they reuse those PTEs for backup?
> > > > So, we don't have to allocate the PTE or maintain the pool.
> > >
> > > It might not work for all pages, as collapsing pages might have had
> > > holes in the user page table, and there were no PTE tables.
> >
> > So if there have holes in the user page table, after we doing the
> > collapsing and then splitting. Do those holes be filled? Assume it is,
> > then, I think it's the reason why it's not work for all the pages.
> >
> > But, after those operations, Will the user get the additional and
> > unexpected memory (which is from the huge page filling)?
> 
> Yes, more memory is going to be allocated for a process in such THP
> collapse case. This is similar to madvise huge pages, and touching the
> first byte may allocate 2M.

Thanks for the explanation.
Yeah, It seems like the reuse case can't work for all the pages.

Thanks,
Chih-En Lin
