Return-Path: <linux-fsdevel+bounces-78957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE10IAvqpWlLHwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 20:50:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 631091DEF79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 20:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F153302E121
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 19:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4268E320CCC;
	Mon,  2 Mar 2026 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWzXbDJj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED778383C7A
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481012; cv=pass; b=AfJFGMUdenlmL5cto3XQQKLfTeaLcTLkuBQOm30CyVwTGIfQbC2tXvM8bm/Fp6KaXDBUvcjNUX0B9NERTV4cB/vx+lKpa36b1hvG/5vgVqPC0V6PRkysIfN1tI8nHbXibffIvq/MLYZQgzejlMYItw8jLQrr92TBCMuyxISwtBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481012; c=relaxed/simple;
	bh=rJURvAfL9mb0xqNNuOToMCGdLo35fO45q5YSwvSu7Rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kd/87A1Hq8u3kdpGG7Zr2E53jPtI+NAJ2ofzPKr/xEKMIB3pBEczUoqY8Ny+tvyTOBad+4eRkE2owLBxNJq8MdvpGEd/jfFBBFEkbHWeT7E8roezJVbf0YekqQ4igFyKj7dGA8Gv2g/zAfkUhB2/zBCcKQCJiL5D+YpeoxC09k0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWzXbDJj; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506a93ba42dso54136611cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 11:50:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772481008; cv=none;
        d=google.com; s=arc-20240605;
        b=hKmtOfc90A3U9J69x6aauwvpaQesTrKkt1mchWDBqcOkfh7Z2Y1Rieu6PuwGSPJhsJ
         T5fkl6vodvyr7l1EtE2/ZWBFfHXFBgxVqNF5iDZu6S1Vn2GtUt1c+V5rP3/Bkd1QMWKA
         ceRVRrcwnU+jIKyS2fLs1RYbGNTJKfCMAUAPY15B2bmwZkPIx1PSP5g6oHxfDtgAdL3C
         z+3bkoMonKZQmCR//RbCbqt2uXlbQoQ9kd+4NLu9sCfvRpdHNZpiceQWxeXIvFT60emC
         uYpd+LpifPG7Bc9B7zhQtsyZTGh4quuddPLwEMDi34f81xvuA7U2e6AJN1BsXu0YkWPF
         n2rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rJURvAfL9mb0xqNNuOToMCGdLo35fO45q5YSwvSu7Rg=;
        fh=q8Dt2K1i2KpUtJ6rJ2fb6NKUKCM+L9OZ1l9CJvNE/hE=;
        b=lVF5J889FlpCyKdgpO69lciE7ed3Y0OKgAKcDtl7CJDWiqIx/Pd05XiNbuNVOOsK3p
         3QPCuYaqmBbzwMB2/TPCuf2oZGRxFRs8M/Z+Olb2RFzxrZ/oGg4CBb2yKDGp7t33s/iM
         qfbyJ9IXUYwMr897v7lEpXQ64jpAXwJSMbSQO+RgE7TWv/hsuVHwjbz6DQV5QdB+dpk7
         CCjY+wP8PrAYe6SgHY6oiSisawK7mvhPGlcGMEomthdVF3nwxVRIInxI2Ze6x/S+YF0o
         +8nCfmuHfPbUJhAUTa1qAHo60EZszveeTOqsRKI43HBvwHvi4jDC5n52cRBJC7tWLAkm
         1aEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772481008; x=1773085808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJURvAfL9mb0xqNNuOToMCGdLo35fO45q5YSwvSu7Rg=;
        b=VWzXbDJjXLIHVYavJfG7jkygvZCvRnL6Z0K7/k1GdyqxZeYowLK620R+tdNenGDh8x
         H9k5BkSJO/VrEjKhB8G/8g29cVH/wXtWddIQuG/fbamgIJtgdSN/AcsPOSPv3HESRyQR
         bZ7myfwf8j6NsXnSg6m/fWsTH4jiS7AoQXxhoBwd4OpWwFm7bf0QrERKts81/7/Da6p6
         +LoYJh9zI24qMID4pPHjjegiBUo6YEqlkJnNWsw2a2zNu93pW2M2/ySqOivZ2XT3dFuF
         m3z9xDy663J3AJtW72bbp33piCM6DhV9B8IHHM0RYTpMbm+Eqj8Eljc8TtLwcOHUdIeS
         5GLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772481008; x=1773085808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rJURvAfL9mb0xqNNuOToMCGdLo35fO45q5YSwvSu7Rg=;
        b=esrauxLraIKpiODDmsLb4p6olkOJcd6EQ0nr7YwhMazqnniccWZ6lgB6+D64qiz1ML
         InrGz3HJHKsZhKU01nuXueazBt6KPDkOTnfJ+rrKQ1FSBmeAAbwudg9JjPKOUfppwjCF
         EGMiBzY172VJQ29Z/Kz0AkeAv+EEHELelsZBrekHj3NBCiVYvVkakYw0cHz1MdK+WKDu
         ajGgfh+AKbUtXbk8cUzHikzomDq0VQGRn5XI7IZ7HqHy4DP99ZNHj8kTn+EbtnpJ/+dx
         Ek2vppMZ/FeXNSnH5b/FlaGJhDTO6HswSfsdLh41nIb1Y8Q8yB9N0GtIkahLMc2x804h
         hMPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVc4m17Ks3DaEvsJguFRWUa/pA4grDcLyIsqDJP9YOiTmvzTDF/yBCxSWWKXxlKIQJAt945h8625reK4UO@vger.kernel.org
X-Gm-Message-State: AOJu0YxG9LyTIPD8I0IO6/PqF0gwcuicTbIKLHNGcxtL/kPbhOBLxYba
	zsX7qgwU6t78HKKhqWLyYHlWF9q9wbZzYIGQYwhxFUSTjrjvAeXOjgbiQ2QkEVEumjecHPhFRlO
	0fPUz7IgAw0tYJWI5DmtrduhbsDbSWYM=
X-Gm-Gg: ATEYQzyn26YNcRTIQoPWblbAJ4I5B2S3XD/lBpd/gQMT/XxnlYlE+QYrh8dWDl4AhWz
	0oiYdc1hU+roDgDlaJq5NSBj0Br0OvGQxgt+2/RdDBvnD5/EwDSlybdcKL2KYVWfd7HRDIZPdCS
	UEsB5nN2HyS74LaHwkA7Gi9frELub6CFDdlV57NsYE4TP/mbEKY5OlPMQmymSlJm3ho/+D5R2TE
	RMUDeXKKqQuDTWgz7bOMcsXn1PrGEkvgK2GbrtofJ8jiiVbazBjEKDFMgTPePfxJbLYU6EZWcEh
	KMF9+w==
X-Received: by 2002:a05:622a:1ba5:b0:506:9e57:8ba9 with SMTP id
 d75a77b69052e-5075284aee3mr185778611cf.35.1772481007512; Mon, 02 Mar 2026
 11:50:07 -0800 (PST)
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
 <11869d3d-1c40-4d49-a6c2-607fd621bf91@gmail.com> <CAJnrk1Zr=9RMGpNXpe6=fSDkG2uVijB9qa1vENHpQozB3iPQtg@mail.gmail.com>
 <94ae832e-209a-4427-925c-d4e2f8217f5a@gmail.com> <CAJnrk1a1FAARebZ0Aqw18zxtOy8WTMb2UfcAK6jQaigXiZbTfQ@mail.gmail.com>
 <000f7db7-5546-4680-bef2-84ce740ad8fd@gmail.com>
In-Reply-To: <000f7db7-5546-4680-bef2-84ce740ad8fd@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 2 Mar 2026 11:49:56 -0800
X-Gm-Features: AaiRm52JdruEeK2MfAi4mXfLJPAkXo1Ar_bLrLRcnwz965v-5ezUJCtja-knG8s
Message-ID: <CAJnrk1Yi8Rv8NPq_UskOrXg6zHS42ReKoG13LLgqspzrkUe7PQ@mail.gmail.com>
Subject: Re: [PATCH v1 03/11] io_uring/kbuf: add support for kernel-managed
 buffer rings
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk, io-uring@vger.kernel.org, 
	csander@purestorage.com, krisman@suse.de, bernd@bsbernd.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 631091DEF79
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78957-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 12:05=E2=80=AFPM Pavel Begunkov <asml.silence@gmail=
.com> wrote:
>
> On 2/24/26 22:19, Joanne Koong wrote:
> > On Mon, Feb 23, 2026 at 12:00=E2=80=AFPM Pavel Begunkov <asml.silence@g=
mail.com> wrote:
> >>
> >> On 2/21/26 02:14, Joanne Koong wrote:
> >>> On Fri, Feb 20, 2026 at 4:53=E2=80=AFAM Pavel Begunkov <asml.silence@=
gmail.com> wrote:
> >> ...
> >>>> So I'm asking whether you expect that a server or other user space
> >>>> program should be able to issue a READ_OP_RECV, READ_OP_READ or any
> >>>> other similar request, which would consume buffers/entries from the
> >>>> km ring without any fuse kernel code involved? Do you have some
> >>>> use case for that in mind?
> >>>
> >>> Thanks for clarifying your question. Yes, this would be a useful
> >>> optimization in the future for fuse servers with certain workload
> >>> characteristics (eg network-backed servers with high concurrency and
> >>> unpredictable latencies). I don't think the concept of kmbufrings is
> >>> exclusively fuse-specific though (for example, Christoph's use case
> >>> being a recent instance);
> >>
> >> Sorry, I don't see relevance b/w km rings and what Christoph wants.
> >> I explained why in some sub-thread, but maybe someone can tell
> >> what I'm missing.
> >>
> >>> I think other subsystems/users that'll use
> >>> kmbuf rings would also generically find it useful to have the option
> >>> of READ_OP_RECV/READ_OP_READ operating directly on the ring.
> >>
> >> Yep, it could be, potentially, it's just the patchset doesn't plumb
> >> it to other requests and uses it within fuse. It's just cases like
> >
> > This patchset just represents the most basic foundation. The
> > optimization patches (eg incremental buffer consumption, plumbing it
> > to other io-uring requests, etc) were to be follow-up patchsets that
> > would be on top of this.
>
> Got it. Any understanding how the work flow would look like if used
> with non-cmd io_uring requests? Is there some particular use case
> you have in mind for fuse servers?

One use case is for network-backed servers with high concurrency and
unpredictable latencies where with kmbuf rings we can submit multipel
recvs and have the buffer assignment be done as the completion comes
in rather than having to preassign the buffers before submission when
we don't know which requests will complete first.

Thanks,
Joanne

