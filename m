Return-Path: <linux-fsdevel+bounces-844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CDE7D14A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 19:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACC8DB2154A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 17:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213B0200D8;
	Fri, 20 Oct 2023 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0hmxcPj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87125200B8
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 17:16:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384291A3
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 10:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697822184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lsRDSOfLSgK+OVjButp4OW1KdjhEPQi3GLbItueI8EA=;
	b=i0hmxcPjs+amhyRSH0z980nMtuBDOwAYMzJvifjRDqwChMrXoC+VdV+FLKnRMOBXvUjlGm
	+47son+XlKgeneDIy9tWTQ6x9ZBAoBXTEqbbV8bLVz8IH098TqvCKE50wtw15+09CYC1J3
	eiYAozqKsUIGQcggzh67uVew6hNq+G0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-iiYW0jcEPMeFFINRqGQcAg-1; Fri, 20 Oct 2023 13:16:22 -0400
X-MC-Unique: iiYW0jcEPMeFFINRqGQcAg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4084d08235fso6416805e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 10:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697822181; x=1698426981;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsRDSOfLSgK+OVjButp4OW1KdjhEPQi3GLbItueI8EA=;
        b=SatWsnx94LC6ZjFYYU8qN1IDEKGRw5D4TfS0o20A/QqzttZ9f1pkarv2064TnsUc0u
         A/OO26wRL5tGv0CvyNwBEC0zaT5cmDTRM2mrAG0iCnA/bMCKoHMWBrph1RlUQ6A+M9kP
         CedhJtNk9fW1VIFzdOSaxwpd9nIxegCenO9Z4x8zuGZ5biw+OJj1MBMx4UlPUOSvXYMJ
         GI/cu7CWASVpfKMZAjUfUv7a2g1XCV1ymRPmuWFbDRHVEXu4ltQXwvZJCznHXOG6h7Au
         yzbOR4HkZtNeGy41J8QTCgZLNGDXurlKyW3Nju8B+DwS2wOSvDcA2EmxU33fr1sjx3+N
         D/zw==
X-Gm-Message-State: AOJu0YzHna7obks8jAHJaLRtCWIKvzssE2EqNO1Ho04GFy/f/z/fgLDb
	PFTFsB8M/z4RrVOF9TI0ISVlcCIudcNT7TugQSveTF3cnzc6kqbyPZI8x93sduYyhzcZQslw6g3
	n+zDRFPDZEd+PRUNjUlVHTtTnlg==
X-Received: by 2002:a05:600c:45cb:b0:401:bd2e:49fc with SMTP id s11-20020a05600c45cb00b00401bd2e49fcmr1944193wmo.24.1697822181441;
        Fri, 20 Oct 2023 10:16:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpDuBIvXOrHCjCzBmw6Y1rGu2/4O4pDplP+7RFa1GbF4nHJgxGw7Ie4FOyVMHeFKkP7i7zNQ==
X-Received: by 2002:a05:600c:45cb:b0:401:bd2e:49fc with SMTP id s11-20020a05600c45cb00b00401bd2e49fcmr1944158wmo.24.1697822180874;
        Fri, 20 Oct 2023 10:16:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:c100:5d8:2d46:b11e:6784? (p200300cbc719c10005d82d46b11e6784.dip0.t-ipconnect.de. [2003:cb:c719:c100:5d8:2d46:b11e:6784])
        by smtp.gmail.com with ESMTPSA id p10-20020a05600c05ca00b004083729fc14sm7268977wmd.20.2023.10.20.10.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 10:16:20 -0700 (PDT)
Message-ID: <d34dfe82-3e31-4f85-8405-c582a0650688@redhat.com>
Date: Fri, 20 Oct 2023 19:16:19 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Xu <peterx@redhat.com>, Lokesh Gidra <lokeshgidra@google.com>,
 akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 shuah@kernel.org, aarcange@redhat.com, hughd@google.com, mhocko@suse.com,
 axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
 Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
 bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
 jdduke@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com
References: <478697aa-f55c-375a-6888-3abb343c6d9d@redhat.com>
 <CA+EESO5nvzka0KzFGzdGgiCWPLg7XD-8jA9=NTUOKFy-56orUg@mail.gmail.com>
 <ZShS3UT+cjJFmtEy@x1n> <205abf01-9699-ff1c-3e4e-621913ada64e@redhat.com>
 <ZSlragGjFEw9QS1Y@x1n> <12588295-2616-eb11-43d2-96a3c62bd181@redhat.com>
 <ZS2IjEP479WtVdMi@x1n> <8d187891-f131-4912-82d8-13112125b210@redhat.com>
 <ZS7ZqztMbhrG52JQ@x1n> <d40b8c86-6163-4529-ada4-d2b3c1065cba@redhat.com>
 <ZTGJHesvkV84c+l6@x1n> <81cf0943-e258-494c-812a-0c00b11cf807@redhat.com>
 <CAJuCfpHZWfjW530CvQCFx-PYNSaeQwkh-+Z6KgdfFyZHRGSEDQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJuCfpHZWfjW530CvQCFx-PYNSaeQwkh-+Z6KgdfFyZHRGSEDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>
>> The sub-feature in question (cross-mm) has no solid use cases; at this
>> point I am not even convinced the use case you raised requires
>> *userfaultfd*; for the purpose of moving a whole VMA worth of pages
>> between two processes; I don't see the immediate need to get userfaultfd
>> involved and move individual pages under page lock etc.
> 
> You make a compelling case against cross-mm support.

I tried to :P

I'm happy to hear compelling cases for cross-mm support that we need 
*right now*. And that's what I'm missing so far besides "already 
included in the patches" and "but we would eventually need a separate flag".

As a side note, I already do have another rmap-related feature in the 
works that will require extra-effort to handle this case (short: assign 
each MM a unique ID and use that for accounting purposes when 
(un)mapping pages); I think I figured out how to handle this case here; 
and it's questionable if my work will make it upstream -- to be posted 
as PoC in 2-4 weeks I guess. But it easily shows that there are cases 
where this will require extra work -- without any current benefits due 
to lack of actual users.

> While I can't force Andrea to participate in upstreaming nor do I have
> his background, keeping it simple, as you requested, is doable. That's
> what I plan on doing by splitting the patch and I think we all agreed
> to that. I'll also see if I can easily add a separate patch to test
> cross-mm support.
> I do apologize for the extra effort required from reviewers to cover
> for the gaps in my patches. I'm doing my best to minimize that and I
> really appreciate your time.

It's absolutely not your fault and there is absolutely no need to 
apologize (sorry if I sounded like I would be blaming you in any way). I 
made myself the experience that up-streaming the work of someone else 
can be troublesome, because it's hard to grasp all the details from a 
set of patches. Documentation and comments can't handle all the implicit 
knowledge from the original author.

I likely wouldn't be able to even write that code myself.

For example: why is cross-mm relevant and was included in the original 
patches? Maybe there was a very good reason and it is simply not documented.

> 
>>
>>>
>>> I'll leave that to Suren and Lokesh to decide.  For me the worst case is
>>> one more flag which might be confusing, which is not the end of the world..
>>> Suren, you may need to work more thoroughly to remove cross-mm implications
>>> if so, just like when renaming REMAP to MOVE.
>>
>> I'm asking myself why you are pushing so hard to include complexity
>> "just because we can"; doesn't make any sense to me, honestly.
>>
>> Maybe you have some other real use cases that ultimately require
>> userfaultfd for cross-mm that you cannot share?
>>
>> Will the world end when we have to use a separate flag so we can open
>> this pandora's box when really required?
>>
>>
>> Again, moving anon pages within a process is a known thing; we do that
>> already via mremap; the only difference here really is, that we have to
>> get the rmap right because we don't adjust VMAs. It's a shame we don't
>> try to combine both code paths, maybe it's not easily possible like we
>> did with mprotect vs. uffd-wp.
> 
> That's a good point. With cross-mm support baked in, the overlap was
> not obvious to me. I'll see how much we can reuse from the mremap
> path.

My comment was inspired by Lokesh "While going through mremap's 
move_page_tables code, which is pretty similar to what we do here".

There are some subtle differences (could we even move whole page tables? 
probably not due to holding the mmap locking only in read-mode) and 
special exclusive-only+rmap adjust handling. Further, TLB flushing is 
different (but maybe there are ways to just reuse the batching, did not 
look into the details).

But move_page_tables is clearly single-mm code, and a unification might 
not be that straight forward.

> 
>>
>> Moving anon pages between process is currently only done via COW, where
>> all things (page pinning, memcg, ...) have been figured out and are
>> simply working as expected. Making uffd special by coding-up their own
>> thing does not sound compelling to me.
>>
>>
>> I am clearly against any unwarranted features+complexity. Again, I will
>> stop arguing further, the whole thing of "include it just because we
>> can" to avoid a flag (that we might never even see) doesn't make any
>> sense to me and likely never will.
>>
>> The whole way this feature is getting upstreamed is just messed up IMHO
>> and I the reasoning used in this thread to stick
>> as-close-as-possible to some code person B wrote some years ago (e.g.,
>> naming, sub-features) is far out of my comprehension.
> 
> I don't think staying as-close-as-possible to the original version was
> the way I was driving this so far. At least that was not my conscious

These are rather the vibes I'm getting from Peter. "Why rename it, could 
confuse people because the original patches are old", "Why exclude it if 
it has been included in the original patches". Not the kind of reasoning 
I can relate to when it comes to upstreaming some patches.


> intention. I'm open to further suggestions whenever it makes sense to
> deviate from it.

I'll repeat: any complexity we remove and any code reused in common 
code/moved out of userfaultfd will be a win.

-- 
Cheers,

David / dhildenb


