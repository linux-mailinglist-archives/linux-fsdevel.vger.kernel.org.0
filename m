Return-Path: <linux-fsdevel+bounces-1870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 324587DF992
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 19:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEF841F2275B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 18:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D9221112;
	Thu,  2 Nov 2023 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AAml46qk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B723208A4
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 18:08:34 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CB6212A
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 11:06:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32d895584f1so677329f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 11:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698948383; x=1699553183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Yc0Vs7ENia0QB6Jekhs2eJe0iOFbFKiK50kmBF20/E=;
        b=AAml46qkULvvDA7AGY8yiDdcClIi7GzF5jB0cikC9f/beVFq4YF1AZyJwFTc3GE2i6
         RAO6GxuZivWM9WL5gooShP5XQh14OHtoC02jhbgWZI4yeOcDvSd9buJRBdpgTUwit8ND
         PGy0t1+UZt8BrFXetbMQbE9dIwB4fUKoY+/RN/3XX1HhzmtIKIMI8rUJ5ovRSzCfaH4U
         Rm5NVeUvFBkp3D3BhasVZVYiNfydH+e83qJ4i9KT1ShIpqMhCSuUaI77SVaUZ7VU1VNE
         4pUSrhX31/C23HIOI2RGTzAdWDEnTrSRvSv2XY6mTs4uNoaSpso6aZcUnMRboMkweQ97
         4E+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698948383; x=1699553183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Yc0Vs7ENia0QB6Jekhs2eJe0iOFbFKiK50kmBF20/E=;
        b=vQIVpo0WqJK59UGjJw6bxcR8oB50eHS7RlPhx43ccSMA5QMNmwR47P1ZnoK5wUHHkJ
         6tpFPlbCS/O1vlET42EgQDhg7Bw96J6pUNpULTwTAcKJ7N31phSDbVZ697/Npw53a8eI
         PavABFYcXV6BXod2D5eRK6Dp25zb03oNi/AZBIltBOprhEjqClXrH4k2PiGSoJC8vgox
         DW/sX2US9aL9RhC9I0SGQSylV1Cok2l3550r3AOCC1JRaZqJNaaxu/qXZeb/9FZwqAGl
         SVATx+zrb+Sjvy6R6qVd8bJfgv2B+3s6IffRLiq5m8Nf5CHdP56Ih+I0iIXySs1eDtEQ
         woOw==
X-Gm-Message-State: AOJu0Yye13KufUoWHQu0nTXjwsLd7+sBzAJrEGscl8FEJWN7NsDdGWph
	0WB3ncTChrCilI1jVjSGrK4WMrOV0WBuI0QgRcNJ3Q==
X-Google-Smtp-Source: AGHT+IHxgMVDIc1myhEwVwiOiXyS7PCrW3Q4+lNTE2vtJGBS0emSiUxvpgM+3Thyp+4mZnvr/GaOhiSSJdvkhfObMOw=
X-Received: by 2002:a5d:68c1:0:b0:32d:a022:8559 with SMTP id
 p1-20020a5d68c1000000b0032da0228559mr15540985wrw.47.1698948382660; Thu, 02
 Nov 2023 11:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231101230816.1459373-1-souravpanda@google.com>
 <20231101230816.1459373-2-souravpanda@google.com> <CAAPL-u_enAt7f9XUpwYNKkCOxz2uPbMrnE2RsoDFRcKwZdnRFQ@mail.gmail.com>
 <CA+CK2bC3rSGOoT9p_VmWMT8PBWYbp7Jo7Tp2FffGrJp-hX9xCg@mail.gmail.com>
 <CAAPL-u-4D5YKuVOsyfpDUR+PbaA3MOJmNtznS77bposQSNPjnA@mail.gmail.com>
 <1e99ff39-b1cf-48b8-8b6d-ba5391e00db5@redhat.com> <CA+CK2bDo6an35R8Nu-d99pbNQMEAw_t0yUm0Q+mJNwOJ1EdqQg@mail.gmail.com>
 <025ef794-91a9-4f0c-9eb6-b0a4856fa10a@redhat.com> <CA+CK2bDJDGaAK8ZmHtpr79JjJyNV5bM6TSyg84NLu2z+bCaEWg@mail.gmail.com>
 <99113dee-6d4d-4494-9eda-62b1faafdbae@redhat.com> <CA+CK2bApoY+trxxNW8FBnwyKnX6RVkrMZG4AcLEC2Nj6yZ6HEw@mail.gmail.com>
 <b71b28b9-1d41-4085-99f8-04d85892967e@redhat.com> <CA+CK2bCNRJXm2kEjsN=5a_M8twai4TJX3vpd72uOHFLGaDLg4g@mail.gmail.com>
In-Reply-To: <CA+CK2bCNRJXm2kEjsN=5a_M8twai4TJX3vpd72uOHFLGaDLg4g@mail.gmail.com>
From: Wei Xu <weixugc@google.com>
Date: Thu, 2 Nov 2023 11:06:10 -0700
Message-ID: <CAAPL-u_OWFLrrNxszm4D+mNiZY6cSb3=jez3XJHFtN6q05dU2g@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] mm: report per-page metadata information
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: David Hildenbrand <david@redhat.com>, Sourav Panda <souravpanda@google.com>, corbet@lwn.net, 
	gregkh@linuxfoundation.org, rafael@kernel.org, akpm@linux-foundation.org, 
	mike.kravetz@oracle.com, muchun.song@linux.dev, rppt@kernel.org, 
	rdunlap@infradead.org, chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, 
	tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com, 
	yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com, 
	kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com, 
	adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 10:12=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> > > Wei, noticed that all other fields in /proc/meminfo are part of
> > > MemTotal, but this new field may be not (depending where struct pages
> >
> > I could have sworn that I pointed that out in a previous version and
> > requested to document that special case in the patch description. :)
>
> Sounds, good we will document that parts of per-page may not be part
> of MemTotal.

But this still doesn't answer how we can use the new PageMetadata
field to help break down the runtime kernel overhead within MemUsed
(MemTotal - MemFree).

> > > are allocated), so what would be the best way to export page metadata
> > > without redefining MemTotal? Keep the new field in /proc/meminfo but
> > > be ok that it is not part of MemTotal or do two counters? If we do tw=
o
> > > counters, we will still need to keep one that is a buddy allocator in
> > > /proc/meminfo and the other one somewhere outside?
> >

I think the simplest thing to do now is to only report the buddy
allocations of per-page metadata in meminfo.  The meaning of the new
counter is easier to understand and consistent with MemTotal and other
fields in meminfo. Its implementation can also be greatly simplified
and we don't need to handle the other special cases, either, e.g.
pagemeta allocated from DAX devices.

> > IMHO, we should just leave MemTotal alone ("memory managed by the buddy
> > that could actually mostly get freed up and reused -- although that's
> > not completely true") and have a new counter that includes any system
> > memory (MemSystem? but as we learned, as separate files), including mos=
t
> > memblock allocations/reservations as well (metadata, early pagetables,
> > initrd, kernel, ...).
> >
> > The you would actually know how much memory the system is using
> > (exclusing things like crashmem, mem=3D, ...).
> >
> > That part is tricky, though -- I recall there are memblock reservations
> > that are similar to the crashkernel -- which is why the current state i=
s
> > to account memory when it's handed to the buddy under MemTotal -- which
> > is straight forward and simply.
>
> It may be simplified if we define MemSystem as all the usable memory
> provided by firmware to Linux kernel.
> For BIOS it would be the "usable" ranges in the original e820 memory
> list before it's been modified by the kernel based on the parameters.
>
> For device-tree architectures, it would be the memory binding provided
> by the original device tree from the firmware.
>
> Pasha

