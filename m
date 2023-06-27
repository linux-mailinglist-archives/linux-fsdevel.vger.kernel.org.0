Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4567874003E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 18:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjF0QBW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 12:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjF0QBU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:01:20 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AD62D63
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 09:01:19 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-bacf685150cso4664387276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 09:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687881679; x=1690473679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZ/aZnCB2+YlDU+Ga0O4oZcR0sxHQ0xYMLAmmJhI0Q4=;
        b=XjG+cMncQkL546mb3ZvTLEPSRSb5MAObCihNdAofp7Nk4A0b9YcIh5enoJRE6qc81Z
         Dn9+WV+fE5c4+rB1BtMdtu7bYxunG623p32EAqdGJ775l+sE3f3H2gMprP2uR8QvZ/Ic
         lD2uKf6ClFO9Luxh4lPthS9YegmL6EOs8bk9nLORbez2Layf/gdNc6wpp4MlxLDmqoSl
         fLbO+LNIlW7HBBti5U+qXyVSH0C+8qQj477UNo5z9l4/TcyXJSHU0QqwyxBy70/VovBv
         Lk4794ZdkPuXIqm5pSAM6VX3jOM5e2W3j2wpJqY+DK7WM0cBWznroTSUdjqoqiBaCkvd
         2X5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687881679; x=1690473679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZ/aZnCB2+YlDU+Ga0O4oZcR0sxHQ0xYMLAmmJhI0Q4=;
        b=hNowHjU7tzEkj085ZCIYJg1UvywyI7G8aBxUMDYIiJ5NsMnYZK9dPo+P0ahxEvaxNt
         ikW/wLHNNPriFyW/sob3ma6PyKxN7XUq5b21WzDuISN/B+gJ5WrW9j9ENToz7AtzE1Es
         Gr7AXT/8Erx6mAea7d23IeDxZDLhaAvpYN40bAM03h17AWx0BfPZztqxEjur9S4oTIHx
         WKXsIYHLVf6ALFJvPC9khMc5UsCzCzg9vnuK+CnrgJc8I+JlzJx6UYDNDhtK9Ndeb5g9
         BYl9PP9qzLdPFJ0NDsj4Jg/J9RLxOR8B4iW83NzNqp9Ek7Ij4G51BuuwAaHeGetCP0/N
         Q9zg==
X-Gm-Message-State: AC+VfDzeDXYeDqlEDDQXeoCV5uhQIQ/AyLANA848H7olfjAVY4sCf/vd
        Lm7e2ovx3TOylivXJot3KiC0MCZuiZX8kFahy57lnw==
X-Google-Smtp-Source: ACHHUZ6ZNyLbJUC0sWAhuJrS2pBneYTQJbWBg2QwCk+NwNZhIgHbBthpc7Ncxu18cJTwHgpgcvZ/A2lM4fDE9eXpSKI=
X-Received: by 2002:a25:ac27:0:b0:ba6:b486:84ed with SMTP id
 w39-20020a25ac27000000b00ba6b48684edmr27217909ybi.20.1687881677605; Tue, 27
 Jun 2023 09:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230627042321.1763765-1-surenb@google.com> <20230627042321.1763765-6-surenb@google.com>
 <871qhx2uot.fsf@nvdebian.thelocal>
In-Reply-To: <871qhx2uot.fsf@nvdebian.thelocal>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 27 Jun 2023 09:01:06 -0700
Message-ID: <CAJuCfpG=g0TgOMx17H4oEkVfOm1HU1yaSmDeOboX5SO68wp=oA@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] mm: make folio_lock_fault indicate the state of
 mmap_lock upon return
To:     Alistair Popple <apopple@nvidia.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        peterx@redhat.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
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

On Tue, Jun 27, 2023 at 1:09=E2=80=AFAM Alistair Popple <apopple@nvidia.com=
> wrote:
>
>
> Suren Baghdasaryan <surenb@google.com> writes:
>
> > folio_lock_fault might drop mmap_lock before returning and to extend it
> > to work with per-VMA locks, the callers will need to know whether the
> > lock was dropped or is still held. Introduce new fault_flag to indicate
> > whether the lock got dropped and store it inside vm_fault flags.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/mm_types.h | 1 +
> >  mm/filemap.c             | 2 ++
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 79765e3dd8f3..6f0dbef7aa1f 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -1169,6 +1169,7 @@ enum fault_flag {
> >       FAULT_FLAG_UNSHARE =3D            1 << 10,
> >       FAULT_FLAG_ORIG_PTE_VALID =3D     1 << 11,
> >       FAULT_FLAG_VMA_LOCK =3D           1 << 12,
> > +     FAULT_FLAG_LOCK_DROPPED =3D       1 << 13,
>
> Minor nit but this should also be added to the enum documentation
> comment above this.

Thanks! Sounds like we will be dripping the new flag, so hopefully I
won't need to document it :)

>
> >  };
> >
> >  typedef unsigned int __bitwise zap_flags_t;
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 87b335a93530..8ad06d69895b 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -1723,6 +1723,7 @@ vm_fault_t __folio_lock_fault(struct folio *folio=
, struct vm_fault *vmf)
> >                       return VM_FAULT_RETRY;
> >
> >               mmap_read_unlock(mm);
> > +             vmf->flags |=3D FAULT_FLAG_LOCK_DROPPED;
> >               if (vmf->flags & FAULT_FLAG_KILLABLE)
> >                       folio_wait_locked_killable(folio);
> >               else
> > @@ -1735,6 +1736,7 @@ vm_fault_t __folio_lock_fault(struct folio *folio=
, struct vm_fault *vmf)
> >               ret =3D __folio_lock_killable(folio);
> >               if (ret) {
> >                       mmap_read_unlock(mm);
> > +                     vmf->flags |=3D FAULT_FLAG_LOCK_DROPPED;
> >                       return VM_FAULT_RETRY;
> >               }
> >       } else {
>
