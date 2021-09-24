Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EED416940
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 03:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243698AbhIXBNG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 21:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbhIXBNE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 21:13:04 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81065C061574;
        Thu, 23 Sep 2021 18:11:32 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c22so29400634edn.12;
        Thu, 23 Sep 2021 18:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VFfvy7CaZhgcLYY+FfLl/jy2UCxLFiyJXxO+xMizlY8=;
        b=QeEYSnEUK0ib55fvyXr+8QyGfTWVhNpZKIOFxKXARQsaOq+EjoYfzOvwxlMH8c430q
         JsH7ihjKKg1Lt+M0mVBnGgrHL5Md6WANoerWpABhN2bXSAQ+x8tp0lDd0UyE1H/nUKKT
         wAC9ybyfQ6mx/DeaZ2kND8MG5ba2syvCBYThPA9Ga7nI+dZps5WXsdr+QR0L3meTWoRd
         XE82tAF/HVIuzyx+qr7a90R9P9dwz1rde9+butcxcu/MSGwVs8HixMCTdvbdu0TJEmZR
         IerRQEyCfQBhfVbCpi5z5fdQ1YcEItDdGalGMI5WVaU01O7cKV3c3SV8Sw1oET9QkcPI
         MoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VFfvy7CaZhgcLYY+FfLl/jy2UCxLFiyJXxO+xMizlY8=;
        b=pkkSx5lRVrUHTe5dquRhVW08154MeRUjEKiN5gCAe0HOTpicyIkizQF+6SoxCePg2U
         KEYeoPdzz6W3jjfaJjIINTip9qcn3VNHzggMM5oapWqHyH91D/4TpLLgossMm247EJcT
         jDJJnVtMWLeStduOV6o41jugpmF2MKRgplRxPP/bltpEbe1qXxX9o2PXenUY1SVxADKk
         32NWfzhEnekcPSj5EuIdfwY3EdomVcr96O/+/0HIOjC9gQBAM2QWXK2Ak2/sK6Z6Tiw0
         wdlCw4Jr+d+32AD1wtVe3gioehU9otdy4hrwdGu1Qh4zZugENHcy4Kzx9J6aW+9d37wY
         jYKQ==
X-Gm-Message-State: AOAM531b3TKTOwJJ52U4VycYR6/drFd3Wgw26zJsCx7ZHb89DeI9pNh/
        B0yeHT6xwVWkMsKwixInKT4SIedk1DO9+LdRYPk=
X-Google-Smtp-Source: ABdhPJxpnqVA1eKt+/Vve1DRMMUdEM9aoOdp0894puGK/ibv6YQaXIPIhLJUc2Jspr0c+7skoLATHzGi1V57jztpylE=
X-Received: by 2002:a17:906:c7d0:: with SMTP id dc16mr8461596ejb.555.1632445891060;
 Thu, 23 Sep 2021 18:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <YUvWm6G16+ib+Wnb@moria.home.lan> <YUvzINep9m7G0ust@casper.infradead.org>
 <YUwNZFPGDj4Pkspx@moria.home.lan> <YUxnnq7uFBAtJ3rT@casper.infradead.org>
 <20210923124502.nxfdaoiov4sysed4@box.shutemov.name> <72cc2691-5ebe-8b56-1fe8-eeb4eb4a4c74@google.com>
 <CAHbLzkrELUKR2saOkA9_EeAyZwdboSq0HN6rhmCg2qxwSjdzbg@mail.gmail.com>
 <2A311B26-8B33-458E-B2C1-8BA2CF3484AA@nvidia.com> <77b59314-5593-1a2e-293c-b66e8235ad@google.com>
In-Reply-To: <77b59314-5593-1a2e-293c-b66e8235ad@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 23 Sep 2021 18:11:19 -0700
Message-ID: <CAHbLzkp__irFweEZMEM-CMF_-XQpJcW1dNDFo=RnqaSTGtdJkg@mail.gmail.com>
Subject: Re: Mapcount of subpages
To:     Hugh Dickins <hughd@google.com>
Cc:     Zi Yan <ziy@nvidia.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 4:49 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Thu, 23 Sep 2021, Zi Yan wrote:
> > On 23 Sep 2021, at 17:54, Yang Shi wrote:
> > > On Thu, Sep 23, 2021 at 2:10 PM Hugh Dickins <hughd@google.com> wrote:
> > >>
> > >> NR_FILE_MAPPED being used for /proc/meminfo's "Mapped:" and a couple
> > >> of other such stats files, and for a reclaim heuristic in mm/vmscan.c.
> > >>
> > >> Allow ourselves more slack in NR_FILE_MAPPED accounting (either count
> > >> each pte as if it mapped the whole THP, or don't count a THP's ptes
> > >> at all - you opted for the latter in the "Mlocked:" accounting),
> > >> and I suspect subpage _mapcount could be abandoned.
> > >
> > > AFAIK, partial THP unmap may need the _mapcount information of every
> > > subpage otherwise the deferred split can't know what subpages could be
> > > freed.
>
> I believe Yang Shi is right insofar as the decision on whether it's worth
> queuing for deferred split is being done based on those subpage _mapcounts.
> That is a use I had not considered, and I've given no thought to how
> important or not it is.

Anyway deferred split is anon THP specific. We don't have to worry
about this for file THP. So your suggestion about just counting total
mapcount seems feasible to me for file THP at least.

>
> >
> > Could we just scan page tables of a THP during deferred split process
> > instead? Deferred split is a slow path already, so maybe it can afford
> > the extra work.
>
> But unless I misunderstand, actually carrying out the deferred split
> already unmaps, uses migration entries, and remaps the remaining ptes:
> needing no help from subpage _mapcounts to do those, and free the rest.
>
> Hugh
