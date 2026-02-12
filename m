Return-Path: <linux-fsdevel+bounces-77008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BRdMlKqjWkK5wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 11:24:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4487412C72D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 11:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E25AE302EAA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 10:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0925C2BE630;
	Thu, 12 Feb 2026 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZBr4JGw3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62011EACD
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770891849; cv=pass; b=YHO3kx0sDlglP3QLZSUlwG8JVxqGghbQ/ZFpH4IQ6MYbsUUfLP/LjuRi/aOZiofebrybF5TCnMTcKKEUXwQ0UWcQ0jwBCRBACvm+XcpyQZ/qBTW6D9YVyJ1iE1ycUfblGIpz5GJ0PYEW/bxGvkTCSawfM4L964hBoz7CI9c7Z2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770891849; c=relaxed/simple;
	bh=tkOoUE+EIusw9jf8hhqQ8MIAGZ+LenJ7d5DpipH659M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjAiXwD6D6S4BP30pndMRMwVd80Jl0IM2DLQ95zMDKoqkBb1xCOMLZDaUmMryuvRlYjGrwaceY+Y0190syD4EIDCjXb/gkaPO/ySaZuiAUk0SNiPdAdl1NvZ/JROrL57E/4TbrLwZVVOnfZAY3K4e2FhN6bLyZ03ZjflxyxOYqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ZBr4JGw3; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5028fb9d03bso62061771cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 02:24:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770891847; cv=none;
        d=google.com; s=arc-20240605;
        b=NSXEPSySCmXX4gS5lMoTpz33AVPP8zlpIJfUGyYuvKwVVc7ZMtU15D3ybWt3QZmekJ
         RcdmdOmUCVesDUMhh7cZtl5jJKgqBBEdgrgK/SiX8uBcAmmHk3f8zfRDp9DxJsD79VpA
         nF0XUcCkHeWcf0tEjxMaOEPsNX4h69FJrisE8Kkba1re/SuTtPDHy39qp7GOPqsdmcS9
         LXyG6x+OI1xO3CJcgqamFCVbuVtARmRwqWXRdi696r2AiL42jYvMmioICqy+0jCQZ4ZP
         D3McGTf4jQ6pTpXhOZBb2UFO4aXsSosyVJ1wpCS/ocqfL2ojwgT6uJdmO/Urp98cA7HQ
         mNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5+CHVG8dFYyefz3eblHMIjuz2an5SF1d/2IXHdWOPhQ=;
        fh=7WA/FNL/zT+lRzFoJPfKtfuTYJvBYML1cGixr7cDkYU=;
        b=CHnYGmNqOOZFacq+n619+mJtyzgtKEs5qs8rB+QJi8EsfSQmw+FXHtQeu1oZIgKpNh
         z+9fFc0hBcFUky8K8oH4dziDAvTpRT8OUzS09UUM6iCFWlmp2JI5ldIhfs0MiX4aoZt+
         iRFoT97AwfuwYpbjjMtn6dF0UUF52qrsWS8Mh0/wXhaDkTQKnHwCr9uORNoRs6okQhUU
         zHo56qUosFh039gW4MR44DFUuoV2yhP2/okQPICfNkDuqqUibmD14EdHZug/TDtaW2Zb
         lIilzERQ52BmZzHnwcOko6Dw5rTo6iXOOJbmgoeVy9pJP8Y5viQwjU1UMxTK/u4M099p
         YheA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1770891847; x=1771496647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5+CHVG8dFYyefz3eblHMIjuz2an5SF1d/2IXHdWOPhQ=;
        b=ZBr4JGw3HfRLVd3gC+rb92dYxTxka/rZhF2VLMn/vmElnA170KKvY9WyZCU981+po4
         eOWvBks8Dj5IRCRUAhXZlTeQB07AOImMOLBgMHCxb+rNRAq4aabMBSMzpqen/2A+Rxln
         yg/OtgZiZN3Q3a/99sNU8nJzMRJq1XJgcdO7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770891847; x=1771496647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+CHVG8dFYyefz3eblHMIjuz2an5SF1d/2IXHdWOPhQ=;
        b=vS9J0M8XThOzAir20niUir1ugJjE5EcP1nfpacQ5bPclWjfiWpCS/7rjpDzn53LVr0
         RfaRWGJPR++5SlQJi+0w0JdNw7zR+/4TFxoHFmYXFoGGjrrADGu0JeZ/9tBdRE17HBFI
         O1IlgbqLVLFxqzE7AdM38QbdjcUI/yl8EpwiA9lx6c2W48RJSetAUEaDykof+o5iJVid
         84E+v3B0VZpezjlR2br0efU+UJ0/YUf4JhlXvNkRON2X2QURQJ8DOgU6YZ8eXp0C9tKc
         e1RIn5HPfufsuYf2GH7xRB+Sik45h8cOZYjDk4Et17SOwpncGW+p4jwoEM3XvqkB0e0l
         3mVw==
X-Forwarded-Encrypted: i=1; AJvYcCWIAak5j3SOkgpzD+ZdJ/HGcBfD23OnQo/W2m0oskrX3KiuZ0jEuEDBCzI18LCFHfF4ar4MadUww55oLqtl@vger.kernel.org
X-Gm-Message-State: AOJu0YzJZawpkeLu10jF4LzFYpHH8FH8osAArtvHllcWhRV/jJZ55C/t
	sfodckycqsMJ6UAEWJuJ2eah2LBuqRdQsuLlspMempPaI2aup1bGJ7GKqFDmrygs178jUqJypXx
	vie66aOB1qt4AXbnPRRlv4GjLacm5iZ9MQ9Y2bIJJhw==
X-Gm-Gg: AZuq6aKIxZlLmj5BG4WMybGLRmqeA2eW/LJdO67cpz0iDYRNtQ/cMdvm/Ry3yzdnjJ8
	S4hCNZ+cpefKddN2UIq4msTM3h+WTt4nXtFiJA8UFdupddB5JsLSVpD6SvUIiKEoypgX9mhsZKj
	FWRdLAN55z+cGuKf9NjZDL9+0y5QUoPhURIHj6hkrYDHwcIB8PEyDlKKRZfyGTuRTYXgloYHCYU
	DxbdjgGy0rRqKW3M1CQCRm+jCQtigyQclunju5qbv6/dRBI/GVHP369rY3pEQ/DSvchb4BqnWwe
	9Yr9+A==
X-Received: by 2002:ac8:598c:0:b0:4ee:bac:e3a9 with SMTP id
 d75a77b69052e-50691f549d5mr27718341cf.68.1770891847303; Thu, 12 Feb 2026
 02:24:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com>
 <20260210-fuse-compounds-upstream-v5-1-ea0585f62daa@ddn.com>
 <CAJfpegvt0HwHOmOTzkCoOqdmvU6pf-wM228QQSauDsbcL+mmUA@mail.gmail.com>
 <aYysaoP0y4_j9erG@fedora-2.fritz.box> <CAJfpegsoF3dgBpiO=96HPS_xckfWbP2dF2Ne94Qdb5M743kuJw@mail.gmail.com>
 <aY2gS8q0AclXbXJT@fedora-2.fritz.box>
In-Reply-To: <aY2gS8q0AclXbXJT@fedora-2.fritz.box>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 12 Feb 2026 11:23:56 +0100
X-Gm-Features: AZwV_QiU4ozLtnWrBiNEhxBFu8PoxjRKpTmxvZlr0FQ50mbPcBxWmhVwBHpx_C0
Message-ID: <CAJfpegvQPKEP_fYE0xg1RCN9dd4Fb8-eom3o53ewqgboRXW4hA@mail.gmail.com>
Subject: Re: Re: Re: [PATCH v5 1/3] fuse: add compound command to combine
 multiple requests
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Horst Birthelmer <horst@birthelmer.com>, Bernd Schubert <bschubert@ddn.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77008-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[birthelmer.com,ddn.com,gmail.com,igalia.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,szeredi.hu:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4487412C72D
X-Rspamd-Action: no action

On Thu, 12 Feb 2026 at 10:53, Horst Birthelmer <horst@birthelmer.de> wrote:
>
> On Thu, Feb 12, 2026 at 10:38:25AM +0100, Miklos Szeredi wrote:
> > On Wed, 11 Feb 2026 at 17:35, Horst Birthelmer <horst@birthelmer.de> wrote:
> > >
> > > >
> > > > > +#define FUSE_MAX_COMPOUND_OPS   16        /* Maximum operations per compound */
> > > >
> > > > Don't see a good reason to declare this in the API.   More sensible
> > > > would be to negotiate a max_request_size during INIT.
> > > >
> > >
> > > Wouldn't that make for a very complicated implementation of larger compounds.
> > > If a fuse server negotiates something like 2?
> >
> > I didn't mean negotiating the number of ops, rather the size of the
> > buffer for the compound.
> >
> OK, so the current limit would be the size of the whole operation.
>
> > But let's not overthink this.   If compound doesn't fit in 4k, then it
> > probably not worth doing anyway.
>
> Got it!
> Unless some people have the idea of doing some atomic operation with
> WRITE+<some attribute operation> ;-)
>
> >
> > > > > +
> > > > > +#define FUSE_COMPOUND_SEPARABLE (1<<0)
> > > > > +#define FUSE_COMPOUND_ATOMIC (1<<1)
> > > >
> > > > What is the meaning of these flags?
> > >
> > > FUSE_COMPOUND_SEPARABLE is a hint for the fuse server that the requests are all
> > > complete and there is no need to use the result of one request to complete the input
> > > of another request further down the line.
> >
> > Aha, so it means parallel execution is allowed.
>
> Yes.
>
> >
> > > Think of LOOKUP+MKNOD+OPEN ... that would never be 'separable'.
> >
> > Right.  I think for the moment we don't need to think about parallel
> > execution within a compound.
>
> Not only for parallel execution. You cannot craft the args for this to be
> complete, independent of parallel execution.
>
> You will need the result of LOOKUP to know what to do with MKNOD and to fill the args for OPEN.
>
> >
> > > At the moment I use this flag to signal libfuse that it can decode the compund
> > > and execute sequencially completely in the lib and just call the separate requests
> > > of the fuse server.
> >
> > I think decoding and executing the ops sequentially should always be
> > possible, and it would be one of the major advantages of the compound
> > architecture: kernel packs a number of requests that it would do
> > sequentially, sends to server, server decodes and calls individual
> > callbacks in filesystem, then replies with the compound result.  This
> > reduces the number of syscalls/context switches which can be a win
> > even with an unchanged library API.
>
> Yes, but some combinations are not complete when you have interdependencies
> within the packed requests.
>
> >
> > The trick in a case like MKNOD + OPEN is to let the server know how to
> > feed the output of one request to the input of the next.
> >
>
> Exactly. And the FUSE_COMPOUND_SEPARABLE was actually there to tell the fuse server,
> that we know that this is not done in this case, so the requests can be processed
> 'separately'.
> If that is missing the fuse server has to look at the combination and decide wether it
> will execute it as a 'compound' or return an error.

I'd rather add some sub-op header flag that how to fill the missing
input.  E.g. use the nodeid from the previous op's result.

If there's no flag, then the op is "separable".

> > > FUSE_COMPOUND_ATOMIC was an idea to hint to the fuse server that the kernel treats
> > > the compound as one atomic request. This can maybe save us some checks for some
> > > compounds.
> >
> > Do you have an example?
>
> Yes, I have used it for my (not yet ready for scrutiny) implementation of atomic open.
> If you know that LOOKUP got a valid result and the operation was atomic on fuse server side,
> you don't have to check for MKNODs result.

As noted in my reply to Bernd the LOOKUP+MKNOD may not be the best way
to use compounds. May be better off sticking with an actual atomic op
for this.

Thanks,
Miklos

