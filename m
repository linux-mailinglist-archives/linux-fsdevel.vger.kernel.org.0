Return-Path: <linux-fsdevel+bounces-78208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOfEA6XonGmNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:54:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F1D18013D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 628A2301BC2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614DD37E308;
	Mon, 23 Feb 2026 23:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwJVVkmN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B19A34DCE2
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 23:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890810; cv=pass; b=p4/rmlJl9pN626498ZiuOd03jbb15ilZP3wtp6M5J6hTvuWBVhHyDegrKnKavuKeRhuya1u/ATn2N0APoTl+eJ4SCtqLgQersL4iZQohAJgVNwr/HZY+hagdkHv29/okm6KE5nWXPyjLtVUy/f794z5gwuHTVz7EvfV87Qr6818=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890810; c=relaxed/simple;
	bh=P0nxApqL67Uch6bD60kpq3sEbnJY3RxaWIGADaZfTZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYAHjwBilQSeADYPHI70WTkVf/R5rravvL4tykr0Po0ZweHP/gVtsKqZXwrFC+sCCqd4rvW77kVI42oQuoajyGL8y+R1+mFAFZe/+fV0oF37B5BA3GaruNRyES+cUs3fMdJMi6zL/DOw+y6mV4FchIxG7UKOfqstgFC1PyjfAio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwJVVkmN; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8972a14e27bso65162346d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 15:53:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771890807; cv=none;
        d=google.com; s=arc-20240605;
        b=ZJGCkOxVqtZ8G07SS0DCLZ2fkDXxh3BO9Db9ju/G0sAIAFDBHcrrLw64cZZyoLFZfW
         Jdsl1NZwHjgdpxP9rMRHXXoFz0/63G4wZqTKDRcD6KKiYVR6Z25w/gABBhUsY98sTeOu
         WSCLP9ayUY2ATjprwpqIOvk5c1j2gLj053ILDy74XjfK6pQpqpKv2LbbelN2zX8JUyMo
         Zw0pxdEnV+YlJ/2jbkxxxobIaB6QI7q/Z8f8uSiTdUPX4eCaGbjZYEq0vcarj6PiZ2Wb
         KqaGyXKTgXnwFnNKhdZuI9Y6HRPJzhfSqMm83+p7b4Gqg+Y6Lehi+sWjPZxRW1bMrEew
         hWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WokFcgWHzHLmsBrCXZikSrtkdMiE4lGy98lwNnOtPo8=;
        fh=WBCBnSrWe4AMJzmsq5vOFKESrdkLEgIGaGQfpQLiJXc=;
        b=XX6ld0CtXo1xqmYdVoKYnXBe5uKzd3+ilhiTLML6qGVpYU3SNJsdJ4CV/QLaa9csNd
         fRlagvckz9NIO2aNdty0QgFEuR6/u/vE+9L33KGBls02LowQgQwOBA/MjW7uUsD6OHd0
         xpsQr6j/BniRC1YxzH+wDaDwdzBBH9Po1gq4+Nh04ZyrkWGzSHfNJs8a0CmIPDPt13JR
         K52S+eF6ynBvurrkCKx190FK2Z2kTC4Lw1Jo7bxYoaonPg+T7EFrTi+fV+31+aN/Z9Bv
         FsgAxwAuKcfgkiRtAmQhnAV+IykxQGYSzCbqS9HBwhk0PFxs4GC5xHFZ7qcDF2l3gUWE
         R/kQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771890807; x=1772495607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WokFcgWHzHLmsBrCXZikSrtkdMiE4lGy98lwNnOtPo8=;
        b=OwJVVkmNugiGtz1nuvUsziMNCQKxBc8uHveu7TChG8VejRKrOifz4GlKNccboLC62P
         7f9KOenwZ3Y/QSlqtHMV1Vu7XISnxnuoLu6R3ObT1OD0t9SIuvR9PDP1j0Rvr809+lIB
         JESdqQ0USuron8Y4BMRP//lwdVm4RK0c51k7alYcpFhgfgR6asxxoBKEBKwaZ1Ec7Y0A
         yj677zct2lDv4OM0rXEMNMDXXNvOjxhzProA3AtU20E9Dw7rrs6SdRXEhWyAth2Dcq4U
         f2dg4aBbzOINebH5Qr0rJ7URWNfDwnbqD1hJTFbyz91iGuRdCg571k5uPqt97+8xUNaa
         +Gzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771890807; x=1772495607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WokFcgWHzHLmsBrCXZikSrtkdMiE4lGy98lwNnOtPo8=;
        b=OtxjRfR/w1j16KIhMwQn1zD65/BCwc5FSyBlDxgAs+ChRmXBfm3LLM7FyK7MHc59oQ
         tPjSjmhjuEJqJYYpzElRRwL8kdnO+2tGY6L5ZQueX2me1i6z4VcbkSTwf9/7GowqYsIE
         JYlH70Ag9wLhJ7o90NTUjGLGLV82dGMd4xsX4UgXC/GVubMvtk6FFmHQvfzk9i2JGdie
         6RLZkdL8VGqCRevuMsAeRKScg76lb/mscL4i/KZeJukCsy8KvPVQfjj5GknYRYEGR7Q6
         FVveDHgGX/lK3yhX11xHCXBAnuDrWSifTxzkEgKD/0ZqxkA07+7LXi5IhlwTEqUBxxsV
         1RkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBAodGh5Fg825h5mVykBrcj2ScuR4q8XgCx0a+5zgIVuFxCphyiZwiz7//0JPqMWbRKGKSO/HSGfLx0pmL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2bjk8lV1tCpNTqGTNvklbs0wmugoS6H5RojJGCxBF3jktl1XZ
	Ohnpho+0FLtD+efLwEkC2Gh3Eq/w3Z30xMLgCvt64HFyn1IXq8SgRVM1Fs1M2W2mVQYxw87jw5G
	jBT+iu68mzSfE69O1QJPxtYxPOTtSVEI=
X-Gm-Gg: ATEYQzzB/Hu7V8zCCy9CipLsu+2mrwZOKR8LUQUdZiyoP5oxqIWlB7uJQU7K2AeuTtL
	e+LcXkfrieB1S5qEB58Ip5id9IWH5W2gglBQABOHlLDdy2uMddICWVoWWWm7UiNVqPdCw7P/9n/
	pXlp4L4TFiwokVsoF1HbSeWBUjxw84XRgZL21hNmqceqTFLMb39ES3alSQT59O4BXnhWtQdyjJZ
	tXngX8h8Bqe4mc7Xm8bTI+1ChijKUIHMXaHcTiJyWwGChGehsNueRfb7uhi6jamphhzt5jzuMRH
	V8oVafJtwaZ5ZiWO
X-Received: by 2002:ad4:5b82:0:b0:888:23a9:7b01 with SMTP id
 6a1803df08f44-89979ecb5a0mr147580746d6.42.1771890807324; Mon, 23 Feb 2026
 15:53:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219003911.344478-1-joannelkoong@gmail.com>
 <20260219003911.344478-2-joannelkoong@gmail.com> <20260219024534.GN6467@frogsfrogsfrogs>
 <aZaQO0jQaZXakwOA@casper.infradead.org> <20260220234521.GA11069@frogsfrogsfrogs>
In-Reply-To: <20260220234521.GA11069@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 23 Feb 2026 15:53:15 -0800
X-Gm-Features: AaiRm51UQQsM1jyQjP5zhNU4OCXR8lVzGFmCWxdxikJ_mHq5yCo_jnEuiO0Mgqc
Message-ID: <CAJnrk1Zk1hHCoC4xaY_KT0m_04CQ=pO6j3e1tGrdj7LTf5BHsA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] iomap: don't mark folio uptodate if read IO has
 bytes pending
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, brauner@kernel.org, wegao@suse.com, 
	sashal@kernel.org, hch@infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-78208-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 76F1D18013D
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 3:45=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Thu, Feb 19, 2026 at 04:23:23AM +0000, Matthew Wilcox wrote:
> > On Wed, Feb 18, 2026 at 06:45:34PM -0800, Darrick J. Wong wrote:
> > > On Wed, Feb 18, 2026 at 04:39:11PM -0800, Joanne Koong wrote:
> > > > If a folio has ifs metadata attached to it and the folio is partial=
ly
> > > > read in through an async IO helper with the rest of it then being r=
ead
> > > > in through post-EOF zeroing or as inline data, and the helper
> > > > successfully finishes the read first, then post-EOF zeroing / readi=
ng
> > > > inline will mark the folio as uptodate in iomap_set_range_uptodate(=
).
> > > >
> > > > This is a problem because when the read completion path later calls
> > > > iomap_read_end(), it will call folio_end_read(), which sets the upt=
odate
> > > > bit using XOR semantics. Calling folio_end_read() on a folio that w=
as
> > > > already marked uptodate clears the uptodate bit.
> > >
> > > Aha, I wondered if that xor thing was going to come back to bite us.
> >
> > This isn't "the xor thing has come back to bite us".  This is "the ioma=
p
> > code is now too complicated and I cannot figure out how to explain to
> > Joanne that there's really a simple way to do this".
> >
> > I'm going to have to set aside my current projects and redo the iomap
> > readahead/read_folio code myself, aren't I?
>
> <willy and I had a chat; this is a clumsy non-AI summary of it>
>
> I started looking at folio read state management in iomap, and made a
> few observations that (I hope) match what willy's grumpy about.
>
> There are three ways that iomap can be reading into the pagecache:
> a) async ->readahead,
> b) synchronous ->read_folio (page faults), and

b) is async as well. The code for b) and a) are exactly the same (the
logic in iomap_read_folio_iter())

> c) synchronous ->read_folio_range (pagecache write).
>
> (Note that (b) can call a different ->read_folio_range than (c), though
> all implementations seem to have the same function)
>
> All three of these IO paths share the behavior that they try to fill out
> the folio's contents and set the corresponding folio/ifs uptodate bits
> if that succeeds.  Folio contents can come from anywhere, whether it's:
>
> i) zeroing memory,
> ii) copying from an inlinedata buffer, or
> iii) asynchronously fetching the contents from somewhere
>
> In the case of (c) above, if the read fails then we fail the write, and
> if the read succeeds then we start copying to the pagecache.
>
> However, (a) and (b) have this additional read_bytes_pending field in
> the ifs that implements some extra tracking.  AFAICT the purpose of this
> field is to ensure that we don't call folio_end_read prematurely if
> there's an async read in progress.  This can happen if iomap_iter
> returns a negative errno on a partially processed folio, I think?
>
> read_bytes_pending is initialized to the folio_size() at the start of a
> read and subtracted from when parts of the folio are supplied, whether
> that's synchronous zeroing or asynchronous read ioend completion.  When

Synchronous zeroing does not update read_bytes_pending, only async
read completions do.

> the field reaches zero, we can then call folio_end_read().
>
> But then there are twists, like the fact that we only call
> iomap_read_init() to set read_bytes_pending if we decide to do an
> asynchronous read.  Or that iomap_read_end and iomap_finish_folio_read
> have awfully similar code.  I think in the case of (i) and (ii) we also
> don't touch read_pending_bytes at all, and merely set the uptodate bits?
>
> This is confusing to me.  It would be more straightforward (I think) if
> we just did it for all cases instead of adding more conditionals.  IOWs,
> how hard would it be to consolidate the read code so that there's one
> function that iomap calls when it has filled out part of a folio.  Is
> that possible, even though we shouldn't be calling folio_end_read during
> a pagecache write?

imo, I don't think the synchronous ->read_folio_range() for buffered
writes should be consolidated with the async read logic. If we have
the synchronous write path setting read_bytes_pending, that adds extra
overhead with having to acquire/release the spinlock for every range
read in. It also makes the handling more complicated (eg now having to
differentiate whether the folio was read in for a read vs. a write).
Synchronous ->read_folio_range() for buffered writes is extremely
simple and self-contained right now and I think it should be kept that
way.

For async reads, I agree that there are a bunch of different edge
cases that arise from i) ii) and iii), and from the fact that a folio
could be composed of a mixture of i) ii) and iii).

The motivation for adding read_bytes_pending was so we could know
which async read finishes last. eg this example scenario: read a 64k
folio where the first and last page are not uptodate but everything in
between is
* ->read_folio_range() for 0 to 4k
* ->read_folio_range() for 60k to 64k
These two async read calls may be two different I/O requests that
complete at different times but only the last finisher should call
folio_end_read().

I don't think having the zeroing and inline read paths also
manipulating read_bytes_pending helps here. This was discussed a bit
in [1] but I think it runs into other edge cases / race conditions [2]
that would need to be accounted for and makes some paths more
suboptimal (eg unnecessary ifs allocations and spinlock acquires). But
maybe I'm missing something here and there is a better approach for
doing this?

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1YcuhKwbZLo-11=3DumcTzH_OJ+=
bdwZq5=3DXjeJo8gb9e5ig@mail.gmail.com/T/#md09648082a96122ec1e541993872e0c43=
da5105f
[2] https://lore.kernel.org/linux-fsdevel/CAJnrk1YcuhKwbZLo-11=3DumcTzH_OJ+=
bdwZq5=3DXjeJo8gb9e5ig@mail.gmail.com/T/#mdc49b649378798fa9e850c9c6914c8c6a=
f5e2895

>
> At the end of the day, however, there's a bug in Linus' tree and we need
> to fix it, so Joanne's patch is a sufficient bandaid until we can go
> clean this up.
>
> --D

