Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DF23B8226
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 14:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbhF3Mch (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 08:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35826 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234560AbhF3Mch (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 08:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625056207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RQZ34p00W47EK/M00vu4N1h6gunJeEQ5RDsJI1DSqqg=;
        b=PQYg6WwCwLIUgJ943ElHUVaRIE1A4ryge7Qr8Vj2aadYCVvGG5RFKAUsaPl/8k/Yby3PKI
        Jt/YExo96AMkQiV9Ix2Ooru9pjgAyTkMKo6xbNnm9ZRNqpllszU7H+r1QQSDbN+l4OExT7
        VblfF5X3Gy2g3M6d8oA6Cg6YrX/44vU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-EHJeNNEuM2aGM03HYRDRLw-1; Wed, 30 Jun 2021 08:30:05 -0400
X-MC-Unique: EHJeNNEuM2aGM03HYRDRLw-1
Received: by mail-wm1-f71.google.com with SMTP id y129-20020a1c32870000b029016920cc7087so443363wmy.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jun 2021 05:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RQZ34p00W47EK/M00vu4N1h6gunJeEQ5RDsJI1DSqqg=;
        b=WmPl+Y3V3CY4LeJb8I1I2xQJoKDuNiMs0fdeZQoFcQB1lMXX+ZBJm5ahk8AktyFGH4
         wGQtEA+5khwQJFN0dMQMcEr4AaOuMZnOyezp85P0FOtWZF6PJryUKntN1OKVyMmtVQJd
         +oQqRYz5asACfra30FegO6hLDEPBNhLdG1QwCajPfXSFqhSu5rJU8RWYAhHbEhlMKnbz
         atxS0vzLEjpLkPlzymYgUjykVtUHW13DX/eFxNusZonzTQ76hSTuW+++q5Wjl0Sq4CpD
         FyPw3mHXmJN9RpSuFwTEd5bjjqtphT0JE9XL01VQ3RJa+8LKmNQ9lH1SYmbtY4u2L+bu
         h50g==
X-Gm-Message-State: AOAM533Spp/EPUsd/cXOXcqUWJpgwQrTsNK0N4D374QzBlbUPKHFLGhv
        VZdGPdMQE3WH1NvOn3bBHttSVsOzf3JC7CgclJq1JQ1oGS0cW7zdH+AZAd3lzBU8hU9w0BziyHv
        KoxJ3aOIfH4tHepOzE56JaXRZvs5vSwstzw9PGOKGDQ==
X-Received: by 2002:a5d:64a1:: with SMTP id m1mr38417844wrp.377.1625056204780;
        Wed, 30 Jun 2021 05:30:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiKZD8yv7AFvQByvy6FrFUeDUZiI9d4+EOWLz8GJb+ib2SSR1Xzbba+opGBb3gRXer0OrDHoNpt28PzPvCzZU=
X-Received: by 2002:a5d:64a1:: with SMTP id m1mr38417829wrp.377.1625056204627;
 Wed, 30 Jun 2021 05:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210628172727.1894503-1-agruenba@redhat.com> <YNoJPZ4NWiqok/by@casper.infradead.org>
 <YNoLTl602RrckQND@infradead.org> <YNpGW2KNMF9f77bk@casper.infradead.org> <YNqvzNd+7+YtXfQj@infradead.org>
In-Reply-To: <YNqvzNd+7+YtXfQj@infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 30 Jun 2021 14:29:53 +0200
Message-ID: <CAHc6FU7+Q0D_pnjUbLXseeHfVQZ2nHTKMzH+0ppLh9cpX-UaPg@mail.gmail.com>
Subject: Re: [PATCH 0/2] iomap: small block problems
To:     "Darrick J . Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Darrick,

On Tue, Jun 29, 2021 at 7:47 AM Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Jun 28, 2021 at 10:59:55PM +0100, Matthew Wilcox wrote:
> > > > so permit pages without an iop to enter writeback and create an iop
> > > > *then*.  Would that solve your problem?
> > >
> > > It is the right thing to do, especially when combined with a feature
> > > patch to not bother to create the iomap_page structure on small
> > > block size file systems when the extent covers the whole page.
> >
> > We don't know the extent layout at the point where *this* patch creates
> > iomap_pages during writeback.  I imagine we can delay creating one until
> > we find out what our destination layout will be?
>
> Hmm.  Actually ->page_mkwrite is always is always called on an uptodate
> page and we even assert that.  I should have remembered the whole page
> fault path better.
>
> So yeah, I think we should take patch 1 from Andreas, then a non-folio
> version of your patch as a start.

will you pick up those two patches and push them to Linus? They both
seem pretty safe.

Thanks,
Andreas

