Return-Path: <linux-fsdevel+bounces-7131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD547821FD0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 17:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7916F1F22E6F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 16:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48AA15488;
	Tue,  2 Jan 2024 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IjW4QxnT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024C114F95
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jan 2024 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5f254d1a6daso12513827b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jan 2024 08:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704214726; x=1704819526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kfSvqUQhDDQeZ7w9vi8u82O1MW4zk5hhfYcLpsRKrM=;
        b=IjW4QxnTXys2dTHJsWz38eoLZWSaTE6apxTe+eRi13iJVSEIpVTfydtj6hFTLJQWk9
         hKhWJ1i5+qzO2M6z78Mzpbcugv6JUEw/jgsggi/7zhARANmBS77lJj0qXZuquQCuziKk
         fa8uy3t65HJs8x7QkOWfra5YfWOW5A3YJi36R1JWFJNKLrNSfX9SNikxKyFwtmWIomHA
         BXbxTyx0Pe7+hAur9pIVN2EKygtbHh1G/zdgXvveQb5sxW8tp17fYMl/PtLN7kiKgn/u
         YsTl7QNjZwME/8YRVEVWJ2mt4pI1NHwWqOVzfshJoKE7GhTwQ7HpXZ8ggVVqY9bea06T
         LK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704214726; x=1704819526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kfSvqUQhDDQeZ7w9vi8u82O1MW4zk5hhfYcLpsRKrM=;
        b=N+3vin0b5GHAH8ASxFoNJclZ/D7cVvE+GtV5JyCqN2lzn4+OpwrYKMNk7d+6wYL+rM
         +EyuI2YR8p3xw9TPPEnmwfZjB/XyF8l+EO0lVmtE06Ig6nhjcyIJhqWSAzVEN1kLHea7
         qulvK6A9l2N6vjcGCqsImwL4KZvP2rx8iVubgWrWjO01/auVNrhDWnFyy+zvxDnd7V0S
         GDfhHg6knKQjD97DlqfXRYDl/BTyVS4yOF6LNQflQEeK4yPE5OZUUv/CyizEWBzX13sE
         LMlmjhC/2a2fb05igxfbAxoPDSI9W5QHSdZW/+NlMyfZ05ckaOqRLWsihg9AtqKNjPUd
         ggqg==
X-Gm-Message-State: AOJu0YyHCcNDorvKyboVrkdi79TrUPZD//wpW9qXv28LVpBPC8TJ3qJq
	cwy3liE3+8C+TIfeo7XElz+I3nCS/P851apR2y8PdrP5K4yc
X-Google-Smtp-Source: AGHT+IEiET7hC1eLxq7vY+dYnw1pivEcf25fOPa47AK6Yo5ywRpiE2S/bGFSeiyw7FCc/mlNNgWDk+kcawue6+1X1eM=
X-Received: by 2002:a0d:d2c6:0:b0:5e7:cd6d:b6da with SMTP id
 u189-20020a0dd2c6000000b005e7cd6db6damr11272113ywd.47.1704214725685; Tue, 02
 Jan 2024 08:58:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231230025607.2476912-1-surenb@google.com> <ZZPQjO91fvB66z1s@x1n>
In-Reply-To: <ZZPQjO91fvB66z1s@x1n>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 2 Jan 2024 08:58:33 -0800
Message-ID: <CAJuCfpF8h4aPAvFQv4NjX=DRWTZ1P5DcO16DfT-Sot1cGucjJQ@mail.gmail.com>
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

On Tue, Jan 2, 2024 at 1:00=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Dec 29, 2023 at 06:56:07PM -0800, Suren Baghdasaryan wrote:
> > @@ -1078,9 +1078,14 @@ static int move_pages_pte(struct mm_struct *mm, =
pmd_t *dst_pmd, pmd_t *src_pmd,
> >
> >               /* at this point we have src_folio locked */
> >               if (folio_test_large(src_folio)) {
> > +                     /* split_folio() can block */
> > +                     pte_unmap(&orig_src_pte);
> > +                     pte_unmap(&orig_dst_pte);
> > +                     src_pte =3D dst_pte =3D NULL;
> >                       err =3D split_folio(src_folio);
> >                       if (err)
> >                               goto out;
> > +                     goto retry;
> >               }
>
> Do we also need to clear src_folio and src_folio_pte?  If the folio is a
> thp, I think it means it's pte mapped here. Then after the split we may
> want to fetch the small folio after the split, not the head one?

I think we need to re-fetch the src_folio only if the src_addr falls
into a non-head page. Looking at the __split_huge_page(), the head
page is skipped in the last loop, so I think it should stay valid.
That said, maybe it's just an implementation detail of the
__split_huge_page() and I should not rely on that and refetch anyway?

>
> --
> Peter Xu
>

