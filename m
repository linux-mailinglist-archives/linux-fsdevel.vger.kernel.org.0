Return-Path: <linux-fsdevel+bounces-1891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABFC7DFDAD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 02:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C9E281D7F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 01:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C20B1369;
	Fri,  3 Nov 2023 01:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="XKxCFFDe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B2C10E5
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 01:07:18 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1FC197
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 18:07:12 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4196ae80fc3so8665791cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Nov 2023 18:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1698973631; x=1699578431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCr2uTXG4daALtyBbHvIpmUdOFTLryhu1H0hnelXOT0=;
        b=XKxCFFDeeN4XCu7oEb5OzGwM130LRWaKEVYMtCoaNDWaprwONDq0/R1Zt6RthysOsy
         6yM4TS09Kv0B5LigRjPnF5f9hPTj6g6wRAN+HSYNwdYX7/FAboOGugIeVTleG+j3to+r
         ywaCxtYSQ/etLnwRsxPHAcNyp26ZBThhSeWYJypMe9cHdWPXNs23PlomMAKXDhwtBeEl
         +F+0u1MM6EHziRVGjVGRoYPTy9mETqE+Ox4gvGODSCszwic5FdChvuQwJzxD1EmqeozH
         EOuz05V2vugDTYc6J2RBDY11NqCJQWEsaV59zerHTxk2GHiBmZaYBRN74CRc8BNo2E/R
         jIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698973631; x=1699578431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCr2uTXG4daALtyBbHvIpmUdOFTLryhu1H0hnelXOT0=;
        b=BtJ0G8Ip6YX9rxJCpf3Rw/sJTZ77YprF6KQCO4g3f17JPQL0IzdqY+FuleJogGJFhe
         hytbZfmMZGPTkTOMDgvOEoxyBZ3XuQAQKXtxMjX4J6YRgaI1a4H6SjsQqkqMT+FFbNCQ
         3WT5+Z3oLTN0sU1WoGFtMXoXJglELxBMaSMwVFxZihdt/MnXc7IGin35INfg05aPVoLu
         2KJObZM967WQQicI07+xugJqdWUuOZV94zR1PYJ+IaUB7OCpL37zJb5gSIAeEoi8QQ58
         WP1hoyfSH5YrToVeid81eZC8kbOdLshAXtR6so8guZga5mH+7mdX2J2lZtk7cZm3jtVa
         lkpw==
X-Gm-Message-State: AOJu0Yx1+DFK/SBOcdiUkjOVZF7mZakiDrUTJtPkm6t0KOg9FEPRzpRn
	rnz2sndYLoT1Bc6urKIne4IVi6DxjIAFdW8RGjzMRg==
X-Google-Smtp-Source: AGHT+IEqYrzRZ/GFNvFXxoK50vrQQuq1A8gYWJ3fw0CyeAan/l0SmscOwqpyx5yApNc02+deo9lEbx2+K5Z9OdVf+gg=
X-Received: by 2002:ac8:5a8f:0:b0:41e:37cf:8661 with SMTP id
 c15-20020ac85a8f000000b0041e37cf8661mr23002590qtc.12.1698973631023; Thu, 02
 Nov 2023 18:07:11 -0700 (PDT)
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
 <CAAPL-u_OWFLrrNxszm4D+mNiZY6cSb3=jez3XJHFtN6q05dU2g@mail.gmail.com>
 <CA+CK2bBPBtAXFQAFUeF8nTxL_Sx926HgR3zLCj_6pKgbOGt8Wg@mail.gmail.com> <CAAPL-u9HHgPDj_xTTx=GqPg49DcrpGP1FF8zhaog=9awwu0f_Q@mail.gmail.com>
In-Reply-To: <CAAPL-u9HHgPDj_xTTx=GqPg49DcrpGP1FF8zhaog=9awwu0f_Q@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 2 Nov 2023 21:06:33 -0400
Message-ID: <CA+CK2bAv6okHVigjCyDODm5VELi7gtQHOUy9kH5J4jTBpnGPxw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] mm: report per-page metadata information
To: Wei Xu <weixugc@google.com>
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

On Thu, Nov 2, 2023 at 4:22=E2=80=AFPM Wei Xu <weixugc@google.com> wrote:
>
> On Thu, Nov 2, 2023 at 11:34=E2=80=AFAM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > > > > I could have sworn that I pointed that out in a previous version =
and
> > > > > requested to document that special case in the patch description.=
 :)
> > > >
> > > > Sounds, good we will document that parts of per-page may not be par=
t
> > > > of MemTotal.
> > >
> > > But this still doesn't answer how we can use the new PageMetadata
> > > field to help break down the runtime kernel overhead within MemUsed
> > > (MemTotal - MemFree).
> >
> > I am not sure it matters to the end users: they look at PageMetadata
> > with or without Page Owner, page_table_check, HugeTLB and it shows
> > exactly how much per-page overhead changed. Where the kernel allocated
> > that memory is not that important to the end user as long as that
> > memory became available to them.
> >
> > In addition, it is still possible to estimate the actual memblock part
> > of Per-page metadata by looking at /proc/zoneinfo:
> >
> > Memblock reserved per-page metadata: "present_pages - managed_pages"
>
> This assumes that all reserved memblocks are per-page metadata. As I

Right after boot, when all Per-page metadata is still from memblocks,
we could determine what part of the zone reserved memory is not
per-page, and use it later in our calculations.

> mentioned earlier, it is not a robust approach.
> > If there is something big that we will allocate in that range, we
> > should probably also export it in some form.
> >
> > If this field does not fit in /proc/meminfo due to not fully being
> > part of MemTotal, we could just keep it under nodeN/, as a separate
> > file, as suggested by Greg.
> >
> > However, I think it is useful enough to have an easy system wide view
> > for Per-page metadata.
>
> It is fine to have this as a separate, informational sysfs file under
> nodeN/, outside of meminfo. I just don't think as in the current
> implementation (where PageMetadata is a mixture of buddy and memblock
> allocations), it can help with the use case that motivates this
> change, i.e. to improve the breakdown of the kernel overhead.
> > > > > > are allocated), so what would be the best way to export page me=
tadata
> > > > > > without redefining MemTotal? Keep the new field in /proc/meminf=
o but
> > > > > > be ok that it is not part of MemTotal or do two counters? If we=
 do two
> > > > > > counters, we will still need to keep one that is a buddy alloca=
tor in
> > > > > > /proc/meminfo and the other one somewhere outside?
> > > > >
> > >
> > > I think the simplest thing to do now is to only report the buddy
> > > allocations of per-page metadata in meminfo.  The meaning of the new
> >
> > This will cause PageMetadata to be 0 on 99% of the systems, and
> > essentially become useless to the vast majority of users.
>
> I don't think it is a major issue. There are other fields (e.g. Zswap)
> in meminfo that remain 0 when the feature is not used.

Since we are going to use two independent interfaces
/proc/meminfo/PageMetadata and nodeN/page_metadata (in a separate file
as requested by Greg) How about if in /proc/meminfo we provide only
the buddy allocator part, and in nodeN/page_metadata we provide the
total per-page overhead in the given node that include memblock
reserves, and buddy allocator memory?

Pasha

