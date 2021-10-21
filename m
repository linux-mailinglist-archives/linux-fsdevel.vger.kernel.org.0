Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3604369E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 20:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhJUSDW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 14:03:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229968AbhJUSDV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 14:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634839265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sf9FY6qH/YzdVN2hxg25wEYTT/Ij/RZUft7pA2XFpnw=;
        b=YHF4gv4+dKVvbvz6vN61TBjkQKl+eaveGxyZurf0ZxpGDKGGakxVqt6bgqnUp4es+QcU2p
        w6y18HHxyKbNFQ2p/VCTugZcf+B57gAUzSezk8knLEJC3iEJszFTZsSCi+fusRB43sccog
        8uDcPLkjmLuSrUcQtMdI+ayaEwvhgKM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-YWf4rXTbMiC_1u7QF9ylyw-1; Thu, 21 Oct 2021 14:01:04 -0400
X-MC-Unique: YWf4rXTbMiC_1u7QF9ylyw-1
Received: by mail-wm1-f71.google.com with SMTP id n189-20020a1c27c6000000b00322f2e380f2so181194wmn.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 11:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sf9FY6qH/YzdVN2hxg25wEYTT/Ij/RZUft7pA2XFpnw=;
        b=L9s0Rqn/SfZDLVyW34oKCp5h+taVEm5ICMBJ85DnoH+imZEWRzbSvtgVNNOSG8UZBB
         JYVE8vqkOWBDP2B+ujtPQZpuLkdSz62r5qqlx7kfgV3J1zMTHk1+NZuNRu76yrjViUKP
         snNeI4gV9LuDkWM1Fuok7L8PK56/FdZ39T+kz7WCJ9jvle0cFvmAvaI4+9t5cVOtamKV
         eu1bCcLGTpF+Y5qlGG7The29zPHmccJb60ffkW5o6yBnz72CKoKGYnfiuNeLDGAztrLC
         2NVO8btfL5C8dsuvwv3l8OIBxfNvdxVKdgKvQB8HXOOVMRU6NKPiUiRY3aeTqcVjxqDL
         TSdw==
X-Gm-Message-State: AOAM530rpg8iYOyflwGIgc1XxHS2DOrIJ8/CLPBnp23+VE9lO658MSow
        yN6480mxcsaA5I0Fh1zlAYshDXSlWAxJdTOhGVkh5yhl6dNayLa3DEIjA9CPpVARQvFJzUaWcSS
        6JRNx+GUFZPkALMao1M0Lt8GcCzo/efelpS2yotsG1Q==
X-Received: by 2002:a1c:191:: with SMTP id 139mr8334173wmb.186.1634839262828;
        Thu, 21 Oct 2021 11:01:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyp8jl7JjGdAuqkt28+Op/uIaVHGEOr5lv9I7JBHJzSrtRts/AxKHOPTiWybiNdJOqKTnZSHdECUlACCMo2WSE=
X-Received: by 2002:a1c:191:: with SMTP id 139mr8334114wmb.186.1634839262466;
 Thu, 21 Oct 2021 11:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <YSqOUb7yZ7kBoKRY@zeniv-ca.linux.org.uk> <YS40qqmXL7CMFLGq@arm.com>
 <YS5KudP4DBwlbPEp@zeniv-ca.linux.org.uk> <YWR2cPKeDrc0uHTK@arm.com>
 <CAHk-=wjvQWj7mvdrgTedUW50c2fkdn6Hzxtsk-=ckkMrFoTXjQ@mail.gmail.com>
 <YWSnvq58jDsDuIik@arm.com> <CAHk-=wiNWOY5QW5ZJukt_9pHTWvrJhE2=DxPpEtFHAWdzOPDTg@mail.gmail.com>
 <CAHc6FU7bpjAxP+4dfE-C0pzzQJN1p=C2j3vyXwUwf7fF9JF72w@mail.gmail.com>
 <YXE7fhDkqJbfDk6e@arm.com> <CAHc6FU5xTMOxuiEDyc9VO_V98=bvoDc-0OFi4jsGPgWJWjRJWQ@mail.gmail.com>
 <YXGexrdprC+NTslm@arm.com>
In-Reply-To: <YXGexrdprC+NTslm@arm.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 21 Oct 2021 20:00:50 +0200
Message-ID: <CAHc6FU7im8UzxWCzqUFMKOwyg9zoQ8OZ_M+rRC_E20yE5RNu9g@mail.gmail.com>
Subject: Re: [RFC][arm64] possible infinite loop in btrfs search_ioctl()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 7:09 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Thu, Oct 21, 2021 at 04:42:33PM +0200, Andreas Gruenbacher wrote:
> > On Thu, Oct 21, 2021 at 12:06 PM Catalin Marinas
> > <catalin.marinas@arm.com> wrote:
> > > On Thu, Oct 21, 2021 at 02:46:10AM +0200, Andreas Gruenbacher wrote:
> > > > When a page fault would occur, we
> > > > get back an error instead, and then we try to fault in the offending
> > > > pages. If a page is resident and we still get a fault trying to access
> > > > it, trying to fault in the same page again isn't going to help and we
> > > > have a true error.
> > >
> > > You can't be sure the second fault is a true error. The unlocked
> > > fault_in_*() may race with some LRU scheme making the pte not accessible
> > > or a write-back making it clean/read-only. copy_to_user() with
> > > pagefault_disabled() fails again but that's a benign fault. The
> > > filesystem should re-attempt the fault-in (gup would correct the pte),
> > > disable page faults and copy_to_user(), potentially in an infinite loop.
> > > If you bail out on the second/third uaccess following a fault_in_*()
> > > call, you may get some unexpected errors (though very rare). Maybe the
> > > filesystems avoid this problem somehow but I couldn't figure it out.
> >
> > Good point, we can indeed only bail out if both the user copy and the
> > fault-in fail.
> >
> > But probing the entire memory range in fault domain granularity in the
> > page fault-in functions still doesn't actually make sense. Those
> > functions really only need to guarantee that we'll be able to make
> > progress eventually. From that point of view, it should be enough to
> > probe the first byte of the requested memory range, so when one of
> > those functions reports that the next N bytes should be accessible,
> > this really means that the first byte surely isn't permanently
> > inaccessible and that the rest is likely accessible. Functions
> > fault_in_readable and fault_in_writeable already work that way, so
> > this only leaves function fault_in_safe_writeable to worry about.
>
> I agree, that's why generic_perform_write() works. It does a get_user()
> from the first byte in that range and the subsequent copy_from_user()
> will make progress of at least one byte if it was readable. Eventually
> it will hit the byte that faults. The gup-based fault_in_*() are a bit
> more problematic.
>
> Your series introduces fault_in_safe_writeable() and I think for MTE
> doing a _single_ get_user(uaddr) (in addition to the gup checks for
> write) would be sufficient as long as generic_file_read_iter() advances
> by at least one byte (eventually).
>
> This discussion started with the btrfs search_ioctl() where, even if
> some bytes were written in copy_to_sk(), it always restarts from an
> earlier position, reattempting to write the same bytes. Since
> copy_to_sk() doesn't guarantee forward progress even if some bytes are
> writable, Linus' suggestion was for fault_in_writable() to probe the
> whole range. I consider this overkill since btrfs is the only one that
> needs probing every 16 bytes. The other cases like the new
> fault_in_safe_writeable() can be fixed by probing the first byte only
> followed by gup.

Hmm. Direct I/O request sizes are multiples of the underlying device
block size, so we'll also get stuck there if fault-in won't give us a
full block. This is getting pretty ugly. So scratch that idea; let's
stick with probing the whole range.

Thanks,
Andreas

> I think we need to better define the semantics of the fault_in + uaccess
> sequences. For uaccess, we document "a hard requirement that not storing
> anything at all (i.e. returning size) should happen only when nothing
> could be copied" (from linux/uaccess.h). I think we can add a
> requirement for the new size_t-based fault_in_* variants without
> mandating that the whole range is probed, something like: "returning
> leftover < size guarantees that a subsequent user access at uaddr copies
> at least one byte eventually". I said "eventually" but maybe we can come
> up with some clearer wording for a liveness property.
>
> Such requirement would ensure that infinite loops of fault_in_* +
> uaccess make progress as long as they don't reset the probed range. Code
> like btrfs search_ioctl() would need to be adjusted to avoid such range
> reset and guarantee forward progress.
>
> --
> Catalin
>

