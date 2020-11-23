Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDF02C01C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 09:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgKWIye (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 03:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgKWIyd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 03:54:33 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81849C0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 00:54:33 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id l11so8532332plt.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 00:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+bYpsl8R9NvO/I5lN+BmuwOl70TRIsehsuL2xad98dg=;
        b=S70EpVIPjzIAK5nZ7KUmoydETAntPJamCslr4CbpuhjTFouDc0sfycP4I9S5jc4V12
         3CYcPiUZJR1TrV3XChtafJEEb3kabGjGfG3pIbI7kG+en3p+Zmw5NFGwHKmlDC8QsREc
         NYM+Gg4XzlqhW6d5Lg59iSB2acN5FN0eUBt94oTklB0VzsDC6RErR76C55MuchLXj6oM
         ktJbtKcbViCqOijsP7s73R2j7CaPPGR0DA0FZ8+onobungDtZd2SjRvZ1tkpmtbFfmGw
         q91FKsW0XkTmSnkZG86k4rrObeOrzNg4NnukYemJktelhKtPS6Ezi9VxYIGjBoJTWllt
         7qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+bYpsl8R9NvO/I5lN+BmuwOl70TRIsehsuL2xad98dg=;
        b=pAa48ilpl/yer6NtBhONDENrg/J6ZTUhX8VY88+fKQ/8lnvE4kuwTCWnqAyqDyonSg
         2tJknrcG8d6n0TB+nUkbmZ7di8Ru98F/t1NL08NG3c3CZq4Aavece/PYg65UTmRjXwis
         dxObRNfV8SV3vJa83z33EQ/SAbnscAfLrfn3+G3U+NHMRdccF4nIKosc1ZmLf4TP0CB1
         qjJg2VObZNhkhYAmaAQClVbfWqBzbSALYxAYQJmwkLGKhXSjq7Xt80qQHXYX8z+SMHNE
         CE2dKDtAhbQ286yDSufP6qQVwSc4QYuBE7u+wwEXHdtdVUKKpQ/iBBOc41fU9yZZL9GO
         /HSw==
X-Gm-Message-State: AOAM530WnYbB6ogOUrDjbMiNtz+XK9sZuz1CI4mMXasXqw3UdPNTRbQa
        +qJCfVWG1w3n1hK0pbnebHkgWJcG/QV2/0+2D5DcrQ==
X-Google-Smtp-Source: ABdhPJwq0k/O5Uc/JRdE+7QUeFuc9rwPeHWeJehd8e8HxO9FsA6DBl6oXeKnVkQ75hHtSHTg49fQ6xxBtkD8Wa9RyPE=
X-Received: by 2002:a17:902:c14b:b029:d6:ab18:108d with SMTP id
 11-20020a170902c14bb02900d6ab18108dmr23794233plj.20.1606121672924; Mon, 23
 Nov 2020 00:54:32 -0800 (PST)
MIME-Version: 1.0
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120084202.GJ3200@dhcp22.suse.cz> <CAMZfGtWJXni21J=Yn55gksKy9KZnDScCjKmMasNz5XUwx3OcKw@mail.gmail.com>
 <20201120131129.GO3200@dhcp22.suse.cz> <CAMZfGtWNDJWWTtpUDtngtgNiOoSd6sJpdAB6MnJW8KH0gePfYA@mail.gmail.com>
 <20201123074046.GB27488@dhcp22.suse.cz>
In-Reply-To: <20201123074046.GB27488@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 23 Nov 2020 16:53:53 +0800
Message-ID: <CAMZfGtV9WBu0OVi0fw4ab=t4zzY-uVn3amsa5ZHQhZBy88exFw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 00/21] Free some vmemmap pages of
 hugetlb page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 23, 2020 at 3:40 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 20-11-20 23:44:26, Muchun Song wrote:
> > On Fri, Nov 20, 2020 at 9:11 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Fri 20-11-20 20:40:46, Muchun Song wrote:
> > > > On Fri, Nov 20, 2020 at 4:42 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Fri 20-11-20 14:43:04, Muchun Song wrote:
> > > > > [...]
> > > > >
> > > > > Thanks for improving the cover letter and providing some numbers. I have
> > > > > only glanced through the patchset because I didn't really have more time
> > > > > to dive depply into them.
> > > > >
> > > > > Overall it looks promissing. To summarize. I would prefer to not have
> > > > > the feature enablement controlled by compile time option and the kernel
> > > > > command line option should be opt-in. I also do not like that freeing
> > > > > the pool can trigger the oom killer or even shut the system down if no
> > > > > oom victim is eligible.
> > > >
> > > > Hi Michal,
> > > >
> > > > I have replied to you about those questions on the other mail thread.
> > > >
> > > > Thanks.
> > > >
> > > > >
> > > > > One thing that I didn't really get to think hard about is what is the
> > > > > effect of vmemmap manipulation wrt pfn walkers. pfn_to_page can be
> > > > > invalid when racing with the split. How do we enforce that this won't
> > > > > blow up?
> > > >
> > > > This feature depends on the CONFIG_SPARSEMEM_VMEMMAP,
> > > > in this case, the pfn_to_page can work. The return value of the
> > > > pfn_to_page is actually the address of it's struct page struct.
> > > > I can not figure out where the problem is. Can you describe the
> > > > problem in detail please? Thanks.
> > >
> > > struct page returned by pfn_to_page might get invalid right when it is
> > > returned because vmemmap could get freed up and the respective memory
> > > released to the page allocator and reused for something else. See?
> >
> > If the HugeTLB page is already allocated from the buddy allocator,
> > the struct page of the HugeTLB can be freed? Does this exist?
>
> Nope, struct pages only ever get deallocated when the respective memory
> (they describe) is hotremoved via hotplug.
>
> > If yes, how to free the HugeTLB page to the buddy allocator
> > (cannot access the struct page)?
>
> But I do not follow how that relates to my concern above.

Sorry. I shouldn't understand your concerns.

vmemmap pages                 page frame
+-----------+   mapping to   +-----------+
|           | -------------> |     0     |
+-----------+                +-----------+
|           | -------------> |     1     |
+-----------+                +-----------+
|           | -------------> |     2     |
+-----------+                +-----------+
|           | -------------> |     3     |
+-----------+                +-----------+
|           | -------------> |     4     |
+-----------+                +-----------+
|           | -------------> |     5     |
+-----------+                +-----------+
|           | -------------> |     6     |
+-----------+                +-----------+
|           | -------------> |     7     |
+-----------+                +-----------+

In this patch series, we will free the page frame 2-7 to the
buddy allocator. You mean that pfn_to_page can return invalid
value when the pfn is the page frame 2-7? Thanks.

>
> --
> Michal Hocko
> SUSE Labs



--
Yours,
Muchun
