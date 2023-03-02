Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B996A7A63
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 05:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjCBESa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 23:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjCBESC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 23:18:02 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A710057096
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Mar 2023 20:16:47 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id z6so16944428qtv.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Mar 2023 20:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiLX93qNxOIggMQE39gtCyYpTO910rpc2HqmiyP4Wqs=;
        b=A1EaYf8tKwM+OSZSx4sx0qUaPdLBesg9gHN2HlrQvObNa2lqTRK6IIiYpalGERQjcF
         pn+3xJBA/2791KiNqkOv//qXihovDpzswgjkqop1IXsV/L8NKh0Reo/ds5+FfnISkwnR
         I4WYiYH26wHIo2lOKIbarUgozHVzZhjq93i0zsrTBDllz8HnRhjt1fP7c+82n2uMukdc
         FrBA3ORoe7jdcFdPw9qrbyGt3C0CW2OrZV5E0sHojytvWDuV8PlYeOB/d3LJNDdjuJSG
         uvSrX/ZjBU8NVnQtHqnVeKjdMBgeElsggH2A6HgKfI3fDqki+55VcLxx2U4VMZJDfP6k
         wNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiLX93qNxOIggMQE39gtCyYpTO910rpc2HqmiyP4Wqs=;
        b=p2kzoLV41ryydGHTJWOejPRiCKbLse6DReOXElkbGiF04gXnu9yelrCvlboeqtsvex
         Nb6BXzEznW7ayvHBKmeNKFlCmELSjgKBjpAvnihfP1GfjG/T1Kbcg7e4mZpGcxz2+/0g
         Y5cbtK/967sfUt98FFgtnH27NsFmeDho6ZPzZYjb7CNtzC8JTV3++Y0MKHl3b61Mf/Ix
         7QAeIAqpQJGNuQPpXegD0nwWsgPth50ulps0KyR4z0tPrZWlh6SeIF7Vq1v46XMP42V3
         gC91WStxG82SOGfme8HA1K3hOjHpi6C5lY54j/vJ2i32akVAznZvPXFqWLyET2Ygy/MG
         4Z6g==
X-Gm-Message-State: AO0yUKWgXcO40gIpWTvPP6tyc9TejBxYWkr8qla5wUT10oJEcoz9gQxT
        gZsls6FNKGhvnVEv8B6KEwaivmcVAWiPV5Q8GJyjoA==
X-Google-Smtp-Source: AK7set/1Qo/2N3JCxnEKF/vVdWvMT8KXKuR0NcpsojQRCVOxjmuWm2l5Wboe2MANA6zXLOiyu1AmcY+R5Hl0TYWvINA=
X-Received: by 2002:ac8:444a:0:b0:3bf:b844:ffc7 with SMTP id
 m10-20020ac8444a000000b003bfb844ffc7mr2387535qtn.12.1677730602197; Wed, 01
 Mar 2023 20:16:42 -0800 (PST)
MIME-Version: 1.0
References: <Y9KtCc+4n5uANB2f@casper.infradead.org> <8448beac-a119-330d-a2af-fc3531bdb930@linux.alibaba.com>
 <Y/UiY/08MuA/tBku@casper.infradead.org> <CA+CK2bBYX-N8T_ZdzsHC7oJnHsmqHufdTUJj5OrdFk17uQ=fzw@mail.gmail.com>
 <ZAAgKTWpwCE1fruV@casper.infradead.org>
In-Reply-To: <ZAAgKTWpwCE1fruV@casper.infradead.org>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 1 Mar 2023 23:16:06 -0500
Message-ID: <CA+CK2bCxBqjh4b_-ZU8czDR-naaHJVKWo38uhB2_a9x18NWYbQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 1, 2023 at 11:03=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Mar 01, 2023 at 10:50:24PM -0500, Pasha Tatashin wrote:
> > On Tue, Feb 21, 2023 at 2:58=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > > My goal for 2023 is to get to a point where we (a) have struct page
> > > reduced to:
> > >
> > > struct page {
> > >         unsigned long flags;
> > >         struct list_head lru;
> > >         struct address_space *mapping;
> > >         pgoff_t index;
> > >         unsigned long private;
> > >         atomic_t _mapcount;
> > >         atomic_t _refcount;
> > >         unsigned long memcg_data;
> > > #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
> > >         int _last_cpupid;
> > > #endif
> > > };
> >
> > This looks clean, but it is still 64-bytes. I wonder if we could
> > potentially reduce it down to 56 bytes by removing memcg_data.
>
> We need struct page to be 16-byte aligned to make slab work.  We also nee=
d
> it to divide PAGE_SIZE evenly to make CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMA=
P

Hm, can you please elaborate on both of these cases, how do both of
these cases work today with _last_cpuid configs or some other configs
that increase "struct page" above 64-bytes?

> work.  I don't think it's worth nibbling around the edges like this
> anyway; convert everything from page to folio and then we can do the
> big bang conversion where struct page shrinks from 64 bytes to 8.

I agree with general idea that converting to folio and shrinking
"struct page" to 8 bytes can be a big memory consumption win, but even
then we do not want to encourage the memdesc users to use larger than
needed types. If "flags" and "memcgs" are going to be part of almost
every single memdesc type it would be nice to reduce them from
16-bytes to 8-bytes.

Pasha
