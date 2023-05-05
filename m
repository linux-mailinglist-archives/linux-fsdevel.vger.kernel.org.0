Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793BD6F8C5D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 00:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjEEWaV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 18:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjEEWaT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 18:30:19 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CDD3A8C
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 15:30:17 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-559de1d36a9so34225287b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 May 2023 15:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683325816; x=1685917816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUUTziawIl4BojGG/FdaBcAmXedhxfQcsfQb94otdAo=;
        b=umRi9+C0iMLswLI9JRNFsF3df0mPDvKkR4pbd7Iv16rUGFmOxMUUpO0v1FV7gqzf9s
         S/C/gLhte3+iuW1AcsInUFxlriVGiRvOR3diEyrHtEP9clY3yrs3oBT9ntNinCVhW6km
         zbwdk1LeNP2Ny+6cJ7OReYa2ZCamN6/c917Xps4wAxpPBqgWwjJQUbD/cYGz6pAcN7mV
         X7qzuhrvktOw0xdfJAjLc3OIzvLKknvTrrBUBhkShomu3bYgw8C1naTqL7mS7AO9Kv7T
         ZB3tKXycpID763tmw4KivJbaBfBjElA/Z1vdPgScoxBwoSUZvdUYvF4PKJ9cMNagZbNC
         GYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683325816; x=1685917816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUUTziawIl4BojGG/FdaBcAmXedhxfQcsfQb94otdAo=;
        b=KeiXA8nIdiw+CiQBRhZDmS4nP6HySBuIjVVmGMV5pGc2ZOEMXBVi4eytvHfshEfgqh
         uM+cnZ++niZcqOaXJYB+66w5qYZAg5Km23G9hIRfESmhGMl4pQlpGj7DXHPYtbLBSAFm
         kIuoAE+9e2MeSuVVKC0ZG1fFrJmBrMxgKUmrtrLGLm5dCioHdwFE8Xvbyjrq19DOLMDl
         qVig7ycWikUz9NPa1wokbjOftw6YZTO3qIj652xcmkkg2cuBGV6KjazMvRJBxKWtG90M
         qDOpsXuOL7ppr5wEAeF6d3iS5p9yon/bnb4Rxm0fmw10TpK8+iv3s68UG2yUNaWpriyX
         l4bQ==
X-Gm-Message-State: AC+VfDy0x+S9w2UrGIwwcXMeMyOtdYDA/T+pDCwuPZbeJ+CVGsBdDhrb
        nb3ywDXz5ihj/P1K1roOlJcPeNg6is+M2LTFXX0qfg==
X-Google-Smtp-Source: ACHHUZ5om/c1vYg0q2ONh4X75lxWFUD/gu+/wmGRdmIRHfa70cfOo6m8jB80pT24p3+vi1YkKo80Dkaw7U6Pcn0ye3Q=
X-Received: by 2002:a81:5456:0:b0:55a:5ce4:aff2 with SMTP id
 i83-20020a815456000000b0055a5ce4aff2mr3639474ywb.39.1683325816398; Fri, 05
 May 2023 15:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230501175025.36233-1-surenb@google.com> <ZFBvOh8r5WbTVyA8@casper.infradead.org>
 <CAJuCfpHfAFx9rjv0gHK77LbP-8gd-kFnWw=aqfQTP6pH=zvMNg@mail.gmail.com>
 <ZFCB+G9KSNE+J9cZ@casper.infradead.org> <CAJuCfpES=G8i99yYXWoeJq9+JVUjX5Bkq_5VNVTVX7QT+Wkfxg@mail.gmail.com>
 <ZFEmN6G7WRy59Mum@casper.infradead.org> <CAJuCfpFs+Rgpu8v+ddHFwtOx33W5k1sKDdXHM2ej1Upyo_9y4g@mail.gmail.com>
 <ZFGPLXIis6tl1QWX@casper.infradead.org> <CAJuCfpGgc_bCEAE5LrhYPk=qXMU=owgiABTO9ZNqaBx-xfrOuQ@mail.gmail.com>
 <CAJD7tkZJ1VPB+bA0cjHHcehoMW2fT96-h=C5pRHD=Z+SJXYosA@mail.gmail.com>
 <CAJuCfpE9dVK01c-aNT_uwTC=m8RSdEiXsoe6XBR48GjL=ezsmg@mail.gmail.com>
 <CAJD7tkadk9=-PT1daXQyA=X_qz60XOEciXOkXWwPqxYJOaWRXQ@mail.gmail.com> <87wn1nbcbg.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87wn1nbcbg.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 5 May 2023 15:30:04 -0700
Message-ID: <CAJuCfpH6SGT5wwZDt1nv8YWBFPWZnAciYBbkFVwqFuwSD4fcBA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: handle swap page faults under VMA lock if page is uncontended
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 4, 2023 at 10:03=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Yosry Ahmed <yosryahmed@google.com> writes:
>
> > On Wed, May 3, 2023 at 12:57=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> >>
> >> On Wed, May 3, 2023 at 1:34=E2=80=AFAM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> >> >
> >> > On Tue, May 2, 2023 at 4:05=E2=80=AFPM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
> >> > >
> >> > > On Tue, May 2, 2023 at 3:31=E2=80=AFPM Matthew Wilcox <willy@infra=
dead.org> wrote:
> >> > > >
> >> > > > On Tue, May 02, 2023 at 09:36:03AM -0700, Suren Baghdasaryan wro=
te:
> >> > > > > On Tue, May 2, 2023 at 8:03=E2=80=AFAM Matthew Wilcox <willy@i=
nfradead.org> wrote:
> >> > > > > >
> >> > > > > > On Mon, May 01, 2023 at 10:04:56PM -0700, Suren Baghdasaryan=
 wrote:
> >> > > > > > > On Mon, May 1, 2023 at 8:22=E2=80=AFPM Matthew Wilcox <wil=
ly@infradead.org> wrote:
> >> > > > > > > >
> >> > > > > > > > On Mon, May 01, 2023 at 07:30:13PM -0700, Suren Baghdasa=
ryan wrote:
> >> > > > > > > > > On Mon, May 1, 2023 at 7:02=E2=80=AFPM Matthew Wilcox =
<willy@infradead.org> wrote:
> >> > > > > > > > > >
> >> > > > > > > > > > On Mon, May 01, 2023 at 10:50:23AM -0700, Suren Bagh=
dasaryan wrote:
> >> > > > > > > > > > > +++ b/mm/memory.c
> >> > > > > > > > > > > @@ -3711,11 +3711,6 @@ vm_fault_t do_swap_page(str=
uct vm_fault *vmf)
> >> > > > > > > > > > >       if (!pte_unmap_same(vmf))
> >> > > > > > > > > > >               goto out;
> >> > > > > > > > > > >
> >> > > > > > > > > > > -     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> >> > > > > > > > > > > -             ret =3D VM_FAULT_RETRY;
> >> > > > > > > > > > > -             goto out;
> >> > > > > > > > > > > -     }
> >> > > > > > > > > > > -
> >> > > > > > > > > > >       entry =3D pte_to_swp_entry(vmf->orig_pte);
> >> > > > > > > > > > >       if (unlikely(non_swap_entry(entry))) {
> >> > > > > > > > > > >               if (is_migration_entry(entry)) {
> >> > > > > > > > > >
> >> > > > > > > > > > You're missing the necessary fallback in the (!folio=
) case.
> >> > > > > > > > > > swap_readpage() is synchronous and will sleep.
> >> > > > > > > > >
> >> > > > > > > > > True, but is it unsafe to do that under VMA lock and h=
as to be done
> >> > > > > > > > > under mmap_lock?
> >> > > > > > > >
> >> > > > > > > > ... you were the one arguing that we didn't want to wait=
 for I/O with
> >> > > > > > > > the VMA lock held?
> >> > > > > > >
> >> > > > > > > Well, that discussion was about waiting in folio_lock_or_r=
etry() with
> >> > > > > > > the lock being held. I argued against it because currently=
 we drop
> >> > > > > > > mmap_lock lock before waiting, so if we don't drop VMA loc=
k we would
> >> > > > > > > be changing the current behavior which might introduce new
> >> > > > > > > regressions. In the case of swap_readpage and swapin_reada=
head we
> >> > > > > > > already wait with mmap_lock held, so waiting with VMA lock=
 held does
> >> > > > > > > not introduce new problems (unless there is a need to hold=
 mmap_lock).
> >> > > > > > >
> >> > > > > > > That said, you are absolutely correct that this situation =
can be
> >> > > > > > > improved by dropping the lock in these cases too. I just d=
idn't want
> >> > > > > > > to attack everything at once. I believe after we agree on =
the approach
> >> > > > > > > implemented in https://lore.kernel.org/all/20230501175025.=
36233-3-surenb@google.com
> >> > > > > > > for dropping the VMA lock before waiting, these cases can =
be added
> >> > > > > > > easier. Does that make sense?
> >> > > > > >
> >> > > > > > OK, I looked at this path some more, and I think we're fine.=
  This
> >> > > > > > patch is only called for SWP_SYNCHRONOUS_IO which is only se=
t for
> >> > > > > > QUEUE_FLAG_SYNCHRONOUS devices, which are brd, zram and nvdi=
mms
> >> > > > > > (both btt and pmem).  So the answer is that we don't sleep i=
n this
> >> > > > > > path, and there's no need to drop the lock.
> >> > > > >
> >> > > > > Yes but swapin_readahead does sleep, so I'll have to handle th=
at case
> >> > > > > too after this.
> >> > > >
> >> > > > Sleeping is OK, we do that in pXd_alloc()!  Do we block on I/O a=
nywhere
> >> > > > in swapin_readahead()?  It all looks like async I/O to me.
> >> > >
> >> > > Hmm. I thought that we have synchronous I/O in the following paths=
:
> >> > >     swapin_readahead()->swap_cluster_readahead()->swap_readpage()
> >> > >     swapin_readahead()->swap_vma_readahead()->swap_readpage()
> >> > > but just noticed that in both cases swap_readpage() is called with=
 the
> >> > > synchronous parameter being false. So you are probably right here.=
..
> >> >
> >> > In both swap_cluster_readahead() and swap_vma_readahead() it looks
> >> > like if the readahead window is 1 (aka we are not reading ahead), th=
en
> >> > we jump to directly calling read_swap_cache_async() passing do_poll =
=3D
> >> > true, which means we may end up calling swap_readpage() passing
> >> > synchronous =3D true.
> >> >
> >> > I am not familiar with readahead heuristics, so I am not sure how
> >> > common this is, but it's something to think about.
> >>
> >> Uh, you are correct. If this branch is common, we could use the same
> >> "drop the lock and retry" pattern inside read_swap_cache_async(). That
> >> would be quite easy to implement.
> >> Thanks for checking on it!
> >
> >
> > I am honestly not sure how common this is.
> >
> > +Ying who might have a better idea.
>
> Checked the code and related history.  It seems that we can just pass
> "synchronous =3D false" to swap_readpage() in read_swap_cache_async().
> "synchronous =3D true" was introduced in commit 23955622ff8d ("swap: add
> block io poll in swapin path") to reduce swap read latency for block
> devices that can be polled.  But in commit 9650b453a3d4 ("block: ignore
> RWF_HIPRI hint for sync dio"), the polling is deleted.  So, we don't
> need to pass "synchronous =3D true" to swap_readpage() during
> swapin_readahead(), because we will wait the IO to complete in
> folio_lock_or_retry().

Thanks for investigating, Ying! It sounds like we can make some
simplifications here. I'll double-check and if I don't find anything
else, will change to "synchronous =3D false" in the next version of the
patchset.

>
> Best Regards,
> Huang, Ying
>
> >>
> >>
> >> >
> >> > > Does that mean swapin_readahead() might return a page which does n=
ot
> >> > > have its content swapped-in yet?
> >> > >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
