Return-Path: <linux-fsdevel+bounces-78665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJWxCZ7voGmOoAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 02:13:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC611B16CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 02:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B4A630209A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 01:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD5F2BE7A7;
	Fri, 27 Feb 2026 01:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UurKEzms"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CF929D281
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 01:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772154735; cv=pass; b=nVMj+XbB398VQ+dQMcMtwkWZHsWp6lI/LzT8HiA/3k7OmobjeVfoSSo8LCKC6SO2aAlYnlmwtZo2IQp3os+a+UoI+SdQFGXz5oMOkQOB7uV7DUCH92lqcLvrTQfb8cfGVThE7KkfhstQmVwow9btsJOQXIxKZeaYY/nkPiCjBW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772154735; c=relaxed/simple;
	bh=6CYr7T8MzEUaXZzV6MRHPlZaEtYnuPxqMiOyyADI6dM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIGHWVz1kkWWe0CfldZ+q+e+akU+cMPv+FDcn+2ncYtI/mzBhyo47V01e2+u2FKAXiDFR5uPAf+vaOKCKogTcbww4DoZv32g6LjcT9vblzo24IZ4v4YxxWtNSTf6vMF/hHuXsd+rrUAm6pM/xRng2vJ7UStxmkZS8PsOmDuSAQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UurKEzms; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50697d6a69cso8351951cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 17:12:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772154733; cv=none;
        d=google.com; s=arc-20240605;
        b=Yr1jWJrYXJvfgwhn/TavgOzTzz2P1agxv+6q1p/Kv03b9F0ik7uRvWVQ78/ZE7X9Gt
         IpTC6vSK5h6ow/FwovAiavWGZFc/PWCEcb4hOXg/sOcpgmxZPc3veewhA2227BY1zDvV
         rm6IyKnW79komK2hdkLjSKlHBjmyS7zHAoU4t9Qg01/zzGIV7GsEmmJb53lbwC4+f/cd
         EqcbSRsfsZ3IdQ9APHWelOvkmacycKZzOquyR0RjNS2zEf+RAtwrT1BzgCjGnuZmMgzZ
         N/a+XryWkwm5Rm38XA/2qzU4v3M1SGGKGmsa2t/BuzIctxmAAL5HHd+H7iiWPN2RXzLT
         Ue9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WOstYkB9Q2AgMJRvNGEc6lIdl5QiR5DuIxP/4gEsFp0=;
        fh=Qy3xSpr0/JEGaS+2uGDKxNMV4xwXEHCxX8Sk065Yyh0=;
        b=Y7khgkqfM/iR67EompLa0vfOoyAZ3ZyeGblOj///PT3sZC6CpVFsA1uP4U1GtnYV/Q
         psJrGE0d2GttfOzcer2/uJdS6XQNqKkb/yA0u15tbwUg3BUOJGOSgZNmCVJo0RXuurKy
         24JRMvY4+hmBAGK8avZK0yb4iVhU2l/eOO9tOiqckWzx1UJhHEP4qRl87Zh6wFXkgF53
         s4DWZC/XwLpwbAvydKTrWywPY8zkhOfz2slwdsnovIbnhgQUzF/gZUWON50FiBJ9vOES
         O9rjsf1ShDVJHpQ/zcb3rsInm7zw9SwxCY9F5MSGk0WsKdQNz+yfv9I3GkJEFQy1Tgr0
         qKog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772154733; x=1772759533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOstYkB9Q2AgMJRvNGEc6lIdl5QiR5DuIxP/4gEsFp0=;
        b=UurKEzmsgJeRXMlucn40YNFFMyP39nvr2Ofa2EIitZzd4boxPsPPLG93zKI1O+rgi/
         yjb/V8uJsOs2b4+gq+tVexyyXdGA82ZFkFfvX1jdbJ8h1C9LTYpbhXqQh6537nemDLoc
         s+uKWMyNSeNVzJBA3/MtE7ZH7EFjC7Wd0+pCYuK4bUHhBp+C7PVcZkVZGXGsAaSX5h1c
         +WobxnYxDIBgl9ytO4ItalZvtvGgP2kk8QIp03JVnrB8Wh45ugfLTr1Hrd/+9K3y4nmM
         L8ghPdFWE1RqwWNviLlXx+vLt3/OXiDZaYbCYqMXzmwu1+cHZpGSHCGDbk/XiuvfYDXY
         Yv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772154733; x=1772759533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WOstYkB9Q2AgMJRvNGEc6lIdl5QiR5DuIxP/4gEsFp0=;
        b=SRmgdQeEyBBt+J4XPLP9dDKbJKrFLKgbfH0+xg0XJm+XreRLCwwgsH6ptPWJC8nsTQ
         nI2MtsRnS1FTl3KpS89LUGx7wwmV+xhauk+dXE/Ub+kQ++LG8872sjdBuV6AQeORlSp3
         9mQvWFgGKwEMFFj1MLs+st3syOi7ORCrPifWgV0z4kXr+bcE7SM7yYF/ATUbIHKsIR0a
         Kzq/ZDEYKabYq46B/vpfGMC+zGgYWhz1oaNpo9FgTRkvaKIZCWJXg2IRIMcyPz7Hd1iT
         CiGWXoYWREarl+0ZhUtY6jRKtplRw+CBj+Y/elOZ1184VIMrENtT97oVpzTyxQg1iBfF
         O7mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyqnNGp7bQfW+oMcCpheiKJPwex/hnZ76O4lboYbuMYmk/hiEMXjFgoe165EPy8XQ+fpJ+OSasEZ3L6wzO@vger.kernel.org
X-Gm-Message-State: AOJu0YweG579gjhB4MVaFdgNz5nXPjrcGLwFcjQJGiorxEl2hj+wMcud
	F1rZFAne1XbCekphhEMjh8NBqBU8sbGSE5jeUqMVQaT76ffibWrxAetl28xLRemnR8Y3JxpD3lA
	yz/8VPZNNCZ91067gZlc+3xxN0ZdSVXQEroILiEs=
X-Gm-Gg: ATEYQzx9RtrRDF/FDA5UocaMoBUwYCfWpa3b9rjmznpnK7aSQqtDw1T0VSAANyCLoLI
	Ds/a+4TcoCncR98WsUbpYCMNKQjuvxLzD7XpLOf/EOkI3AhiQOgkvbeHXK9aOEPwx8mEvC72O+Z
	ZSYm4EEXIX7mqb04rx7d8XbhHXFQfE2n/wH103Y3XmgRqKmBAjxBfmDk5re8vDDdwQfBIq1BYkz
	cSBjFPB8qtAOj8Mk6tmtEPH4aq3x8qFobNAGjZXoMMKPqtUxmcpOE+MAfr4ynG6bWz5d9wcZswI
	hlsBmA==
X-Received: by 2002:ac8:5a81:0:b0:4ed:6dde:4573 with SMTP id
 d75a77b69052e-507529a8606mr12840511cf.52.1772154733110; Thu, 26 Feb 2026
 17:12:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210002852.1394504-1-joannelkoong@gmail.com>
 <20260210002852.1394504-4-joannelkoong@gmail.com> <89c75fc1-2def-4681-a790-78b12b45478a@gmail.com>
 <CAJnrk1ZZyYmwtzcHAnv2x8rt=ZVsz7CXCVV6jtgMMDZytyxp3A@mail.gmail.com>
 <1c657f67-0862-4e13-9c71-7217aeecef61@gmail.com> <CAJnrk1YXmxqUnT561-J7seaicxFRJTyJ=F3_MX1rmtAROC6Ybg@mail.gmail.com>
In-Reply-To: <CAJnrk1YXmxqUnT561-J7seaicxFRJTyJ=F3_MX1rmtAROC6Ybg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 26 Feb 2026 17:12:01 -0800
X-Gm-Features: AaiRm51DUGU78O75qpvj-Q89bRyh_-LRasIvedVgKFuTGIZjmW0a7g5kcb4_4eY
Message-ID: <CAJnrk1YoaHnCmuwQra0XwOxf0aC_PQGby-DT1y_p=YRzotiE-w@mail.gmail.com>
Subject: Re: [PATCH v1 03/11] io_uring/kbuf: add support for kernel-managed
 buffer rings
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: axboe@kernel.dk, io-uring@vger.kernel.org, csander@purestorage.com, 
	krisman@suse.de, bernd@bsbernd.com, hch@infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78665-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6EC611B16CF
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 2:06=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Wed, Feb 11, 2026 at 4:01=E2=80=AFAM Pavel Begunkov <asml.silence@gmai=
l.com> wrote:
> >
> > On 2/10/26 19:39, Joanne Koong wrote:
> > > On Tue, Feb 10, 2026 at 8:34=E2=80=AFAM Pavel Begunkov <asml.silence@=
gmail.com> wrote:
> > >
> > >>> diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
> > >>> index aa9b70b72db4..9bc36451d083 100644
> > >>> --- a/io_uring/kbuf.c
> > >>> +++ b/io_uring/kbuf.c
> > >> ...
> > >>> +static int io_setup_kmbuf_ring(struct io_ring_ctx *ctx,
> > >>> +                            struct io_buffer_list *bl,
> > >>> +                            struct io_uring_buf_reg *reg)
> > >>> +{
> > >>> +     struct io_uring_buf_ring *ring;
> > >>> +     unsigned long ring_size;
> > >>> +     void *buf_region;
> > >>> +     unsigned int i;
> > >>> +     int ret;
> > >>> +
> > >>> +     /* allocate pages for the ring structure */
> > >>> +     ring_size =3D flex_array_size(ring, bufs, bl->nr_entries);
> > >>> +     ring =3D kzalloc(ring_size, GFP_KERNEL_ACCOUNT);
> > >>> +     if (!ring)
> > >>> +             return -ENOMEM;
> > >>> +
> > >>> +     ret =3D io_create_region_multi_buf(ctx, &bl->region, bl->nr_e=
ntries,
> > >>> +                                      reg->buf_size);
> > >>
> > >> Please use io_create_region(), the new function does nothing new
> > >> and only violates abstractions.
> > >
> > > There's separate checks needed between io_create_region() and
> > > io_create_region_multi_buf() (eg IORING_MEM_REGION_TYPE_USER flag
> >
> > If io_create_region() is too strict, let's discuss that in
> > examples if there are any, but it's likely not a good idea changing
> > that. If it's too lax, filter arguments in the caller. IOW, don't
> > pass IORING_MEM_REGION_TYPE_USER if it's not used.
> >
> > > checking) and different allocation calls (eg
> > > io_region_allocate_pages() vs io_region_allocate_pages_multi_buf()).
> >
> > I saw that and saying that all memmap.c changes can get dropped.
> > You're using it as one big virtually contig kernel memory range then
> > chunked into buffers, and that's pretty much what you're getting with
> > normal io_create_region(). I get that you only need it to be
> > contiguous within a single buffer, but that's not what you're doing,
> > and it'll be only worse than default io_create_region() e.g.
> > effectively disabling any usefulness of io_mem_alloc_compound(),
> > and ultimately you don't need to care.
>
> When I originally implemented it, I had it use
> io_region_allocate_pages() but this fails because it's allocating way
> too much memory at once. For fuse's use case, each buffer is usually
> at least 1 MB if not more. Allocating the memory one buffer a time in
> io_region_allocate_pages_multi_buf() bypasses the allocation errors I
> was seeing. That's the main reason I don't think this can just use
> io_create_region().
>
> >
> > Regions shouldn't know anything about your buffers, how it's
> > subdivided after, etc.
> >

I still think the memory for the buffers should be tied to the ring
itself and allocated physically contiguously per buffer. Per-buffer
contiguity will enable the most efficient DMA path for servers to send
read/write data to local storage or the network. If the buffers for
the bufring have to be allocated as one single memory region, the
io_mem_alloc_compound() call will fail for this large allocation size.
Even if io_mem_alloc_compound() did succeed, this is a waste as the
buffer pool as an entity doesn't need to be physically contiguous,
just the individual buffers themselves. For fuse, the server
configures what buffer pool size it wants to use, depending on what
queue depth and max request size it needs. So for most use cases, at
least for high-performance servers, allocation will have to fall back
to alloc_pages_bulk_node(), which doesn't allocate contiguously. You
mentioned in an earlier comment that this "only violates abstractions"
- which abstractions does this break? The pre-existing behavior
already defaults to allocating pages non-contiguously if the mem
region can't be allocated fully contiguously.

Going through registered buffers doesn't help either. Fuse servers can
be unprivileged and it's not guaranteed that there are enough huge
pages reserved or that another process hasn't taken them or that the
server has privileges to pre-reserve pages for the allocation. Also
the 2 MB granularity is inflexible while 1 GB is too much.

I'm not really seeing a way where we can honor the physical contiguity
requirements for the buffers without going through kernel-managed
bufrings with the allocation done on a per-buffer basis. Or am I
missing something here?

Thanks,
Joanne

