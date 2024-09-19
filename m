Return-Path: <linux-fsdevel+bounces-29714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D6697CB77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 17:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67081F250EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 15:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106441A0B02;
	Thu, 19 Sep 2024 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qSQdo6Lm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509661A2548;
	Thu, 19 Sep 2024 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726758866; cv=none; b=Pp8IazVP+76NY+jncEDHgOLpvIKm25zk1aX6B1JDYcaQXq8pZruzBpVtAavD15opjHmL+Jkh9gDqKhD3Wy5sZAOK5d6NE+yrbUzk6J9oBOjOINepvYiA2vKdIWBWRz4dLLuN3oxcsTtuHR/vrL2KqzVe2YkCDHDUCDbUvQ1GdyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726758866; c=relaxed/simple;
	bh=aA6ncyqbB5zG1a+0fNn+ZX9FSpsfipgLPNOmW1nff8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svFnHG/TnBB+aZwfMoRB6WEB00qFnkfNVHAEocJntmDPAkWZzaHxx8qBhFtDJ+adjXKMLLC0swy+EZcR5EalLx9Bt4VACnYVYQGHnaVdKv+aq1e9YTOY5lk/oi4EmkguGQoOXhnO5c69cEOJCJ3yAG5pePJ1rlQpHiWvxatorg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qSQdo6Lm; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726758824; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5VCFEuYCnHsfOuo1YYnMThvXIJQAqGa76+hoecHZapM=;
	b=qSQdo6LmLHBbbh2nJBAp1ZgWqrucWl39jfPg2PO5vCgHBX0pJFHcfqdSBEkc9EcxYyiArtPe7Vj2YUP2PtvCdSkJo16zZj3kEbzywUpwzcQ4T42bUcLI3aILGqnEHOSwdbNRV9EGZuLD3rAig7T6quZCfQuxYEegFjxHNtJ6cMo=
Received: from 30.27.101.7(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFI-2kQ_1726758821)
          by smtp.aliyun-inc.com;
          Thu, 19 Sep 2024 23:13:43 +0800
Message-ID: <9bbbac63-c05f-4f7b-91c2-141a93783cd3@linux.alibaba.com>
Date: Thu, 19 Sep 2024 23:13:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
To: Benno Lossin <benno.lossin@proton.me>, Gary Guo <gary@garyguo.net>,
 Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-erofs@lists.ozlabs.org, rust-for-linux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-4-toolmanp@tlmp.cc>
 <20240916210111.502e7d6d.gary@garyguo.net>
 <2b04937c-1359-4771-86c6-bf5820550c92@linux.alibaba.com>
 <ac871d1e-9e4e-4d1b-82be-7ae87b78d33e@proton.me>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ac871d1e-9e4e-4d1b-82be-7ae87b78d33e@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Benno,

On 2024/9/19 21:45, Benno Lossin wrote:
> Hi,
> 
> Thanks for the patch series. I think it's great that you want to use
> Rust for this filesystem.
> 
> On 17.09.24 01:58, Gao Xiang wrote:
>> On 2024/9/17 04:01, Gary Guo wrote:
>>> Also, it seems that you're building abstractions into EROFS directly
>>> without building a generic abstraction. We have been avoiding that. If
>>> there's an abstraction that you need and missing, please add that
>>> abstraction. In fact, there're a bunch of people trying to add FS
>>
>> No, I'd like to try to replace some EROFS C logic first to Rust (by
>> using EROFS C API interfaces) and try if Rust is really useful for
>> a real in-tree filesystem.  If Rust can improve EROFS security or
>> performance (although I'm sceptical on performance), As an EROFS
>> maintainer, I'm totally fine to accept EROFS Rust logic landed to
>> help the whole filesystem better.
> 
> As Gary already said, we have been using a different approach and it has
> served us well. Your approach of calling directly into C from the driver
> can be used to create a proof of concept, but in our opinion it is not
> something that should be put into mainline. That is because calling C
> from Rust is rather complicated due to the many nuanced features that
> Rust provides (for example the safety requirements of references).
> Therefore moving the dangerous parts into a central location is crucial
> for making use of all of Rust's advantages inside of your code.

I'm not quite sure about your point honestly.  In my opinion, there
is nothing different to use Rust _within a filesystem_ or _within a
driver_ or _within a Linux subsystem_ as long as all negotiated APIs
are audited.

Otherwise, it means Rust will never be used to write Linux core parts
such as MM, VFS or block layer. Does this point make sense? At least,
Rust needs to get along with the existing C code (in an audited way)
rather than refuse C code.

My personal idea about Rust: I think Rust is just another _language
tool_ for the Linux kernel which could save us time and make the
kernel development better.

Or I wonder why not writing a complete new Rust stuff instead rather
than living in the C world?

> 
>> For Rust VFS abstraction, that is a different and indepenent story,
>> Yiyang don't have any bandwidth on this due to his limited time.
> 
> This seems a bit weird, you have the bandwidth to write your own
> abstractions, but not use the stuff that has already been developed?

It's not written by me, Yiyang is still an undergraduate tudent.
It's his research project and I don't think it's his responsibility
to make an upstreamable VFS abstraction.

> 
> I have quickly glanced over the patchset and the abstractions seem
> rather immature, not general enough for other filesystems to also take

I don't have enough time to take a full look of this patchset too
due to other ongoing work for now (Rust EROFS is not quite a high
priority stuff for me).

And that's why it's called "RFC PATCH".

> advantage of them. They also miss safety documentation and are in

I don't think it needs to be general enough, since we'd like to use
the new Rust language tool within a subsystem.

So why it needs to take care of other filesystems? Again, I'm not
working on a full VFS abstriction.

Yes, this patchset is not perfect.  But I've asked Yiyang to isolate
all VFS structures as much as possible, but it seems that it still
touches something.

> general poorly documented.

Okay, I think it can be improved then if you give more detailed hints.

> 
> Additionally, all of the code that I saw is put into the `fs/erofs` and
> `rust/erofs_sys` directories. That way people can't directly benefit
> from your code, put your general abstractions into the kernel crate.
> Soon we will be split the kernel crate, I could imagine that we end up
> with an `fs` crate, when that happens, we would put those abstractions
> there.
> 
> As I don't have the bandwidth to review two different sets of filesystem
> abstractions, I can only provide you with feedback if you use the
> existing abstractions.

I think Rust is just a tool, if you could have extra time to review
our work, that would be wonderful!  Many thanks then.

However, if you don't have time to review, IMHO, Rust is just a tool,
I think each subsystem can choose to use Rust in their codebase, or
I'm not sure what's your real point is?

> 
>> And I _also_ don't think an incomplete ROFS VFS Rust abstraction
>> is useful to Linux community
> 
> IIRC Wedson created ROFS VFS abstractions before going for the full
> filesystem. So it would definitely be useful for other read-only
> filesystems (as well as filesystems that also allow writing, since last
> time I checked, they often also support reading).

Leaving aside everything else, an incomplete Rust read-only VFS
abstraction itself is just an unsafe stuff.

> 
>> (because IMO for generic interface
>> design, we need a global vision for all filesystems instead of
>> just ROFSes.  No existing user is not an excuse for an incomplete
>> abstraction.)
> 
> Yes we need a global vision, but if you would use the existing
> abstractions, then you would participate in this global vision.
> 
> Sorry for repeating this point so many times, but it is *really*
> important that we don't have multiple abstractions for the same thing.

I've expressed my viewpoint.

> 
>> If a reasonble Rust VFS abstraction landed, I think we will switch
>> to use that, but as I said, they are completely two stories.
> 
> For them to land, there has to be some kind of user. For example, a rust
> reference driver, or a new filesystem. For example this one.

Without a full proper VFS abstraction, it's just broken and
needs to be refactored.  And that will be painful to all
users then.

=======
In the end,

Other thoughts, comments are helpful here since I wonder how "Rust
-for-Linux" works in the long term, and decide whether I will work
on Kernel Rust or not at least in the short term.

Thanks,
Gao Xiang

> 
> ---
> Cheers,
> Benno
> 


