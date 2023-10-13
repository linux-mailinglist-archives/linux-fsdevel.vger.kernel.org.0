Return-Path: <linux-fsdevel+bounces-336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DB67C8BB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 18:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9311C21054
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 16:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A4221A08;
	Fri, 13 Oct 2023 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zr38qGbT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF96D219F6
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 16:49:26 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3019BE
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 09:49:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-405524e6769so15031875e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 09:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697215763; x=1697820563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nz4f3IlrP+KvlAwyWza5Savvd/r4RIbASaykdzTPF2Q=;
        b=Zr38qGbTftWVwYVo/sIa97l2o26Fp9ztdIwVUF6s6kBA77xdtmtvnpPmdWYDyGMKo7
         nVQQTOMTEOywlYdWt+nmoHapfNMv2PUzYE8M/TP24eMxBRAjr6hXtifvHtezuYLUnG2J
         i1J/cZxNkV0Hrdty0/0s+ksJ4b+QBX7/ZherxAK++qBpzyWc4eQa5SA791PWFAKGWHnm
         exbvQ0ZqDP1gn+D3fzLnSVmwMygK6yuj0aDmk6J+B6BOdJE/ZNBhxNjEFEREutpv6WOi
         3AJgsLek1XG3JhaR/xrsiVo1MYAgfbPycU42mgenIr1SJJXq8LthBdxYiY4VwMuaRCNg
         l9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697215763; x=1697820563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nz4f3IlrP+KvlAwyWza5Savvd/r4RIbASaykdzTPF2Q=;
        b=ZyJKtoMYHfyM2x12XQ7+ZTWrmsIZ0jveF7v917Ru6XFxcBFjYonniLFapZ02VcONbI
         pgkwmQny1WSQSKofbJThpPaP/zGwRyicJoi4igqlttNr/aamV9ZdweRod8HxAj8bK+/j
         a06ntBLA9cZscdD65BzVg37/L54hbkf3ybjrcU+diGQzLxWx2skEWfka/8gsEhAMZIiL
         r5btWRaYORi8CXv6wLfICnqrhu8uR8Iwkd5Oa7NYJZ3WFMkAnevTBjGPGB/ysvHMCOLP
         HSTDDJIf+1Sp3eFf7EXwby6VFo7rxBs9hhZRUfFuaxQCkVLT20YG6TqSROjvClgbrLiE
         WVvw==
X-Gm-Message-State: AOJu0YzorvSIAo/culI18mqbc/7f0iHEA5yMV3n6MDe1NosdofvzSyxe
	EKItXRzsSoaJLFpNZ09/9XDiS08pAK3jwZ4W2uMf3A==
X-Google-Smtp-Source: AGHT+IFtLjgll1xakrK/VXVK5frgZzT7mNEQp+t035PCVEvFE07IjQVR2WujR5jmn9Xe1LJF1YS/ZP6IHRPFfrZ4aQw=
X-Received: by 2002:a05:600c:a0a:b0:405:19dd:ad82 with SMTP id
 z10-20020a05600c0a0a00b0040519ddad82mr538198wmp.16.1697215762890; Fri, 13 Oct
 2023 09:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009064230.2952396-1-surenb@google.com> <20231009064230.2952396-3-surenb@google.com>
 <214b78ed-3842-5ba1-fa9c-9fa719fca129@redhat.com> <CAJuCfpHzSm+z9b6uxyYFeqr5b5=6LehE9O0g192DZdJnZqmQEw@mail.gmail.com>
 <478697aa-f55c-375a-6888-3abb343c6d9d@redhat.com> <CA+EESO5nvzka0KzFGzdGgiCWPLg7XD-8jA9=NTUOKFy-56orUg@mail.gmail.com>
 <ZShS3UT+cjJFmtEy@x1n> <205abf01-9699-ff1c-3e4e-621913ada64e@redhat.com> <ZSlragGjFEw9QS1Y@x1n>
In-Reply-To: <ZSlragGjFEw9QS1Y@x1n>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Fri, 13 Oct 2023 09:49:10 -0700
Message-ID: <CA+EESO5ESxxricWx2EFneizLGj2Cb5tuM3kbAicc0ggA4Wh2oQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org, 
	aarcange@redhat.com, hughd@google.com, mhocko@suse.com, 
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org, 
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com, 
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com, 
	jdduke@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 9:08=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Oct 13, 2023 at 11:56:31AM +0200, David Hildenbrand wrote:
> > Hi Peter,
>
> Hi, David,
>
> >
> > > I used to have the same thought with David on whether we can simplify=
 the
> > > design to e.g. limit it to single mm.  Then I found that the trickies=
t is
> > > actually patch 1 together with the anon_vma manipulations, and the pr=
oblem
> > > is that's not avoidable even if we restrict the api to apply on singl=
e mm.
> > >
> > > What else we can benefit from single mm?  One less mmap read lock, bu=
t
> > > probably that's all we can get; IIUC we need to keep most of the rest=
 of
> > > the code, e.g. pgtable walks, double pgtable lockings, etc.
> >
> > No existing mechanisms move anon pages between unrelated processes, tha=
t
> > naturally makes me nervous if we're doing it "just because we can".
>
> IMHO that's also the potential, when guarded with userfaultfd descriptor
> being shared between two processes.
>
> See below with more comment on the raised concerns.
>
> >
> > >
> > > Actually, even though I have no solid clue, but I had a feeling that =
there
> > > can be some interesting way to leverage this across-mm movement, whil=
e
> > > keeping things all safe (by e.g. elaborately requiring other proc to =
create
> > > uffd and deliver to this proc).
> >
> > Okay, but no real use cases yet.
>
> I can provide a "not solid" example.  I didn't mention it because it's
> really something that just popped into my mind when thinking cross-mm, so=
 I
> never discussed with anyone yet nor shared it anywhere.
>
> Consider VM live upgrade in a generic form (e.g., no VFIO), we can do tha=
t
> very efficiently with shmem or hugetlbfs, but not yet anonymous.  We can =
do
> extremely efficient postcopy live upgrade now with anonymous if with REMA=
P.
>
> Basically I see it a potential way of moving memory efficiently especiall=
y
> with thp.
>
> >
> > >
> > > Considering Andrea's original version already contains those bits and=
 all
> > > above, I'd vote that we go ahead with supporting two MMs.
> >
> > You can do nasty things with that, as it stands, on the upstream codeba=
se.
> >
> > If you pin the page in src_mm and move it to dst_mm, you successfully b=
roke
> > an invariant that "exclusive" means "no other references from other
> > processes". That page is marked exclusive but it is, in fact, not exclu=
sive.
>
> It is still exclusive to the dst mm?  I see your point, but I think you'r=
e
> taking exclusiveness altogether with pinning, and IMHO that may not be
> always necessary?
>
> >
> > Once you achieved that, you can easily have src_mm not have MMF_HAS_PIN=
NED,
>
> (I suppose you meant dst_mm here)
>
> > so you can just COW-share that page. Now you successfully broke the
> > invariant that COW-shared pages must not be pinned. And you can even tr=
igger
> > VM_BUG_ONs, like in sanity_check_pinned_pages().
>
> Yeah, that's really unfortunate.  But frankly, I don't think it's the fau=
lt
> of this new feature, but the rest.
>
> Let's imagine if the MMF_HAS_PINNED wasn't proposed as a per-mm flag, but
> per-vma, which I don't see why we can't because it's simply a hint so far=
.
> Then if we apply the same rule here, UFFDIO_REMAP won't even work for
> single-mm as long as cross-vma. Then UFFDIO_REMAP as a whole feature will
> be NACKed simply because of this..
>
> And I don't think anyone can guarantee a per-vma MMF_HAS_PINNED can never
> happen, or any further change to pinning solution that may affect this.  =
So
> far it just looks unsafe to remap a pin page to me.
>
> I don't have a good suggestion here if this is a risk.. I'd think it risk=
y
> then to do REMAP over pinned pages no matter cross-mm or single-mm.  It
> means probably we just rule them out: folio_maybe_dma_pinned() may not ev=
en
> be enough to be safe with fast-gup.  We may need page_needs_cow_for_dma()
> with proper write_protect_seq no matter cross-mm or single-mm?
>
> >
> > Can it all be fixed? Sure, with more complexity. For something without =
clear
> > motivation, I'll have to pass.
>
> I think what you raised is a valid concern, but IMHO it's better fixed no
> matter cross-mm or single-mm.  What do you think?
>
> In general, pinning lose its whole point here to me for an userspace eith=
er
> if it DONTNEEDs it or REMAP it.  What would be great to do here is we unp=
in
> it upon DONTNEED/REMAP/whatever drops the page, because it loses its
> coherency anyway, IMHO.
>
> >
> > Once there is real demand, we can revisit it and explore what else we w=
ould
> > have to take care of (I don't know how memcg behaves when moving betwee=
n
> > completely unrelated processes, maybe that works as expected, I don't k=
now
> > and I have no time to spare on reviewing features with no real use case=
s)
> > and announce it as a new feature.
>
> Good point.  memcg is probably needed..
>
> So you reminded me to do a more thorough review against zap/fault paths, =
I
> think what's missing are (besides page pinning):
>
>   - mem_cgroup_charge()/mem_cgroup_uncharge():
>
>     (side note: I think folio_throttle_swaprate() is only for when
>      allocating new pages, so not needed here)
>
>   - check_stable_address_space() (under pgtable lock)
>
>   - tlb flush
>
>     Hmm???????????????? I can't see anywhere we did tlb flush, batched or
>     not, either single-mm or cross-mm should need it.  Is this missing?
>
IIUC, ptep_clear_flush() flushes tlb entry. So I think we are doing
unbatched flushing. Possibly a nice performance improvement later on
would be to try doing it batched. Suren can throw more light on it.

One thing I was wondering is don't we need cache flush for the src
pages? mremap's move_page_tables() does it. IMHO, it's required here
as well.

> >
> >
> > Note: that (with only reading the documentation) it also kept me wonder=
ing
> > how the MMs are even implied from
> >
> >        struct uffdio_move {
> >            __u64 dst;    /* Destination of move */
> >            __u64 src;    /* Source of move */
> >            __u64 len;    /* Number of bytes to move */
> >            __u64 mode;   /* Flags controlling behavior of move */
> >            __s64 move;   /* Number of bytes moved, or negated error */
> >        };
> >
> > That probably has to be documented as well, in which address space dst =
and
> > src reside.
>
> Agreed, some better documentation will never hurt.  Dst should be in the =
mm
> address space that was bound to the userfault descriptor.  Src should be =
in
> the current mm address space.
>
> Thanks,
>
> --
> Peter Xu
>

