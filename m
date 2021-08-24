Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4063F598D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 09:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbhHXIAQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 04:00:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29807 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235108AbhHXIAP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 04:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629791970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LJy4JqwQsWHwjFHrTAXgfzWwLoN0LGrnWV2wmHdwLfo=;
        b=XxvgOxf4Bgp6scOxEvRBTM1YuVy1A0mMP9txMndutUIlUwjRxA1D3g3mrfw0paUwz/ZCzP
        exk5dEFad7o+kQfIP4kuNBnFVjq9EEoMCnsoT1ByjgEmPNz4kua4FNgxt3wu8SLpCqT7Fg
        YrmHBB51vqnq8Q/GRuKKVKjoVoVwELw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-qQihFAdaNPSdAQoUqmodsg-1; Tue, 24 Aug 2021 03:59:28 -0400
X-MC-Unique: qQihFAdaNPSdAQoUqmodsg-1
Received: by mail-wm1-f69.google.com with SMTP id j135-20020a1c238d000000b002e87aa95b5aso79155wmj.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Aug 2021 00:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=LJy4JqwQsWHwjFHrTAXgfzWwLoN0LGrnWV2wmHdwLfo=;
        b=bBCAsuS0cDo6skDhSlfFD3gACu2J1qC8j50POmmFvGnMMCtr8iRRcVy4XWZQIYGfIM
         nFtqH5GA9aRhaYxOGckczpxCKFLg7QaOHylxBmurWCfkHJ4Q1RKB8WAnZ5C4slmiOeEG
         /hLwgjkX98ekj6V3JCSxpsiIYiPdVTd6skSHnATPEaxlWRetHdVODVAuYwoLR2rL1oEa
         +4ebVBveiYkTaH7f4vBp5ZCgvIPEmSbRsb7lIQG0v6ME4us4T2c2mmkkSOw/yAhmdb1p
         eZd2YQFmLEkhEaIRgQK5PqB2QcZJ3DyrYom1UFJjF+HRzmddkWwGCnYVHeFIOCmgsD/q
         hs4Q==
X-Gm-Message-State: AOAM5333WW/+Pozxvw7TddEXtj8Sad/T4BolljWYzcqSOahoLqo8BJ4H
        PMGjsI6NoHYBV65rFWeVZcEYYDp88RMRZrxuqw2MT2j1lRGkn3Zjcu3H5H6Yy6uXepXhQ30dFbX
        YEZsGKXA5In4gNnYxl2xXDNRkBQ==
X-Received: by 2002:a1c:40c:: with SMTP id 12mr2733053wme.158.1629791966868;
        Tue, 24 Aug 2021 00:59:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzj0PhJgg4JTvuFLgnwv/kAZGzTP9BXAmE0J1/y6sKtGk33rcQwpzh4xhgOENzEg5F5zC0g7A==
X-Received: by 2002:a1c:40c:: with SMTP id 12mr2733027wme.158.1629791966569;
        Tue, 24 Aug 2021 00:59:26 -0700 (PDT)
Received: from 0.7.3.c.2.b.0.0.0.3.7.8.9.5.0.2.0.0.0.0.a.d.f.f.0.b.8.0.1.0.0.2.ip6.arpa (0.7.3.c.2.b.0.0.0.3.7.8.9.5.0.2.0.0.0.0.a.d.f.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:ffda:0:2059:8730:b2:c370])
        by smtp.gmail.com with ESMTPSA id r1sm428715wmn.46.2021.08.24.00.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 00:59:25 -0700 (PDT)
Message-ID: <2c0fbb32e7668844f148b12cb4711abc76f50fe4.camel@redhat.com>
Subject: Re: [Cluster-devel] [PATCH v6 10/19] gfs2: Introduce flag for glock
 holder auto-demotion
From:   Steven Whitehouse <swhiteho@redhat.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Date:   Tue, 24 Aug 2021 08:59:24 +0100
In-Reply-To: <CAHc6FU5uHJSXD+CQk3W9BfZmnBCd+fqHt4Bd+=uVH18rnYCPLg@mail.gmail.com>
References: <20210819194102.1491495-1-agruenba@redhat.com>
         <20210819194102.1491495-11-agruenba@redhat.com>
         <5e8a20a8d45043e88013c6004636eae5dadc9be3.camel@redhat.com>
         <cf284633-a9db-9f88-6b60-4377bc33e473@redhat.com>
         <CAHc6FU7EMOEU7C5ryu5pMMx1v+8CTAOMyGdf=wfaw8=TTA_btQ@mail.gmail.com>
         <8e2ab23b93c96248b7c253dc3ea2007f5244adee.camel@redhat.com>
         <CAHc6FU5uHJSXD+CQk3W9BfZmnBCd+fqHt4Bd+=uVH18rnYCPLg@mail.gmail.com>
Organization: Red Hat UK Ltd
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Mon, 2021-08-23 at 17:18 +0200, Andreas Gruenbacher wrote:
> On Mon, Aug 23, 2021 at 10:14 AM Steven Whitehouse <
> swhiteho@redhat.com> wrote:
> > On Fri, 2021-08-20 at 17:22 +0200, Andreas Gruenbacher wrote:
> > > On Fri, Aug 20, 2021 at 3:11 PM Bob Peterson <rpeterso@redhat.com
> > > >
> > > wrote:
> > [snip]
> > > > You can almost think of this as a performance enhancement. This
> > > > concept
> > > > allows a process to hold a glock for much longer periods of
> > > > time,
> > > > at a
> > > > lower priority, for example, when gfs2_file_read_iter needs to
> > > > hold
> > > > the
> > > > glock for very long-running iterative reads.
> > > 
> > > Consider a process that allocates a somewhat large buffer and
> > > reads
> > > into it in chunks that are not page aligned. The buffer initially
> > > won't be faulted in, so we fault in the first chunk and write
> > > into
> > > it.
> > > Then, when reading the second chunk, we find that the first page
> > > of
> > > the second chunk is already present. We fill it, set the
> > > HIF_MAY_DEMOTE flag, fault in more pages, and clear the
> > > HIF_MAY_DEMOTE
> > > flag. If we then still have the glock (which is very likely), we
> > > resume the read. Otherwise, we return a short result.
> > > 
> > > Thanks,
> > > Andreas
> > > 
> > 
> > If the goal here is just to allow the glock to be held for a longer
> > period of time, but with occasional interruptions to prevent
> > starvation, then we have a potential model for this. There is
> > cond_resched_lock() which does this for spin locks.
> 
> This isn't an appropriate model for what I'm trying to achieve here.
> In the cond_resched case, we know at the time of the cond_resched
> call
> whether or not we want to schedule. If we do, we want to drop the
> spin
> lock, schedule, and then re-acquire the spin lock. In the case we're
> looking at here, we want to fault in user pages. There is no way of
> knowing beforehand if the glock we're currently holding will have to
> be dropped to achieve that. In fact, it will almost never have to be
> dropped. But if it does, we need to drop it straight away to allow
> the
> conflicting locking request to succeed.
> 
> Have a look at how the patch queue uses gfs2_holder_allow_demote()
> and
> gfs2_holder_disallow_demote():
> 
> https://listman.redhat.com/archives/cluster-devel/2021-August/msg00128.html
> https://listman.redhat.com/archives/cluster-devel/2021-August/msg00134.html
> 
> Thanks,
> Andreas
> 

Ah, now I see! Apologies if I've misunderstood the intent here,
initially. It is complicated and not so obvious - at least to me!

You've added a lot of context to this patch in your various replies on
this thread. The original patch description explains how the feature is
implemented, but doesn't really touch on why - that is left to the
other patches that you pointed to above. A short paragraph or two on
the "why" side of things added to the patch description would be
helpful I think.

Your message on Friday (20 Aug 2021 15:17:41 +0200 (20/08/21 14:17:41))
has a good explanation in the second part of it, which with what you've
said above (or similar) would be a good basis.

Apologies again for not understanding what is going on,

Steve.


