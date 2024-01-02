Return-Path: <linux-fsdevel+bounces-7147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CE2822591
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 00:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82FAB28440A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 23:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E39D1775A;
	Tue,  2 Jan 2024 23:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TbOeiDBt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFCE17753
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jan 2024 23:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbd029beef4so8126205276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jan 2024 15:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704238499; x=1704843299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEeHN1tMa7cbdkZt1wLkdCjR844Pa9tAzIQcAD+DKkg=;
        b=TbOeiDBtMM3VQzjCTx+vQzqEIsYMMdfafBnQb4OL9mNorkV5EVEzF/E6NRsVum344u
         FH/bSMVREJ8A5uDjwuyQ/bdSS9fP/umdMFtbn8uWhQfIshTaW2YnOlpM3pciFbN/CPv9
         iFkwuyFKJbQoTfnTez2h7ICI1niZtRTCBExGwMLtqxOSEAkW2P0Ce9kEcLmjAnCrXxCj
         yc2w31Tg7r/gYkQBS8bIzdev1VnKLZS7Mlcvp3I79+7CSdCLwFTwlmXGXDM6hDrDBGlu
         rcGZVs2jQ6Lsa5urffJeSOnr1kFc2iMX9k0pUEwipPkTragdetDOcF8QIc4SnGOiFF+K
         l+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704238499; x=1704843299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEeHN1tMa7cbdkZt1wLkdCjR844Pa9tAzIQcAD+DKkg=;
        b=l20kvL+9ypfpNyIrQH8xlseZSUyoDHUZ8DvqyiDlE8d/2EOflXPLoUMkrDS+dXwTxy
         wxwvP+U26IZQmdGZBDiMJDRl8RXlkHRzDP+VYmnKSyawx+Vn4nKeY5Hr3QuKtIPvoEPm
         cDNuj1rY4bOVH0xfdQ/fNC3oe44DWW3Kxsb3/MTRwnV7wHltdBT2PdWQEDXFeXkRtDVX
         153jv4IyB6PsfxNh8a12Id932ZeeJrXUUzG7YEyxltvP7eAKSj6GI80BgSs5GPaXtD6Z
         YyIiE0vsshNStoxrsetYv87RGAIpkyDsSVKmFcyrDMpDMUeOSHaLWF/9WuLk++CJ66R3
         o/mw==
X-Gm-Message-State: AOJu0YxfjzeFYiocODOACOeyAM6+mKenbTWPivdLROk7k1WcltfBTbLM
	o3Fdwgv4LRAzHx2JeHtXc+NSKHw4HYKRpbUboQHdcnW+Z4IL
X-Google-Smtp-Source: AGHT+IGU6yh4YTmF3G9jvMQhRAMuGZOpnj42Na+/PAXUmwKui2qn2ADQ4/SQ2umSN0+5z8f+hfJb4rX5XjLhNFsGcAA=
X-Received: by 2002:a5b:7c3:0:b0:db5:4ec5:6f2f with SMTP id
 t3-20020a5b07c3000000b00db54ec56f2fmr129240ybq.20.1704238499402; Tue, 02 Jan
 2024 15:34:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231230025607.2476912-1-surenb@google.com> <ZZPQjO91fvB66z1s@x1n>
 <CAJuCfpF8h4aPAvFQv4NjX=DRWTZ1P5DcO16DfT-Sot1cGucjJQ@mail.gmail.com> <CAJuCfpG4tSPADrSpUCubsymoT_FWO4mONFODb2_sK4f-5RTY-A@mail.gmail.com>
In-Reply-To: <CAJuCfpG4tSPADrSpUCubsymoT_FWO4mONFODb2_sK4f-5RTY-A@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 2 Jan 2024 15:34:46 -0800
Message-ID: <CAJuCfpExJHNmNPhy1X1CioDT2OrnaQqf=awoj5Vkhr1msBsCDQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] userfaultfd: fix move_pages_pte() splitting folio
 under RCU read lock
To: Peter Xu <peterx@redhat.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	shuah@kernel.org, aarcange@redhat.com, lokeshgidra@google.com, 
	david@redhat.com, ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com, 
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org, 
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com, 
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com, 
	jdduke@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 3:16=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Tue, Jan 2, 2024 at 8:58=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
> >
> > On Tue, Jan 2, 2024 at 1:00=E2=80=AFAM Peter Xu <peterx@redhat.com> wro=
te:
> > >
> > > On Fri, Dec 29, 2023 at 06:56:07PM -0800, Suren Baghdasaryan wrote:
> > > > @@ -1078,9 +1078,14 @@ static int move_pages_pte(struct mm_struct *=
mm, pmd_t *dst_pmd, pmd_t *src_pmd,
> > > >
> > > >               /* at this point we have src_folio locked */
> > > >               if (folio_test_large(src_folio)) {
> > > > +                     /* split_folio() can block */
> > > > +                     pte_unmap(&orig_src_pte);
> > > > +                     pte_unmap(&orig_dst_pte);
> > > > +                     src_pte =3D dst_pte =3D NULL;
> > > >                       err =3D split_folio(src_folio);
> > > >                       if (err)
> > > >                               goto out;
> > > > +                     goto retry;
> > > >               }
> > >
> > > Do we also need to clear src_folio and src_folio_pte?  If the folio i=
s a
> > > thp, I think it means it's pte mapped here. Then after the split we m=
ay
> > > want to fetch the small folio after the split, not the head one?
> >
> > I think we need to re-fetch the src_folio only if the src_addr falls
> > into a non-head page. Looking at the __split_huge_page(), the head
> > page is skipped in the last loop, so I think it should stay valid.
> > That said, maybe it's just an implementation detail of the
> > __split_huge_page() and I should not rely on that and refetch anyway?
>
> I'll post a v2 with this fix and re-fetching the folio
> unconditionally. We also don't need to reset src_folio_pte value
> because it's used only if src_folio is not NULL.

Posted at https://lore.kernel.org/all/20240102233256.1077959-1-surenb@googl=
e.com/

> Thanks for catching this, Peter!
>
> >
> > >
> > > --
> > > Peter Xu
> > >

