Return-Path: <linux-fsdevel+bounces-7145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB3A82256C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 00:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF1E1F233C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 23:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CED17747;
	Tue,  2 Jan 2024 23:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n7U12ke9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A5017728
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jan 2024 23:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5e784ce9bb8so74554367b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jan 2024 15:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704237394; x=1704842194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9VsReBQkICOIEczr/aBz2S0AWm3omPhTa+sgYDFysE=;
        b=n7U12ke9HUlf9h9JIl4Hr4vTl35sGXHRFMUgb0qxklXMMaAXtpchclYkN9V5/aUTEl
         Tr+qgAczELBPYnbHzYrM0+3gFdEDFDtoO4vEaRIUxgUQ1qF2AcB5wFnuhKA0ns+ZuYJY
         V6ZvLt2PtpBTCrbg+9RgWIms6P5JcQDd22XEI7HCgmpV+hjmECCUX2U+6ilocGPbSpzv
         jZc10ZpGudzYXnBg3WhZ2ITPdYtunH+Jt8XWEV4k444EEbqZ8gBgZxFEgLJLFEht3sA/
         DyfYjkWmuVp9mjOQ/184BWYsOQdG/a9KSLWXv/ZUXjGxdK7X7brrHc060NlcRki7zmK8
         vCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704237394; x=1704842194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9VsReBQkICOIEczr/aBz2S0AWm3omPhTa+sgYDFysE=;
        b=w1Be0QRYGQvHjqusrnr+VaHUDvPl2TjJpqyafrO7nvkJsKe91imFuC/4l7mGn1TtSY
         YREphT2YTLZufQi6cUQYp6PYOuE5XMIiufr+GoduI2DDMRYD7k3gUm+IfD/wl4aUJTB+
         3+r1RKOjNGNUDu4gZt3K4DyTEu6GPjB/FmdX/uGqDEK4emz7gfuput9zv4fFMoHm7VV9
         Gtlu7uMzJ5YbHC4jKe8cpNhT9hOJ0UQnYfZqqGmkJ8j4wEgvXfBJs4MpnIYmtSNlBH0C
         k8BvdRDHfkxjww/7rYe85gRycXCDUUxsVwxfumCB+vX/DqAGT50tsWZk+xREDCfTFhvj
         chcQ==
X-Gm-Message-State: AOJu0YyEkXnuURhXRYVvHJN58GkPzKCDWgwSC8dPPDj6wgrJuhCFRnmd
	l0S4aBWpa7LMVHNfJypleQ+/gtQC57GruirGQSG48MLNMqlZ
X-Google-Smtp-Source: AGHT+IE8Ax7U2bqyqO1lsnqmhbIiZe0ibMeQxiHn/HbCQlPrEjVBV5+vDgfgYKVCj0YEiEECTa6N9nL3Qu/E0E5RKYw=
X-Received: by 2002:a81:574d:0:b0:5d3:dacc:63bd with SMTP id
 l74-20020a81574d000000b005d3dacc63bdmr108135ywb.19.1704237393551; Tue, 02 Jan
 2024 15:16:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231230025607.2476912-1-surenb@google.com> <ZZPQjO91fvB66z1s@x1n>
 <CAJuCfpF8h4aPAvFQv4NjX=DRWTZ1P5DcO16DfT-Sot1cGucjJQ@mail.gmail.com>
In-Reply-To: <CAJuCfpF8h4aPAvFQv4NjX=DRWTZ1P5DcO16DfT-Sot1cGucjJQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 2 Jan 2024 15:16:20 -0800
Message-ID: <CAJuCfpG4tSPADrSpUCubsymoT_FWO4mONFODb2_sK4f-5RTY-A@mail.gmail.com>
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

On Tue, Jan 2, 2024 at 8:58=E2=80=AFAM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Tue, Jan 2, 2024 at 1:00=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
> >
> > On Fri, Dec 29, 2023 at 06:56:07PM -0800, Suren Baghdasaryan wrote:
> > > @@ -1078,9 +1078,14 @@ static int move_pages_pte(struct mm_struct *mm=
, pmd_t *dst_pmd, pmd_t *src_pmd,
> > >
> > >               /* at this point we have src_folio locked */
> > >               if (folio_test_large(src_folio)) {
> > > +                     /* split_folio() can block */
> > > +                     pte_unmap(&orig_src_pte);
> > > +                     pte_unmap(&orig_dst_pte);
> > > +                     src_pte =3D dst_pte =3D NULL;
> > >                       err =3D split_folio(src_folio);
> > >                       if (err)
> > >                               goto out;
> > > +                     goto retry;
> > >               }
> >
> > Do we also need to clear src_folio and src_folio_pte?  If the folio is =
a
> > thp, I think it means it's pte mapped here. Then after the split we may
> > want to fetch the small folio after the split, not the head one?
>
> I think we need to re-fetch the src_folio only if the src_addr falls
> into a non-head page. Looking at the __split_huge_page(), the head
> page is skipped in the last loop, so I think it should stay valid.
> That said, maybe it's just an implementation detail of the
> __split_huge_page() and I should not rely on that and refetch anyway?

I'll post a v2 with this fix and re-fetching the folio
unconditionally. We also don't need to reset src_folio_pte value
because it's used only if src_folio is not NULL.
Thanks for catching this, Peter!

>
> >
> > --
> > Peter Xu
> >

