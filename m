Return-Path: <linux-fsdevel+bounces-79443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFcoHR2oqGlgwQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 22:46:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C86EC2082CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 22:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75DC8311B853
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 21:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B113C6A30;
	Wed,  4 Mar 2026 21:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPF56mXw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD313C3BF4
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 21:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772660545; cv=pass; b=tMfR05ee69zbYqdIehvPZTQEgC+LIz6y70+fQYasC5i+Jm5HkPlnJQwesaFhxQ/7YV6aDSC7BrynUvDe7HfLZdJFWVrL0i3T7K0TabNXOgd5JJ3hrPFqXjimAAZbK/AkBDm7LcYM3qf84zrKQItaTy6bELWWku5F0UB9K9o5LRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772660545; c=relaxed/simple;
	bh=i1ALXycXCV8XoY21HZ6L/IyAzerARgDINy0i+drQ7g4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVsg1WdFV4HOmioMLwdN7gh7COM35nScU6Jk0eDV9jRDhfXi0hM1cXnF9bO8uJbpNhPwNVtb3mEr88hoVTYtzOqm0mGhPMCn2P3vdt5ht/a1oCW8Zb7cDA6GnZzlREknq5VeaQlSyjmIo/VdQPOw81FhQqwiWak+xXQamcd7xNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPF56mXw; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-503347e8715so88387631cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Mar 2026 13:42:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772660541; cv=none;
        d=google.com; s=arc-20240605;
        b=EyeFB+g8k+xLGHBDoTEYW29Gicdama+NOLCIwwFMQd/yEfP68r4ATeGblBmVI/fqFM
         2e9qZ+3PpUabQYO7vqHeue5gQxxrfWJs+q5CchpLlsqPiq3nNZkgmbfdv2kZkTd6OWBe
         wuEcsanErVjeCJ7FejFQCsGRwN3ipZtbJCFjAMj46x44E0t48No2C/abwDyoZk0ekB8F
         h0Idv7tO958gupW8rR3bHqGJD+RuSGnufDbUwJpEhOXG8jWM9P3Pyr+QpEzW4BmLcV5H
         YyNTNkeQ/3UbIxxHwttlIucR9REm3j8u6gkS/Q9s4hYAowP6tP5PS0K3Lxizhnsv87c+
         jG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/8wrYE/pUnkcaekNRZlYzxl8mOrEZgmxbA+1YveSJto=;
        fh=OI8jOnl9haVB2GhAvsUOs/O6o/RhYWFvmzCMIqpJ5yg=;
        b=loXhhmpt2PBvCIstFFKb6AX6bsgocuMbrxL1T1IIyt3NWFkHxikTXSaTqjXTHroaV1
         HFc6IWZmB0YFZ2NddxESpdSSt3u1gUS4pOVt6C+PsLcwD3ci3yKqjij5jBudIkx0oA8q
         A+qFNq8fZlMmVhZPVBURFbQKOXRcJVG++l7mfcDPd2PWHO4SRgzCC9cvy9kAI6Dn8hHZ
         aoe5boUbbXH8N8oBX55+PHFD4xownioiF1ImdOvoYm+twoFFAyOne0rK4fMiL9dRS3bn
         yStRpDsl+256e0+8OJwIi/aG581Yi7AwEwXAVipffE9IeDP76XGmgUeIzp6MI4TLnFm1
         bl+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772660541; x=1773265341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8wrYE/pUnkcaekNRZlYzxl8mOrEZgmxbA+1YveSJto=;
        b=GPF56mXwvDmHbJISl37RS5eBJA4mlJNpCvUPAbd04v+HJgWVKD3xCARHiuZ7lG+zOt
         Ada2pSD+CKJQQUOtkVa/jvl/yjRHe9Anp+tP5DwAD0wVP/2X3CA+ktNK9GIH1I2HDbtE
         ckW477gHdED75zawdxp+5uFZMELEVYDFIku/QJTLtb+y4GKh0ucjdcoRPFFgywiueLQt
         02OC3yGVWmZL625rOPWHJR8ZWZMXBnK5jpc8aM5+xCXgdZYqMOynZxLvkvrch6PiJjoK
         H+3JcACU0b6jUEBGY+oyyzHC2hhKX8EB8t5wYz7FGgBu2zjsaH2nT8Qmn6JxYpfeu/kD
         x96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772660541; x=1773265341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/8wrYE/pUnkcaekNRZlYzxl8mOrEZgmxbA+1YveSJto=;
        b=faegysEM6zFeaOOjAX6hWjl7nKi8ikk0VR9xS/pheqI9ffHo+8P/Tx0c4GOpU6wTvC
         y3b+CbhHlCCY7B5+6XD4j9o7Onfwqmhr2RPjgMJoow6X6DlyGSMqL6VSH0RuKx1scnwQ
         Z4Krf5XT5IDm76he6SdFsoKJV05vCmozwJPbJ7XA7LUuShVpnxhqh/COrhz4SEuv7MuJ
         Us8Jz5FEOl9IDVrwBYsd5eyx1+pDvn9k+xBJxGTz80yW942u8NsWVRhNGWsFhq63dJ7Y
         Rx0AJm82GVScxJg0vjyjOI+MBLLKNGYDujO5U6ZmFau5D42nO+KJUkYBCsMei/Tprz/v
         TzPg==
X-Forwarded-Encrypted: i=1; AJvYcCU5rjM4rgqCDZmT5Yn+PYhMWksGUxj8+chTmhSyUCngJTvuVIEuTjXVyP8fQNWm+gV99R87dnSjT0SLwJXM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8l6ZJg03LSacRQUPLrJJM4moZdwVA3xUNhjKKoR/EQCzh0PK1
	3VALChfiQOLPOSwcBa9l81ILOliOxrKJcifm7hgK9Vd+Sc81tkCR1cl5JrdoOO5tv4JUrG5VS16
	qjsuHexzyV73KSNlZNe7V5YIdFnSfM3Q=
X-Gm-Gg: ATEYQzz+3MqP2iFsfHQMUfmkEZ7BC/yP6XjVDe+D9HJy2fiY5YTBObWe8YOw5XiXkl6
	xHfvKUv++iQYdI2J16k6b8UqnBnQKA0q+2OelLJmxJXjYXQuB8oHLbr0UH8cIUVG4tiPWWuhAOQ
	BLOr+WTNd9VjNs6BAsJKF+qUFRGNfif6Ovx6MtAcBD+mjmEH2TITGch++6ME4vSnxoGqVLmqW2+
	x8XhDEmuCEophbiRkBH2Mkvq239LpvkvQj1VSMGAN+ZUFtB5thXO2FfQwAFzeWaDNVdwwfn7/26
	PvjbEQ==
X-Received: by 2002:a05:622a:24b:b0:503:2f49:6f81 with SMTP id
 d75a77b69052e-508db3b84e1mr50890701cf.74.1772660541294; Wed, 04 Mar 2026
 13:42:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aaFJEeeeDrdqSEX9@fedora.fritz.box> <CAJnrk1ZiKyi4jVN=mP2N-27nmcf929jsN7u6LhzdYePiEzJWaA@mail.gmail.com>
 <CAJnrk1ZQN6vGog2p_CsOh=C=O_jg6qHgXA0s4dKsgNbZycN2Cg@mail.gmail.com>
 <aaKiWhdfLqF0qI3w@fedora.fritz.box> <CAJnrk1bHSRxiKNefNH_SUq1E93Ysnyk-POjh5GWxy+=8BewKtA@mail.gmail.com>
 <62edc506-2b0c-4470-8bdd-ee2d7fcc1cf1@ddn.com> <20260303050614.GO13829@frogsfrogsfrogs>
 <CAJfpegtTdL5Sxjtm3cKu9ZuYwceCfa2bX15Q3Wr_GQ2JNb84EA@mail.gmail.com>
 <aaa4oXWKKaaY2RJW@fedora.fritz.box> <CAJnrk1Z5uR+TpV-rNbfx4NNWQ=uY2BeS+wADvYN4vNtx7kmw+Q@mail.gmail.com>
 <aaf2evE-RU1Ro_TJ@fedora-3.fritz.box>
In-Reply-To: <aaf2evE-RU1Ro_TJ@fedora-3.fritz.box>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 4 Mar 2026 13:42:10 -0800
X-Gm-Features: AaiRm517YFJpvdHxh6sgW3pDYAOFHbptIXo3AMcRV9_RLUboMNYqdcE8zZb6kfw
Message-ID: <CAJnrk1Z-sSDQVEi8AZCEDwOUwtZhqRqJUce_SWR3aQQW6mLSyA@mail.gmail.com>
Subject: Re: Re: Re: [PATCH v6 3/3] fuse: add an implementation of open+getattr
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>, "Darrick J. Wong" <djwong@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Horst Birthelmer <horst@birthelmer.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C86EC2082CB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79443-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 1:11=E2=80=AFAM Horst Birthelmer <horst@birthelmer.d=
e> wrote:
>
> On Tue, Mar 03, 2026 at 01:19:43PM -0800, Joanne Koong wrote:
> > On Tue, Mar 3, 2026 at 2:39=E2=80=AFAM Horst Birthelmer <horst@birthelm=
er.de> wrote:
> > >
> > > On Tue, Mar 03, 2026 at 11:03:14AM +0100, Miklos Szeredi wrote:
> > > > On Tue, 3 Mar 2026 at 06:06, Darrick J. Wong <djwong@kernel.org> wr=
ote:
> > > > >
> > > > > On Mon, Mar 02, 2026 at 09:03:26PM +0100, Bernd Schubert wrote:
> > > > > >
> > > > > > On 3/2/26 19:56, Joanne Koong wrote:
> > > >
> > > > > > > The overhead for the server to fetch the attributes may be no=
ntrivial
> > > > > > > (eg may require stat()). I really don't think we can assume t=
he data
> > > > > > > is locally cached somewhere. Why always compound the getattr =
to the
> > > > > > > open instead of only compounding the getattr when the attribu=
tes are
> > > > > > > actually invalid?
> > > > > > >
> > > > > > > But maybe I'm wrong here and this is the preferable way of do=
ing it.
> > > > > > > Miklos, could you provide your input on this?
> > > >
> > > > Yes, it makes sense to refresh attributes only when necessary.
> > > >
> > >
> > > OK, I will add a 'compound flag' for optional operations and don't
> > > execute those, when the fuse server does not support compounds.
> > >
> > > This way we can always send the open+getattr, but if the fuse server
> > > does not process this as a compound (aka. it would be costly to do it=
),
> > > we only resend the FUSE_OPEN. Thus the current behavior does not chan=
ge
> > > and we can profit from fuse servers that actually have the possibilit=
y to
> > > give us the attributes.
> >
> > in my opinion, this adds additional complexity for no real benefit.  I
> > think we'll rarely hit a case where it'll be useful to speculatively
> > prefetch attributes that are already valid that is not already
> > accounted for by the attr_timeout the server set.
> >
>
> So the current consensus would be to use the compound when we
> either don't have the data, or it has become invalid,
> and use the current behavior
> (just do an open and don't worry about the stale attributes)
> when we have unexpired attributes?

In my opinion yes that would be the best path forward. I don't think
we should be optimizing for the distributed backend stale attributes
case as it introduces additional complexity and overhead and the case
is rarely encountered. I think it's better handled by the lease idea
Miklos mentioned.

Thanks,
Joanne
>
> Thanks,
> Horst

