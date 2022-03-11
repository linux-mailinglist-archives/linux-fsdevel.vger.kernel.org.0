Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BCA4D5E0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 10:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343548AbiCKJG5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 04:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbiCKJG4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:06:56 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C021BB70D
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Mar 2022 01:05:53 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id h126so15981508ybc.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Mar 2022 01:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m4uZHfd5TEknERkFPf+I/joPh8Butuy4Qgst4A1Cqjw=;
        b=pF6htef8BElDLh5mKnFuCbURvy+T/DgtLXd1OrtoV5iZB/kuFmt74asVUCwjaEiP1W
         VvVb0/uyuvzAHsaOwfvAPUbNjLLi/4O+SisK77Z/w6dLGflRJWAcnwFg8SMYxuEzUtm9
         Kn0yMKbWtwRnmtRjIb/fgaiA5s9Zib6MbM6LijkloeJGFeDoxalPAyalbbC5Vvm4edYz
         fKO5lHEqYrZVhfKCrzgSemS8X69xLKp4tDnuTSv1x4AULBBK4IQkDR+YI9t12YnNKIli
         OXfoMRM7zpWFlX+2+hnO36gI1Xv1n89u0KcNlYLC4ioZEqwTkHNfcCLxhOk5rKKtlYoP
         icDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m4uZHfd5TEknERkFPf+I/joPh8Butuy4Qgst4A1Cqjw=;
        b=eGOyWw2RdfckD/1x091vmEd59m+OzxxfOK+yKZPew/NWHLzFcTRj+TpiigSEz2yNYT
         puy81crGbzwI+hdKZxhdNrMjrI/TG5D90r+WfFQG0FVvjYX7KRs312TISi/EBXBi8r7A
         P/kLA9DbrZHWc+CNIwiPXSY0Be9pMtza15t7sbBLRJP4gMpwNVQVGJcl7kWAkLTS8073
         zjhtruU5/GbGrgJi+Ypi9oMt8ZpIQj6TNmi8KvdGT4Y9sh87QETrc1Td0HQT71MT90mC
         bQqRje2o0k5cef2ECTDOZU7/pFbn2MK4cPw3RBQKj5cBCGrthXPUxBinv9YGKd4Bs97w
         PEAA==
X-Gm-Message-State: AOAM531F4UgTfcaQOUZoUG0KWmBSxuiSigmtA+L2vse1WH46QrSIZx8z
        riCR2ZWYnlW7ycJiuTaJ1uGREatVKA3TGbSVeYp6wQ==
X-Google-Smtp-Source: ABdhPJw9qo6/6qA17qt3SommKl5Kt2eGwf1GjUaS4QRzcq/DenqfvaHGIbgh5aqK7drz/IJ4KLgY2d7lQMruWIN46Do=
X-Received: by 2002:a25:d188:0:b0:628:ba86:ee68 with SMTP id
 i130-20020a25d188000000b00628ba86ee68mr7040760ybg.427.1646989552644; Fri, 11
 Mar 2022 01:05:52 -0800 (PST)
MIME-Version: 1.0
References: <20220302082718.32268-1-songmuchun@bytedance.com>
 <20220302082718.32268-6-songmuchun@bytedance.com> <CAPcyv4hsMWe1AreVVhGJD-St3FGtGBMeA-BX7XbA_kVX97tw4Q@mail.gmail.com>
In-Reply-To: <CAPcyv4hsMWe1AreVVhGJD-St3FGtGBMeA-BX7XbA_kVX97tw4Q@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 11 Mar 2022 17:04:06 +0800
Message-ID: <CAMZfGtUmhcryboPdRC7ZhWVuV3TX0rLcKUxhvamAGbHUoATaow@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] dax: fix missing writeprotect the pte entry
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Hugh Dickins <hughd@google.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 10, 2022 at 8:59 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Mar 2, 2022 at 12:30 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > Currently dax_mapping_entry_mkclean() fails to clean and write protect
> > the pte entry within a DAX PMD entry during an *sync operation. This
> > can result in data loss in the following sequence:
> >
> >   1) process A mmap write to DAX PMD, dirtying PMD radix tree entry and
> >      making the pmd entry dirty and writeable.
> >   2) process B mmap with the @offset (e.g. 4K) and @length (e.g. 4K)
> >      write to the same file, dirtying PMD radix tree entry (already
> >      done in 1)) and making the pte entry dirty and writeable.
> >   3) fsync, flushing out PMD data and cleaning the radix tree entry. We
> >      currently fail to mark the pte entry as clean and write protected
> >      since the vma of process B is not covered in dax_entry_mkclean().
> >   4) process B writes to the pte. These don't cause any page faults since
> >      the pte entry is dirty and writeable. The radix tree entry remains
> >      clean.
> >   5) fsync, which fails to flush the dirty PMD data because the radix tree
> >      entry was clean.
> >   6) crash - dirty data that should have been fsync'd as part of 5) could
> >      still have been in the processor cache, and is lost.
>
> Excellent description.
>
> >
> > Just to use pfn_mkclean_range() to clean the pfns to fix this issue.
>
> So the original motivation for CONFIG_FS_DAX_LIMITED was for archs
> that do not have spare PTE bits to indicate pmd_devmap(). So this fix
> can only work in the CONFIG_FS_DAX_LIMITED=n case and in that case it
> seems you can use the current page_mkclean_one(), right?

I don't know the history of CONFIG_FS_DAX_LIMITED.
page_mkclean_one() need a struct page associated with
the pfn,  do the struct pages exist when CONFIG_FS_DAX_LIMITED
and ! FS_DAX_PMD? If yes, I think you are right. But I don't
see this guarantee. I am not familiar with DAX code, so what am
I missing here?

Thanks.
