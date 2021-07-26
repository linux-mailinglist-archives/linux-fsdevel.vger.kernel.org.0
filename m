Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC7B3D5370
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 08:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhGZGQo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 02:16:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29059 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231795AbhGZGQo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 02:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627282632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hoM+40XrUs08/iafF0W5TlGWYGpGG8kF5CcKon7tTtw=;
        b=JH4sTO+ItS2ylGohJwbMuzFe7NEZ3thd+ywlWkIUP9ewujUW9bwlMzAVTXbl/gbZXPPl4J
        PB1abFQNDILxsZyU8d9L/mkWS3c0klcJkej+dG2yTWykuYghRbqDSCtLcZiCyHJ/AYzTp1
        /FEh1U3AJ31u6abG5osRgHkYM+XJfOA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-LQmr-HhoOgO-89wwiSsjAQ-1; Mon, 26 Jul 2021 02:57:10 -0400
X-MC-Unique: LQmr-HhoOgO-89wwiSsjAQ-1
Received: by mail-wr1-f70.google.com with SMTP id s16-20020adfdb100000b0290140a25efc6dso4345692wri.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jul 2021 23:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hoM+40XrUs08/iafF0W5TlGWYGpGG8kF5CcKon7tTtw=;
        b=i/uz1KHF52OLJcThzLz9EPcsp6IeuNkhP9ZelBIbQ21w5RcLWg1N6QcooS+LMeanV8
         Zf7ACros7DvkVPNwdVPPq6lryVtkaFC3r65HI6SlF1tE1YTr7JWin/17oDhn5n+EVlKp
         J74wa0cP52IpAS6efGvArkzwg0UQmMlSLdPF2vwgT2AMkFyLkg9rPTdh9SrE+Qb0OMVl
         0agrv0Fdd1NnOd5lioU/WWqB1iHY2+1RWdJZVylOeIWMQzols9/2dbtI3QpBL9sUWPKk
         JC7ybN6UQoheVpFbnVzxyZdpQAifxsgr6c03qD0X7mv3gH87B5cdVzCgPGAg0IiRM+Gf
         Z/Zw==
X-Gm-Message-State: AOAM5339NXQY87PB15SHhvr7ohqTJII5QL308R+aGtsGiDgAM8b5lQED
        hkwcuG9hEard94mXyHLHaE0rhgF2/opkjPZ1qEmotC0olg+Bs3gmKQd8ADAvfzRm3fjUDtjupKc
        moKBJY6c4ITxKRP75amFSJHxNPlTsPANXMx9rjRpTkA==
X-Received: by 2002:a05:600c:2319:: with SMTP id 25mr9998430wmo.27.1627282629744;
        Sun, 25 Jul 2021 23:57:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1d7vnal7HJ1PcZ4njvl3+oYt3GMB7C300ETtzmpr8AsBsi2dyhup0b5RU8e3Tw7o3XKPki+Q+cwnpDOXFJvY=
X-Received: by 2002:a05:600c:2319:: with SMTP id 25mr9998417wmo.27.1627282629625;
 Sun, 25 Jul 2021 23:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
 <20210723174131.180813-1-hsiangkao@linux.alibaba.com> <20210725221639.426565-1-agruenba@redhat.com>
 <YP4mzBixPoBgGCCR@casper.infradead.org>
In-Reply-To: <YP4mzBixPoBgGCCR@casper.infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 26 Jul 2021 08:56:58 +0200
Message-ID: <CAHc6FU6C44b=u3YJmL9VSZGwLK3wAVxgnNdxx87RmEwVbRUB=w@mail.gmail.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Huang Jianan <huangjianan@oppo.com>,
        linux-erofs@lists.ozlabs.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 26, 2021 at 5:07 AM Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, Jul 26, 2021 at 12:16:39AM +0200, Andreas Gruenbacher wrote:
> > @@ -247,7 +251,6 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> >       sector_t sector;
> >
> >       if (iomap->type == IOMAP_INLINE) {
> > -             WARN_ON_ONCE(pos);
> >               iomap_read_inline_data(inode, page, iomap);
> >               return PAGE_SIZE;
>
> This surely needs to return -EIO if there was an error.

Hmm, right.

Thanks,
Andreas

