Return-Path: <linux-fsdevel+bounces-77184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOt1Duyfj2kuSAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 23:04:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FBF139B52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 23:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E1EB3038A4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 22:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDD4218AC4;
	Fri, 13 Feb 2026 22:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4ZTdcu6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ED825C704
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 22:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771020260; cv=pass; b=g/Vd+aT9XjBqM0D77bJ4mtZPYPDBSXUs5w1AIBqpvioLzLx44v8JINz0KGvbZeli0kjwRRnlY7bBYL0GJNySijN0G/OsvfbGLr0aIa+uZvdpw7kqIIqW1UOFiv4RLdyJZ6ZUmPRh7f9/n6TpmPnqA4lposvCeJV0ypDfGtuW5NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771020260; c=relaxed/simple;
	bh=T/yajJUkS71yB85E10CugrMOpuhcfqZphF8pIW9PcgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pe59XRkoGvS6Qk0MsNSTnVgx77JCbvnJVn/9QbsyQVtDgugQfzRkmiUi0Qx5HszgqzPX+SKqxXdhRtZcbQp//qv2He4UiKq3LsoExt63+Ru66djukk/AVv7qGTB1iQSvpJ51ypNb3jKmRs+76d38ATjom/GX02Dc/Q1EzlOuK94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4ZTdcu6; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-89549b2f538so33646116d6.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 14:04:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771020258; cv=none;
        d=google.com; s=arc-20240605;
        b=a/acnPtyRFdo6sHl2FRdzXCkjQs3EZn5xuV055sByNAEUqITy6cIgoJkABicbs9Tvb
         XpfJCPZxkJk6nvGMDxJyQDqaxb5Or+5s8deXKUrhQT4NJzRB1yOkJNuZ+FSMZ867ws6u
         rs4hdRvmPH4UWMibOB1tKjEtv3Oj9Ny5jvBG5WMsEM/FE156QxDjfqUvISzHoSIIriDp
         Jk9Uf/JcG5w6u7zLSM8bAYuFXDhqPJ7rpTG+jOjZuuwmyRSeyjAnr918rPmj+uFVFmUh
         mnZfR6BbbWaHXxrS9XzBPi78dLPcb3m5DA4Y6aCF3HeSb54TIls5aqFOjFaQ2SN7hlbJ
         q+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4ytRz6Niq4RXHZO+jocyqZC/3Kvjco2xLpMvmT8UTXg=;
        fh=pWiHuK93eltPqlQZt5VrbKWZnfjd1ZEcvmPzLjPYt9g=;
        b=NG4xShwQX09Sot+uhdclF0G6k5bIjz89DFuN/isAK8mhZLHHs6CJn1gWYIlpJ6CrHS
         i8b8AcFehkUbephtFXnZfN0SGiBCV82rFrVjrkgx0cHMwZoxzMH21ulbRgsAwCLOWp9Z
         rn07pgG3Pmoq5uWpx3SppBdUbhDtjq+d3v6+wo1lxOZ/EU77xw84MXhzeZgBNOtBU6wX
         2AAOG+pXjTxEfQgBs8wrvLeT6mzzKZsxyMCBHty7ElquMj+tbPQLi6o5iWBY2DMemAfY
         JhufXhuy7HhH9JVRq/8rUVROB1yd17wGzuY7eocGHDLPZWmmq7ZPlmGvlzqDWpapIdbW
         pNeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771020258; x=1771625058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ytRz6Niq4RXHZO+jocyqZC/3Kvjco2xLpMvmT8UTXg=;
        b=e4ZTdcu6NOsNJaCAAS/eFyb5oL5mEM19rskHXS1F4Y967jJb67Yxb0WjdC2MYAeNug
         WFM1NjarRAK8Ar9bRjxAuSMbtC+bbGXJ6HwaZV67OMOh3ebbK89f1uY96mkRLivzXkif
         t/IrIo4q3EUaM9URInQW3/gHOIcZ+IBI7UWAOtd8MdODlQF5uEOtS5sMH0HZd7FAe1f5
         TL5RxoZMgrmtiK0TIoPY50+JvFBUXtN2CpxEe6beVVW6MB9o7fvGZwNLEfA4TLIp/emT
         3mT/pIeBPIyv6Uhf5fyjbAnFLYFR4BxGUpRXCqQ76aALUghqwvv+w8AR9rIn7OLNWYFd
         5BIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771020258; x=1771625058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ytRz6Niq4RXHZO+jocyqZC/3Kvjco2xLpMvmT8UTXg=;
        b=GCFNWYwl9jx8Yd36lezyw1rP+V6dJrVniOBzVaB5uzjt31bgp99fj3QChkI4kj+xj6
         s7bR1CTABlL3+iB3xuBR9W/GlfgYFk0I9xWHf4rO1pM/+Kg2jKNlazqkAWeRm3Ygo16E
         dShuPGPSsW3ta2hQL1J5LwHoF/0gr04hFdKixbqn5nUYs0zz6Op7bhG53VF4kWPXQ3OC
         DMn2N6q6s+ZUQ7lgi/ZMXbAEBn/2ioC7coiyXJqvhN0Z978F5+k59Q5NjCM+hkv3Mfb4
         n77ULrjS9Xw4f1xPW1OYl/OUyJ3ELH1qEVt7z8gTodr3oTQc5Gf+qEdq+lkwFqOS6ldq
         /qkA==
X-Forwarded-Encrypted: i=1; AJvYcCUB3W6n05TwQt9D35xbm+DXwkMzDrSpc+Nsh/R5Atw5fPCw2GvNDiVNN6W+aNAglVwSbGpf/xVLmH93qkQ6@vger.kernel.org
X-Gm-Message-State: AOJu0YyiSJnaZgpgWaici0Xz95o0SnQylXeAmluFWKNzO3ygzwx0kTVG
	fbnJer8uRwqZk7rVky9QM13Ylauo4h0bIE/Qdpu4UaRmjwlHFygknBmHtq0jV3+PHw2q0awcOd1
	74YDzPllfB6gFJ5p1YMwOpJ2MDLRNrEo=
X-Gm-Gg: AZuq6aIPJZYiSBNKvypA6nAQdiDQVhcrzcZh6vK9vXPtt+krK9V0YtBg+XhnRtU7nqT
	U1UPyP6bol0I7U6m023cOCse5M2CyDKXuj4Up3BoZa6fU9Kfy4kqRjVVffhatRnah6zn8FUQXVl
	pcWjspCVaMKXXjW4srexZFmTcyP08LcFJ9tB/vDTtca/stXkm4S7Ho83DDP1Sj00rD0O+yvwvSm
	IdbMEB/lIMu5YE9i1Lx2sg4PeEY0rAtueb8BI8wx0DrnPp8uMLBwAPNM4BA1LAdoedjUF2aF+Qz
	1SDcRg==
X-Received: by 2002:ac8:5fc3:0:b0:501:4a4a:c24a with SMTP id
 d75a77b69052e-506b3f7db1fmr13486811cf.13.1771020257987; Fri, 13 Feb 2026
 14:04:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210002852.1394504-1-joannelkoong@gmail.com>
 <20260210002852.1394504-4-joannelkoong@gmail.com> <89c75fc1-2def-4681-a790-78b12b45478a@gmail.com>
 <aYykILfX_u9-feH-@infradead.org> <bd488a4e-a856-4fa5-b2bb-427280e6a053@gmail.com>
 <aY7QX-BIW-SMJ3h_@infradead.org> <34cf24a3-f7f3-46ed-96be-bf716b2db060@gmail.com>
In-Reply-To: <34cf24a3-f7f3-46ed-96be-bf716b2db060@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 13 Feb 2026 14:04:06 -0800
X-Gm-Features: AZwV_QjThxaD8sVCwmbCVOqtIgzU0nkxJVAh4dZ7_BVtSiwr6yitbg8e-HZnYJw
Message-ID: <CAJnrk1a+YuPpoLghA01uJhEKrhmrLhQ+5bw2OeeuLG3tG8p6Ew@mail.gmail.com>
Subject: Re: [PATCH v1 03/11] io_uring/kbuf: add support for kernel-managed
 buffer rings
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk, io-uring@vger.kernel.org, 
	csander@purestorage.com, krisman@suse.de, bernd@bsbernd.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77184-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95FBF139B52
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 4:41=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 2/13/26 07:18, Christoph Hellwig wrote:
> > On Thu, Feb 12, 2026 at 10:44:44AM +0000, Pavel Begunkov wrote:
> >>>
> > Can you clarify what you mean with 'pbuf'?  The only fixed buffer API I
> > know is io_uring_register_buffers* which always takes user provided
> > buffers, so I have a hard time parsing what you're saying there.  But
> > that might just be sign that I'm no expert in io_uring APIs, and that
> > web searches have degraded to the point of not being very useful
> > anymore.
>
> Registered, aka fixed, buffers are the ones you pass to
> IORING_OP_[READ,WRITE]_FIXED and some other requests. It's normally
> created by io_uring_register_buffers*() / IORING_REGISTER_BUFFERS*
> with user memory, but there are special cases when it's installed
> internally by other kernel components, e.g. ublk.
> This series has nothing to do with them, and relevant parts of
> the discussion here don't mention them either.
>
> Provided buffer rings, a.k.a pbuf rings, IORING_REGISTER_PBUF_RING
> is a kernel-user shared ring. The entries are user buffers
> {uaddr, size}. The user space adds entries, the kernel (io_uring
> requests) consumes them and issues I/O using the user addresses.
> E.g. you can issue a IORING_OP_RECV request (+IOSQE_BUFFER_SELECT)
> and it'll grab a buffer from the ring instead of using sqe->addr.
>
> pbuf rings, IORING_REGISTER_MEM_REGION, completion/submission
> queues and all other kernel-user rings/etc. are internally based
> on so called regions. All of them support both user allocated
> memory and kernel allocations + mmap.
>
> This series essentially creates provided buffer rings, where
> 1. the ring now contains kernel addresses
> 2. the ring itself is in-kernel only and not shared with user space
> 3. it also allocates kernel buffers (as a region), populates the ring
>     with them, and allows mapping the buffers into the user space.

The most important part and the whole reason fuse needs the buffer
ring to be kernel-managed is because the kernel needs to control when
buffers get recycled back into the ring. For fuse's use case, the
buffer is used for passing data between the kernel and the server. We
can't have the server recycle the buffer because the server writes
back data to the kernel in that buffer when it submits the sqe. After
fuse receives the sqe and reads the reply from the server, it then
needs to recycle that buffer back into the ring so it can be reused
for a future cqe (eg sending a future request).

>
> Fuse is doing both adding (kernel) buffers to the ring and consuming
> them. At which point it's not clear:
>
> 1. Why it even needs io_uring provided buffer rings, it can be all
>     contained in fuse. Maybe it's trying to reuse pbuf ring code as
>     basically an internal memory allocator, but then why expose buffer
>     rings as an io_uring uapi instead of keeping it internally.
>
>     That's also why I mentioned whether those buffers are supposed to
>     be used with other types of io_uring requests like recv, etc.

On the userspace/server side, it uses the buffers for other io-uring
operations (eg reading or writing the contents from/to a
locally-backed file).

>
> 2. Why making io_uring to allocate payload memory. The answer to which
>     is probably to reuse the region api with mmap and so on. And why
>     payload buffers are inseparably created together with the ring

My main motivation for this is simplicity. I see (and thanks for
explaining) that using a registered mem region allows the use of some
optimizations (the only one I know of right now is the PMD one you
mentioned but maybe there's more I'm missing) that could be useful for
some workloads, but I don't think (and this could just be my lack of
understanding of what more optimizations there are) most use cases of
kmbufs benefit from those optimizations, so to me it feels like we're
adding non-trivial complexity for no noticeable benefit.

I feel like we get the best of both worlds by letting users have both:
the simple kernel-managed pbuf where the kernel allocates the buffers
and the buffers are tied to the lifecycle of the ring, and the more
advanced kernel-managed pbuf where buffers are tied to a registered
memory region that the subsystem is responsible for later populating
the ring with.

>     and via a new io_uring uapi.

imo it felt cleaner to have a new uapi for it because kmbufs and pbufs
have different expectations and behaviors (eg pbufs only work with
user-provided buffers and requires userspace to populate the ring
before using it, whereas for kmbufs the kernel allocates the buffers
and populates it for you; pbufs require userspace to recycle back the
buffer, whereas for kmbufs the kernel is the one in control of
recycling) and from the user pov it seemed confusing to have kmbufs as
part of the pbuf ring uapi, instead of separating it out as a
different type of ringbuffer with a different expectation and
behavior. I was trying to make the point that combining the interface
if we go with IORING_MEM_REGION gets even more confusing because now
pbufs that are kernel-managed are also empty at initialization and
only can point to areas inside a registered mem region and the
responsibility of populating it is now on whatever subsystem is using
it.

I still have this opinion but I also think in general, you likely know
better than I do what kind of io-uring uapi is best for io-uring's
users. For v2 I'll have kmbufs go through the pbuf uapi.

>
>     And yes, I believe in the current form it's inflexible, it requires
>     a new io_uring uapi. It requires the number of buffers to match
>     the number of ring entries, which are related but not the same

I'm not really seeing what the purpose of having a ring entry with no
buffer associated with it is. In the existing code for non-kernel
managed pbuf rings, there's the same tie between reg->ring_entries
being used as the marker for how many buffers the ring supports. But
if the number of buffers should be different than the number of ring
entries, this can be easily fixed by passing in the number of buffers
from the uapi for kernel-managed pbuf rings.

>     thing. You can't easily add more memory as it's bound to the ring
>     object. The buffer memory won't even have same lifetime as the

To play devil's advocate, we also can't easily add more memory to the
mem region once it's been registered. I think there's also a worse
penalty where the user needs to know upfront how much memory to
allocate for the mem region for the lifetime of the ring, which imo
may be hard to do (eg if a kernel-managed buf ring only needs to be
registered for some code paths and not others, the mem region
registration would still have to allocate the memory a potential kbuf
ring would use).

>     ring object -- allow using that km buffer ring with recv requests
>     and highly likely I'll most likely give you a way to crash the
>     kernel.

I'm a bit confused by this part. The buffer memory does have the same
lifetime as the ring object, no? The buffers only get freed when the
ring itself is freed.

>
> But hey, I'm tired. I don't have any beef here and am only trying
> to make it a bit cleaner and flexible for fuse in the first place
> without even questioning the I/O path. If everyone believes

I appreciate you looking at this and giving your feedback and insight.
Thank you for doing so. I don't want to merge in something you're
unhappy with.

Are you open to having support for both a simple kernel-managed pbuf
interface and later on if/when the need arises, a kernel-managed pbuf
interface that goes through a registered memory region? If the answer
is no, then I'll make the change to have kmbufs go through the
registered memory region.

Thanks,
Joanne

> everything is right, just ask Jens to merge it.
>
> --
> Pavel Begunkov
>

