Return-Path: <linux-fsdevel+bounces-1586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901007DC1D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 22:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0B14B20E40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 21:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B5A1C2B3;
	Mon, 30 Oct 2023 21:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wx0iAWYl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC331B29C
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 21:22:31 +0000 (UTC)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DED7F9
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 14:22:30 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d9c687f83a2so4481592276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 14:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698700949; x=1699305749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwJPbkzTcW2a0Aake5KdIVl2hETAF8IjmbwWVJSuVUw=;
        b=Wx0iAWYlcDRAmwXfeDu1TIGeyf2a03/2CWVPGcQioNB/aaFiWvz90T94M4WYfoSqrU
         9QZTpRC1AIUhUVYs5J+/SWqyFtsNFOKoiJTst5mrlSU8qxE1g2rqaj00RVNjxl+JsvA9
         n4UggqZSccmnxcq4kY37ADju4VGy8Riww0zPhxRBiQMopa2XY7VuSQc3N09+ta/C5SRY
         5HYLouNCHser50Vzw8S8awr8qREytcoKY9jpytWQUoCKGvyckPtCt3NxNxZGMdCMtDr7
         56Szab0mLt3wDKsI9cjAWD5s8j29ZtyuAXwR9/tdnWWgaNNyr1nm2sJvnQ+3K5FAZWye
         Pc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698700949; x=1699305749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwJPbkzTcW2a0Aake5KdIVl2hETAF8IjmbwWVJSuVUw=;
        b=l2KSyu9VIRF8/LYsTuT5CxshMvI0MGU41XHn+09maqM7usPfhV3p7pqbOjwEKXiMw8
         +mBg7o7M08A1xtULNpFZALnGjA9Quf+qPuB9UCs2hwKbcv+3DiEGU64jphFa2WSr/r8l
         UKUJ6Cnqcp7W0UOKtEEgr6DSI5+3iKIKINmGqW5McktMsFgVvqaAWVhNRyQqHgMYfq01
         EwdUPVtFiKKp/4Yy1NxhM6PnZLErB8H+jMq9prDR2cI/21UNJEUnco1sVpdrJD4Z/cNp
         EFP2tfVCI/BWGEkHgKpHloA6ouvP+XS9V4vsDzrzo/LvySroO8OCjsYHoZ/Edf5j0Kqv
         VWkg==
X-Gm-Message-State: AOJu0YzFT40cMNN0xdLv047XVQ2a+kdjAwWUX0soWTlehWHftg2TWzXi
	9Czes3uV7WXLLth/pT8Y6k4B/opSsB0K2ao0chco8w==
X-Google-Smtp-Source: AGHT+IHUKCGn+zcI97gOSVY+FNlKbbSCWP6tGfywZjOb4ubvvKE7w61Yhe1EdRLZDEeh63lNRWL2VU/yYTIkofZbYco=
X-Received: by 2002:a25:30d:0:b0:d15:7402:f7cd with SMTP id
 13-20020a25030d000000b00d157402f7cdmr11851887ybd.27.1698700949306; Mon, 30
 Oct 2023 14:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231028003819.652322-1-surenb@google.com> <20231028003819.652322-6-surenb@google.com>
 <ZUAOpmVO3LMmge3S@x1n> <CAJuCfpEbrWVxfuqRxCrxB482-b=uUnZw2-gqmjxENBUqhCQb8A@mail.gmail.com>
 <ZUATjxr2i7zVfL8I@x1n>
In-Reply-To: <ZUATjxr2i7zVfL8I@x1n>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 30 Oct 2023 14:22:15 -0700
Message-ID: <CAJuCfpHzEn0=6-4sngq8qQ6h5mSM+Gj-4OqOGF=cvefouk1cbw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
To: Peter Xu <peterx@redhat.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	shuah@kernel.org, aarcange@redhat.com, lokeshgidra@google.com, 
	david@redhat.com, hughd@google.com, mhocko@suse.com, axelrasmussen@google.com, 
	rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com, 
	jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com, 
	kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 1:35=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Oct 30, 2023 at 01:22:02PM -0700, Suren Baghdasaryan wrote:
> > > > +static int adjust_page_size(void)
> > > > +{
> > > > +     page_size =3D default_huge_page_size();
> > >
> > > This is hacky too, currently page_size is the real page_size backing =
the
> > > memory.
> > >
> > > To make thp test simple, maybe just add one more test to MOVE a large=
 chunk
> > > to replace the thp test, which may contain a few thps?  It also doesn=
't
> > > need to be fault based.
> >
> > Sorry, I didn't get your suggestion. Could you please clarify? Which
> > thp test are you referring to?
>
> The new "move-pmd" test.
>
> I meant maybe it makes sense to have one separate MOVE test for when one
> ioctl(MOVE) covers a large range which can cover some thps.  Then that wi=
ll
> trigger thp paths.  Assuming the fault paths are already covered in the
> generic "move" test.

Oh, you mean I should not share uffd_move_test() between move and
move-pmd test and have separate logic instead that does not rely on
the page_size overrides? If so then I think that's doable. Some more
code but probably cleaner.

>
> Thanks,
>
> --
> Peter Xu
>

