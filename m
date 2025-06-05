Return-Path: <linux-fsdevel+bounces-50784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4025EACF920
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 23:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C1D189D500
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 21:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AEF27F73A;
	Thu,  5 Jun 2025 21:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Yey3F62d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4855A27F4E7
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749157613; cv=none; b=bHsUTwov+ik2mLWcbqc8zmLH2HFRMxRYDfSGilrey2EG1OhArfPqkOhisRaoQ8bQhqRcGrTaxoxPO6lyFPE/FS6KaB7ivojCRXK966DK3pghlOUyvCnus3pwPDCb6WcdUP55ehpDyDjk+48uiHjCFbDSuiW3f59ZTosXfcFgZmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749157613; c=relaxed/simple;
	bh=opgv1wEXerdl0y8fo81eC9+VV0HRKdrhqP6Hc3Nrjv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWDf/MPuqqk0xTPJ7tAv3N1XAFj+yV7dz5YEh58PQBFSqYtM1FIAWVu5ej1EYU36DvPaqZHH0u20LjLcKah0Oqvxtot7bdysD8fbxeGcBXp4wNeYOh+WmpyOT4sm/VTdPvT6C0TaEdGWjM9jBOFb/W3wV/vlWL/S92oBYqRnFFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Yey3F62d; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555L4mCV028048
	for <linux-fsdevel@vger.kernel.org>; Thu, 5 Jun 2025 17:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pps01;
 bh=+4t+B2pD6+kpWYFt+7p6MEr09BsrqvjyD3ljU+axPAs=;
 b=Yey3F62d/5thvpoAv6BWRhQU/VKUic/00d6QzVimrbhapPndDLIpzXHGS8nHmUtl0jXA
 YhNEAKuRQ8Y6IaQPHTykjONtEc+sV/yqaO3WtY8xMnzTBHuTarUIln5qzsZDEZDPzAVz
 I/hAJ6yAhWHvpgWGcx/70hpqxvpkyoSOPHr5hXmtTvlVgedIiaXJ+nU/p0RmCibi6+s2
 WFoAOgKW7I4DoOCaU328I+w9pDL2imFr0ekT5FgBlD4KHTHXsSUTMLFTYr7SjRvdYOdD
 dYpPEPv0goao46pP1kQhEohXeJl9plropxI8ZaiMsmYny6I3vmM06aSb1zuowzib7Sy8 Zw== 
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 46yv219vxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 17:06:50 -0400
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-70b5013cd97so20455937b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 14:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749157609; x=1749762409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4t+B2pD6+kpWYFt+7p6MEr09BsrqvjyD3ljU+axPAs=;
        b=IEw/JjE70iUHaUylyqTZYl85HL5mAWLgWW0e8oMlHB6VhD5mavXZEfPr9VA/ATHeXK
         qQu+l8EcmWT5PicEqkFo4MDTFXzi6CzCkH8/ToELaMOoHpba2E8MSyg8ZhHdwylJGVVQ
         iiTLLvJIFeGgGI7x5mYjcTygWGBLs80GzNupW01sr3FEpgGN5Rxw0UD1Bu9PhLPb7JDZ
         zwIBtCbVjPHZDChzlee3SwLRzMGc3cPIIST/Eo1nlLgTzW/pSKnOZhTMwTYfKDZFYOSJ
         BVqjp0t40A7w7/UKoHIo0OFg3JH5dcA66aCVwiKm9Rte7fkfk3Lr8VhaWOhYjiGd2OvW
         Jr5w==
X-Forwarded-Encrypted: i=1; AJvYcCU6kMhxl0arPbA2VcOIVuqq+QCokS7gHx8nHCNmj/+tlvuhhMp6Gf4dfNHiGTmJldGeiVmqVXZAcyYZpq7B@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/5iT1gLhE6kKHAq5mY0+sya1NFrBacGjhslQt3ZS1KKMeIP5l
	47BEtJfNkr9cA5sVBUxd3RiWb9uiT6XQgz/x6iSqyBJNo3c761lg3p8o/FWTiNnF7B+tCfsALol
	kSsy6lXFG6Pa9tX/tRezHoJ+CeQuFAXyl1qmKgfx+3E78iqmilsnx09Dk1tKORTJKa6n2ixeMOe
	OEr1SMmtImXOlOi87cScOROdLLHWVi3dQC4bClyg==
X-Gm-Gg: ASbGnctzo8E0HJg8cWXfrMHs9fIPvJ3njRIrfaUslONtnJUA/gisbLz/0HYbJ9MJadE
	ZR/ib3biEsp15t4a3h5VWALnDykY0tCBq0qfiJpQG/dF0Lfuhl/UsFNXFKS9111xw5aYiQw==
X-Received: by 2002:a05:690c:3685:b0:6f9:7a3c:1fe with SMTP id 00721157ae682-710f776cc31mr13836947b3.23.1749157608940;
        Thu, 05 Jun 2025 14:06:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFpswqCHFSqwALooH+sBikcUL5B8njFjFNXDocdSyUUxkugwfcle1F23KSlnDph3jsu+K0GvNMwj824P5EaQo=
X-Received: by 2002:a05:690c:3685:b0:6f9:7a3c:1fe with SMTP id
 00721157ae682-710f776cc31mr13836337b3.23.1749157608327; Thu, 05 Jun 2025
 14:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603-uffd-fixes-v1-0-9c638c73f047@columbia.edu>
 <20250603-uffd-fixes-v1-2-9c638c73f047@columbia.edu> <84cf5418-42e9-4ec5-bd87-17ba91995c47@redhat.com>
In-Reply-To: <84cf5418-42e9-4ec5-bd87-17ba91995c47@redhat.com>
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 5 Jun 2025 17:06:37 -0400
X-Gm-Features: AX0GCFstPrjtQYpw6EfTjM-xcC75nUUqJYkys8M1u1GJ2SLteZ0JyCXfVm1EAzM
Message-ID: <CAKha_sq7QQ5+GQ_4irNcfdNqPgHpNUqHUZe8D0g+-Y-_La4ohQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] userfaultfd: prevent unregistering VMAs through a
 different userfaultfd
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE5MSBTYWx0ZWRfX5UhRXXO1MSCQ ALQhSDUMese9r6DL7JTgG48YNCRnPKwUoKJwCnBf9xHJjn3+HtpxExoHoSgBjixkLYveoIIFvW6 PfRCHggEoDYfSSJmZwSZz2LwpHYLrEY5Q2PHLVtIPbLvQWgGurSPc3DR6bfbtbi27V2INufqHF5
 jcq4c4jOZrh85BBHabPvODGTqREefMEeKqDJbTYojJ4QSndefnRlelXYTApEeGLzJ16Tzdb6Xrh gm4kvdmyvEPesrcI3v92R9o3IVyg0HUm1NRGpTkpAbgkZ6mP0oBamthluSIqzlLVtUmfMMcJvb0 xB4Dx6/8nzjZT9Cc8/4v5ktxY58yv7Svj+tXZ8Nt9c6V1oq6DtPJrN2nPaFfqPfbSoKuKK0TGY3 wIxUHMKJ
X-Proofpoint-GUID: 8uSBBSmqTEp2qMR81bjiHyDjXC4Hohu5
X-Proofpoint-ORIG-GUID: 8uSBBSmqTEp2qMR81bjiHyDjXC4Hohu5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_06,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=834
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=10 spamscore=0
 bulkscore=10 suspectscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506050191

On Wed, Jun 4, 2025 at 9:23=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 04.06.25 00:14, Tal Zussman wrote:
> > Currently, a VMA registered with a uffd can be unregistered through a
> > different uffd asssociated with the same mm_struct.
> >
> > Change this behavior to be stricter by requiring VMAs to be unregistere=
d
> > through the same uffd they were registered with.
> >
> > While at it, correct the comment for the no userfaultfd case. This seem=
s
> > to be a copy-paste artifact from the analagous userfaultfd_register()
> > check.
>
> I consider it a BUG that should be fixed. Hoping Peter can share his
> opinion.
>
> >
> > Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory ex=
ternalization")
> > Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> > ---
> >   fs/userfaultfd.c | 15 +++++++++++++--
> >   1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 22f4bf956ba1..9289e30b24c4 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -1477,6 +1477,16 @@ static int userfaultfd_unregister(struct userfau=
ltfd_ctx *ctx,
> >   if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
> >   goto out_unlock;
> >
> > + /*
> > + * Check that this vma isn't already owned by a different
> > + * userfaultfd. This provides for more strict behavior by
> > + * preventing a VMA registered with a userfaultfd from being
> > + * unregistered through a different userfaultfd.
> > + */
> > + if (cur->vm_userfaultfd_ctx.ctx &&
> > +    cur->vm_userfaultfd_ctx.ctx !=3D ctx)
> > + goto out_unlock;
>
> So we allow !cur->vm_userfaultfd_ctx.ctx to allow unregistering when
> there was nothing registered.
>
> A bit weird to set "found =3D true" in that case. Maybe it's fine, just
> raising it ...
>
> > +
> >   found =3D true;
> >   } for_each_vma_range(vmi, cur, end);
> >   BUG_ON(!found);
> > @@ -1491,10 +1501,11 @@ static int userfaultfd_unregister(struct userfa=
ultfd_ctx *ctx,
> >   cond_resched();
> >
> >   BUG_ON(!vma_can_userfault(vma, vma->vm_flags, wp_async));
> > + BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
> > +       vma->vm_userfaultfd_ctx.ctx !=3D ctx);
> >
>
> No new BUG_ON please. VM_WARN_ON_ONCE() if we really care. After all, we
> checked this above ...

Yeah, I mainly added this to maintain symmetry with userfaultfd_register().
I don't think it's really necessary to add this, so I'll remove it for v2.

I'm happy to send another patch (preceding this one) converting all of the
pre-existing userfaultfd BUG_ON()s to VM_WARN_ON_ONCE(). Although I do see
that all uses of VM_WARN_ON_ONCE() are in arch/ or mm/ code, while this fil=
e
is under fs/. Is that fine? Alternatively, I can remove them, but I defer t=
o
you.

> >   /*
> > - * Nothing to do: this vma is already registered into this
> > - * userfaultfd and with the right tracking mode too.
> > + * Nothing to do: this vma is not registered with userfaultfd.
> >   */
> >   if (!vma->vm_userfaultfd_ctx.ctx)
> >   goto skip;
> >
>
>
> --
> Cheers,
>
> David / dhildenb
>

