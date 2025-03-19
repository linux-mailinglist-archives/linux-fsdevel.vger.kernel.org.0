Return-Path: <linux-fsdevel+bounces-44476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7107BA698F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 20:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8B529819D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 19:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D75B214A97;
	Wed, 19 Mar 2025 19:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="LZd4xeRf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3721DED58;
	Wed, 19 Mar 2025 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742411740; cv=none; b=Rd2R10VnxBt+g4zCLC59bDarkqMWoomdnhDQOLh9nQujBIyjC08c8jc4gCz7Zx/1e2SRzST9oAwP5ngzP1F2l4n98VpHkhqAhwffhapKVpEKypP5j1W1vlcILPInGnlxZbCD4vgMnqyE3MC93sMqr+8CHJFdEJjn+GgRRPrY23c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742411740; c=relaxed/simple;
	bh=QSD7Rtn0EGET3MLCvuaT9o8rxFRfu3WRaMueLB5E5pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bnch7GRgD7SGsg5htWuqW7DhkEhxuMDbs8OBWkLCN2ENrjzSM82Ey1Uw2tyFgAQ1NC31GF/zs4HboiHhxvLJ5qEt2qXa6DMkdWrNPWwsG0zVvLWifsps+Hjix888yboEj+sHHpwtqrNP2Hub09rI5ruzoNo3Czb2ONhz+SuuG/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=LZd4xeRf; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:To:Date:Message-ID:CC;
	bh=U6gFPt5sYKYI8vVJCMZTCGc01EinZbieK1ciixFlzMM=; b=LZd4xeRfIUxgkeZCn0Ku+5C37I
	B+Xx7F9hEj8gA5MlgOh3iu/d92DOnz0dJzgZS2KkkaePPufQPG5xWLz9hSqUyr7ZY2WefWX9TV1Uo
	zfOQ6sQhM3SZv7Nmdc6cAlJ7Updwyc/GQ2xUTWQWavamp++QF0TpvJhW8tV3AD4J/0T0jmXJK0cTZ
	6d/dbPi0ONSfevrZaaTnWHxfJ08Mi8MZX/oRXFk5A314+rqmZgmldBmx65i6xty/p+9VxrJu12HDx
	1P5p6f/buyZIUFdiS5zTsoXYRjkmK9dKKSGem3mmo7VY3T2WNsS7rI9DVydesvgBoBOX2rUY3uOB4
	0/27pJzJD3Yy12FoqyQHNELvJDMC913Yb3npOS/qFi3LnRawxDYMQmhTxq5ce76LKdUmb3B+VWHKr
	teVriQH21oJLMCUPnf4B62OgWCrtwP5Lt0GtWwJSGUojtjeG3/2Hza6lp1ljcf0c91CfSIPDybswT
	DAPATlhHwOXeVT7XVvU2mv0j;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1tuysx-005mEk-1N;
	Wed, 19 Mar 2025 19:15:27 +0000
Message-ID: <356ce660-fc2e-4016-a0d9-6896936669c2@samba.org>
Date: Wed, 19 Mar 2025 20:15:26 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
To: Jens Axboe <axboe@kernel.dk>, Joe Damato <jdamato@fastly.com>,
 Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, asml.silence@gmail.com,
 linux-fsdevel@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
 viro@zeniv.linux.org.uk, jack@suse.cz, kuba@kernel.org, shuah@kernel.org,
 sdf@fomichev.me, mingo@redhat.com, arnd@arndb.de, brauner@kernel.org,
 akpm@linux-foundation.org, tglx@linutronix.de, jolsa@kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250319001521.53249-1-jdamato@fastly.com>
 <Z9p6oFlHxkYvUA8N@infradead.org> <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
 <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
 <19e3056c-2f7b-4f41-9c40-98955c4a9ed3@kernel.dk>
 <Z9sCsooW7OSTgyAk@LQ3V64L9R2>
 <dc3ebb86-f4b2-443a-9b0d-f5470fd773f1@kernel.dk>
Content-Language: en-US, de-DE
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <dc3ebb86-f4b2-443a-9b0d-f5470fd773f1@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 19.03.25 um 19:37 schrieb Jens Axboe:
> On 3/19/25 11:45 AM, Joe Damato wrote:
>> On Wed, Mar 19, 2025 at 11:20:50AM -0600, Jens Axboe wrote:
>>> On 3/19/25 11:04 AM, Joe Damato wrote:
>>>> On Wed, Mar 19, 2025 at 10:07:27AM -0600, Jens Axboe wrote:
>>>>> On 3/19/25 9:32 AM, Joe Damato wrote:
>>>>>> On Wed, Mar 19, 2025 at 01:04:48AM -0700, Christoph Hellwig wrote:
>>>>>>> On Wed, Mar 19, 2025 at 12:15:11AM +0000, Joe Damato wrote:
>>>>>>>> One way to fix this is to add zerocopy notifications to sendfile similar
>>>>>>>> to how MSG_ZEROCOPY works with sendmsg. This is possible thanks to the
>>>>>>>> extensive work done by Pavel [1].
>>>>>>>
>>>>>>> What is a "zerocopy notification"
>>>>>>
>>>>>> See the docs on MSG_ZEROCOPY [1], but in short when a user app calls
>>>>>> sendmsg and passes MSG_ZEROCOPY a completion notification is added
>>>>>> to the error queue. The user app can poll for these to find out when
>>>>>> the TX has completed and the buffer it passed to the kernel can be
>>>>>> overwritten.
>>>>>>
>>>>>> My series provides the same functionality via splice and sendfile2.
>>>>>>
>>>>>> [1]: https://www.kernel.org/doc/html/v6.13/networking/msg_zerocopy.html
>>>>>>
>>>>>>> and why aren't you simply plugging this into io_uring and generate
>>>>>>> a CQE so that it works like all other asynchronous operations?
>>>>>>
>>>>>> I linked to the iouring work that Pavel did in the cover letter.
>>>>>> Please take a look.
>>>>>>
>>>>>> That work refactored the internals of how zerocopy completion
>>>>>> notifications are wired up, allowing other pieces of code to use the
>>>>>> same infrastructure and extend it, if needed.
>>>>>>
>>>>>> My series is using the same internals that iouring (and others) use
>>>>>> to generate zerocopy completion notifications. Unlike iouring,
>>>>>> though, I don't need a fully customized implementation with a new
>>>>>> user API for harvesting completion events; I can use the existing
>>>>>> mechanism already in the kernel that user apps already use for
>>>>>> sendmsg (the error queue, as explained above and in the
>>>>>> MSG_ZEROCOPY documentation).
>>>>>
>>>>> The error queue is arguably a work-around for _not_ having a delivery
>>>>> mechanism that works with a sync syscall in the first place. The main
>>>>> question here imho would be "why add a whole new syscall etc when
>>>>> there's already an existing way to do accomplish this, with
>>>>> free-to-reuse notifications". If the answer is "because splice", then it
>>>>> would seem saner to plumb up those bits only. Would be much simpler
>>>>> too...
>>>>
>>>> I may be misunderstanding your comment, but my response would be:
>>>>
>>>>    There are existing apps which use sendfile today unsafely and
>>>>    it would be very nice to have a safe sendfile equivalent. Converting
>>>>    existing apps to using iouring (if I understood your suggestion?)
>>>>    would be significantly more work compared to calling sendfile2 and
>>>>    adding code to check the error queue.
>>>
>>> It's really not, if you just want to use it as a sync kind of thing. If
>>> you want to have multiple things in flight etc, yeah it could be more
>>> work, you'd also get better performance that way. And you could use
>>> things like registered buffers for either of them, which again would
>>> likely make it more efficient.
>>
>> I haven't argued that performance would be better using sendfile2
>> compared to iouring, just that existing apps which already use
>> sendfile (but do so unsafely) would probably be more likely to use a
>> safe alternative with existing examples of how to harvest completion
>> notifications vs something more complex, like wrapping iouring.
> 
> Sure and I get that, just not sure it'd be worth doing on the kernel
> side for such (fairly) weak reasoning. The performance benefit is just a
> side note in that if you did do it this way, you'd potentially be able
> to run it more efficiently too. And regardless what people do or use
> now, they are generally always interested in that aspect.
> 
>>> If you just use it as a sync thing, it'd be pretty trivial to just wrap
>>> a my_sendfile_foo() in a submit_and_wait operation, which issues and
>>> waits on the completion in a single syscall. And if you want to wait on
>>> the notification too, you could even do that in the same syscall and
>>> wait on 2 CQEs. That'd be a downright trivial way to provide a sync way
>>> of doing the same thing.
>>
>> I don't disagree; I just don't know if app developers:
>>    a.) know that this is possible to do, and
>>    b.) know how to do it
> 
> Writing that wrapper would be not even a screenful of code. Yes maybe
> they don't know how to do it now, but it's _really_ trivial to do. It'd
> take me roughly 1 min to do that, would be happy to help out with that
> side so it could go into a commit or man page or whatever.
> 
>> In general: it does seem a bit odd to me that there isn't a safe
>> sendfile syscall in Linux that uses existing completion notification
>> mechanisms.
> 
> Pretty natural, I think. sendfile(2) predates that by quite a bit, and
> the last real change to sendfile was using splice underneath. Which I
> did, and that was probably almost 20 years ago at this point...
> 
> I do think it makes sense to have a sendfile that's both fast and
> efficient, and can be used sanely with buffer reuse without relying on
> odd heuristics.
> 
>>>> I would also argue that there are likely user apps out there that
>>>> use both sendmsg MSG_ZEROCOPY for certain writes (for data in
>>>> memory) and also use sendfile (for data on disk). One example would
>>>> be a reverse proxy that might write HTTP headers to clients via
>>>> sendmsg but transmit the response body with sendfile.
>>>>
>>>> For those apps, the code to check the error queue already exists for
>>>> sendmsg + MSG_ZEROCOPY, so swapping in sendfile2 seems like an easy
>>>> way to ensure safe sendfile usage.
>>>
>>> Sure that is certainly possible. I didn't say that wasn't the case,
>>> rather that the error queue approach is a work-around in the first place
>>> for not having some kind of async notification mechanism for when it's
>>> free to reuse.
>>
>> Of course, I certainly agree that the error queue is a work around.
>> But it works, app use it, and its fairly well known. I don't see any
>> reason, other than historical context, why sendmsg can use this
>> mechanism, splice can, but sendfile shouldn't?
> 
> My argument would be the same as for other features - if you can do it
> simpler this other way, why not consider that? The end result would be
> the same, you can do fast sendfile() with sane buffer reuse. But the
> kernel side would be simpler, which is always a kernel main goal for
> those of us that have to maintain it.
> 
> Just adding sendfile2() works in the sense that it's an easier drop in
> replacement for an app, though the error queue side does mean it needs
> to change anyway - it's not just replacing one syscall with another. And
> if we want to be lazy, sure that's fine. I just don't think it's the
> best way to do it when we literally have a mechanism that's designed for
> this and works with reuse already with normal send zc (and receive side
> too, in the next kernel).

A few month (or even years) back, Pavel came up with an idea
to implement some kind of splice into a fixed buffer, if that
would be implemented I guess it would help me in Samba too.
My first usage was on the receive side (from the network).

But the other side might also be possible now we have RWF_DONTCACHE.
Instead of dropping the pages from the page cache, it might
be possible move them to fixed buffer instead.
It would mean the pages would be 'stable' when they are
no longer part of the pagecache.
But maybe my assumption for that is too naive...

Anyway that splice into a fixed buffer would great to have,
as the new IORING_OP_RECV_ZC, requires control over the
hardware queues of the nic and only allows a single process
to provide buffers for that receive queue (at least that's how
I understand it). And that's not possible for multiple process
(maybe not belonging to the same high level application and likely
non-root applications). So it would be great have splice into
fixed buffer as alternative to IORING_OP_SPLICE/IORING_OP_TEE,
as it would be more flexible to use in combination with
IORING_OP_SENDMSG_ZC as well as IORING_OP_WRITE[V]_FIXED with RWF_DONTCACHE.

I guess such a splice into fixed buffer linked to IORING_OP_SENDMSG_ZC
would be the way to simulate the sendfile2() in userspace?

Thanks!
metze

