Return-Path: <linux-fsdevel+bounces-77036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ+kAQ8OjmmS+wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 18:29:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A579912FEAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 18:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17E263011144
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 17:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF9B134AB;
	Thu, 12 Feb 2026 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQaPPedn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97E524503C
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917385; cv=pass; b=jC1nIj/S/cJJEcB1qEya1O5B22diZ6LC1rhPnZkgv1qq/q9leCcubr/VV9c0F0/p66Q1JyVV4Gp5Tga05ADjAL/ZXAc8ZzlMT48EcOPr3kW091JdkdLCqeL4uRLrZOY+cqDMWpPYR3FSu1JJh8pCDjUisd9MEbIYoEhYkzw3EnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917385; c=relaxed/simple;
	bh=1EByc7pPcUDpjYuGji62SyQGdnhfUhO6Z5xF3S7UI6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdVQc/FUI9yY/bIFe7+DNCaWjEzfR2ERWg07Qca31cWQG9SghPgqihb5CvIWL9mTkaUsvlBF7C1jSezPnE9fyzdC7RyW0JkGwKJhyZzmOkWqLMHEn3EWsCXpJZL7d8J/lthvfuFuSCVGWmg9qGkfEeyC1NJcLE+okjV5UROLckQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQaPPedn; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506362ac5f7so819211cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 09:29:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770917383; cv=none;
        d=google.com; s=arc-20240605;
        b=WRT4Wg8MTdCVMRKKsKvQFeC5Ffgjxi1o8mtTY/GL5yLL9lDLki2dNbREobQsathP12
         dReyW5b442e021LFSqbfukrovXFu+BrHup8EO6lJw59+9UkDv7ew1rlpS556807xHXsq
         BGBmc0FmKrC9vSpp1e0ShBK2jm5wGgOYEspPT+Fc821ubL9yTFUSpIVsV1dGpTQCE3iF
         GABRM5csXrzuf68kyY9vO7obhKxpVhSXnOOYDFJrsGDDqpt2/Dsmmfj8yMQcR/ze0UWw
         JLDDsk+mdrdl2SOTn/KKx1zCLeEuxXpstb+9V56wy119cFRmaG6MVQTUbw1gRSxrlsKN
         ZPHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gGRtar0eNrSBMa5mAb00tI7qTYYP3hc8LonPzVdLY28=;
        fh=XwgNKj8nxDgd3hq6Qn9C74v12vaZ8b1KE9FfcW+Fy5w=;
        b=C6Qk5s8IrVADHSgTDFlkXfjRYi6/P8BTGWWeHhZOqTWA6XSu10Z/+1h36ddVIeu04a
         8w/HWHYZNf7JlmkI0RSyB1hpVe6cDjwS9+cGgvNbVhe8EHh+TmVJTRJr9N2D2Cm4ssiH
         sWnG7NLWlgbLe84WDhuRnHchZoSqFeWpcwl9UfeHj/+mrkzMiMhInDCdMBMIYpEmwxGZ
         H82Mah6s67raDUuu9OE+mBq8E2re79ScIlo1zbgkU+9ECctgQKX3GuqrdwaATbXtNA0k
         xoPOnV1/oP1tuJHF3jriCj5f9XiRMc56XvUpzd90kKWzLjQ8B6dlrOCqej6zx/gxlCbZ
         1p/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770917383; x=1771522183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGRtar0eNrSBMa5mAb00tI7qTYYP3hc8LonPzVdLY28=;
        b=bQaPPednqGBAwKKDeymcmjSrv0os+UZgWjRwbXKDTFxhx/UUtNHm+6nkHWSAl9XjB7
         wCQRVJEKTE2kL2LQaMK7b4QjSXJdDKA3xjlFjqio3S59xKTi8/PWTFMQQxJapcTyGRt4
         pnCChn/FwM/8ZUF26owR/paWr0XpW6WKbtV+qtj5zmiQBzZ5WrzQsVz908pw/vdUk7Cd
         hqE33zUsRhXGUh6o3ULYl+7XHwgC0SItoWLhH4xDekq2dMzVwCQCUvZhaRTddQ72b1EW
         iB/nkwymvcQ1AMKUwgnk83ckgQUrtOq8hZW8CnPI5HCfBmBX7FDoU/3/tJxM9z4QJ9QD
         Zd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770917383; x=1771522183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gGRtar0eNrSBMa5mAb00tI7qTYYP3hc8LonPzVdLY28=;
        b=oYYV5HdZVUxuYhb5sswk49jqDY9Y7vmUlpzMj63AbaENss0V0jjU38TTQiGxY3nZeW
         XbXCKB6DNZ5Ko70HdmhLelwt6mX+o6jYX7YFm8WL8aMAz+hNa9mqj4XH3qhc6tqVC4+S
         pHl9xy6XjWNNihQQkRIFIc7+S+mn++PlcyOPJ7J36HvSd7V1HsWIaggEhxCXOJoUCtpG
         pykrXJutViATEGfRIKY6ZtIkrz8Wn8pIOw6fMf5FRXFsRagB7YiMflAEf2EBY4nleSXW
         r8LvKk12fAigUKkGxuLCncFZOBna7velOI/w3Xcs1r4MIEvp9S7bApTP+39an3FJFRrj
         oZ8g==
X-Forwarded-Encrypted: i=1; AJvYcCWtQUJ22DkWki4zt7n9kRztEBXVtW7fhDhYuW9kjKEA5MDwDdu+HoUig2u71hFVDxNPSIIbHEtt46Lp4MCx@vger.kernel.org
X-Gm-Message-State: AOJu0YwvPTz6RdDVvdBylKvlUGqiNgxpEJGVS6fvw/N0o07CnNesYPcs
	vqZ0RBcTxFullyxsLNc+sdJD+rIa6ensMGuZafwVxXkmB3YA+rh4f2kpDkuY1AqM0h2zxb0rYKn
	N81YpxiLigZRCiS7uJcotwRFrdAXNqZM=
X-Gm-Gg: AZuq6aKIfqN5laNuLva7ndlfQJEUZQq3ZGi33Pq4inzLgd4lEHQpnei0Q8EpjOLdrRR
	HBx19aNybaN81q5tSOKfQM6bnZoJMl4eP56WPE5rguTJCsp8HLOe7wPW3fD/+R+wPNvF64bGwN1
	uCV0NfLE5AtmRipc5rUQpxZUKstIzcS2hwPRLr+N59G3lrB6K2ueDHxY61SuoLqqCAPzIuxgwTq
	LJmsMGSZdggBUBXQgEgCF7aiqRVsi2uUBHiO5naB482OO2jrZCvyX0X0L5klCqMd5eJKCLC/reN
	aeRyctTQlu0UKg4n
X-Received: by 2002:ac8:7f81:0:b0:503:2f21:6355 with SMTP id
 d75a77b69052e-50691ceb8cdmr47743991cf.34.1770917382679; Thu, 12 Feb 2026
 09:29:42 -0800 (PST)
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
 <aY2mdLkqPM0KfPMC@infradead.org> <809cd04b-007b-46c6-9418-161e757e0e80@gmail.com>
In-Reply-To: <809cd04b-007b-46c6-9418-161e757e0e80@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 12 Feb 2026 09:29:31 -0800
X-Gm-Features: AZwV_Qhwfszf8ijKJetXoa5_RTHnDqlX39tu-a_UpQ9gTpK2zQI2VVCnpbohqyM
Message-ID: <CAJnrk1Y6YSw6Rkdh==RfL==n4qEYrrTcdbbS32sBn12jaCoeXg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77036-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A579912FEAB
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 2:52=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 2/12/26 10:07, Christoph Hellwig wrote:
> > On Wed, Feb 11, 2026 at 02:06:18PM -0800, Joanne Koong wrote:
> >>> I don't think I follow. I'm saying that it might be interesting
> >>> to separate rings from how and with what they're populated on the
> >>> kernel API level, but the fuse kernel module can do the population
> >>
> >> Oh okay, from your first message I (and I think christoph too) thought
> >> what you were saying is that the user should be responsible for
> >> allocating the buffers with complete ownership over them, and then
> >> just pass those allocated to the kernel to use. But what you're saying
> >> is that just use a different way for getting the kernel to allocate
> >> the buffers (eg through the IORING_REGISTER_MEM_REGION interface). Am
> >> I reading this correctly?
> >
> > I'm arguing exactly against this.  For my use case I need a setup
> > where the kernel controls the allocation fully and guarantees user
> > processes can only read the memory but never write to it.  I'd love

By "control the allocation fully" do you mean for your use case, the
allocation/setup isn't triggered by userspace but is initiated by the
kernel (eg user never explicitly registers any kbuf ring, the kernel
just uses the kbuf ring data structure internally and users can read
the buffer contents)? If userspace initiates the setup of the kbuf
ring, going through IORING_REGISTER_MEM_REGION would be semantically
the same, except the buffer allocation by the kernel now happens
before the ring is created and then later populated into the ring.
userspace would still need to make an mmap call to the region and the
kernel could enforce that as read-only. But if userspace doesn't
initiate the setup, then going through IORING_REGISTER_MEM_REGION gets
uglier.

> > to be able to piggy back than onto your work.
>
> IORING_REGISTER_MEM_REGION supports both types of allocations. It can
> have a new registration flag for read-only, and then you either make
> the bounce avoidance optional or reject binding fuse to unsupported
> setups during init. Any arguments against that? I need to go over
> Joanne's reply, but I don't see any contradiction in principal with
> your use case.

So i guess the flow would have to be:
a) user calls io_uring_register_region(&ring, &mem_region_reg) with
mem_region_reg.region_uptr's size field set to the total buffer size
(and mem_region_reg.flags read-only bit set if needed)
     kernel allocates region
b) user calls mmap() to get the address of the region. If read-only
bit was set, it gets a read-only address
c) user calls io_uring_register_buf_ring(&ring, &buf_reg, flags) with
buf_reg.flags |=3D IOU_PBUF_RING_KERNEL_MANAGED
     kernel creates an empty kernel-managed ring. None of the buffers
are populated
d) user tells X subsystem to populate the ring starting from offset Z
in the registered mem region
e) on the kernel side, the subsystem populates the ring starting from
offset Z, filling it up using the buf_size and ring_entries values
that the user registered the ring with in c)

To be completely honest, the more I look at this the more this feels
like overkill / over-engineered to me. I get that now the user can do
the PMD optimization, but does that actually lead to noticeable
performance benefits? It seems especially confusing with them going
through the same pbuf ring interface but having totally different
expectations.

What about adding a straightforward kmbuf ring that goes through the
pbuf interface (eg the design in this patchset) and then in the future
adding an interface for pbuf rings (both kernel-managed and
non-kernel-managed) to go through IORING_REGISTERED_MEM_REGIONS if
users end up needing/wanting to have their rings populated that way?

Thanks,
Joanne

>
> --
> Pavel Begunkov
>

