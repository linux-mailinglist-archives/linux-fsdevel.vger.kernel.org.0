Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CD86DA6C4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Apr 2023 03:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjDGBDj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 21:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjDGBDi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 21:03:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7933B83F2
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Apr 2023 18:03:36 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l15so5297758ejq.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Apr 2023 18:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680829415; x=1683421415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1XvlUCiR72ZgTzOM/og5L0+VnHEni2vL4kpkj08keI=;
        b=Gi1Y36e4Jc0UALptyl/LTUaKrFpOmFC+j8X9vJU+aUHaJ3V/nAFb/UcxcPBuAejvaH
         /DykQnS/vNIUGvAj/vpicf1rCmjLItBkP+bLF+dGVfixHnNW+5CvjeDuW4eo191qm+tD
         /Nq+T7LDKnMVZlYaOt6vDiKYbS+KZVpU3p3A8de2y3YKNEYQKgxNxXTk0yrPUZn575XF
         mnbdm2DvXhWi2hHHHAf/oVSgR8l2Df2pc7SE6ASCqpyOOXjWD43ob5Yvini26m7y0KFt
         weAJHGxy1ugwudrZ9aw5LDrjquxkqb8elbQYiLtsZ+UmZCKrfLf6fl9xA0VwSR5qwu3S
         lr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680829415; x=1683421415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1XvlUCiR72ZgTzOM/og5L0+VnHEni2vL4kpkj08keI=;
        b=WStDHjZvTSgZxtjnXmerdW74mcxAGhv2CihgTX3IQVyvAhPEmZHz+WumGiyfW0pU4V
         627NjySqv+dvh/angWsiRaXpvZ2l0uoQa958X+jtyvqu26s0xycC3V7/Q/ZRc6JYHUb6
         lBDDAu3THfZQ+prjyj5JWusX7giLIxgLXqb4iGA57WCqhkTLYgbzlo7RtldrbrPNA/Ow
         MHIrjzgnblbKE6b6e/RS03AVvYCSiywj4c7LlVbPkSaFTNRNVSixVgc9z/NuuieVIJyz
         5mUzR9VB45ZLDSgaLVShEH7RVe+eFXRJznYyVeh1mh47puJZ8DZeqVXz6WUoOYD0VB73
         k5vA==
X-Gm-Message-State: AAQBX9e1PW0RAbagYdli/SyMAuC/MoUIddgq24eCdxPH3Hu2l0SfLLU3
        kXFfGSa+HrMkHXrRaR7wSi+7QkfChHno2Rqdt830CA==
X-Google-Smtp-Source: AKy350bKwpPCq7aUCh6NiZcMFFssax3P1vh2/SYajMVgSOKC2SUmSEJRZckrVOXLSYAQz7B816irIxnvUuw5f1vCMFM=
X-Received: by 2002:a17:906:d976:b0:931:2bcd:ee00 with SMTP id
 rp22-20020a170906d97600b009312bcdee00mr332600ejb.15.1680829414816; Thu, 06
 Apr 2023 18:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230405185427.1246289-1-yosryahmed@google.com>
 <20230405185427.1246289-3-yosryahmed@google.com> <ZC8vTi3SlKwnYv5i@x1n>
In-Reply-To: <ZC8vTi3SlKwnYv5i@x1n>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 6 Apr 2023 18:02:58 -0700
Message-ID: <CAJD7tkbGhkBW+3yzGyzg6t9RPDOrqhGJPgdjLVA-BW0x0SqW4g@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mm: vmscan: refactor reclaim_state helpers
To:     Peter Xu <peterx@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        NeilBrown <neilb@suse.de>, Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 6, 2023 at 1:45=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> Hi, Yosry,
>
> On Wed, Apr 05, 2023 at 06:54:27PM +0000, Yosry Ahmed wrote:
>
> [...]
>
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index c82bd89f90364..049e39202e6ce 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -188,18 +188,6 @@ struct scan_control {
> >   */
> >  int vm_swappiness =3D 60;
> >
> > -static void set_task_reclaim_state(struct task_struct *task,
> > -                                struct reclaim_state *rs)
> > -{
> > -     /* Check for an overwrite */
> > -     WARN_ON_ONCE(rs && task->reclaim_state);
> > -
> > -     /* Check for the nulling of an already-nulled member */
> > -     WARN_ON_ONCE(!rs && !task->reclaim_state);
> > -
> > -     task->reclaim_state =3D rs;
> > -}
> > -
> >  LIST_HEAD(shrinker_list);
> >  DECLARE_RWSEM(shrinker_rwsem);
> >
> > @@ -511,6 +499,59 @@ static bool writeback_throttling_sane(struct scan_=
control *sc)
> >  }
> >  #endif
> >
> > +static void set_task_reclaim_state(struct task_struct *task,
> > +                                struct reclaim_state *rs)
> > +{
> > +     /* Check for an overwrite */
> > +     WARN_ON_ONCE(rs && task->reclaim_state);
> > +
> > +     /* Check for the nulling of an already-nulled member */
> > +     WARN_ON_ONCE(!rs && !task->reclaim_state);
> > +
> > +     task->reclaim_state =3D rs;
> > +}
>
> Nit: I just think such movement not necessary while it loses the "git
> blame" information easily.
>
> Instead of moving this here without major benefit, why not just define
> flush_reclaim_state() right after previous set_task_reclaim_state()?

An earlier version did that, but we would have to add a forward
declaration of global_reclaim() (or cgroup_reclaim()), as they are
defined after the previous position of set_task_reclaim_state().

>
> > +
> > +/*
> > + * flush_reclaim_state(): add pages reclaimed outside of LRU-based rec=
laim to
> > + * scan_control->nr_reclaimed.
> > + */
> > +static void flush_reclaim_state(struct scan_control *sc,
> > +                             struct reclaim_state *rs)
> > +{
> > +     /*
> > +      * Currently, reclaim_state->reclaimed includes three types of pa=
ges
> > +      * freed outside of vmscan:
> > +      * (1) Slab pages.
> > +      * (2) Clean file pages from pruned inodes.
> > +      * (3) XFS freed buffer pages.
> > +      *
> > +      * For all of these cases, we have no way of finding out whether =
these
> > +      * pages were related to the memcg under reclaim. For example, a =
freed
> > +      * slab page could have had only a single object charged to the m=
emcg
> > +      * under reclaim. Also, populated inodes are not on shrinker LRUs
> > +      * anymore except on highmem systems.
> > +      *
> > +      * Instead of over-reporting the reclaimed pages in a memcg recla=
im,
> > +      * only count such pages in global reclaim. This prevents unneces=
sary
> > +      * retries during memcg charging and false positive from proactiv=
e
> > +      * reclaim (memory.reclaim).
> > +      *
> > +      * For uncommon cases were the freed pages were actually signific=
antly
> > +      * charged to the memcg under reclaim, and we end up under-report=
ing, it
> > +      * should be fine. The freed pages will be uncharged anyway, even=
 if
> > +      * they are not reported properly, and we will be able to make fo=
rward
> > +      * progress in charging (which is usually in a retry loop).
> > +      *
> > +      * We can go one step further, and report the uncharged objcg pag=
es in
> > +      * memcg reclaim, to make reporting more accurate and reduce
> > +      * under-reporting, but it's probably not worth the complexity fo=
r now.
> > +      */
> > +     if (rs && global_reclaim(sc)) {
> > +             sc->nr_reclaimed +=3D rs->reclaimed;
> > +             rs->reclaimed =3D 0;
> > +     }
> > +}
> > +
> >  static long xchg_nr_deferred(struct shrinker *shrinker,
> >                            struct shrink_control *sc)
> >  {
> > @@ -5346,10 +5387,7 @@ static int shrink_one(struct lruvec *lruvec, str=
uct scan_control *sc)
> >               vmpressure(sc->gfp_mask, memcg, false, sc->nr_scanned - s=
canned,
> >                          sc->nr_reclaimed - reclaimed);
> >
> > -     if (global_reclaim(sc)) {
> > -             sc->nr_reclaimed +=3D current->reclaim_state->reclaimed_s=
lab;
> > -             current->reclaim_state->reclaimed_slab =3D 0;
> > -     }
> > +     flush_reclaim_state(sc, current->reclaim_state);
> >
> >       return success ? MEMCG_LRU_YOUNG : 0;
> >  }
> > @@ -6474,10 +6512,7 @@ static void shrink_node(pg_data_t *pgdat, struct=
 scan_control *sc)
> >
> >       shrink_node_memcgs(pgdat, sc);
> >
> > -     if (reclaim_state && global_reclaim(sc)) {
> > -             sc->nr_reclaimed +=3D reclaim_state->reclaimed_slab;
> > -             reclaim_state->reclaimed_slab =3D 0;
> > -     }
> > +     flush_reclaim_state(sc, reclaim_state);
>
> IIUC reclaim_state here still points to current->reclaim_state.  Could it
> change at all?
>
> Is it cleaner to make flush_reclaim_state() taking "sc" only if it always
> references current->reclaim_state?

Good point. I think it's always current->reclaim_state.

I think we can make flush_reclaim_state() only take "sc" as an
argument, and remove the "reclaim_state" local variable in
shrink_node() completely.

>
> >
> >       /* Record the subtree's reclaim efficiency */
> >       if (!sc->proactive)
> > --
> > 2.40.0.348.gf938b09366-goog
> >
>
> --
> Peter Xu
>
