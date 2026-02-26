Return-Path: <linux-fsdevel+bounces-78462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIY5M2kdoGmzfgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 11:16:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C661A41D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 11:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E67230D3E80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 10:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087873A4F23;
	Thu, 26 Feb 2026 10:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0TWyIdM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F799393DF6
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 10:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772100796; cv=pass; b=t0pMIMpuLZAcZBvJPGyGwTh9RwyZuj7g7wHcYKIqRGA5gkRQ/gHSqvz1/5WWbX29F+leTqQ+7ZIIaJ1Tnmeq/g81ldLglk9XqNsjh9xg8qUTUra7KV0Rfad5zesOpR/FPwHrmrx1a+p2k8csqAaokKL8COX7Gs3lpjUWTndQmRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772100796; c=relaxed/simple;
	bh=eqcgfxKwweo3g7DbLJ8+WLgh5kmbXwc5z41fwt0ySSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+Q6cGmUGvz/U3Vof8wQZ2B4vlyYkfIY5PipmJOGz+u7flBxnPvtvBcCe4F7mHOzKn5tfzLLLi6gdxsSI51Fy/HPXizoPUNx4BBxS5HtslQicW63V9d63y7igAuEXQgjA3mXcIfQCu8MIKN4Qu3dT0XeriMdO3nu3zMfDqUK9h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0TWyIdM; arc=pass smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56a973a7bdfso490431e0c.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 02:13:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772100794; cv=none;
        d=google.com; s=arc-20240605;
        b=JniINomvYvq6T0Uj7kLdoUzvB6vY8WxOtik/JNRFitSgpU17v/315tI5bmEmjW8OYd
         q+mFzxhmD5FPnD6mYADj5G/LOqU34+x7ELt7G9+SyKo9t8mm51VNSrbHh1NRzyGeCmGX
         SdUBa8TJ20uwj/0EmwO+DnTXD/nA40q37ADaUOtnscMz5xaephm6uVCbfAxYrx4qYHNz
         U8HEPjtv0WWpzXkXX7rA8oS8acWlfZy291xktRQQV9DvZcribWHv+a2zYyUFh0hy9jXe
         iSdBZcAXCoHZuRbi6leS4nHGkApS3xtfNOmZjiXbaGKgIfOaTGwP5o4332YrMS/UF87J
         Sc0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QpKHBD0mhwVP9kJAJUi3zD5uY8oKKK5cQ3gsTRpGswo=;
        fh=8IaL6Eswo8CBBqh+z5uNfwaz5zPDW2Mttu45vqfCiGw=;
        b=h3G5w7nIPa336UV+dGk7nV66/k1sdjkX5KzsKQav35gCn3AQVgkvWkWF98ev5wtoEM
         ig4HMUeEwvCMLEiSJRuHaq6/YWHsXLmTib9zTovBTqUKD+/In9TA3TSA4ZwyuDRJyhDh
         z7m+UwF+ips5XXt1KNb9IrNvpa/F3cwO4ILecnnWbQJirvwRRW4Okg7xKoTD07O+M9te
         i4MJRJOooKGcxUZKuj40ZjxVzDbjdwmUXcrPZgYGx8ZtEg21cobX4U5SkhKA6NzeR+H1
         C9BSY0iv2jU9wFJP+TzvTNl1gRBrIiHFZg8uKnLRddrxG8SjFX7/MBd6yaNL0yQ1+RPE
         MYOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772100794; x=1772705594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpKHBD0mhwVP9kJAJUi3zD5uY8oKKK5cQ3gsTRpGswo=;
        b=A0TWyIdMuG+DugL9znw8oNPWc/Js01vwtRhIURRjglohg4P6OTZv/nyamtBqhZVBC/
         YAVZym07i3Ko2u/Ze7UVE01RnO8TvNCoCbLtPNO/T4jG1XC9rgIyDQVImi3JYpmJZs+7
         krbexD51O7ar7GcxcI/arc016rIVFujPI5xw8Q2cJa1FyJ+4LpVan/aFulrZxqjBi35A
         ccsbkFbJRaPgx2+wt6+UTXDixM9ur/YzLFKCHJgGBBP22SfEsngTUKe2J87nXZP+KQBV
         YUcmSYf1BG+UFgOuQ17mOgj6vcqACtmJbdU4JNbGOnLj/9NMSg5xcK5KR0aDgpXAXhu0
         ZBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772100794; x=1772705594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QpKHBD0mhwVP9kJAJUi3zD5uY8oKKK5cQ3gsTRpGswo=;
        b=mxFeazbpwAMqh08+35bNlEdcCLzMSPf2PzYkgzBr2IQm0Mq6w7duh7HMQF1L1d8wsx
         0cymCoLMkl/Zb1ipRjHSGh2cJ8CeyqwsrmFX2CqHz96Jh0DaAKpTNcv3FerVN6sotpcj
         PMNJm7e9rVpK1lM77RujCnv2r6JYZyADWEPhmcXKO4/TIFRn+v39JMiinOhZPfHiA6vJ
         tL2XS2xn2/MluAuw19eZjb6iHHDGWmjnBNcVBA6fzjcf8JyccA8oNiqfFBXLixO9AzES
         g1u5ET92lybFQVXlIZ5krrAzEQk+b4S+k9jUbpuiLSgqQJv+SPJS1mKe/JQBpebZmipQ
         0AOw==
X-Forwarded-Encrypted: i=1; AJvYcCVtG5cSMzzGjtmUI2ekaX9XRwT3Ibz1At8nGWB72yKkBAL7/iVhHtp8lKLGXGq1V53vbqb98uUOvf6gZfl1@vger.kernel.org
X-Gm-Message-State: AOJu0YwttOmjs+4/Xxb7yVILMfN42VYEPxnc3urNpyFirk+i+D+vRTsE
	YCwoW+jZB7flCYPyQHNrSOhmn/ccmaubN320X9HeY/Pyt1f6hBNIUWHSbGJr4pJImI4MJ47kaAW
	Mw9CmDs82mpgU8xC7Mi6le2R56ReSI5g=
X-Gm-Gg: ATEYQzxTvqfN0tI9GFKUbahrX4EeN8yDqpOdv+47lGITPeBJSTeLD5ZweUCQf9ClCAo
	S8E19jGwogo6F1TcZKQntUpLaCu4Syq0bfu2NoDPfl8BE7uFEFH3nl45t7t4MPF6pFXaJY0Ae9I
	YnVUYoQjBsVwf9jxx1wvjBrh27R3BLaS+VsVZMU4biTFR4P1LFpn3CCi00ADhpge15hT0bplfnx
	2F1yzR4YZ8WUcCbhXrDHy3Vyp5SY5Jd3fHHyOaTkECM6f4QVdyI0COEkR1YSxL+rEhb6QmLKKdS
	Lg4UKQ==
X-Received: by 2002:a05:6102:3746:b0:5fd:f8d6:e5d7 with SMTP id
 ada2fe7eead31-5ff20a265a3mr869277137.11.1772100793952; Thu, 26 Feb 2026
 02:13:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <75f43184.d57.19c7b2269dd.Coremail.nzzhao@126.com>
 <aZiCV2lPYhiQzYUJ@infradead.org> <aZiqsQsWFSCjcfE_@casper.infradead.org> <aZzIUnYprj_wTyqn@google.com>
In-Reply-To: <aZzIUnYprj_wTyqn@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 26 Feb 2026 18:13:01 +0800
X-Gm-Features: AaiRm51jChSZI5BEV-wZgNYqeWNjz7J8xjz21TRTV8Vtb2crImnWPP2nMbwao7E
Message-ID: <CAGsJ_4yN+RyF5hh-=sBfnRGp-r8KZBYY-ByT_V9KjiiKy1FgSA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Large folio support: iomap framework changes
 versus filesystem-specific implementations
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Nanzhe Zhao <nzzhao@126.com>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	yi.zhang@huaweicloud.com, Chao Yu <chao@kernel.org>, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78462-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[infradead.org,126.com,lists.linux-foundation.org,vger.kernel.org,huaweicloud.com,kernel.org,suse.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[21cnbao@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52C661A41D7
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 5:36=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org> wr=
ote:
>
> On 02/20, Matthew Wilcox wrote:
> > On Fri, Feb 20, 2026 at 07:48:39AM -0800, Christoph Hellwig wrote:
> > > Maybe you catch on the wrong foot, but this pisses me off.  I've been
> > > telling you guys to please actually fricking try converting f2fs to
> > > iomap, and it's been constantly ignored.
> >
> > Christoph isn't alone here.  There's a consistent pattern of f2fs going
> > off and doing weird shit without talking to anyone else.  A good start
> > would be f2fs maintainers actually coming to LSFMM, but a lot more desi=
gn
> > decisions need to be cc'd to linux-fsdevel.
>
> What's the benefit of supporting the large folio on the write path? And,
> which other designs are you talking about?
>
> I'm also getting the consistent pattern: 1) posting patches in f2fs for
> production, 2) requested to post patches modifying the generic layer, 3)
> posting the converted patches after heavy tests, 4) sitting there for
> months without progress.

It can sometimes be a bit tricky for the common layer and
filesystem-specific layers to coordinate smoothly. At times,
it can be somewhat frustrating.

Privately, I know how tough it was for Nanzhe to decide whether
to make changes in the iomap layer or in filesystem-specific code.
Nevertheless, he has the dedication and care to implement F2FS
large folio support in the best possible way, as he has discussed
with me many times in private.

I strongly suggest that LSF/MM/BPF invite Kim (and Chao, if possible)
along with the iomap team to discuss this together=E2=80=94at least
remotely if not everyone can attend in person.

>
> E.g.,
> https://lore.kernel.org/lkml/20251202013212.964298-1-jaegeuk@kernel.org/

Thanks
Barry

