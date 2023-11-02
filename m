Return-Path: <linux-fsdevel+bounces-1862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9937DF7E2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 17:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245F41C20FE5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 16:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A00A18C2A;
	Thu,  2 Nov 2023 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FEUSgRyq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0010011724
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 16:44:21 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A4012F
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 09:44:17 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-41cda69486eso6262881cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 09:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1698943456; x=1699548256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5huHRXTal5EExhtsUH3oeQOysPPywQTNSCA2FV70Z4=;
        b=FEUSgRyq3Ml7GXdMIhkaKrKwkAHfJTp8K5963ipBUdHA+8H4LrWQ1Spv0J0p76l9fI
         ncMunMxXpYyXS0J+WPvubhYHhNAiKUMGq5/903Ieyw7vTODfgDUVtlkeQbH/gaRyQDXB
         S67mKSevX+xT+Fph8nvlLbwAkC4mENRIoMm294gqsUf5y3iKEWXgqEFIbD2NoHUtGmeM
         frIlOlMlAhagN8utbrZgQRZD/Ia6tc4JGvaXThfg3dG4ivtzkLj+IibYrXxkjdnEIH9U
         oC6mUJpzPQCpszH7ZLg912xSxHepNGtJwEpIlaIDFYO4W65aoBXa3xyRSUNxTeFkWI1d
         INRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698943456; x=1699548256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5huHRXTal5EExhtsUH3oeQOysPPywQTNSCA2FV70Z4=;
        b=RoelCZVAKot8d02EniH6QvTGdriIV/aPE6A0mFOyFYpqIIWYg78tjsmqt05OfFDNET
         uCUovDmmXA3QT5J55p/XqlQ2dO5ga0szsajUXbZN2EKyH7+w/3bB463uH2AsdZbU24AK
         hl8OK+9E5kojLuKdSj1q28cMGZ7t0U4xFxn/AuCO5Fr3Ja1U0iTIWcegxbBWRHIVXrh0
         T9zXFtxKfGABFTW2toxb+ivc4MDRbbzAaCjXe9gt+Mf8VOm+Hs2PqyXdY5K2YRyzvIV9
         x+prh/Nphw5HP9X6zmRhALyCvSv/rzkRwoBTBVkLgVV2GzyqegEHq3UAtuJQr7wzEoNC
         xeRw==
X-Gm-Message-State: AOJu0Yxsi7sy0g4OUIy7WDbARrov0zZ3rEkomwT8FlonMiDQvrIF2Bo5
	bOAWcVtlWa8N8Dr/kLr8lGl7DJvX0kPNEo4zhQBqxA==
X-Google-Smtp-Source: AGHT+IF9lgp6HSclfxgGWa51q3PXdKEwLSx/iwMNQZdCz8lh2GUtaevw/shwA9kvCh/H16OZ4J9mUGLpb/Z5kyo4xi4=
X-Received: by 2002:ac8:5c4a:0:b0:41c:baed:2941 with SMTP id
 j10-20020ac85c4a000000b0041cbaed2941mr22010647qtj.15.1698943456529; Thu, 02
 Nov 2023 09:44:16 -0700 (PDT)
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
 <99113dee-6d4d-4494-9eda-62b1faafdbae@redhat.com>
In-Reply-To: <99113dee-6d4d-4494-9eda-62b1faafdbae@redhat.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 2 Nov 2023 12:43:39 -0400
Message-ID: <CA+CK2bApoY+trxxNW8FBnwyKnX6RVkrMZG4AcLEC2Nj6yZ6HEw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] mm: report per-page metadata information
To: David Hildenbrand <david@redhat.com>
Cc: Wei Xu <weixugc@google.com>, Sourav Panda <souravpanda@google.com>, corbet@lwn.net, 
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

On Thu, Nov 2, 2023 at 12:09=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 02.11.23 17:02, Pasha Tatashin wrote:
> > On Thu, Nov 2, 2023 at 11:53=E2=80=AFAM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 02.11.23 16:50, Pasha Tatashin wrote:
> >>>>> Adding reserved memory to MemTotal is a cleaner approach IMO as wel=
l.
> >>>>> But it changes the semantics of MemTotal, which may have compatibil=
ity
> >>>>> issues.
> >>>>
> >>>> I object.
> >>>
> >>> Could you please elaborate what you object (and why): you object that
> >>> it will have compatibility issues, or  you object to include memblock
> >>> reserves into MemTotal?
> >>
> >> Sorry, I object to changing the semantics of MemTotal. MemTotal is
> >> traditionally the memory managed by the buddy, not all memory in the
> >> system. I know people/scripts that are relying on that [although it's
> >> been source of confusion a couple of times].
> >
> > What if one day we change so that struct pages are allocated from
> > buddy allocator (i.e. allocate deferred struct pages from buddy) will
>
> It does on memory hotplug. But for things like crashkernel size
> detection doesn't really care about that.

"Crash kernel" is a different case: it is kernel external memory,
similar to limiting the amount of physical memory via mem=3D/memmap=3D, it
sets memory that cannot be used by this kernel, but only by the crash
kernel. Also, the crash kernel reserve is exposed in /proc/iomem via
"Crash kernel" range.

Page metadata memory on the other hand, is used by this kernel, and
also can be changed by this kernel depending on how the memory is
used: memdec, hotplug, THP, emulated pmem etc.

> > it break those MemTotal scripts? What if the size of struct pages
> > changes significantly, but the overhead will come from other metadata
> > (i.e. memdesc) will that break those scripts? I feel like struct page
>
> Probably; but ideally the metadata overhead will be smaller with
> memdesc. And we'll talk about that once it gets real ;)

The size and allocation of struct pages change MemTotal today, during
runtime, even without memdesc, I just brought it up, to emphasize that
this is something that we should resolve now before it gets worse.

> > memory should really be included into MemTotal, otherwise we will have
> > this struggle in the future when we try to optimize struct page
> > memory.
> How far do we want to go, do we want to include crashkernel reserved
> memory in MemTotal because it is system memory? Only metadata? what else
> allocated using memblock?
>
> Again, right now it's simple: MemTotal is memory managed by the buddy.
>
> The spirit of this patch set is good, modifying existing counters needs
> good justification.

Wei, noticed that all other fields in /proc/meminfo are part of
MemTotal, but this new field may be not (depending where struct pages
are allocated), so what would be the best way to export page metadata
without redefining MemTotal? Keep the new field in /proc/meminfo but
be ok that it is not part of MemTotal or do two counters? If we do two
counters, we will still need to keep one that is a buddy allocator in
/proc/meminfo and the other one somewhere outside?

Pasha

