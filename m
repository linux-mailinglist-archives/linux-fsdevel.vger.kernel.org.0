Return-Path: <linux-fsdevel+bounces-51990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2F6ADDF6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 01:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 657B87A9E79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 23:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5068A296160;
	Tue, 17 Jun 2025 23:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="oEhhXgwt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA98285053
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 23:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750201835; cv=none; b=lK5KqAwNricSiTezdGnxCUGjon6lW0cxM8DdOXFQjMpoflXOI6Sd2IYK57hYmSmdyPe8snq+Fm5Mb+j5tYh+KkD82Xz8aCTbEKBuwMMVhdHFy4scw97WgtysHOtnVeCBpbA6uAhy3XCvid4nBSCl7BewHt4jHwhYE3Jr+xmpDEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750201835; c=relaxed/simple;
	bh=UrEMMjEPSwEJVU83B62Oj6rl4+xnE99fDuvkpRRPFMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pt8LQ4SNdLiJmHrV47jNb22qIiI9D/C9b/j2TbLg/Az1OfOXNYlnqoQKvxEfM9EA4OM4PNUT6VavXk8l8P7tvbgZ2U+9RsG3I2YU7moloXUGKYQ2Q3691rEwNShjEfm+NgPg1cPl1ljX1d48EoDtlLJQvgOe5JTdP079dQ4xm3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=oEhhXgwt; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HMjJiq029940
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 19:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pps01;
 bh=PPIlybKNdm4yIUURr7WS1HfyttFDFu0B0++M/LaRTs0=;
 b=oEhhXgwtMdtGkxaZplg5vPgoi6ApdWz+EMAofe1hVO+8xKkhQV/3owORzGoV+iIduk5x
 YOdvAs5xdha8DaIjug++WKJaYcpFRYixOL6ah5V2vuM0skOUCz6ke3icihGaRP3pUcMB
 PfJqo+BUV+JszgmcXZKPWWgscl4bUKr0znbOxHsK4oQm6MvTUSOINmEjUVY4s6T2XqAp
 5Ok/ZhD2hgFlPf9j7+CQo5M1r8eV9lQ58cIiAbhMqm12y0zrKpG9uYpeOtXmYpEFlTc7
 JMmZ25CB5CBl2P1i9FTmIRXR3bcXXwMog+FGahzvriHF6jjNLWXdpNBcgUyv9+GfoZc1 Gg== 
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4792nvvcn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 19:10:31 -0400
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-70e4bd6510eso85048597b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 16:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750201831; x=1750806631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPIlybKNdm4yIUURr7WS1HfyttFDFu0B0++M/LaRTs0=;
        b=LDXtuDAAcHQzMNWbp9u0SOBdrkaztni5iRhGTre6AHTMSNiCiS0hrFybFFNrArKXKX
         iM+R0Jh3WDBVQik+MJKFXH+aixAGZ3++ToxJvk67eFljpeExt6TSZsYlnuLhj2qO3V7p
         w8RGpSXk/bHL6Yz1RQ6MvawCc3M83vwIefsQSNpY8SkdB3qITlUpJyG1nhRAcm+ROevJ
         IhDftS/mYe9X8oLfeAoVT5tprdx8xsveNlCmEnFCeK0spIoh7UcrWkT+8Bme6mFhOb/q
         i+A9uV7hqeWe2fTVIeb75HpIUfdRyDCfTtwGoxqqMnZNrIz5l/1awFtbKq2PH3G4n41I
         XrNw==
X-Forwarded-Encrypted: i=1; AJvYcCUr03jcBmBxnxLYG652M644nM30ZT8v9vC4zY6FXxR8K7Cu1tGgwrKpsI4U9RLpyEy0kaCLfmVHkqrDuK1E@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqz1/enKYWFdXQrw5PSbabHs9EB6A+77AZnBTtKbfI2T91Fwnq
	d/mkRXhQW3tjaZs5z0Z+VjLlOhq2sVdtYWs5cqXlTV1bTW03FYSjI73Uo8n+qktaAIoAkQLhWOR
	v8qt1iN870yrpdqC9XQwqEa0s27JEX3lefASPGrWVLpthbZF+XkGgK358SnvkUNYTdZhssg4Vgw
	uERK3TbYq3ym9vuraS7e0jc8QyAXq2+/ksr7j6Eg==
X-Gm-Gg: ASbGncsQj+Xhe1tFGzYcmKCxyjdj1a2G5whFiNsCdUPPCKeBIVUwlFgGaZwnGAuF8vf
	qwjymjdPok8DCXcoCkuNm7V/R2KZH8HhQucGxBKJVfFCtwXYNUZGixhFK3Qs/g71+bFTOBx6/Ng
	hl758J
X-Received: by 2002:a05:690c:39a:b0:70e:2ba2:659d with SMTP id 00721157ae682-71175508e9fmr212259607b3.23.1750201830715;
        Tue, 17 Jun 2025 16:10:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1MaV6Rrl4NS52+ptXzrJWizfrxcqVttjZ4z6G//Vqhsn2sOORf/ikGlXkhM2uf2ZCmVQQKfsMabSKiWjkcII=
X-Received: by 2002:a05:690c:39a:b0:70e:2ba2:659d with SMTP id
 00721157ae682-71175508e9fmr212259297b3.23.1750201830365; Tue, 17 Jun 2025
 16:10:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607-uffd-fixes-v2-0-339dafe9a2fe@columbia.edu>
 <20250607-uffd-fixes-v2-2-339dafe9a2fe@columbia.edu> <b1c61317-a17d-4ca0-88d4-d22e6b536de6@redhat.com>
In-Reply-To: <b1c61317-a17d-4ca0-88d4-d22e6b536de6@redhat.com>
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 17 Jun 2025 19:10:19 -0400
X-Gm-Features: Ac12FXzaafrz6_SjU1Auy6iU7reT4WBtzzTB9t9DBfTU53fTcxWKGcC7DGMVbzU
Message-ID: <CAKha_soyfjVpjrP9L0UxMwdH9HK5Gy+fin=XyxZt=34JaFUL=g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] userfaultfd: remove (VM_)BUG_ON()s
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE4OSBTYWx0ZWRfX0ZUqhaEUPCKe Iv057fguJ24u8RZ8hmkVClqk9G6kLjTrzWHm/rsxpyQU6MG3LGkKwK0/dpcY31RGh2q0fLti715 vcjGmt6ncD7yBpUeOcobEBvKHRAMLgYcY2sZe5IBxT0cQklfKo93qZW0qcVLdjd19ICzblgbRHk
 l4/AZDpetGon5e+HFIVfDlAMzMDBHjH7zY8qJkdSKDLZ4H0nNJ5oSBwQZdmP94cdqZcfSCrcSeV t83AbMpz4qZ0vLCFCjYec1MdC6AaUB93W7FapJgRxMb1AgGSbNgOA9hrzsD7JDsgUs2sgR4qXFx 25UzTiK/rdaF+E48E2wOm3gm0V6MuUM7LCQvPPj3nFLLu/ixvkcYExnBGcrzC7808388CSLbltO JKXYTTua
X-Proofpoint-ORIG-GUID: 8kpvT_3ZU7YxgeJgB5WtRPmx1P5XmiRU
X-Proofpoint-GUID: 8kpvT_3ZU7YxgeJgB5WtRPmx1P5XmiRU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_09,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 adultscore=0 bulkscore=10 priorityscore=1501 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=10
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506170189

On Tue, Jun 10, 2025 at 3:26=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 07.06.25 08:40, Tal Zussman wrote:
> >
> >   if (ctx->features & UFFD_FEATURE_SIGBUS)
> >   goto out;
> > @@ -411,12 +411,11 @@ vm_fault_t handle_userfault(struct vm_fault *vmf,=
 unsigned long reason)
> >   * to be sure not to return SIGBUS erroneously on
> >   * nowait invocations.
> >   */
> > - BUG_ON(vmf->flags & FAULT_FLAG_RETRY_NOWAIT);
> > + VM_WARN_ON_ONCE(vmf->flags & FAULT_FLAG_RETRY_NOWAIT);
> >   #ifdef CONFIG_DEBUG_VM
> >   if (printk_ratelimit()) {
> > - printk(KERN_WARNING
> > -       "FAULT_FLAG_ALLOW_RETRY missing %x\n",
> > -       vmf->flags);
> > + pr_warn("FAULT_FLAG_ALLOW_RETRY missing %x\n",
> > + vmf->flags);
>
> You didn't cover that in the patch description.
>
> I do wonder if we really still want the dump_stack() here and could
> simplify to
>
> pr_warn_ratelimited().
>
> But I recall that the stack was helpful at least once for me (well, I
> was able to reproduce and could have figured it out differently.).

I'll include this in the description as well. Given that you found the stac=
k
helpful before, I'll leave it as-is for now.

> [...]
>
> >   err =3D uffd_move_lock(mm, dst_start, src_start, &dst_vma, &src_vma);
> >   if (err)
> > @@ -1867,9 +1865,9 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, u=
nsigned long dst_start,
> >   up_read(&ctx->map_changing_lock);
> >   uffd_move_unlock(dst_vma, src_vma);
> >   out:
> > - VM_WARN_ON(moved < 0);
> > - VM_WARN_ON(err > 0);
> > - VM_WARN_ON(!moved && !err);
> > + VM_WARN_ON_ONCE(moved < 0);
> > + VM_WARN_ON_ONCE(err > 0);
> > + VM_WARN_ON_ONCE(!moved && !err);
> >   return moved ? moved : err;
>
>
> Here you convert VM_WARN_ON to VM_WARN_ON_ONCE without stating it in the
> description (including the why).

Will update in the description. These checks represent impossible condition=
s
and are analogous to the BUG_ON()s in move_pages(), but were added later.
So instead of BUG_ON(), they use VM_WARN_ON() as a replacement when
VM_WARN_ON_ONCE() is likely a better fit, as per other conversions.

> > @@ -1956,9 +1954,9 @@ int userfaultfd_register_range(struct userfaultfd=
_ctx *ctx,
> >   for_each_vma_range(vmi, vma, end) {
> >   cond_resched();
> >
> > - BUG_ON(!vma_can_userfault(vma, vm_flags, wp_async));
> > - BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
> > -       vma->vm_userfaultfd_ctx.ctx !=3D ctx);
> > + VM_WARN_ON_ONCE(!vma_can_userfault(vma, vm_flags, wp_async));
> > + VM_WARN_ON_ONCE(vma->vm_userfaultfd_ctx.ctx &&
> > + vma->vm_userfaultfd_ctx.ctx !=3D ctx);
> >   WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
>
> Which raises the question, why this here should still be a WARN

After checking it, it looks like the relevant condition is enforced in the
registration path, so this can be converted to a debug check. I'll update
the patch accordingly.

However, I think the checks in userfaultfd_register() may be redundant.
First, it checks !(cur->vm_flags & VM_MAYWRITE). Then, after a hugetlb
check, it checks
((vm_flags & VM_UFFD_WP) && !(cur->vm_flags & VM_MAYWRITE)), which should
never be hit.

Am I missing something?

Additionally, the comment above the first !(cur->vm_flags & VM_MAYWRITE)
check is a bit confusing. It seems to be based on the fact that file-backed
MAP_SHARED mappings without write permissions will not have VM_MAYWRITE set=
,
while MAP_PRIVATE mappings will always(?) have it set, but doesn't say it a=
s
explicitly. Am I understanding this check correctly?

Thanks for the review!

> --
> Cheers,
>
> David / dhildenb
>

