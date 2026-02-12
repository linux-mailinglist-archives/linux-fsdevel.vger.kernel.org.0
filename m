Return-Path: <linux-fsdevel+bounces-77017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNUlGlTDjWlt6gAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 13:11:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF6612D521
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 13:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B3D6305D6E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 12:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8E33570B6;
	Thu, 12 Feb 2026 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fZwprfz1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E245B665
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770898232; cv=pass; b=CSIfthx4xc6gSXHu/Vb3FMY4lseg5EmoIrsF7pwmWwfOI0Ud6AbrOMBt0pqepin76MFjzGB7uLiKPVCJes+P3xGfsuBEPdwOe9MLIc5r82NIfCgu80PmrtLo+ZQGb+uTNUffit7y+ZizbVELnV2hmiHMiknoBpw8/fuoubLX4k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770898232; c=relaxed/simple;
	bh=MSu5Wt3uQM+xaRf0M2PCkHl44UEIqh3BwSJzrGmiw5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AjvscrVGNsv22LaEiiLER6A9bQ0LovVsxcQXT/OEGN1jK2K1s1S0Udj9Tj2TJEqY/PwAJGuZSzL9raKmZGF/fe1ATLas2u8V6eQJ9Tk3uLczKGi8x9m7OYYs6HmDUI2QJW4NGu3c2MU+dboIVPjqPrfyM2DSbobWkUFUoI3FgOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=fZwprfz1; arc=pass smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c531473fdcso864048785a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 04:10:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770898230; cv=none;
        d=google.com; s=arc-20240605;
        b=k7rDk48jLsTByq+p/74xImOkxvmukhaM7PJYW2L70u6SHnxcpBGFqsTKh7eHvL1nIO
         vZr5GEqjlf0SD4UInoNqAXtal0v3UFiEDOC+Zpnzt0Aqj0+ghtbLfFhmgBAPKK/4W1hy
         SRCBCND1tDDl1DjZosi4GB2qpi44sRGc9v2ZWpEA+RqXSTzuf/q05YK/TTIgtx9lDFh+
         ehGgBkJ9T4Fw+TXX9IXfz+18rnef6tYjzcV5measqmvOnAoBNv97tLpt1pUfoxYKWp8+
         PoouBRl+vZKtDRcUTwExX4OU9X8d5ceHWbuRuHRPCduo233iIvECcwvfZnd4gKcBcwaU
         xRoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FcyE5uYd2/LCh01kUNPb+LBrkZ3vQxzSxNaV7r0MrXg=;
        fh=JEv7ZCi27B5PK5qxFr97jFR0OqBnn5zBKPEr1qfvhRA=;
        b=PVs167+L1yWxxRqwxO87KYRw4IPn05CZHxnlgTILP8iLqIZtgo/LdTKF5l1md3c81A
         IBzuJ+i2hv+8Ee5l4nEG7QRUBwPEAyqXmhAmdzNFlTrRPG+6ucAWLArTHcm6cABk38w7
         zBn4J9nWT7Sa/5z7mDQlo8yzYo9F2GpiiIDHttwSdSERBdShE/ItWeZDQ1oBp3kOo02x
         hNjZRykTBwBwzrXQI4JKpFJWFOnBu2UbFS1OVGdUMhepN6LzKNWYQeM2Hzf+AjbbNj70
         TT4r86KMYpVaXJ7aNcwj/ts0iqixcHo3bOJqLv9Ho+6ew4O0jJB2xvNh+GvcIs4MxymD
         JUGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1770898230; x=1771503030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FcyE5uYd2/LCh01kUNPb+LBrkZ3vQxzSxNaV7r0MrXg=;
        b=fZwprfz1xl0ba/OZB+Rc6FXi0MSE28xy6oMV5H79OXCU+iOwHj6IRL0BPFM1B9zAum
         9zL57IE0ARpDBTGjMlfad/RRGEHEI9RRvgrV6qt73hck/0EAt1reM8UA25R0/mhEjBbD
         66vQeE7GV2lvZRHlntB/VTG/t9WoT6gHnPaKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770898230; x=1771503030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcyE5uYd2/LCh01kUNPb+LBrkZ3vQxzSxNaV7r0MrXg=;
        b=NO0kZk9BGATw/UVFRu9PPWlnhT8QZUsSxMLsOzrVWpQf73rWEvKbKiMaSiAgvpbaYs
         1lysUmnQztx+cmkiJV9kPczm4+vIv4mQ4SleQMv4zL7jEe7cJAH+DNMv0xejanLgxnXV
         x52sZXNRgv+dwUVsaOhb0hKTXPNZuUYERN2TtwaBdPxC68eAbcioTsCrW+Yq72sPalZ+
         KmKu+66fS/3aq15hnZuNA/oYAwTlHh54c1rfZiTdG+lqu0l0FNzVmHd/HZbZBfVUFasw
         WLJbVXTkZhsCvjRwD8+YXoVtiV5kyXsQWS/RWuV5zum0+hhUviiYyZrlHAUco3zzsfZm
         EoxA==
X-Forwarded-Encrypted: i=1; AJvYcCXsoO19VvubuUKvxpGyKIKs0x0wwBkjR6k/0xeNCKX6OBTDh561FmJmsd5pNDFjzKbsc3lAu6qJj72HQEng@vger.kernel.org
X-Gm-Message-State: AOJu0YwlrWA7dxT1n1JofpAgvQb98Der/QwaIM2Ep41/xBlwRLbWKvZ7
	UPp4o2kipPgzCiTaa59HijkgDrnnx7LWOR3RcZd8QiKKnX4zEzkkWow+xokIZ4/IMlcLD18m0CV
	y4ivGoEIOAhglPyNNTBqmsOxHGvCuzC0D/uOyp2RY/w==
X-Gm-Gg: AZuq6aILq2rcZ3LznMBCx9W/YvA6+XlnW+vOGFBSJhjw7rurHqcYfR1HAy8MdFWPI07
	0c+OzLyEAmJrkbsxAM404SDKfGSYfTdNPJJI+DMCCftPFqYObQOZBimwUB89BezE9/kkSHPwM0j
	bqttnXSTP0z8AlFP7lTj3LyBHqPwa8LdGBP3pPUG67G/3DOjQRGc59z657oxAnHJhPlD5kaLLJh
	bB7F1Jt4CJLAdDtVNuj0yczjwv6WQ1ppaJbFRSKza+ZYolXNfj2ddcldz0YMOqUqb5iv+Nz6ZYF
	Y5qgKQ==
X-Received: by 2002:a05:622a:14cf:b0:501:17a9:5ff5 with SMTP id
 d75a77b69052e-50691a27db3mr39817761cf.21.1770898230215; Thu, 12 Feb 2026
 04:10:30 -0800 (PST)
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
 <aY2gS8q0AclXbXJT@fedora-2.fritz.box> <CAJfpegvQPKEP_fYE0xg1RCN9dd4Fb8-eom3o53ewqgboRXW4hA@mail.gmail.com>
 <aY2sZifjV-Hl3t_j@fedora-2.fritz.box>
In-Reply-To: <aY2sZifjV-Hl3t_j@fedora-2.fritz.box>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 12 Feb 2026 13:10:19 +0100
X-Gm-Features: AZwV_Qi3elyp96XWRraYFjnW89GVujW_1iWNaaFGZUaR1uituz8OCM23CAFDViE
Message-ID: <CAJfpegvZiBb6oJCeTeLDiHdUsKEkSLuifrmmMh3aRnXFBzkRkw@mail.gmail.com>
Subject: Re: Re: Re: Re: [PATCH v5 1/3] fuse: add compound command to combine
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77017-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,szeredi.hu:dkim,birthelmer.de:email]
X-Rspamd-Queue-Id: BEF6612D521
X-Rspamd-Action: no action

On Thu, 12 Feb 2026 at 11:48, Horst Birthelmer <horst@birthelmer.de> wrote:
>
> On Thu, Feb 12, 2026 at 11:23:56AM +0100, Miklos Szeredi wrote:
> > On Thu, 12 Feb 2026 at 10:53, Horst Birthelmer <horst@birthelmer.de> wrote:
> > >
> > >
> > > Exactly. And the FUSE_COMPOUND_SEPARABLE was actually there to tell the fuse server,
> > > that we know that this is not done in this case, so the requests can be processed
> > > 'separately'.
> > > If that is missing the fuse server has to look at the combination and decide wether it
> > > will execute it as a 'compound' or return an error.
> >
> > I'd rather add some sub-op header flag that how to fill the missing
> > input.  E.g. use the nodeid from the previous op's result.
> >
> > If there's no flag, then the op is "separable".
> >
>
> This makes the handling on the fuse server side unnecessarily harder.
> With the current way I can check the flag in the compound header and let libfuse handle the
> compound by calling the request handlers separately, and not worry about a thing.
>
> If the flag is not there, the fuse server itself
> (passthrough_hp from the PR already demonstrates this) has to handle the whole compound
> as a whole. I'm confident that this way we can handle pretty much every semantically
> overloaded combination.

Yeah, that's one strategy.  I'm saying that supporting compounds that
are not "separable" within libfuse should be possible, given a few
constraints.  Something very similar is done in io-uring.  It adds
complexity, but I think it's worth it.

I also have the feeling that decoding requests should always be done
by the library, and if the server wants to handle compounds in special
way (because for example the network protocol also supports that),
then it should be done by bracketing the regular operation callbacks
with compound callbacks, that can allocate/free context which can be
used by the operation callbacks.

Not sure if I'm making sense.


>
> The other way would make the handling in libfuse or in the lowest level of the fuse server
> (for fuse servers that don't use libfuse) almost impossible without parsing all the requests
> and all the flags to know that we would have been able to get away with very little work.
>
> I had thought of a hierarchical parsing of the compound.
> The fuse server can decide
> 1. does it handle compounds at all
> 2. does it support this particular compound (based on the opcodes and the compound flags
> and the particular capabilities of the fuse server)
> 3. if the particular compound can not be handled can libfuse handle it for us?
>
> This way we can have real atomic operations in fuse server, where it supports it.

Yes, that's something definitely useful.   But I also think that the
fuse *filesystem* code in the kernel should not have to worry about
whether a particular server supports a particular combination of
operations and fall back to calling ops sequentially if it doesn't.
This could be all handled transparently in the layers below
(fs/fuse/dev.c, lib/fuse_lowelevel.c).

> I don't understand yet, why.
> I think we could actually implement a real atomic open if we craft a compound for it and
> the fuse server supports it. If not, we can go back to the way it is handled now.
>
> What am I missing here?

I'm saying that there's no point in splitting FUSE_CREATE into
FUSE_LOOKUP + FUSE_MKNOD compound, since that would:

a) complicate the logic of joining the ops (which I was taking about above)
b) add redundant information (parent and name are the same in both ops)
c) we already have an atomic op that does both, so why make it larger
and less efficient?

Thanks,
Miklos

