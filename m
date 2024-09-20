Return-Path: <linux-fsdevel+bounces-29731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D18BF97CFB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 02:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8381F21E00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 00:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32DADF5C;
	Fri, 20 Sep 2024 00:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="n9niZC6p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109B8B644;
	Fri, 20 Sep 2024 00:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726793378; cv=none; b=OHJb2TYXNLWJkyOzWuH6SzwKhNk11gLlKErqxSztOBsS1qBQYIwkHP3Q8J20V7LHjIjqhvk2bk7kNU9LoczNU07FrfhV0YH9X10AvmDGMOXpxEPw4CZKzcghi28AlGZz17sMh0an4CfBcSXf3Hdt/y5fqAWuE7l6nuSpQmJtoQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726793378; c=relaxed/simple;
	bh=fGpAiCESCaWC+yXZ9LJgxsH6FXzeR2ucCNVX7ynGU6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZIC7q8IfY9fd8cNkWdbpV5AI1Zm1uN0jieIkn9Jf8gONAW1eLmSE/8ekS1EfUaNhQ+76Vy1+34bI+e6DrxQ4FpT7GUKT0msxxwxToqIgFHa9Nv+qOOxuGoVxl0WoDpZ+Gd0NPKwt/+3mVsWptGpMvVEZ0nntMCvT97T/hks8niw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=n9niZC6p; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726793371; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ojunlQf1lYqbuWBcDoilBDz9Bilr/mUd098c1JYuR5w=;
	b=n9niZC6pOLH7VzZ1OXZ5PCgMo2sx4qj5Be0ZO+fYALmHJFobwp5mPi/n02ut0IKW7MAIOjBjd9+gTdeOSfP7ZCoabosNrfHm98oxszuunXvewEajk4Wwn+t1dxIcYh0w9Pv/cWS8rFUI5/P08GUH0ozz7qzCi3Y5FD9tSUXo0tE=
Received: from 30.27.101.7(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFIs30l_1726793368)
          by smtp.aliyun-inc.com;
          Fri, 20 Sep 2024 08:49:30 +0800
Message-ID: <b5c77d5b-7f6d-4fe5-a711-6376c265ed53@linux.alibaba.com>
Date: Fri, 20 Sep 2024 08:49:26 +0800
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
 <9bbbac63-c05f-4f7b-91c2-141a93783cd3@linux.alibaba.com>
 <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/9/20 03:36, Benno Lossin wrote:
> On 19.09.24 17:13, Gao Xiang wrote:
>> Hi Benno,
>>
>> On 2024/9/19 21:45, Benno Lossin wrote:
>>> Hi,
>>>
>>> Thanks for the patch series. I think it's great that you want to use
>>> Rust for this filesystem.
>>>
>>> On 17.09.24 01:58, Gao Xiang wrote:
>>>> On 2024/9/17 04:01, Gary Guo wrote:
>>>>> Also, it seems that you're building abstractions into EROFS directly
>>>>> without building a generic abstraction. We have been avoiding that. If
>>>>> there's an abstraction that you need and missing, please add that
>>>>> abstraction. In fact, there're a bunch of people trying to add FS
>>>>
>>>> No, I'd like to try to replace some EROFS C logic first to Rust (by
>>>> using EROFS C API interfaces) and try if Rust is really useful for
>>>> a real in-tree filesystem.  If Rust can improve EROFS security or
>>>> performance (although I'm sceptical on performance), As an EROFS
>>>> maintainer, I'm totally fine to accept EROFS Rust logic landed to
>>>> help the whole filesystem better.
>>>
>>> As Gary already said, we have been using a different approach and it has
>>> served us well. Your approach of calling directly into C from the driver
>>> can be used to create a proof of concept, but in our opinion it is not
>>> something that should be put into mainline. That is because calling C
>>> from Rust is rather complicated due to the many nuanced features that
>>> Rust provides (for example the safety requirements of references).
>>> Therefore moving the dangerous parts into a central location is crucial
>>> for making use of all of Rust's advantages inside of your code.
>>
>> I'm not quite sure about your point honestly.  In my opinion, there
>> is nothing different to use Rust _within a filesystem_ or _within a
>> driver_ or _within a Linux subsystem_ as long as all negotiated APIs
>> are audited.
> 
> To us there is a big difference: If a lot of functions in an API are
> `unsafe` without being inherent from the problem that it solves, then
> it's a bad API.

Which one? If you point it out, we will update the EROFS kernel
APIs then.

> 
>> Otherwise, it means Rust will never be used to write Linux core parts
>> such as MM, VFS or block layer. Does this point make sense? At least,
>> Rust needs to get along with the existing C code (in an audited way)
>> rather than refuse C code.
> 
> I am neither requiring you to write solely safe code, nor am I banning
> interacting with the C side. What we mean when we talk about
> abstractions is that we want to minimize the Rust code that directly
> interfaces with C. Rust-to-Rust interfaces can be a lot safer and are

We will definitly minimize the API interface between Rust and C in
EROFS.

And it can be done incrementally, why not?  I assume your world is
not pure C and pure Rust as for the Rust for Linux project, no?

> easier to implement correctly.
> 
>> My personal idea about Rust: I think Rust is just another _language
>> tool_ for the Linux kernel which could save us time and make the
>> kernel development better.
> 
> Yes, but we do have conventions, rules and guidelines for writing such
> code. C code also has them. If you want/need to break them, there should
> be a good reason to do so. I don't see one in this instance.
> >> Or I wonder why not writing a complete new Rust stuff instead rather
>> than living in the C world?
> 
> There are projects that do that yes. But Rust-for-Linux is about
> bringing Rust to the kernel and part of that is coming up with good
> conventions and rules.

Which rule is broken?  Was they discussed widely around the
Linux world?

> 
>>>> For Rust VFS abstraction, that is a different and indepenent story,
>>>> Yiyang don't have any bandwidth on this due to his limited time.
>>>
>>> This seems a bit weird, you have the bandwidth to write your own
>>> abstractions, but not use the stuff that has already been developed?
>>
>> It's not written by me, Yiyang is still an undergraduate tudent.
>> It's his research project and I don't think it's his responsibility
>> to make an upstreamable VFS abstraction.
> 
> That is fair, but he wouldn't have to start from scratch, Wedsons
> abstractions were good enough for him to write a Rust version of ext2.

The Wedson one is just broken, I assume that you've read
https://lwn.net/Articles/978738/ ?

The initial Linux VFS C version is already for generic
read-write use.

> In addition, tarfs and puzzlefs also use those bindings.

These are both toy fses, I don't know who will use these two
fses for their customers.

> To me it sounds as if you have not taken the time to try to make it work
> with the existing abstractions. Have you tried reaching out to Ariel? He
> is working on puzzlefs and might have some insight to give you. Sadly

IMHO, puzzlefs is another Rust incomplete clone of EROFS, I
could tell him what EROFS currently do.

I'm very happy to collaborate with him to work on his use
cases (and tell him why EROFS can already be used for his
use cases), just
like the previous ComposeFS discussion.

There are enough FS projects which reinvents in-tree fses without
enough good reasons (for example, performance or design): ZUFS,
FamFS, ComposeFS.

Tarfs (here tar is not the real tar format), and Puzzlefs are
two special one just because they are written in Rust.  But
other than that they are just incomplete approach to EROFS.

I do hope Ariel could attend LSF/MM/BPF to discuss his use
cases with filesystem developpers.  And I'm very happy to
collaborate with him .

> Wedson has left the project, so someone will have to pick up his work.

It's not necessary to be Yiyang, since he's interested in
EROFS only.

> 
> I hope that you understand that we can't have two abstractions for the
> same C API. It confuses people which to use, some features might only be
> available in one version and others only in the other. It would be a
> total mess. It's just like the rule for no duplicated drivers that you
> have on the C side.
> 
> People (mostly Wedson) also have put in a lot of work into making the
> VFS abstractions good. Why ignore all of that?

How good? TBH, I think there could be something left eventually,
but the current prososed Rust VFS abstraction is just broken.

I don't think the current abstraction is of any use to be
upstreamed, at least, it should be driven with a generic
read-write filesystem, and resolve lifetime issues during
development (for example, just like Al mentioned d_name and
d_parent, etc.)

Because the initial Linux VFS C version is completely out of
minix fs, rather than an incomplete broken one just for some
toy (I don't know how to express more accurately, since each
upstream filesystem should have strong use cases and users,
but tarfs and puzzlefs are both not.)

Otherwise, all the broken Rust VFS users will be painful for
bugs and endless API refactering.

> 
>>> I have quickly glanced over the patchset and the abstractions seem
>>> rather immature, not general enough for other filesystems to also take
>>
>> I don't have enough time to take a full look of this patchset too
>> due to other ongoing work for now (Rust EROFS is not quite a high
>> priority stuff for me).
>>
>> And that's why it's called "RFC PATCH".
> 
> Yeah I saw the RFC title. I just wanted to communicate early that I
> would not review it if it were a normal patch. In fact, I would advise
> against taking the patch, due to the reasons I outlined.

You reason currently is still not valid.  IMO, again, Rust
is just a tool, you cannot forbid a real Linux subsystem to
use Rust as an experiment.

Or what's your real point?  An Rust gatekeeper?

> 
>>> advantage of them. They also miss safety documentation and are in
>>
>> I don't think it needs to be general enough, since we'd like to use
>> the new Rust language tool within a subsystem.
>>
>> So why it needs to take care of other filesystems? Again, I'm not
>> working on a full VFS abstriction.
> 
> And that's OK, feel free to just pick the parts of the existing VFS that
> you need and extend as you (or your student) see fit. What you said
> yourself is that we need a global vision for VFS abstractions. If you
> only use a subset of them, then you only care about that subset, other
> people can extend it if they need. If everyone would roll their own
> abstractions without communicating, then how would we create a global
> vision?

No.  We don't roll our own abstraction, instead we define a
clear C <-> Rust boundary of EROFS APIs, just like
"fs/xfs/libxfs" if you could take a look.

> 
>> Yes, this patchset is not perfect.  But I've asked Yiyang to isolate
>> all VFS structures as much as possible, but it seems that it still
>> touches something.
> 
> It would already be a big improvement to put the VFS structures into the
> kernel crate. Because then everyone can benefit from your work.

Again, that is not Yiyang's interest.  Which is just like to sell
something you don't want, I don't think it's reasonable.

> 
>>> general poorly documented.
>>
>> Okay, I think it can be improved then if you give more detailed hints.
>>
>>>
>>> Additionally, all of the code that I saw is put into the `fs/erofs` and
>>> `rust/erofs_sys` directories. That way people can't directly benefit
>>> from your code, put your general abstractions into the kernel crate.
>>> Soon we will be split the kernel crate, I could imagine that we end up
>>> with an `fs` crate, when that happens, we would put those abstractions
>>> there.
>>>
>>> As I don't have the bandwidth to review two different sets of filesystem
>>> abstractions, I can only provide you with feedback if you use the
>>> existing abstractions.
>>
>> I think Rust is just a tool, if you could have extra time to review
>> our work, that would be wonderful!  Many thanks then.
>>
>> However, if you don't have time to review, IMHO, Rust is just a tool,
>> I think each subsystem can choose to use Rust in their codebase, or
>> I'm not sure what's your real point is?
> 
> I don't want to prevent or discourage you from using Rust in the kernel.
> In fact, I can't prevent you from putting this in, since after all you
> are the maintainer.

I do think you're discouraging anyone to use Rust in their codebase,
because I've said we _will_ form a good abstraction in our codebase.

But you're just selling another stuff forcely.

> What I can do, is advise against not using abstractions. That has been
> our philosophy since very early on. They are the reason that you can
> write PHY drivers without any `unsafe` code whatsoever *today*. I think

I don't think filesystems are comparable to some PHY drivers.  If you
take ext4, it's more than 65000 line, and XFS, that is almost 78000.

I think filesystems can have a way to be reimplmented in Rust
incrementally, rather than purely black and write world.

> that is an impressive feat and our recipe for success.
> 
> We even have this in our documentation:
> https://docs.kernel.org/rust/general-information.html#abstractions-vs-bindings
> 
> My real point is that I want Rust to succeed in the kernel. I strongly
> believe that good abstractions (in the sense that you can do as much as
> possible using only safe Rust) are a crucial factor.

On my side, you are just isolating any useful subsystem to try
to use Rust and

“Leaf” modules (e.g. drivers) should not use the C bindings directly

is unreasonable for filesystems because it cannot be done in one
shot.

In addition, there are a lot ongoing features on both C and Rust
side, you need at least a fallback to make end users happy with a
unique feature view rather than just return "it's broken".

Users don't care C or Rust (they only care full functionality)
but only developers care.  And mixing up two different things
(VFS abstraction and use Rust in the codebase) is not good to
RFL success.

IMHO, this is "Rust for Linux" not "Linux for Rust".

> I and others from the RfL team can help you if you (or your student)
> have any Rust related questions for the abstractions. Feel free to reach
> out.
> 
> 
> Maybe Miguel can say more on this matter, since he was at the
> maintainers summit, but our takeaways essentially are that we want
> maintainers to experiment with Rust. And if you don't have any real
> users, then breaking the Rust code is fine.
> Though I think that with breaking we mean that changes to the C side
> prevent the Rust side from working, not shipping Rust code without
> abstractions.

I think you're still mixing them up.

> 
> We might be able to make an exception to the "your driver can only use
> abstractions" rule, but only with the promise that the subsystem is
> working towards creating suitable abstractions and replacing the direct
> C accesses with that.

I don't think those rules are reasonable for RFL success, honestly.

You are artificially isolating the Linux C and Rust world, not from
Linux users or Linux ecosystem perspective, but only from some
developer perspersive.

Good luck, anyway.

> 
> I personally think that we should not make that the norm, instead try to
> create the minimal abstraction and minimal driver (without directly
> calling C) that you need to start. Of course this might not work, the
> "minimal driver" might need to be rather complex for you to start, but I
> don't know your subsystem to make that judgement.

...

>>
>> Without a full proper VFS abstraction, it's just broken and
>> needs to be refactored.  And that will be painful to all
>> users then.
> 
> I also don't understand your point here. What is broken, this EROFS
> implementation? Why will it be painful to refactor?

I've said earlier.

> 
>> =======
>> In the end,
>>
>> Other thoughts, comments are helpful here since I wonder how "Rust
>> -for-Linux" works in the long term, and decide whether I will work
>> on Kernel Rust or not at least in the short term.
> 
> The longterm goal is to make everything that is possible in C, possible
> in Rust. For more info, please take a look at the kernel summit talk by

But you're disallowing Rust in the codebase.

> Miguel Ojeda.
> However, we can only reach that longterm goal if maintainers are willing
> and ready to put Rust into their subsystems (either by knowing/learning
> Rust themselves or by having a co-maintainer that does just the Rust
> part). So you wanting to experiment is great. I appreciate that you also
> have a student working on this. Still, I think we should follow our
> guidelines and create abstractions in order to require as little
> `unsafe` code as possible.

I've expressed my point.  I don't think some `guideline`
could bring success to RFL.  Since many subsystems needs
an incremental way, not just a black-or-white thing.

Thanks,
Gao Xiang

> 
> ---
> Cheers,
> Benno


