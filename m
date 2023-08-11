Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732BD77874D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 08:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjHKGNR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 02:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjHKGNQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 02:13:16 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522ED2D54
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 23:13:15 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-487546cdf68so673908e0c.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 23:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691734394; x=1692339194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTSvGxQlqE/d/nCRDAA446cp2cSwaY6fTxEGcqvRIYU=;
        b=EqAO+nFDplIDMURYlBwR4a564c6eQbDsGagIpyAcR71ZBk/VsGVaUaATVIqgXKZOd3
         SkPl4Aj5teUfdRy8XUqHZagvWH8yIRPSlrzpwAzC5ezG5Loa0G4KeztM3QyR7ORDPyMq
         13FFyXJRr0tKlyP6fOkkSV+YlwgJceiWK5jjzQOxLNQYcKtS8ykZga2KNmAIZAJwy1dD
         WEIjAla25JM/mN8DVtF1BBPlKQI0+DceAAT2M7eqqIPs6q17m1xlS1mS/bMojKOY+rih
         yiKwcCQ40eMvJCpDMNN2q7eGXhclCfiN5M3cp/Swg59BA5TP+OrIsvrc1sQjHFsw1YoW
         FNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691734394; x=1692339194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTSvGxQlqE/d/nCRDAA446cp2cSwaY6fTxEGcqvRIYU=;
        b=Vt23sJk4NdI/B5Sn8Aq46jN8pJRgZfqoQUZ4WO/iuMiRV2fgCPBloz2XdnYFUJhc6d
         hTn6JdttupBazMfA7vxLODj2mxUWfSR6aQdK4ViKV7pcpkZCUoxi1/+dRSc2XmZ7RV5u
         NUiM49FUFa6dd1lGA+8ObAOBUerU3NNnN53D9uyCDhkEWDNS3mqR+Lq4+EWrSgtB7X7V
         rsBsyyKlQJgrtpUe1j7R+TNekfzRaJ8bHxVl0LB+/6MP73gQJI9vJMb3g/hjz4RlS7BL
         7LGB8ocYD6Kq7mK+nOeOffq61W341BEpNcJfnSM2n3/1Ryvh9x304pRikl4gSzB8fbAt
         Ljkw==
X-Gm-Message-State: AOJu0Yzkk5DvN1TkJsGeo2e8CQ2I5k3ltyrJgB27lWKRbmcLEawn2ZAI
        E4gFTwt9wqA0k5CTU1Zsvt4+O1qmnV6qdXrfXFppWw==
X-Google-Smtp-Source: AGHT+IEx399Z6BEVQYFMXGR9aRWcbccFC0l/CgGo5PMPl5/PDwhNP4Hfv3CYIONNd9sdo9md84btCApNCv7wzldaBQg=
X-Received: by 2002:a1f:6096:0:b0:471:19d6:1ce1 with SMTP id
 u144-20020a1f6096000000b0047119d61ce1mr990704vkb.11.1691734394213; Thu, 10
 Aug 2023 23:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230630211957.1341547-1-surenb@google.com> <a34a418a-9a6c-9d9a-b7a3-bde8013bf86c@redhat.com>
 <CAJuCfpGCWekMdno=L=4m7ujWTYMr0Wv77oYzXWT5RXnx+fWe0w@mail.gmail.com>
 <CAJuCfpGMvYxu-g9kVH40UDGnpF2kxctH7AazhvmwhWWq1Rn1sA@mail.gmail.com>
 <CAJuCfpHA78vxOBcaB3m7S7=CoBLMXTzRWego+jZM7JvUm3rEaQ@mail.gmail.com>
 <0ab6524a-6917-efe2-de69-f07fb5cdd9d2@redhat.com> <CAJuCfpEs2k8mHM+9uq05vmcOYCfkNnOb4s3xPSoWheizPkcwLA@mail.gmail.com>
 <CAJuCfpERuCx6QvfejUkS-ysMxbzp3mFfhCbH=rDtt2UGzbwtyg@mail.gmail.com>
 <CAJuCfpH-drRnwqUqynTnvgqSjs=_Fwc0H_7h6nzsdztRef0oKw@mail.gmail.com>
 <CAJuCfpH8ucOkCFYrVZafUAppi5+mVhy=uD+BK6-oYX=ysQv5qQ@mail.gmail.com>
 <ZNVhpeejqGkEqqSr@casper.infradead.org> <CAJuCfpG2Sc8Og+9EfeWsZ-xX+bUuEokUJe8Bvg5+dAqHtC-DfQ@mail.gmail.com>
 <CAJuCfpEdO9HLZtPx_Z-DqT65t4RQ-vzWw3Y35aWeb=vEXsijcA@mail.gmail.com>
In-Reply-To: <CAJuCfpEdO9HLZtPx_Z-DqT65t4RQ-vzWw3Y35aWeb=vEXsijcA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 10 Aug 2023 23:13:00 -0700
Message-ID: <CAJuCfpHSFikZ=h34yS980BmUP5M=+j6rB4_b-q7MCc10Xs24+w@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] Per-VMA lock support for swap and userfaults
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, peterx@redhat.com, ying.huang@intel.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 10, 2023 at 4:43=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Aug 10, 2023 at 4:29=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Thu, Aug 10, 2023 at 3:16=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Thu, Aug 10, 2023 at 06:24:15AM +0000, Suren Baghdasaryan wrote:
> > > > Ok, I think I found the issue.  wp_page_shared() ->
> > > > fault_dirty_shared_page() can drop mmap_lock (see the comment sayin=
g
> > > > "Drop the mmap_lock before waiting on IO, if we can...", therefore =
we
> > > > have to ensure we are not doing this under per-VMA lock.
> > >
> > > ... or we could change maybe_unlock_mmap_for_io() the same way
> > > that we changed folio_lock_or_retry():
> > >
> > > +++ b/mm/internal.h
> > > @@ -706,7 +706,7 @@ static inline struct file *maybe_unlock_mmap_for_=
io(struct vm_fault *vmf,
> > >         if (fault_flag_allow_retry_first(flags) &&
> > >             !(flags & FAULT_FLAG_RETRY_NOWAIT)) {
> > >                 fpin =3D get_file(vmf->vma->vm_file);
> > > -               mmap_read_unlock(vmf->vma->vm_mm);
> > > +               release_fault_lock(vmf);
> > >         }
> > >         return fpin;
> > >  }
> > >
> > > What do you think?
> >
> > This is very tempting... Let me try that and see if anything explodes,
> > but yes, this would be ideal.
>
> Ok, so far looks good, the problem is not reproducible. I'll run some
> more exhaustive testing today.

So far it works without a glitch. Matthew, I think it's fine. If you
post a fixup please add my Tested-by.
Thanks,
Suren.

>
> >
> >
> > >
> > > > I think what happens is that this path is racing with another page
> > > > fault which took mmap_lock for read. fault_dirty_shared_page()
> > > > releases this lock which was taken by another page faulting thread =
and
> > > > that thread generates an assertion when it finds out the lock it ju=
st
> > > > took got released from under it.
> > >
> > > I'm confused that our debugging didn't catch this earlier.  lockdep
> > > should always catch this.
> >
> > Maybe this condition is rare enough?
