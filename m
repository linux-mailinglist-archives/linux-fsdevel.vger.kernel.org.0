Return-Path: <linux-fsdevel+bounces-445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70F87CB1C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 20:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F391C20A21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 18:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7A9328C0;
	Mon, 16 Oct 2023 18:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUeEVEK8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82D431A7F
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 18:01:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE37E1
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 11:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697479291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XgLDjZVj0XdXYm9kLe73MFbIBa94kVbOoQPaPBwR2t8=;
	b=gUeEVEK8NXWTi4dR9peDany4l9QCF5w+z4uxZVbL1eknIi75ivo54+bxRtjH+pPgBaWMuP
	XjkcxB1fCRNlsLu52WtDiBCYje0UYLJA4pmlD5XwLdgGqgCOx28XgXTG1xfk+TRSWUK+Mf
	AIFWM6lCz8fYOOgZk2Wp7GmRsFw+ppA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-nstcIPofOX6JhMI90OWwEQ-1; Mon, 16 Oct 2023 14:01:14 -0400
X-MC-Unique: nstcIPofOX6JhMI90OWwEQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40647c6f71dso36126605e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 11:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697479273; x=1698084073;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XgLDjZVj0XdXYm9kLe73MFbIBa94kVbOoQPaPBwR2t8=;
        b=uKpM0RmN3K4NQZ5M807eyG6fG8AHTLRMqPeya0cjx6RYxi6wbHr4nu4tsHjAgKvpel
         gGshWjlrSw4bCCADEWLWEZHFr2HjJvFt0+YUMnT51CSu3ORXD1QW/Y4XiMzeTvNTKaQ+
         Kwamu5ASSYtQj38lzdHhjsfAr9cOXlJB9PMKEBRa+spqtA6HYtFEPRQm9zSETLxOnIOP
         vGFgpfl1PztrF7LghOSHsvZAE2J0IupqaCwjtFeKMWB1BJ1ZI8eOibPg+K704mGwycAM
         GO7MQBf44WrIjV86It/je12LouLWMBmRDe0op8liE5XKh0lzfrEPgefGek5lsux4Yw+N
         a53g==
X-Gm-Message-State: AOJu0Yxb0mOAtgfn5Gbx1RS8dHWQxEswnr0hvViaP5wM+y815IGpAhKP
	gTH/Po/ZWwF4ZBqRZzpBW/WdOzJFp06Vm4zpoNfeQNRIdAJG0W1gGiUf1ux4pive89UlDcysZms
	zcEgF/RCW7RqNkoekZAnrUInx9w==
X-Received: by 2002:a05:600c:2154:b0:401:519:c9 with SMTP id v20-20020a05600c215400b00401051900c9mr30565373wml.13.1697479273186;
        Mon, 16 Oct 2023 11:01:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8pCLIakSA25F9i66lD2EnjM3dwIvovQhF2Qm8USqE6swBPT/eG0QlP1UN5SBxdqyxfV6Gsg==
X-Received: by 2002:a05:600c:2154:b0:401:519:c9 with SMTP id v20-20020a05600c215400b00401051900c9mr30565339wml.13.1697479272598;
        Mon, 16 Oct 2023 11:01:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73c:9300:8903:bf2e:db72:6527? (p200300cbc73c93008903bf2edb726527.dip0.t-ipconnect.de. [2003:cb:c73c:9300:8903:bf2e:db72:6527])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c350800b004068e09a70bsm7804392wmq.31.2023.10.16.11.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 11:01:12 -0700 (PDT)
Message-ID: <12588295-2616-eb11-43d2-96a3c62bd181@redhat.com>
Date: Mon, 16 Oct 2023 20:01:10 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>,
 Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
 aarcange@redhat.com, hughd@google.com, mhocko@suse.com,
 axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
 Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
 bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
 jdduke@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com
References: <20231009064230.2952396-1-surenb@google.com>
 <20231009064230.2952396-3-surenb@google.com>
 <214b78ed-3842-5ba1-fa9c-9fa719fca129@redhat.com>
 <CAJuCfpHzSm+z9b6uxyYFeqr5b5=6LehE9O0g192DZdJnZqmQEw@mail.gmail.com>
 <478697aa-f55c-375a-6888-3abb343c6d9d@redhat.com>
 <CA+EESO5nvzka0KzFGzdGgiCWPLg7XD-8jA9=NTUOKFy-56orUg@mail.gmail.com>
 <ZShS3UT+cjJFmtEy@x1n> <205abf01-9699-ff1c-3e4e-621913ada64e@redhat.com>
 <ZSlragGjFEw9QS1Y@x1n>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
In-Reply-To: <ZSlragGjFEw9QS1Y@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

[...]

>>> Actually, even though I have no solid clue, but I had a feeling that there
>>> can be some interesting way to leverage this across-mm movement, while
>>> keeping things all safe (by e.g. elaborately requiring other proc to create
>>> uffd and deliver to this proc).
>>
>> Okay, but no real use cases yet.
> 
> I can provide a "not solid" example.  I didn't mention it because it's
> really something that just popped into my mind when thinking cross-mm, so I
> never discussed with anyone yet nor shared it anywhere.
> 
> Consider VM live upgrade in a generic form (e.g., no VFIO), we can do that
> very efficiently with shmem or hugetlbfs, but not yet anonymous.  We can do
> extremely efficient postcopy live upgrade now with anonymous if with REMAP.
> 
> Basically I see it a potential way of moving memory efficiently especially
> with thp.

It's an interesting use case indeed. The questions would be if this is 
(a) a use case we want to support; (b) why we need to make that decision 
now and add that feature.

One question is if this kind of "moving memory between processes" really 
should be done, because intuitively SHMEM smells like the right thing to 
use here (two processes wanting to access the same memory).

The downsides of shmem are lack of the shared zeropage and KSM. The 
shared zeropage is usually less of a concern for VMs, but KSM is. 
However, KSM will also disallow moving pages here. But all 
non-deduplicated ones could be moved.

[I wondered whether moving KSM pages (rmap items) could be done; 
probably in some limited form with some more added complexity]

> 
>>
>>>
>>> Considering Andrea's original version already contains those bits and all
>>> above, I'd vote that we go ahead with supporting two MMs.
>>
>> You can do nasty things with that, as it stands, on the upstream codebase.
>>
>> If you pin the page in src_mm and move it to dst_mm, you successfully broke
>> an invariant that "exclusive" means "no other references from other
>> processes". That page is marked exclusive but it is, in fact, not exclusive.
> 
> It is still exclusive to the dst mm?  I see your point, but I think you're
> taking exclusiveness altogether with pinning, and IMHO that may not be
> always necessary?

That's the definition of PAE. See do_wp_page() on when we reset PAE: 
when there are no other references, which implies no other references 
from other processes. Maybe you have "currently exclusively mapped" in 
mind, which is what the mapcount can be used for.

> 
>>
>> Once you achieved that, you can easily have src_mm not have MMF_HAS_PINNED,
> 
> (I suppose you meant dst_mm here)

Yes.

> 
>> so you can just COW-share that page. Now you successfully broke the
>> invariant that COW-shared pages must not be pinned. And you can even trigger
>> VM_BUG_ONs, like in sanity_check_pinned_pages().
> 
> Yeah, that's really unfortunate.  But frankly, I don't think it's the fault
> of this new feature, but the rest.
> 
> Let's imagine if the MMF_HAS_PINNED wasn't proposed as a per-mm flag, but
> per-vma, which I don't see why we can't because it's simply a hint so far.
> Then if we apply the same rule here, UFFDIO_REMAP won't even work for
> single-mm as long as cross-vma. Then UFFDIO_REMAP as a whole feature will
> be NACKed simply because of this..

Because of gup-fast we likely won't see that happening. And if we would, 
it could be handled (src_mm has the flag set, set it on the destination 
if the page maybe pinned after hiding it from gup-fast; or simply always 
copy the flag if set on the src).

> 
> And I don't think anyone can guarantee a per-vma MMF_HAS_PINNED can never
> happen, or any further change to pinning solution that may affect this.  So
> far it just looks unsafe to remap a pin page to me.

It may be questionable to allow remapping pinned pages.

> 
> I don't have a good suggestion here if this is a risk.. I'd think it risky
> then to do REMAP over pinned pages no matter cross-mm or single-mm.  It
> means probably we just rule them out: folio_maybe_dma_pinned() may not even
> be enough to be safe with fast-gup.  We may need page_needs_cow_for_dma()
> with proper write_protect_seq no matter cross-mm or single-mm?

If you unmap and sync against GUP-fast, you can check after unmapping 
and remap and fail if it maybe pinned afterwards. Plus an early check 
upfront.

> 
>>
>> Can it all be fixed? Sure, with more complexity. For something without clear
>> motivation, I'll have to pass.
> 
> I think what you raised is a valid concern, but IMHO it's better fixed no
> matter cross-mm or single-mm.  What do you think?

single-mm should at least not cause harm, but the semantics are 
questionable. cross-mm could, especially with malicious user space that 
wants to find ways of harming the kernel.

I'll note that mremap with pinned pages works.

> 
> In general, pinning lose its whole point here to me for an userspace either
> if it DONTNEEDs it or REMAP it.  What would be great to do here is we unpin
> it upon DONTNEED/REMAP/whatever drops the page, because it loses its
> coherency anyway, IMHO.

Further, moving a part of a THP would fail either way, because the 
pinned THP cannot get split.

-- 
Cheers,

David / dhildenb


