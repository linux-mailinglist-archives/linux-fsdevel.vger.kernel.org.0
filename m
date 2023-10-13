Return-Path: <linux-fsdevel+bounces-324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A60D17C8A29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 18:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85351C21112
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 16:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABE11DA39;
	Fri, 13 Oct 2023 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JVBL9oCY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC28210E4
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 16:12:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC10B6E92
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 09:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697213320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l877RZEJE1wmnlu2HXZmUf5JJOPmxuWtRyzMAVCkcBQ=;
	b=JVBL9oCY4422oBfbk03eutK689EL8OWDIsZYdJfbkFtKqAhhQAMgNqrHXXCFdkT9bl4S7u
	umOUiS2lxdLBoqNE5Pt69dZQuTmG5oqEdwzY2EUTtdhyOVftZW4Lc7JQB832rFWfxfastd
	NSLjSdJbkvd1eNdiu4Mv531QlCHJNJI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-rBEsG4QDOTOemDrj6doisg-1; Fri, 13 Oct 2023 12:08:13 -0400
X-MC-Unique: rBEsG4QDOTOemDrj6doisg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-774292de453so32768985a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 09:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697213293; x=1697818093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l877RZEJE1wmnlu2HXZmUf5JJOPmxuWtRyzMAVCkcBQ=;
        b=VwvaPkp7HXf3CsfuxtVGo8ioWw3HgOsAjstNQOIUf9QKtR67TbKzJyxDIbBVDenPUS
         Au/Oa/G13riEe+G82elPAjx/1+iaVQNSZrhykxOgq40ueHLNOkkZiKVp/8GQnjfs8wVQ
         GKassfi6xS1CacG0DpF+ILUVeZAUldr9kiM9GxpbnP+VlLqs30lR9AyMRbCsDBzBr32U
         e2OYk+kxfH73Ao7aul74KYVxKPmO5JSE/00LYzGUozmSFpGLnL397zuGMLaE+Uy49jVy
         +e/nmeakQvn00y5PmAI+4JLapYKOkMOFB1K1jmAaNpXwNfMl7COftPbqvEMBc/vE/4pU
         d1jA==
X-Gm-Message-State: AOJu0YzsMurFBubU2fL3RSGH/MrQPmdhV8/JQZGi1mxZ2yuffCg25W1T
	j6BatKm20zpGpvj8JxuyJsGys8oQozA8cPMZke8+gMpu4YKiQ9SWcle1g2vUsAhel5wiT7END0V
	PwJ1NZ1FHrOpEjqfMdCCBRKVqYw==
X-Received: by 2002:a05:620a:1995:b0:773:ad1f:3d5b with SMTP id bm21-20020a05620a199500b00773ad1f3d5bmr29031622qkb.0.1697213292974;
        Fri, 13 Oct 2023 09:08:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMzq+HmVjk9ZMncHpY2NS0XXagXp4pSZDtTRpzZctU6hE/hHC4ErkahV4f14Sr5cFXgAXzhg==
X-Received: by 2002:a05:620a:1995:b0:773:ad1f:3d5b with SMTP id bm21-20020a05620a199500b00773ad1f3d5bmr29031582qkb.0.1697213292607;
        Fri, 13 Oct 2023 09:08:12 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id s17-20020a05620a031100b007770673e757sm734564qkm.94.2023.10.13.09.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 09:08:12 -0700 (PDT)
Date: Fri, 13 Oct 2023 12:08:10 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>,
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
	aarcange@redhat.com, hughd@google.com, mhocko@suse.com,
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
	jdduke@google.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
Message-ID: <ZSlragGjFEw9QS1Y@x1n>
References: <20231009064230.2952396-1-surenb@google.com>
 <20231009064230.2952396-3-surenb@google.com>
 <214b78ed-3842-5ba1-fa9c-9fa719fca129@redhat.com>
 <CAJuCfpHzSm+z9b6uxyYFeqr5b5=6LehE9O0g192DZdJnZqmQEw@mail.gmail.com>
 <478697aa-f55c-375a-6888-3abb343c6d9d@redhat.com>
 <CA+EESO5nvzka0KzFGzdGgiCWPLg7XD-8jA9=NTUOKFy-56orUg@mail.gmail.com>
 <ZShS3UT+cjJFmtEy@x1n>
 <205abf01-9699-ff1c-3e4e-621913ada64e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <205abf01-9699-ff1c-3e4e-621913ada64e@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 11:56:31AM +0200, David Hildenbrand wrote:
> Hi Peter,

Hi, David,

> 
> > I used to have the same thought with David on whether we can simplify the
> > design to e.g. limit it to single mm.  Then I found that the trickiest is
> > actually patch 1 together with the anon_vma manipulations, and the problem
> > is that's not avoidable even if we restrict the api to apply on single mm.
> > 
> > What else we can benefit from single mm?  One less mmap read lock, but
> > probably that's all we can get; IIUC we need to keep most of the rest of
> > the code, e.g. pgtable walks, double pgtable lockings, etc.
> 
> No existing mechanisms move anon pages between unrelated processes, that
> naturally makes me nervous if we're doing it "just because we can".

IMHO that's also the potential, when guarded with userfaultfd descriptor
being shared between two processes.

See below with more comment on the raised concerns.

> 
> > 
> > Actually, even though I have no solid clue, but I had a feeling that there
> > can be some interesting way to leverage this across-mm movement, while
> > keeping things all safe (by e.g. elaborately requiring other proc to create
> > uffd and deliver to this proc).
> 
> Okay, but no real use cases yet.

I can provide a "not solid" example.  I didn't mention it because it's
really something that just popped into my mind when thinking cross-mm, so I
never discussed with anyone yet nor shared it anywhere.

Consider VM live upgrade in a generic form (e.g., no VFIO), we can do that
very efficiently with shmem or hugetlbfs, but not yet anonymous.  We can do
extremely efficient postcopy live upgrade now with anonymous if with REMAP.

Basically I see it a potential way of moving memory efficiently especially
with thp.

> 
> > 
> > Considering Andrea's original version already contains those bits and all
> > above, I'd vote that we go ahead with supporting two MMs.
> 
> You can do nasty things with that, as it stands, on the upstream codebase.
> 
> If you pin the page in src_mm and move it to dst_mm, you successfully broke
> an invariant that "exclusive" means "no other references from other
> processes". That page is marked exclusive but it is, in fact, not exclusive.

It is still exclusive to the dst mm?  I see your point, but I think you're
taking exclusiveness altogether with pinning, and IMHO that may not be
always necessary?

> 
> Once you achieved that, you can easily have src_mm not have MMF_HAS_PINNED,

(I suppose you meant dst_mm here)

> so you can just COW-share that page. Now you successfully broke the
> invariant that COW-shared pages must not be pinned. And you can even trigger
> VM_BUG_ONs, like in sanity_check_pinned_pages().

Yeah, that's really unfortunate.  But frankly, I don't think it's the fault
of this new feature, but the rest.

Let's imagine if the MMF_HAS_PINNED wasn't proposed as a per-mm flag, but
per-vma, which I don't see why we can't because it's simply a hint so far.
Then if we apply the same rule here, UFFDIO_REMAP won't even work for
single-mm as long as cross-vma. Then UFFDIO_REMAP as a whole feature will
be NACKed simply because of this..

And I don't think anyone can guarantee a per-vma MMF_HAS_PINNED can never
happen, or any further change to pinning solution that may affect this.  So
far it just looks unsafe to remap a pin page to me.

I don't have a good suggestion here if this is a risk.. I'd think it risky
then to do REMAP over pinned pages no matter cross-mm or single-mm.  It
means probably we just rule them out: folio_maybe_dma_pinned() may not even
be enough to be safe with fast-gup.  We may need page_needs_cow_for_dma()
with proper write_protect_seq no matter cross-mm or single-mm?

> 
> Can it all be fixed? Sure, with more complexity. For something without clear
> motivation, I'll have to pass.

I think what you raised is a valid concern, but IMHO it's better fixed no
matter cross-mm or single-mm.  What do you think?

In general, pinning lose its whole point here to me for an userspace either
if it DONTNEEDs it or REMAP it.  What would be great to do here is we unpin
it upon DONTNEED/REMAP/whatever drops the page, because it loses its
coherency anyway, IMHO.

> 
> Once there is real demand, we can revisit it and explore what else we would
> have to take care of (I don't know how memcg behaves when moving between
> completely unrelated processes, maybe that works as expected, I don't know
> and I have no time to spare on reviewing features with no real use cases)
> and announce it as a new feature.

Good point.  memcg is probably needed..

So you reminded me to do a more thorough review against zap/fault paths, I
think what's missing are (besides page pinning):

  - mem_cgroup_charge()/mem_cgroup_uncharge(): 

    (side note: I think folio_throttle_swaprate() is only for when
     allocating new pages, so not needed here)

  - check_stable_address_space() (under pgtable lock)

  - tlb flush

    Hmm???????????????? I can't see anywhere we did tlb flush, batched or
    not, either single-mm or cross-mm should need it.  Is this missing?

> 
> 
> Note: that (with only reading the documentation) it also kept me wondering
> how the MMs are even implied from
> 
>        struct uffdio_move {
>            __u64 dst;    /* Destination of move */
>            __u64 src;    /* Source of move */
>            __u64 len;    /* Number of bytes to move */
>            __u64 mode;   /* Flags controlling behavior of move */
>            __s64 move;   /* Number of bytes moved, or negated error */
>        };
> 
> That probably has to be documented as well, in which address space dst and
> src reside.

Agreed, some better documentation will never hurt.  Dst should be in the mm
address space that was bound to the userfault descriptor.  Src should be in
the current mm address space.

Thanks,

-- 
Peter Xu


