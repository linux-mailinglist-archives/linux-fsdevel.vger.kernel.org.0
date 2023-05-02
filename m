Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA20E6F3CDD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 07:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbjEBFFM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 01:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbjEBFFK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 01:05:10 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC18C30F3
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 22:05:08 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-b9a7e639656so5653558276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 22:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683003908; x=1685595908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aysv1FPzsQsQI02R++ef6/e3KwVy65b2cRl1SJjrhgI=;
        b=OIE+zQkAgv442W4FpET90fUnuSM85S+yyELrfcdEX9POXBEUXtrNFara1bYiUZZ9zj
         5gxVaF1MplXouDnuoYX6t2Mjszv/j5Rx7PG0ciMWwVrXpFgZbMIAbNZ/dCBijZ2/cdNu
         Z0uq2s2unL3HsbCNA7v63ZgHPjhzC+bDdUl8ezXqYdtQs4aNGBiCiw7UoW7NLWqEscHK
         n1G6u65hmmYkaXmerxU9d98FdhWLbntlShHriPMyIATHady+wSQ0lIqUc933/MGLH9Ml
         qLFgs5X6RFFDR3g2Q1zXlqyn6q4nZEKENi0b9AT9IVT4dvbneIrwJfo4rh6xkqVM1knn
         mneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683003908; x=1685595908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aysv1FPzsQsQI02R++ef6/e3KwVy65b2cRl1SJjrhgI=;
        b=bWYBROV2ZcIK1p0SPvxCdeNUmo910KlIygEf7ZvlTT3mMG5zsW9aEBj/USCZ2Q8XdT
         WZGSZKdxtzZu1W9v/lzJRzUigPM+kwwwOmOkGpqJv6iThKnwuCLGaeddFe/D7b5kcqL6
         xO/+78gU4a91Cf+MKV5jjeP41mNNdOtkyDhcxjbMSuo84UwgS1S8cqrmFUPPGTk6Cknw
         9xxHyL8tpt4+hkopJprgCi2LSAka1KpSTcJ1dbczsRpmacL5mqvgn4tBR+m8buGqpz9/
         s1OMr7FchsIUlnJn//yLrvo64aXo+Qgp7OlPU8u/80d9TKKT/AMbowC6xT7acclCsaTt
         BA8Q==
X-Gm-Message-State: AC+VfDx8WiOHKGf4gSNv7f4IWIWpy5hq2AzvSpqa58RCSQ/wdy00VAqk
        bCd8ExR5scQCVd6aWZmnw432AdxxkkhqLddhkKctRw==
X-Google-Smtp-Source: ACHHUZ41N49bf2gvv4oZ4MwpipxspgrvKz+WfxbxbwpyhulOLDwYMSAzukBN48CDjHEjpROA0L7Eh333xaO6tDW/pSY=
X-Received: by 2002:a25:ad12:0:b0:b99:4af6:185d with SMTP id
 y18-20020a25ad12000000b00b994af6185dmr14333224ybi.6.1683003907781; Mon, 01
 May 2023 22:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230501175025.36233-1-surenb@google.com> <ZFBvOh8r5WbTVyA8@casper.infradead.org>
 <CAJuCfpHfAFx9rjv0gHK77LbP-8gd-kFnWw=aqfQTP6pH=zvMNg@mail.gmail.com> <ZFCB+G9KSNE+J9cZ@casper.infradead.org>
In-Reply-To: <ZFCB+G9KSNE+J9cZ@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 1 May 2023 22:04:56 -0700
Message-ID: <CAJuCfpES=G8i99yYXWoeJq9+JVUjX5Bkq_5VNVTVX7QT+Wkfxg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: handle swap page faults under VMA lock if page is uncontended
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 1, 2023 at 8:22=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Mon, May 01, 2023 at 07:30:13PM -0700, Suren Baghdasaryan wrote:
> > On Mon, May 1, 2023 at 7:02=E2=80=AFPM Matthew Wilcox <willy@infradead.=
org> wrote:
> > >
> > > On Mon, May 01, 2023 at 10:50:23AM -0700, Suren Baghdasaryan wrote:
> > > > +++ b/mm/memory.c
> > > > @@ -3711,11 +3711,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf=
)
> > > >       if (!pte_unmap_same(vmf))
> > > >               goto out;
> > > >
> > > > -     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> > > > -             ret =3D VM_FAULT_RETRY;
> > > > -             goto out;
> > > > -     }
> > > > -
> > > >       entry =3D pte_to_swp_entry(vmf->orig_pte);
> > > >       if (unlikely(non_swap_entry(entry))) {
> > > >               if (is_migration_entry(entry)) {
> > >
> > > You're missing the necessary fallback in the (!folio) case.
> > > swap_readpage() is synchronous and will sleep.
> >
> > True, but is it unsafe to do that under VMA lock and has to be done
> > under mmap_lock?
>
> ... you were the one arguing that we didn't want to wait for I/O with
> the VMA lock held?

Well, that discussion was about waiting in folio_lock_or_retry() with
the lock being held. I argued against it because currently we drop
mmap_lock lock before waiting, so if we don't drop VMA lock we would
be changing the current behavior which might introduce new
regressions. In the case of swap_readpage and swapin_readahead we
already wait with mmap_lock held, so waiting with VMA lock held does
not introduce new problems (unless there is a need to hold mmap_lock).

That said, you are absolutely correct that this situation can be
improved by dropping the lock in these cases too. I just didn't want
to attack everything at once. I believe after we agree on the approach
implemented in https://lore.kernel.org/all/20230501175025.36233-3-surenb@go=
ogle.com
for dropping the VMA lock before waiting, these cases can be added
easier. Does that make sense?
