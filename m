Return-Path: <linux-fsdevel+bounces-3285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 234CD7F24ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 05:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47E24B21AC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 04:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D178BEF;
	Tue, 21 Nov 2023 04:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Su4WUHIM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C234F4
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 20:49:44 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cf5ceadfd8so130945ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 20:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700542184; x=1701146984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ci0fDn2VKn2ROb4P5+ApgEIrDRCxD8DQOtt7YsYQPr8=;
        b=Su4WUHIMCW5vgmjCrvzfT1brcn69WD4tmllN/No3RpWiu/dY+VIm69olbgkXfqmL8/
         gOJpYAs43dvdKXRxpkrVCt+OmvyRdF4Tui4hhE3VHIHKe/rb7SbhPYtfgMN/I1YSHbJH
         PG+L+lS2ynwiZ6Vu3ABEUDoF0vNHqWTuM5ALk4AhSCFqvoo2qMipExgbJKOecAyq6hb6
         5GBmYqhpr6MjNVsy2cRWILQQxFlUcfPtw6yTX2u5KPcas+jcwU8OKDaqc/cXDPaKHWD6
         URg/b4ZfloAQTGexxpDjAiOCsQWpDeirCYzurENszf+fHTaGDiBj1KfK/2CwDsAbggBP
         P/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700542184; x=1701146984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ci0fDn2VKn2ROb4P5+ApgEIrDRCxD8DQOtt7YsYQPr8=;
        b=F1DVpZvM6zTegKEvpwcS+kkmdeNsSMIRTOyyadSwzp1Wpt8AFzthF/qz1QFF0dNfww
         HgiReR3ZUdIv1A9ok+4kakx/T82N77vlZTRcZJaLL6KEo/fcwjDKh03OJVyIOkRyAeYE
         I8SX9MioXmdPjKbpPGgndyDTXyK+PmO34UrGAk7auPO9zgYvIHLt61sIGL0NrWX0d8Lo
         OSS0W2veg/gBxiQSPVbon4f8JKXYLtptmMTas/D4vxES5bne4Rk1hkA2pWljt8N0cKzA
         gTt+iqVny4AaOuLZTt5SumdQN2rDYdwbyRtXjHUiKEYALqNO9LKDBoRWYHLk4dFmzM7o
         d0IQ==
X-Gm-Message-State: AOJu0Yyk6HmpMo6vUrt2sSa54AyuWcPpn7e4J3HWc6GBvmGSZTQsSkTl
	qeJuhIe/HbdyKbKWfY78IpY0VMnWa/aZPj6tJiMILQ==
X-Google-Smtp-Source: AGHT+IEjrSf5kIzKqR8y96cakBbXvSTNzic/DeMBLkOBk4msBIIG12CS40E/lkAesfcKoKMOnN0ye5jmEfxbmJlxJ94=
X-Received: by 2002:a17:902:c454:b0:1cf:6d46:9f2b with SMTP id
 m20-20020a170902c45400b001cf6d469f2bmr136702plm.23.1700542183669; Mon, 20 Nov
 2023 20:49:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230823131350.114942-1-alexandru.elisei@arm.com> <20230823131350.114942-21-alexandru.elisei@arm.com>
In-Reply-To: <20230823131350.114942-21-alexandru.elisei@arm.com>
From: Peter Collingbourne <pcc@google.com>
Date: Mon, 20 Nov 2023 20:49:32 -0800
Message-ID: <CAMn1gO67Lz_Xw5SCrq3fF4rOCSw3sXYK8qC77TTGnJeWd0b0Sg@mail.gmail.com>
Subject: Re: [PATCH RFC 20/37] mm: compaction: Reserve metadata storage in compaction_alloc()
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev, 
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	mhiramat@kernel.org, rppt@kernel.org, hughd@google.com, steven.price@arm.com, 
	anshuman.khandual@arm.com, vincenzo.frascino@arm.com, david@redhat.com, 
	eugenis@google.com, kcc@google.com, hyesoo.yu@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexandru,

On Wed, Aug 23, 2023 at 6:16=E2=80=AFAM Alexandru Elisei
<alexandru.elisei@arm.com> wrote:
>
> If the source page being migrated has metadata associated with it, make
> sure to reserve the metadata storage when choosing a suitable destination
> page from the free list.
>
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  mm/compaction.c | 9 +++++++++
>  mm/internal.h   | 1 +
>  2 files changed, 10 insertions(+)
>
> diff --git a/mm/compaction.c b/mm/compaction.c
> index cc0139fa0cb0..af2ee3085623 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -570,6 +570,7 @@ static unsigned long isolate_freepages_block(struct c=
ompact_control *cc,
>         bool locked =3D false;
>         unsigned long blockpfn =3D *start_pfn;
>         unsigned int order;
> +       int ret;
>
>         /* Strict mode is for isolation, speed is secondary */
>         if (strict)
> @@ -626,6 +627,11 @@ static unsigned long isolate_freepages_block(struct =
compact_control *cc,
>
>                 /* Found a free page, will break it into order-0 pages */
>                 order =3D buddy_order(page);
> +               if (metadata_storage_enabled() && cc->reserve_metadata) {
> +                       ret =3D reserve_metadata_storage(page, order, cc-=
>gfp_mask);

At this point the zone lock is held and preemption is disabled, which
makes it invalid to call reserve_metadata_storage.

Peter

> +                       if (ret)
> +                               goto isolate_fail;
> +               }
>                 isolated =3D __isolate_free_page(page, order);
>                 if (!isolated)
>                         break;
> @@ -1757,6 +1763,9 @@ static struct folio *compaction_alloc(struct folio =
*src, unsigned long data)
>         struct compact_control *cc =3D (struct compact_control *)data;
>         struct folio *dst;
>
> +       if (metadata_storage_enabled())
> +               cc->reserve_metadata =3D folio_has_metadata(src);
> +
>         if (list_empty(&cc->freepages)) {
>                 isolate_freepages(cc);
>
> diff --git a/mm/internal.h b/mm/internal.h
> index d28ac0085f61..046cc264bfbe 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -492,6 +492,7 @@ struct compact_control {
>                                          */
>         bool alloc_contig;              /* alloc_contig_range allocation =
*/
>         bool source_has_metadata;       /* source pages have associated m=
etadata */
> +       bool reserve_metadata;
>  };
>
>  /*
> --
> 2.41.0
>

