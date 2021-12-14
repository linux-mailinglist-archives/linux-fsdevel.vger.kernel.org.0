Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3F3474EAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Dec 2021 00:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238183AbhLNXnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Dec 2021 18:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbhLNXnu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Dec 2021 18:43:50 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01BDC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Dec 2021 15:43:49 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u11so14861231plf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Dec 2021 15:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ZgiCaY5T0l0ZMYR/Mztq5hUwLAkj4TagBnnAdRgHzk=;
        b=o60Xt32UY2brLgl906BjCGYAiHBp6YXZoHuzVMpf/TBtDvCHXRupMf0YCfnhHpR+Vo
         ENpVSux42eejaXSB6ZEshx3h13Zl9SmbgbENxP6Ri1p6CwkmqTTn5hcYInIIzggrD8/X
         gk3rCFal8xdLl4fMLMU5kKB5ailzqJJUhzcKFZshEt9xR/KcqWhkCKR1oyUBKFMLV449
         YYf1FurMhK2QwH/5A3k4eF4RmNfF8RGS96hg8jqQJNZVfEceTwyccP/YcyOJyHahBQhv
         O6h7DDmQmI+W7XhAIKaIuECI8c4odfFfK9I0cfRBHiNPO6uLMRPqzSJyCmjraYWSUCnC
         i3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ZgiCaY5T0l0ZMYR/Mztq5hUwLAkj4TagBnnAdRgHzk=;
        b=JsibOCqX7tqk0zGI/Xm3kon6XLeADya+xzDt5Xasvi5K/7mgdd5V0pYR4w9wRnHopS
         0MECVbmsYU3sNMeuNgXAHZIx3QINDdeKXxiFSM9TagyvCscoEh2az/yefwX0+dItavlc
         OvWcp1SiGauBspdJTcRjiQptR1PqlTFFgQPwXiq+f8F+6c+0l6+kCjEJCdU1yu1bqe5J
         XW/yE88YxXUFJ/rh48LQVzgJnaYnE6GSl2B4aaHJj31NtP54dhmZxN+Vbi/HY9GpeP6s
         x3BEfaHsNEywB+Pg6zhY3TGoDAFGLws2FyZQ7ZFIaWvhllTswhOApVwz5GIrYdLl+RrZ
         c60A==
X-Gm-Message-State: AOAM5306EMISFiHNQfBDJsWLGj1T6mKamggq1dfrV6e9Kmy7RsWwYfqF
        kJIi7QODtaOAPv2Eyazqq5vPlFyU5sW5N6bf5yb40g==
X-Google-Smtp-Source: ABdhPJy+4yBj3d67HMDz3DTq4QLF9yJ3cfSdJiIkjC96epZNko/gKghY4BBpEhMwNLi1UZe5rRHfaBU5MSuVxaK2JYI=
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr8641641pjb.93.1639525429353;
 Tue, 14 Dec 2021 15:43:49 -0800 (PST)
MIME-Version: 1.0
References: <20211209063828.18944-1-hch@lst.de> <20211209063828.18944-5-hch@lst.de>
 <YbNhPXBg7G/ridkV@redhat.com> <CAPcyv4g4_yFqDeS+pnAZOxcB=Ua+iArK5mqn0iMG4PX6oL=F_A@mail.gmail.com>
 <20211213082318.GB21462@lst.de> <YbiosqZoG8e6rDkj@redhat.com>
 <CAPcyv4hFjKsPrPTB4NtLHiY8gyaELz9+45N1OFj3hz+uJ=9JnA@mail.gmail.com> <Ybj/azxrUyU4PZEr@redhat.com>
In-Reply-To: <Ybj/azxrUyU4PZEr@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 14 Dec 2021 15:43:38 -0800
Message-ID: <CAPcyv4h_iFe8U8UrXCbhAYaruFm-xg0n_U3H8wnK-uGoEubTvw@mail.gmail.com>
Subject: Re: [PATCH 4/5] dax: remove the copy_from_iter and copy_to_iter methods
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 14, 2021 at 12:33 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Dec 14, 2021 at 08:41:30AM -0800, Dan Williams wrote:
> > On Tue, Dec 14, 2021 at 6:23 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Mon, Dec 13, 2021 at 09:23:18AM +0100, Christoph Hellwig wrote:
> > > > On Sun, Dec 12, 2021 at 06:44:26AM -0800, Dan Williams wrote:
> > > > > On Fri, Dec 10, 2021 at 6:17 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > > > Going forward, I am wondering should virtiofs use flushcache version as
> > > > > > well. What if host filesystem is using DAX and mapping persistent memory
> > > > > > pfn directly into qemu address space. I have never tested that.
> > > > > >
> > > > > > Right now we are relying on applications to do fsync/msync on virtiofs
> > > > > > for data persistence.
> > > > >
> > > > > This sounds like it would need coordination with a paravirtualized
> > > > > driver that can indicate whether the host side is pmem or not, like
> > > > > the virtio_pmem driver. However, if the guest sends any fsync/msync
> > > > > you would still need to go explicitly cache flush any dirty page
> > > > > because you can't necessarily trust that the guest did that already.
> > > >
> > > > Do we?  The application can't really know what backend it is on, so
> > > > it sounds like the current virtiofs implementation doesn't really, does it?
> > >
> > > Agreed that application does not know what backend it is on. So virtiofs
> > > just offers regular posix API where applications have to do fsync/msync
> > > for data persistence. No support for mmap(MAP_SYNC). We don't offer persistent
> > > memory programming model on virtiofs. That's not the expectation. DAX
> > > is used only to bypass guest page cache.
> > >
> > > With this assumption, I think we might not have to use flushcache version
> > > at all even if shared filesystem is on persistent memory on host.
> > >
> > > - We mmap() host files into qemu address space. So any dax store in virtiofs
> > >   should make corresponding pages dirty in page cache on host and when
> > >   and fsync()/msync() comes later, it should flush all the data to PMEM.
> > >
> > > - In case of file extending writes, virtiofs falls back to regular
> > >   FUSE_WRITE path (and not use DAX), and in that case host pmem driver
> > >   should make sure writes are flushed to pmem immediately.
> > >
> > > Are there any other path I am missing. If not, looks like we might not
> > > have to use flushcache version in virtiofs at all as long as we are not
> > > offering guest applications user space flushes and MAP_SYNC support.
> > >
> > > We still might have to use machine check safe variant though as loads
> > > might generate synchronous machine check. What's not clear to me is
> > > that if this MC safe variant should be used only in case of PMEM or
> > > should it be used in case of non-PMEM as well.
> >
> > It should be used on any memory address that can throw exception on
> > load, which is any physical address, in paths that can tolerate
> > memcpy() returning an error code, most I/O paths, and can tolerate
> > slower copy performance on older platforms that do not support MC
> > recovery with fast string operations, to date that's only PMEM users.
>
> Ok, So basically latest cpus can do fast string operations with MC
> recovery so that using MC safe variant is not a problem.
>
> Then there is range of cpus which can do MC recovery but do slower
> versions of memcpy and that's where the issue is.
>
> So if we knew that virtiofs dax window is backed by a pmem device
> then we should always use MC safe variant. Even if it means paying
> the price of slow version for the sake of correctness.
>
> But if we are not using pmem on host, then there is no point in
> using MC safe variant.
>
> IOW.
>
>         if (virtiofs_backed_by_pmem) {

No, PMEM should not be considered at all relative to whether to use MC
or not, it is 100% a decision of whether you expect virtiofs users
will balk more at unhandled machine checks or performance regressions
on the platforms that set "enable_copy_mc_fragile()". See
quirk_intel_brickland_xeon_ras_cap() and
quirk_intel_purley_xeon_ras_cap() in arch/x86/kernel/quirks.c.

>                 use_mc_safe_version
>         else
>                 use_non_mc_safe_version
>         }
>
> Now question is, how do we know if virtiofs dax window is backed by
> a pmem or not. I checked virtio_pmem driver and that does not seem
> to communicate anything like that. It just communicates start of the
> range and size of range, nothing else.
>
> I don't have full handle on stack of modules of virtio_pmem, but my guess
> is it probably is using MC safe version always (because it does not
> know anthing about the backing storage).
>
> /me will definitely like to pay penalty of slower memcpy if virtiofs
> device is not backed by a pmem.

I assume you meant "not like", but again PMEM has no bearing on
whether using that device will throw machine checks. I'm sure there
are people that would make the opposite tradeoff.
