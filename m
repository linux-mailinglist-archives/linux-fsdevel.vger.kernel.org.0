Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 347A9145920
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 16:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgAVP5D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 10:57:03 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32912 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgAVP5C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 10:57:02 -0500
Received: by mail-ot1-f67.google.com with SMTP id b18so6727702otp.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2020 07:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9U8vpXr1lSnDkiGOePVp2UvsnCYTPpW1/ZiqUrn/0bE=;
        b=DQiCBrPoGOz3XTfcpCIUcGNhA/KNZtuz5uRkW/2xZVqYChlveuBVRhSuYQPTMfol+W
         At71MaSza7laAFgO6UzkAjsrS3tr/rRQmn1CILzBhI/kaceAy5MikhtAT0S6RiGjZYhR
         2tfQEjIssE+M31SShWXhpeDiKZTSgnf4J3p4yGakffIIQzBYZs80qPj2dPjtttQ3PD7x
         Z9YSFWrFUM+ZOFJGmBpHEjAm5Q7cKUoK2gHjnnI+Sem40jlgE5hDIOtz25ovcvksZA52
         kAR5S4kNTQcK6xKsaCVPvsSBRvcXRGrA8GOC16yk7Nw4f/zt2BA6wn8f0F0/+8pXAqtK
         ZHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9U8vpXr1lSnDkiGOePVp2UvsnCYTPpW1/ZiqUrn/0bE=;
        b=FEZg/dsFLdABFDMIT/wFYGoW2IhnDwvee+AMnQup+CjLaKRiswd282YCVZPx8udRbB
         E4XLm3Ya+rLvhUxuaNmkJk+YwPjMbfel3Aw2A5gfK7Z0UHP3Gii84FFIYzHfYb2Qg+4Y
         qhDNWRLWhJg4GNtSuTMs1lDG665qmZUnqDuds7timW5i4j4HiI1LF0p6CVP+vTlysQFy
         /T6B4Hm8AeoskT1y9KUxaNOj2K/+CV+lJMSy+N47UyzZZY32ku8xn8N34k921JsZMDe5
         10lhGFy5O/1hO5ur35VlellVM8cg6UfCQ4HJyTzu5as/7e1pxRLC1Q2KUEFmqLTI83Af
         T+8Q==
X-Gm-Message-State: APjAAAV/Gv8C+jEKmAfu/n5UCw6OGjCNxdNICVzkcAWi4kbAKAsI09Dp
        wIwvvGYhIpvfOYSBRK5/c5c0l6pv/Le2AfHZWQdgS3Tw
X-Google-Smtp-Source: APXvYqxKRi31EhyzzaInRoUEurvrhrWOw8rTDumOjwbWE6I/QgQ4zK+fCfxN1LcK3NhE8w+XJWifpA3CF+mWkUC2Ejo=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr7751497oto.207.1579708622095;
 Wed, 22 Jan 2020 07:57:02 -0800 (PST)
MIME-Version: 1.0
References: <20200122023100.75226-1-jglisse@redhat.com> <CAA9_cmfDKan60EnXCptAu9U6XgQgr5-MKfrENDNOSZYmQY9iRA@mail.gmail.com>
 <20200122050012.GD76712@redhat.com>
In-Reply-To: <20200122050012.GD76712@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 22 Jan 2020 07:56:50 -0800
Message-ID: <CAPcyv4hF-bagqZk-n_2QyvG5zE=5uSWJnbkDsfY3FYHT0+F6FQ@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Do not pin pages for various
 direct-io scheme
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lsf-pc@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>, Benjamin LaHaise <bcrl@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 21, 2020 at 9:04 PM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Tue, Jan 21, 2020 at 08:19:54PM -0800, Dan Williams wrote:
> > On Tue, Jan 21, 2020 at 6:34 PM <jglisse@redhat.com> wrote:
> > >
> > > From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> > >
> > > Direct I/O does pin memory through GUP (get user page) this does
> > > block several mm activities like:
> > >     - compaction
> > >     - numa
> > >     - migration
> > >     ...
> > >
> > > It is also troublesome if the pinned pages are actualy file back
> > > pages that migth go under writeback. In which case the page can
> > > not be write protected from direct-io point of view (see various
> > > discussion about recent work on GUP [1]). This does happens for
> > > instance if the virtual memory address use as buffer for read
> > > operation is the outcome of an mmap of a regular file.
> > >
> > >
> > > With direct-io or aio (asynchronous io) pages are pinned until
> > > syscall completion (which depends on many factors: io size,
> > > block device speed, ...). For io-uring pages can be pinned an
> > > indifinite amount of time.
> > >
> > >
> > > So i would like to convert direct io code (direct-io, aio and
> > > io-uring) to obey mmu notifier and thus allow memory management
> > > and writeback to work and behave like any other process memory.
> > >
> > > For direct-io and aio this mostly gives a way to wait on syscall
> > > completion. For io-uring this means that buffer might need to be
> > > re-validated (ie looking up pages again to get the new set of
> > > pages for the buffer). Impact for io-uring is the delay needed
> > > to lookup new pages or wait on writeback (if necessary). This
> > > would only happens _if_ an invalidation event happens, which it-
> > > self should only happen under memory preissure or for NUMA
> > > activities.
> >
> > This seems to assume that memory pressure and NUMA migration are rare
> > events. Some of the proposed hierarchical memory management schemes
> > [1] might impact that assumption.
> >
> > [1]: http://lore.kernel.org/r/20191101075727.26683-1-ying.huang@intel.c=
om/
> >
>
> Yes, it is true that it will likely becomes more and more an issues.
> We are facing a tough choice here as pining block NUMA or any kind of
> migration and thus might impede performance while invalidating an io-
> uring buffer will also cause a small latency burst. I do not think we
> can make everyone happy but at very least we should avoid pining and
> provide knobs to let user decide what they care more about (ie io with-
> out burst or better NUMA locality).

It's a question of tradeoffs and this proposal seems to have already
decided that the question should be answered in favor a GPU/SVM
centric view of the world without presenting the alternative.
Direct-I/O colliding with GPU operations might also be solved by
always triggering a migration, and applications that care would avoid
colliding operations that slow down their GPU workload. A slow compat
fallback that applications can programmatically avoid is more flexible
than an upfront knob.
