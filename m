Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A5D44B46A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 22:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244870AbhKIVFV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 16:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244855AbhKIVFU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 16:05:20 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A30C061764
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Nov 2021 13:02:34 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id m26so562950pff.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Nov 2021 13:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGCSLoiUEixbJUJjsAamjo0128u/1ab9KY+NrB7bwnI=;
        b=IDKm1rsTtY3dB0GDCmzldy6w5oNdAEtYqYum2g8jAh8YcbdgNPee6EKgJgpVDGvOYm
         bU6jDw0yL/QcyIuE/xVK1UYwJc49WviERyfg4i3F/XXBlL1DNA+ighGEMF3DuJCCq8tv
         QWtcGcWkkrl6zbkb1R9aYtSkyT7LRYl6pjn5y+1bV2Wwg+Uy9m6899rhjfE/tggdqcV7
         mgVw6fzNLoRs6Gtjk9melP5C5jhP0pwQfMd4XIVp2t1qomP89JlhKCbulJn73gqXMq9y
         yavXZHcca/est+LsSX+OrbpkL8gszp7TwD/gV7PtJ8VksmnTYRybSZLRVsLOHU/acVk3
         YKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGCSLoiUEixbJUJjsAamjo0128u/1ab9KY+NrB7bwnI=;
        b=LCIgeugtAa+YLlU6INoFfO27VEQumPPe6uwKMb9/SAal1xTd290gwDa9kChRPLyn+O
         VJiAo2N35QMniSXNwRBsvxMeuktPU7ojAIJj1EAHfUpXVu3A7AKxyLSeJciHpllfNCtm
         xpSUXobnLxP1KVRAY/zg4xxR8js1U0B5rSDGx3p/71jXbJ+7puGdjJBdNNXUfqhkFmh0
         Vn8x5floAD63O7o8aHwtbgy70FPAujfM9aV78iAaFI3ViEGwRMMV2gVt9c4G8PXRAnp2
         K1hg9b7ZAOToA7XrMYNFNzuSN50/mw0U75mmyPj4bzF2n9voBSao1OtJpvuCD483PADL
         fVag==
X-Gm-Message-State: AOAM532KZQ730NgFhNyqohWPE9R/f7oaJPUV+yNjMyYvixbS5A/gBRTB
        0or/LRQXKB9vJIHWP4rZ795Jza4Lh0p3a3bRa08n7A==
X-Google-Smtp-Source: ABdhPJxLkjcYAJ6xF4i22dGgcThaQc5MIlNV4NzhpLHAutoT4ZKPk8dFHjZwxwWusNLUT463Jmt8uLtznOEGS++66P4=
X-Received: by 2002:a05:6a00:140e:b0:444:b077:51ef with SMTP id
 l14-20020a056a00140e00b00444b07751efmr11438892pfu.61.1636491753212; Tue, 09
 Nov 2021 13:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20211106011638.2613039-1-jane.chu@oracle.com> <20211106011638.2613039-3-jane.chu@oracle.com>
 <YYoi2JiwTtmxONvB@infradead.org> <CAPcyv4hQrUEhDOK-Ys1_=Sxb8f+GJZvpKZHTUPKQvVMaMe8XMg@mail.gmail.com>
 <15f01d51-2611-3566-0d08-bdfbec53f88c@oracle.com>
In-Reply-To: <15f01d51-2611-3566-0d08-bdfbec53f88c@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 9 Nov 2021 13:02:23 -0800
Message-ID: <CAPcyv4gwbZ=Z6xCjDCASpkPnw1EC8NMAJDh9_sa3n2PAG5+zAA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dax,pmem: Implement pmem based dax data recovery
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>, david <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 9, 2021 at 11:59 AM Jane Chu <jane.chu@oracle.com> wrote:
>
> On 11/9/2021 10:48 AM, Dan Williams wrote:
> > On Mon, Nov 8, 2021 at 11:27 PM Christoph Hellwig <hch@infradead.org> wrote:
> >>
> >> On Fri, Nov 05, 2021 at 07:16:38PM -0600, Jane Chu wrote:
> >>>   static size_t pmem_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff,
> >>>                void *addr, size_t bytes, struct iov_iter *i, int mode)
> >>>   {
> >>> +     phys_addr_t pmem_off;
> >>> +     size_t len, lead_off;
> >>> +     struct pmem_device *pmem = dax_get_private(dax_dev);
> >>> +     struct device *dev = pmem->bb.dev;
> >>> +
> >>> +     if (unlikely(mode == DAX_OP_RECOVERY)) {
> >>> +             lead_off = (unsigned long)addr & ~PAGE_MASK;
> >>> +             len = PFN_PHYS(PFN_UP(lead_off + bytes));
> >>> +             if (is_bad_pmem(&pmem->bb, PFN_PHYS(pgoff) / 512, len)) {
> >>> +                     if (lead_off || !(PAGE_ALIGNED(bytes))) {
> >>> +                             dev_warn(dev, "Found poison, but addr(%p) and/or bytes(%#lx) not page aligned\n",
> >>> +                                     addr, bytes);
> >>> +                             return (size_t) -EIO;
> >>> +                     }
> >>> +                     pmem_off = PFN_PHYS(pgoff) + pmem->data_offset;
> >>> +                     if (pmem_clear_poison(pmem, pmem_off, bytes) !=
> >>> +                                             BLK_STS_OK)
> >>> +                             return (size_t) -EIO;
> >>> +             }
> >>> +     }
> >>
> >> This is in the wrong spot.  As seen in my WIP series individual drivers
> >> really should not hook into copying to and from the iter, because it
> >> really is just one way to write to a nvdimm.  How would dm-writecache
> >> clear the errors with this scheme?
> >>
> >> So IMHO going back to the separate recovery method as in your previous
> >> patch really is the way to go.  If/when the 64-bit store happens we
> >> need to figure out a good way to clear the bad block list for that.
> >
> > I think we just make error management a first class citizen of a
> > dax-device and stop abstracting it behind a driver callback. That way
> > the driver that registers the dax-device can optionally register error
> > management as well. Then fsdax path can do:
> >
> >          rc = dax_direct_access(..., &kaddr, ...);
> >          if (unlikely(rc)) {
> >                  kaddr = dax_mk_recovery(kaddr);
>
> Sorry, what does dax_mk_recovery(kaddr) do?

I was thinking this just does the hackery to set a flag bit in the
pointer, something like:

return (void *) ((unsigned long) kaddr | DAX_RECOVERY)

>
> >                  dax_direct_access(..., &kaddr, ...);
> >                  return dax_recovery_{read,write}(..., kaddr, ...);
> >          }
> >          return copy_{mc_to_iter,from_iter_flushcache}(...);
> >
> > Where, the recovery version of dax_direct_access() has the opportunity
> > to change the page permissions / use an alias mapping for the access,
>
> again, sorry, what 'page permissions'?  memory_failure_dev_pagemap()
> changes the poisoned page mem_type from 'rw' to 'uc-' (should be NP?),
> do you mean to reverse the change?

Right, the result of the conversation with Boris is that
memory_failure() should mark the page as NP in call cases, so
dax_direct_access() needs to create a UC mapping and
dax_recover_{read,write}() would sink that operation and either return
the page to NP after the access completes, or convert it to WB if the
operation cleared the error.

> > dax_recovery_read() allows reading the good cachelines out of a
> > poisoned page, and dax_recovery_write() coordinates error list
> > management and returning a poison page to full write-back caching
> > operation when no more poisoned cacheline are detected in the page.
> >
>
> How about to introduce 3 dax_recover_ APIs:
>    dax_recover_direct_access(): similar to dax_direct_access except
>       it ignores error list and return the kaddr, and hence is also
>       optional, exported by device driver that has the ability to
>       detect error;
>    dax_recovery_read(): optional, supported by pmem driver only,
>       reads as much data as possible up to the poisoned page;

It wouldn't be a property of the pmem driver, I expect it would be a
flag on the dax device whether to attempt recovery or not. I.e. get
away from this being a pmem callback and make this a native capability
of a dax device.

>    dax_recovery_write(): optional, supported by pmem driver only,
>       first clear-poison, then write.
>
> Should we worry about the dm targets?

The dm targets after Christoph's conversion should be able to do all
the translation at direct access time and then dax_recovery_X can be
done on the resulting already translated kaddr.

> Both dax_recovery_read/write() are hooked up to dax_iomap_iter().

Yes.
