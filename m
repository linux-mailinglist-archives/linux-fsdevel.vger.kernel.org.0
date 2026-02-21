Return-Path: <linux-fsdevel+bounces-77843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCo6JbwVmWl5QQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 03:17:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC7316BE9D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 03:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A933305443C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 02:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0D2325484;
	Sat, 21 Feb 2026 02:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQpQorUJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1A632573F
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Feb 2026 02:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771640082; cv=pass; b=WEmfhg+xq8d8J4kjxVhSE8yWfaE8iJAf7F9FPbaGg8J+OS8Qut5rDV1JNJytC5ioEJtEGEv1EUSobSNnAWue8Uv3RXefCPQmQiysbs/dzZDqYko2UGyFL30zDH83RpMcnRUP3Nmk9TmRIqUJyd+uN9MSp4onwaJCO3VGSh2SfWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771640082; c=relaxed/simple;
	bh=YUbqqln8//CvvsJa1IdFylkHcvzhQ1mGu/okOx8vkcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Luiymvg2JO/lCB94M748UFGipCvNeI9cLimxu+v1HUFmHA4n9X3Cp6akn+jYBkkV6mIQ7j3MXZe8dxcW9VWJskKpA56KhZlBNjioiJj2SiiSTiAMrIdZcNkbxUKxvDPL/WsJCFt3QOWdRBhajIWuzeDH4lA4eFcvJwJpmdNQXH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQpQorUJ; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-895071c5527so30695166d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 18:14:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771640080; cv=none;
        d=google.com; s=arc-20240605;
        b=T1p2NdDcQKbpxNPlKXECPwIl/h8Un100CHIxE+1iX/uwNVmP1qWoGxAaAQG3bzz8xS
         hvUyM1r1H3j4XMny/1TAGVdbb8CQ280Sjw1LW1AXz4mGvrkhs9wc02wkWbgbjK++p7bJ
         rspMPfd9GgIwdd2D5/P6RKZKJPZ3ltDnh6TDAhfLYC9B5xlEYv5zAkZ/QR/n2IIdR7Px
         WpV13WIe6501XxaoGkW5HMRHDU18xpzTO1zNUMq5Nrzdkh1YvF2fyZPxnuZG40v0x3tt
         sUaqFlueKw/kHmwmn/ro97B+6Z7WO7Uj9y2M6kn8SgyfB3Vn5ShnnrU+XHYHpHxBoJWU
         Ix8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9CiMghMiYAW/meQEjcc7d1HgHj4IopVxU1rguFyRTFw=;
        fh=bPw3kmTxh3eAq8UXenC+g7B/wtU14d8CFnqA6ilIiT4=;
        b=ef6UvrwubcgpMDwIz6sJrxAjoCTfzZOrnso6z2EvscTWgCX6RkGVTpMk7XCqlxhylv
         7BHOrPh9lUGp2aI2WSQGJz+YldSKju3x5S2K+vHywX/YuM9fHUvwIycNVyRbE+YzO2Xd
         IsPoWmNhUTr2kLCDPq7nmvwM2Xc3SgRdOJN8+0RE6XqKe3APaz0CTKu3cSr5xx02EBV9
         uPmsMHr/jl1mFStMrSLuFEDJcPPzRt8XlK8dR8oSiYWpy1bPRDNkpD7BdcQytAxUVCpy
         zCkI7C2VvqW0aVl4grXXefYDxZSZ4YFDYVfPNANAe7I14q1xXjq28xQ4WKh4Ha0Bwgfo
         feBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771640080; x=1772244880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CiMghMiYAW/meQEjcc7d1HgHj4IopVxU1rguFyRTFw=;
        b=NQpQorUJOu7dGFr7uv2OF6m0kreRydt0kfZI2Ij6ULDH6vLheFJulk9qoxf3m2q6aw
         ubjBQaVJ841ZHC2oE/Mnp0EaCvNElZVkwQhN2fjwVJp/Zw5QJRMxj5ynFRWQp0ZUFFNy
         WqM9lVCOTAQnQIH5tka7FVxt4QxIIUmK5agt+hdzmnb8/+w32pHx13lbqmUDZVJA9M3R
         aFnIhN53mIXpIxcfPwNz1S0z8Q8lb1xiaCwNKlNiiMUeSUgKXn++BHmo1r4KdiLrw8Nl
         yU0YG59ujsxavfbgYwL4TWJ2sPLQSf//YF2KjauZ8CWF+hxF8NwvEvA6s/KTL+bpLwTd
         hNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771640080; x=1772244880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9CiMghMiYAW/meQEjcc7d1HgHj4IopVxU1rguFyRTFw=;
        b=noTKJW5tQTuWm1pt/98pstpO0YM+Ajx0eSMoWlSbq4t/eczfl63aUMQnAtfcnYsm4t
         yoT2IqIFi7umGvyvY9V7CKc5Bg8jIq70Brzw6ORR09Qvv0IYQTYZOM4Trs3U1X3wPaQ1
         sEzvTvK4gJIVKtpYMfdndX73rDKNjxQSGzeNGNHOzYshk15AXEMRfnshVM++BKEDTN44
         RuollrYVBiMcHUbW7icdsdN7lDu1KfaoEpkiPGAxsRzvxKSYw2yi0MfgTAxjPLAMy8jl
         HQmPaZruo2ikjKtsrr1pjELi7/uSs7/rYnx/AvvHj4vqi7unWuLgZnR9HDWQz+EEmZTH
         +6Cw==
X-Forwarded-Encrypted: i=1; AJvYcCU/pu5UqYi9FzGNyBDNh6tmAvklSZAs9yZlm6nPTCWFqiDQhZevDwTY8quSW5mNJ2NFcHURpYf66SU9DRjO@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0cAUHEpgHuxcC081PCcoXDY+YgOxS/xQ5JW0NTWys++zHvG+W
	nWE1o1I51hg1XXj/Q9LMrmbLcKRmvRJ9jzrcx+k2+FwZKF87KaBG908Wvei+v4UAr1GYnVN2NIC
	ha535nGZQzpQwXsQKeHcJ8SBGULJFzdQ=
X-Gm-Gg: AZuq6aKXpOTLBuUXssqtPyGf3h/ILlu4WwEYAYBtpO4Wq8Dw2hiZpOTdUJHWbYPS9XD
	NDy8njH29pceOKZP9sE5ApTNjTUoBPx9l7+TxfQZ24SVB2oJ4Z7LreddFgJ1g/ePEpt9Gr8cPAE
	f5oA9XNMK+M1jksLDdVQe8v6g0LsYIZ8mI14zKGqDeBnrJwndOi/9hHabvC7L1sFJu4z+ypgmTa
	h81PDueiL6MmobaNP8yOfcIDKKaa9A9Gs4VkJ1tFj0TazjjcbUZzUAzUtscvB4NFwgCe+zUYv5G
	LTioTw==
X-Received: by 2002:a05:6214:2aab:b0:897:255:d5c2 with SMTP id
 6a1803df08f44-89979c947bdmr33288776d6.26.1771640079580; Fri, 20 Feb 2026
 18:14:39 -0800 (PST)
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
 <CAJnrk1a+YuPpoLghA01uJhEKrhmrLhQ+5bw2OeeuLG3tG8p6Ew@mail.gmail.com>
 <7a62c5a9-1ac2-4cc2-a22f-e5b0c52dabea@gmail.com> <CAJnrk1Y5iTOhj4_RbnR7RJPkr7fFcCdh1gY=3Hm72M91D-SnyQ@mail.gmail.com>
 <11869d3d-1c40-4d49-a6c2-607fd621bf91@gmail.com>
In-Reply-To: <11869d3d-1c40-4d49-a6c2-607fd621bf91@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 20 Feb 2026 18:14:28 -0800
X-Gm-Features: AaiRm51YaYJ-GFbPiFG5mJIRVp4u0pWP_kk2d6oLPXn7AUINQAKAcjYepaBfqSg
Message-ID: <CAJnrk1Zr=9RMGpNXpe6=fSDkG2uVijB9qa1vENHpQozB3iPQtg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77843-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2FC7316BE9D
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 4:53=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 2/18/26 21:43, Joanne Koong wrote:
> > On Wed, Feb 18, 2026 at 4:36=E2=80=AFAM Pavel Begunkov <asml.silence@gm=
ail.com> wrote:
> >>
> >> On 2/13/26 22:04, Joanne Koong wrote:
> >>> On Fri, Feb 13, 2026 at 4:41=E2=80=AFAM Pavel Begunkov <asml.silence@=
gmail.com> wrote:
> >> ...
> >>>> Fuse is doing both adding (kernel) buffers to the ring and consuming
> >>>> them. At which point it's not clear:
> >>>>
> >>>> 1. Why it even needs io_uring provided buffer rings, it can be all
> >>>>       contained in fuse. Maybe it's trying to reuse pbuf ring code a=
s
> >>>>       basically an internal memory allocator, but then why expose bu=
ffer
> >>>>       rings as an io_uring uapi instead of keeping it internally.
> >>>>
> >>>>       That's also why I mentioned whether those buffers are supposed=
 to
> >>>>       be used with other types of io_uring requests like recv, etc.
> >>>
> >>> On the userspace/server side, it uses the buffers for other io-uring
> >>> operations (eg reading or writing the contents from/to a
> >>> locally-backed file).
> >>
> >
> > Sorry, I submitted v2 last night thinking the conversation on this
> > thread had died. After reading through your reply, I'll modify v2.
>
> No worries at all, and sorry I'm a bit slow to reply
>
> >> Oops, typo. I was asking whether the buffer rings (not buffers) are
> >> supposed to be used with other requests. E.g. submitting a
> >> IORING_OP_RECV with IOSQE_BUFFER_SELECT set and the bgid specifying
> >> your kernel-managed buffer ring.
> >
> > Yes the buffer rings are intended to be used with other io-uring
> > requests. The ideal scenario is that the user can then do the
> > equivalent of IORING_OP_READ/WRITE_FIXED operations on the
> > kernel-managed buffers and avoid the per-i/o page pinning overhead
> > costs.
>
> You mention OP_READ_FIXED and below agreed not exposing km rings
> an io_uring uapi, which makes me believe we're still talking about
> different things.
>
> Correct me if I'm wrong. Currently, only fuse cmds use the buffer
> ring itself, I'm not talking about buffer, i.e. fuse cmds consume
> entries from the ring (!!! that's the part I'm interested in), then
> process them and tell the server "this offset in the region has user
> data to process or should be populated with data".
>
> Naturally, the server should be able to use the buffers to issue
> some I/O and process it in other ways, whether it's a normal
> OP_READ to which you pass the user space address (you can since
> it's mmap()'ed by the server) or something else is important but
> a separate question than the one I'm trying to understand.
>
> So I'm asking whether you expect that a server or other user space
> program should be able to issue a READ_OP_RECV, READ_OP_READ or any
> other similar request, which would consume buffers/entries from the
> km ring without any fuse kernel code involved? Do you have some
> use case for that in mind?

Thanks for clarifying your question. Yes, this would be a useful
optimization in the future for fuse servers with certain workload
characteristics (eg network-backed servers with high concurrency and
unpredictable latencies). I don't think the concept of kmbufrings is
exclusively fuse-specific though (for example, Christoph's use case
being a recent instance); I think other subsystems/users that'll use
kmbuf rings would also generically find it useful to have the option
of READ_OP_RECV/READ_OP_READ operating directly on the ring.

>
> Understanding that is the key in deciding whether km rings should
> be exposed as io_uring uapi or not, regardless of where buffers
> to populate the ring come from.
>
> ...
> > With it going through a mem region, I don't think it should even go
> > through the "pbuf ring" interface then if it's not going to specify
> > the number of entries and buffer sizes upfront, if support is added
> > for io-uring normal requests (eg IORING_OP_READ/WRITE) to use the
> > backing pages from a memory region and if we're able to guarantee that
> > the registered memory region will never be able to be unregistered by
> > the user. I think if we repurpose the
> >
> > union {
> >    __u64 addr; /* pointer to buffer or iovecs */
> >    __u64 splice_off_in;
> > };
> >
> > fields in the struct io_uring_sqe to
> >
> > union {
> >    __u64 addr; /* pointer to buffer or iovecs */
> >    __u64 splice_off_in;
> >    __u64 offset; /* offset into registered mem region */
> > };
> >
> > and add some IOSQE_ flag to indicate it should find the pages from the
> > registered mem region, then that should work for normal requests.
> > Where on the kernel side, it looks up the associated pages stored in
> > the io_mapped_region's pages array for the offset passed in.
>
> So you already can do all that using the mmap()'ed region user
> pointer, and you just want it to be more efficient, right?
> For that let's just reuse registered buffers, we don't need a
> new mechanism that needs to be propagated to all request types.
> And registered buffer are already optimised for I/O in a bunch
> of ways. And as a bonus, it'll be similar to the zero-copy
> internally registered buffers if you still plan to add them.
>
> The simplest way to do that is to create a registered buffer out
> of the mmap'ed region pointer. Pseudo code:
>
> // mmap'ed if it's kernel allocated.
> {region_ptr, region_size} =3D create_region();
>
> struct iovec iov;
> iov.iov_base =3D region_ptr;
> iov.iov_len =3D region_size;
> io_uring_register_buffers(ring, &iov, 1);
>
> // later instead of this:
> ptr =3D region_ptr + off;
> io_uring_prep_read(sqe, fd, ptr, ...);
>
> // you use registered buffers as usual:
> io_uring_prep_read_fixed(sqe, fd, off, regbuf_idx, ...);
>

I feel like this design makes the interface more convoluted and now
muddies different concepts together by adding new complexity /
relationships between them whereas they were otherwise cleanly
isolated. Maybe I'm just not seeing/understanding the overarching
vision for why conceptually it makes sense for them to be tied
together besides as a mechanism to tell io-uring requests where to
copy from by reusing what exists for fixed buffer ids. There's more
complexity now on the kernel side (eg having to detect if the buffer
passed in is kernel-allocated to know whether to pin the pages /
charge it against the user's RLIMIT_MEMLOCK limit) but I'm not
understanding what we gain from it. I got the sense from your previous
comments that memory regions are the de facto way to go and should be
decoupled from other structures, so if that's the case, why doesn't it
make sense for io-uring to add native support for using memory regions
for io-uring requests? I feel like from the userspace side it makes
things more confusing with this extra layer of indirection that now
has to go through a fixed buffer.

>
> IIRC the registration would fail because it doesn't allow file
> backed pages, but it should be fine if we know it's io_uring
> region memory, so that would need to be patched.
>
> There might be a bunch of other ways you can do that like
> create a kernel allocated registered buffer like what Cristoph
> wants, and then register it as a region. Or allow creating
> registered buffers out of a region. etc.
>
> I wanted to unify registered buffers and regions internally
> at some point, but then drifted away from active io_uring core
> infrastructure development, so I guess that could've been useful.
>
> > Right now there's only a uapi to register a memory region and none to
> > unregister one. Is it guaranteed that io-uring will never add
> > something in the future that will let userspace unregister the memory
> > region or at least unregister it while it's being used (eg if we add
> > future refcounting to it to track active uses of it)?
>
> Let's talk about it when it's needed or something changes, but if
> you do registered buffers instead as per above, they'll be holding
> page references and or have to pin the region in some other way.

I don't think we can guarantee that the caller will register the
memory region as a fixed buffer (eg if it doesn't need/want to use the
buffer for normal io-uring requests). On the kernel side, the internal
buffer entry uses the kaddr of the registered memory region buffer for
any memcpys. If it's not guaranteed that registered memory regions
persist for the lifetime of the ring, there'll have to be extra
overhead for every I/O (eg grab the io-uring lock, checking if the mem
region is still registered, grab a refcount to that mem region, unlock
the ring, do the memcpy to the kaddr, then grab the io-uring lock
again, decrement the refcount, and unlock). Or I guess we could add
pinning to a registered memory region.

Thanks,
Joanne
>
> > If so, then end-to-end, with it going through the mem region, it would
> > be something like:
> > * user creates a mem region for the io-uring
> > * user mmaps the mem region
>
> FWIW, we should just add a liburing helper, so that fuse server
> doesn't need to deal with mmap'ing.
>
> > * user passes in offset into region, length of each buffer, and number
> > of entries in the ring to the subsystem
> > * subsystem creates a locally managed bufring and adds buffers to that
> > ring from the mem region
>
> That's sounds clean to me _if_ it allows you to achieve all
> (fast path) optimisations you want to have. I hope it does?
>
> --
> Pavel Begunkov
>

