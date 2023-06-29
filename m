Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C62A742AB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 18:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjF2Qj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 12:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjF2Qjz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:39:55 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABCA30F1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 09:39:54 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-c13280dfb09so786056276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 09:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688056793; x=1690648793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYKtv9j9EWY+qlSLxNSMyNgvkOT32/s3MoVou6QGXdk=;
        b=0Bxjyvyvdg2n9f+zfkap6qHE3pcwPHyknCZHaeLUFmeO5WxX2baUzGVKhjFdnnVKWJ
         yawFJeYuBM/63nZSBqwgJHqKMl2k9ocxzbD7d6oujPUv2DZoeCxNbYLbJwjFMzXQ64/L
         hTHGf0zikrV2IvW9i4FXRzXsUIM1M5TAj2nA7j+W33Rb6RQyKBkKlulpHnA40N4n3QAn
         WSSYDeRSLQK8B7emh+jneStAmWsqBP3YWXBub9xBI0R9VeF7+EVOWNzzdpMSEnvf0gKP
         rdcS9JCYeg204W4hA4S4bF7KA9iyIMfuRCh6gdi/AHGvbRP6epDvg/4Hq0Yv+ZlR/Kgw
         UwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688056793; x=1690648793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYKtv9j9EWY+qlSLxNSMyNgvkOT32/s3MoVou6QGXdk=;
        b=FKCn0OsCkSqHm2tC4U/LoZ2NYmenRGoHOIw4U6XzWhbFkiiI9SMGA4pGbbjYyLRKq4
         Q/VynUySnKuLwoUkWTF0UJUMadG9MR0VEG647O1yVnjs1BXLQDCjpfglCWzYPdLOa6he
         1louAHxkwHhWH1btH0msZp0VJmyj/Ch0iGuszTTDrOE4XR6VZ/pjgJAzdnvlub18bZLZ
         9W3j6l5suzbWlA3eb1xgeDdpLstwrDF1cpEBDjt9lquhfHf4bw7OzU8Z7NUEFTy5/CoU
         a6cbOJBFx3RqSq9klEryD4kI3pEL73mEwM/z5mR7ddKuucFqPFOSQOM7goKSe44cEKST
         yBkw==
X-Gm-Message-State: ABy/qLZYrhIklsW0yDQNwQChWsqeQUt+9O8e4DLdE8IvU8DkWlwxIdKK
        eR50mEZpkmjljKocLZ/L7BD7BKlNQ55VhpcOpPd6LA==
X-Google-Smtp-Source: APBJJlFZzY82QJbByDeWwktFp9BbYuwkr1Kmyn9ua1mr5NBPoLe1UPj+2Snkn5RTrhUgo21lRxxlPYE1aP8AFayeBvQ=
X-Received: by 2002:a25:23c8:0:b0:c1a:b15d:81b5 with SMTP id
 j191-20020a2523c8000000b00c1ab15d81b5mr385342ybj.35.1688056793361; Thu, 29
 Jun 2023 09:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230628172529.744839-1-surenb@google.com> <20230628172529.744839-7-surenb@google.com>
 <ZJxulItq9iHi2Uew@x1n> <CAJuCfpEPpdEScAG_UOiNfOTpue9ro0AP6414C4tBaK1rbVK7Hw@mail.gmail.com>
 <ZJ2yOACwp7B2poIw@x1n>
In-Reply-To: <ZJ2yOACwp7B2poIw@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 29 Jun 2023 09:39:41 -0700
Message-ID: <CAJuCfpER=0GzcR3sWETYJAPK9SKAaRYtNfVXa-sXZu8MiL67NA@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] mm: handle userfaults under VMA lock
To:     Peter Xu <peterx@redhat.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, ying.huang@intel.com, david@redhat.com,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 29, 2023 at 9:33=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Jun 28, 2023 at 05:19:31PM -0700, Suren Baghdasaryan wrote:
> > On Wed, Jun 28, 2023 at 10:32=E2=80=AFAM Peter Xu <peterx@redhat.com> w=
rote:
> > >
> > > On Wed, Jun 28, 2023 at 10:25:29AM -0700, Suren Baghdasaryan wrote:
> > > > Enable handle_userfault to operate under VMA lock by releasing VMA =
lock
> > > > instead of mmap_lock and retrying. Note that FAULT_FLAG_RETRY_NOWAI=
T
> > > > should never be used when handling faults under per-VMA lock protec=
tion
> > > > because that would break the assumption that lock is dropped on ret=
ry.
> > > >
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > >
> > > Maybe the sanitize_fault_flags() changes suite more in patch 3, but n=
ot a
> > > big deal I guess.
> >
> > IIUC FAULT_FLAG_RETRY_NOWAIT comes into play in this patchset only in
> > the context of uffds, therefore that check seems to be needed when we
> > enable per-VMA lock uffd support, which is this patch. Does that make
> > sense?
>
> I don't see why uffd is special in this regard, as e.g. swap also checks
> NOWAIT when folio_lock_or_retry() so I assume it's also used there.
>
> IMHO the "NOWAIT should never apply with VMA_LOCK so far" assumption star=
ts
> from patch 3 where it conditionally releases the vma lock when
> !(RETRY|COMPLETE); that is the real place where it can start to go wrong =
if
> anyone breaks the assumption.

Um, yes, you are right as usual. It was clear to me from the code that
NOWAIT is not used with swap under VMA_LOCK, that's why I didn't
consider this check earlier. Yeah, patch 3 seems like a more
appropriate place for it. I'll move it and post a new patchset later
today or tomorrow morning with your Acks.
Thanks,
Suren.

>
> Thanks,
>
> --
> Peter Xu
>
