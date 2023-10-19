Return-Path: <linux-fsdevel+bounces-766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D9B7CFDAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 17:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81BF71C20E7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 15:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2D92FE23;
	Thu, 19 Oct 2023 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JojRJhIq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690E32FE1D
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 15:20:06 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CEF121
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 08:20:04 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7af45084eso103693657b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 08:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697728804; x=1698333604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRnUGTvblTffidsZLvzhyxUVdZqdHJIWMYZoMmdQD9g=;
        b=JojRJhIqePzP8nEwaV77iL43Ult2vaCz3uHYjIDX6kiEkCSEHAoqMy0hvLaBx36785
         2Fh0ndEfXYxaewcCHSScTlctjy23Bn5YoM5OvZmL4wvfnwxZZVzskqcjZi4OGvNRQIF9
         J9FxCjdeC7OQbaidiM+fXo0AvsAAGcmq1RYjHg+iheQ0cpXVloOJ2Z22LpgsxYP8z9hv
         B3l/jGPFlms+o/1zucpV9BUmVOCXlkxrUECSd7P80NrIEj9gIWY73GJyoD/AoAJxhoLp
         kLm2JqknSf+JI7uDXRfOPd4Bvq/OPi/tGGUuE66gpjIyFWkC32o9rvYGnP86gBvAqwyX
         NNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697728804; x=1698333604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRnUGTvblTffidsZLvzhyxUVdZqdHJIWMYZoMmdQD9g=;
        b=B6krE9QiiO3WdZSMphYcT+wWgFhExm8HoMmJ7t5+uISUZwruMARA6CqbY7/KyPjNJa
         3iOJOcbHJWUbBBXSYkaDiHVdkfdtSnEh1jH02td9vLrDmdT/5uQhMkN2VMNFzvPlMbUG
         9bu2IQCCgY/Q2xY6wt3lqYYjaZZF0WAPmedUzZ75pjEYcEdVPEI8UYfU4Q3zdZ8TiFys
         6VXBvoUqzcGX3sKSLRwiqCbOhg5/OfQ1exZLJ8724soE7ULfx0y4XktJX8cUGapIULML
         b1WAjyDk1a9rZzMhYD30QmUptSpbhLfKFhD0Myp4pa/+oml6BuVht3oZY6iBtv04HZfn
         5IdA==
X-Gm-Message-State: AOJu0YwThY9jlYvdYGVgB3BErR2qEfFrtG8Fy9kbK9ELVdY4VXfpcJio
	9XsBSoAdUnGl2T/d7Ki9bMLR7EinOTS+MQRIDsJJFQ==
X-Google-Smtp-Source: AGHT+IF0k6UMqpib1oXKFwqqUTgDYexYaE+vjZ9HjrI6meVqchr+93GJHlAwtx4opiMUXj0lZtYCc2bRPUEM94NV5SQ=
X-Received: by 2002:a81:9255:0:b0:5a7:d9ce:363c with SMTP id
 j82-20020a819255000000b005a7d9ce363cmr2795218ywg.6.1697728803811; Thu, 19 Oct
 2023 08:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009064230.2952396-1-surenb@google.com> <20231009064230.2952396-2-surenb@google.com>
 <ZShswW2rkKTwnrV3@x1n> <7495754c-9267-74af-b943-9b0f86619b5d@redhat.com>
In-Reply-To: <7495754c-9267-74af-b943-9b0f86619b5d@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 19 Oct 2023 08:19:50 -0700
Message-ID: <CAJuCfpFEVq_OXESTUCmYYr9ZGbH6i_Vigh8_6FD0PJXXZFEi4Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm/rmap: support move to different root anon_vma
 in folio_move_anon_rmap()
To: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com, 
	lokeshgidra@google.com, hughd@google.com, mhocko@suse.com, 
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org, 
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com, 
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com, 
	jdduke@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 1:04=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 13.10.23 00:01, Peter Xu wrote:
> > On Sun, Oct 08, 2023 at 11:42:26PM -0700, Suren Baghdasaryan wrote:
> >> From: Andrea Arcangeli <aarcange@redhat.com>
> >>
> >> For now, folio_move_anon_rmap() was only used to move a folio to a
> >> different anon_vma after fork(), whereby the root anon_vma stayed
> >> unchanged. For that, it was sufficient to hold the folio lock when
> >> calling folio_move_anon_rmap().
> >>
> >> However, we want to make use of folio_move_anon_rmap() to move folios
> >> between VMAs that have a different root anon_vma. As folio_referenced(=
)
> >> performs an RMAP walk without holding the folio lock but only holding =
the
> >> anon_vma in read mode, holding the folio lock is insufficient.
> >>
> >> When moving to an anon_vma with a different root anon_vma, we'll have =
to
> >> hold both, the folio lock and the anon_vma lock in write mode.
> >> Consequently, whenever we succeeded in folio_lock_anon_vma_read() to
> >> read-lock the anon_vma, we have to re-check if the mapping was changed
> >> in the meantime. If that was the case, we have to retry.
> >>
> >> Note that folio_move_anon_rmap() must only be called if the anon page =
is
> >> exclusive to a process, and must not be called on KSM folios.
> >>
> >> This is a preparation for UFFDIO_MOVE, which will hold the folio lock,
> >> the anon_vma lock in write mode, and the mmap_lock in read mode.
> >>
> >> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> >> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >> ---
> >>   mm/rmap.c | 24 ++++++++++++++++++++++++
> >>   1 file changed, 24 insertions(+)
> >>
> >> diff --git a/mm/rmap.c b/mm/rmap.c
> >> index c1f11c9dbe61..f9ddc50269d2 100644
> >> --- a/mm/rmap.c
> >> +++ b/mm/rmap.c
> >> @@ -542,7 +542,9 @@ struct anon_vma *folio_lock_anon_vma_read(struct f=
olio *folio,
> >>      struct anon_vma *root_anon_vma;
> >>      unsigned long anon_mapping;
> >>
> >> +retry:
> >>      rcu_read_lock();
> >> +retry_under_rcu:
> >>      anon_mapping =3D (unsigned long)READ_ONCE(folio->mapping);
> >>      if ((anon_mapping & PAGE_MAPPING_FLAGS) !=3D PAGE_MAPPING_ANON)
> >>              goto out;
> >> @@ -552,6 +554,16 @@ struct anon_vma *folio_lock_anon_vma_read(struct =
folio *folio,
> >>      anon_vma =3D (struct anon_vma *) (anon_mapping - PAGE_MAPPING_ANO=
N);
> >>      root_anon_vma =3D READ_ONCE(anon_vma->root);
> >>      if (down_read_trylock(&root_anon_vma->rwsem)) {
> >> +            /*
> >> +             * folio_move_anon_rmap() might have changed the anon_vma=
 as we
> >> +             * might not hold the folio lock here.
> >> +             */
> >> +            if (unlikely((unsigned long)READ_ONCE(folio->mapping) !=
=3D
> >> +                         anon_mapping)) {
> >> +                    up_read(&root_anon_vma->rwsem);
> >> +                    goto retry_under_rcu;
> >
> > Is adding this specific label worthwhile?  How about rcu unlock and got=
o
> > retry (then it'll also be clear that we won't hold rcu read lock for
> > unpredictable time)?
>
> +1, sounds good to me

Sorry for the delay, I was travelling for a week.

I was hesitant about RCU unlocking and then immediately re-locking but
your point about holding it for unpredictable time makes sense. Will
change. Thanks!

>
> --
> Cheers,
>
> David / dhildenb
>

