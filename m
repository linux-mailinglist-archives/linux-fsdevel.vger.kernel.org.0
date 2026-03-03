Return-Path: <linux-fsdevel+bounces-79283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBXQM65Rp2lsgwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 22:25:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B281F7795
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 22:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA2FF30DE1AF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 21:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CB33BED7A;
	Tue,  3 Mar 2026 21:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkbTqIgJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B6F32AAD1
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 21:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572796; cv=pass; b=tsMsvoA+Vvrq/b5dh1EfYMdqHi+pnel+S98Qkic9x4odghf3wzISU0ig8Un/LWh/9a+GZ37WpAnYWax3LFG2lAFI8Yb20cPpX1Msj+6YlIkoocwqrnkzY7mYBqeqecRmxq0Q3GRRpt2vMW+DO+cMC2pjoGb3AxjUfcCgLyAgAvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572796; c=relaxed/simple;
	bh=zayJdgoyek51NMVKoC+nXbdP3vPrtdkUzlwMXaUEJeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b9oX8vn2xluQsqtmKe2zasRhEXWeZ5C7uG1TqwNpHYYXTiTPo4ZH1TVcGxj3p4CfKO12EZDfK1wZiGK60Xgw5i9HJ5aT7tFkd/CXwHT7dm9UGfSwSCJnkBWTcHhlYGACAKkbNPMsASUw4gtlSJixc18ZAduqkFXpwSIrevHWQ04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkbTqIgJ; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506a67282a0so59907671cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 13:19:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772572795; cv=none;
        d=google.com; s=arc-20240605;
        b=RNnGU8U1hXuDw6IE2UvaYWxjvXwuPrs2n9pUkOEts6G0YglKVJjhaNhSSygdV3KDG+
         t8DoOp1Ei7Ew3Aosp0FreyU8k/pyTnSzus2tklzH+8qKSopAF0oUehysocaJmiYvy4hf
         ZOwxo+HVi13mPeYzxg/1R4OGfdTh30otZezwgJ//LxE8mxFT2BY04FeNdpCOs/PNjMsd
         JPxUdgftA+3Z5aBcD5EHkmV2qorDsr4EnXV3UVNkIretoZFtY7+zyMkveWVZZbRFhgnR
         9mlEkMVkLL/cHbiTcuqunltYV28n6MWjk7Y8AeseNipyQEDk6fqcgNhOx9g6cbuGzb6C
         VoLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uuGo984LJOrfuHT+ZXEAKkRyIL3YQz9Q7vgZKeXYaKw=;
        fh=IdhvPvqshh9wTz3mOo87Vw2qwBIcVwBWeHztO6bfSV4=;
        b=Pzt0aOaK9BV2jgyJGkDFXK2F/SwZ/43PmZZfn2lrNuwJHGCnylnjNfyiDajPGuZHzb
         V48Eqf1/+ynEboYArmlYRxmmZrIf6dv8tgtGj8JZMH2048Ag64J/3Z0l0opAxi7swOm7
         PrYk0QqC83GKkPPENhF59SEq5ofbpgrRIWUhTMuCJWjdVaD0f0r2+Vat5uDEbI+2BlT5
         RfjalU6U2MyRUFAA6SRlyT8/SNoxDdXZ6oGtJb+YGkxrsKbUY8paDHaSXvKnVeJHIWQX
         /tE5c+BPIBjohE9C8KGWqoSAUH4uGGar04QLmQ8l0jv5jqDsWzyukaNdtoZlAzBae29A
         VcnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772572795; x=1773177595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuGo984LJOrfuHT+ZXEAKkRyIL3YQz9Q7vgZKeXYaKw=;
        b=DkbTqIgJMBgY4ZGGZmTuQletfiWZ4UDNcojrVltFPKYqflnseH/7xW1/OjSMiD5CSb
         q51rg9dvQhOuPmSQPjP3492a19e79kLVXcpp+nYbgzvk4PZGmTMKAySEEuahFVH4Z4od
         kPUyzdDXt1luuRbWJHOp2DCmKSJtijCorIDM8js0lTqPvl6FRI6lpCbBzR6r++AOITpJ
         PPJf3USnUFHVnJzJt5u90SnlJMCVCxTmQ5oyfaU//K9qSNbrFiBYhowezL3/3+rqEicF
         teP7Q/l4Y/QYbiz9WSAvLG9EIAy8uXtdvj28gycUY/H0LoFopgmLMDv4DuTtOsiL40qs
         knGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772572795; x=1773177595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uuGo984LJOrfuHT+ZXEAKkRyIL3YQz9Q7vgZKeXYaKw=;
        b=WPgI36lN2t/9ljlFRoCyubei6MbJZbFxZ+GZ2d+W6jHE2ULY5HVTkeBQg3362I6+kt
         CtIDHuN4oLaoUkV7hoDwwl7DbUA3NvSvivaNor0sNzQ7EjAxf1169E+8lA+9ucFwCh0/
         +NXsrUo35xrnkcO1OOBxNQWKRkNHpLTMU2ME/qGodPaluGh+AdK1b+qZhit4sBzj7Daw
         EcG5P1t3E+q49ir1UHGIOwJ37LzNyQljc0uTqZ0QA+UkTvdBqJLDiCahfCFOPbSuIj9x
         6aMwJu3np1JgfQ0JT0lekbYvR0tAmB0Mxb98YHL78vyhrOzMeuXr2v4DQK/0H9VOfhnB
         1ehg==
X-Forwarded-Encrypted: i=1; AJvYcCVundVkUm97LEioG2krkG3QDpDk74i1RPpabx3YhrsH0kmDAuvRdepaXP6jYetcJRwCwylrpP6YUpmGvEY0@vger.kernel.org
X-Gm-Message-State: AOJu0YyKIHq8VxsivQ2zTylhzRrcgxndjdw7ZduZ3eyXSEDpPN1erdUA
	1NQBbULhRggtgOu9BcSz38gGvElAn7u1WXUugj8pwoLh8CnXeIapzZt8ivDwnbh2ZFDciNsNdcY
	wyNFrt+5St6guXqXrviSgrUJ6bVKI7QQ=
X-Gm-Gg: ATEYQzxRa83naz2HfzQOFmjTh/A6jw+8lvUwFmoePru4oRK1LFB2rQmpGbLw+hXTw6s
	e7XCIkJVPp5rXS85k+nMdM+yx5kCObldChXx9DqPQ4lEJ3A+bBatPiiQvnq1rzuwLCVDPdw0sCY
	A8g9ie1UY/thV6DLcEoe0r1kdT2PSRlvJqLxJFWEnMKXptKKZ9QHZM08DnncJy8Wr07rAExbgQB
	KDFuW36AiQVMGOM04zRcWImgwjC+1ZFTMWEMEdSxl+WUWGsDBtjTag4WhH0HlHCyR2yz2foO1uW
	ZWZaxA==
X-Received: by 2002:a05:622a:241:b0:506:2116:4b86 with SMTP id
 d75a77b69052e-507526ee236mr219452831cf.0.1772572794586; Tue, 03 Mar 2026
 13:19:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-fuse-compounds-upstream-v6-3-8585c5fcd2fc@ddn.com>
 <CAJnrk1ZsvtZh9vZoN=ca_wrs5enTfAQeNBYppOzZH=c+ARaP3Q@mail.gmail.com>
 <aaFJEeeeDrdqSEX9@fedora.fritz.box> <CAJnrk1ZiKyi4jVN=mP2N-27nmcf929jsN7u6LhzdYePiEzJWaA@mail.gmail.com>
 <CAJnrk1ZQN6vGog2p_CsOh=C=O_jg6qHgXA0s4dKsgNbZycN2Cg@mail.gmail.com>
 <aaKiWhdfLqF0qI3w@fedora.fritz.box> <CAJnrk1bHSRxiKNefNH_SUq1E93Ysnyk-POjh5GWxy+=8BewKtA@mail.gmail.com>
 <62edc506-2b0c-4470-8bdd-ee2d7fcc1cf1@ddn.com> <20260303050614.GO13829@frogsfrogsfrogs>
 <CAJfpegtTdL5Sxjtm3cKu9ZuYwceCfa2bX15Q3Wr_GQ2JNb84EA@mail.gmail.com> <aaa4oXWKKaaY2RJW@fedora.fritz.box>
In-Reply-To: <aaa4oXWKKaaY2RJW@fedora.fritz.box>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 3 Mar 2026 13:19:43 -0800
X-Gm-Features: AaiRm52tUR-GHOd3FJjlbJMUY_aWjIVX2Xk7-Bvf4m6HN7aKym1g--u_UJQpnCU
Message-ID: <CAJnrk1Z5uR+TpV-rNbfx4NNWQ=uY2BeS+wADvYN4vNtx7kmw+Q@mail.gmail.com>
Subject: Re: Re: [PATCH v6 3/3] fuse: add an implementation of open+getattr
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>, "Darrick J. Wong" <djwong@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Horst Birthelmer <horst@birthelmer.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 37B281F7795
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
	TAGGED_FROM(0.00)[bounces-79283-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,birthelmer.de:email]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 2:39=E2=80=AFAM Horst Birthelmer <horst@birthelmer.d=
e> wrote:
>
> On Tue, Mar 03, 2026 at 11:03:14AM +0100, Miklos Szeredi wrote:
> > On Tue, 3 Mar 2026 at 06:06, Darrick J. Wong <djwong@kernel.org> wrote:
> > >
> > > On Mon, Mar 02, 2026 at 09:03:26PM +0100, Bernd Schubert wrote:
> > > >
> > > > On 3/2/26 19:56, Joanne Koong wrote:
> >
> > > > > The overhead for the server to fetch the attributes may be nontri=
vial
> > > > > (eg may require stat()). I really don't think we can assume the d=
ata
> > > > > is locally cached somewhere. Why always compound the getattr to t=
he
> > > > > open instead of only compounding the getattr when the attributes =
are
> > > > > actually invalid?
> > > > >
> > > > > But maybe I'm wrong here and this is the preferable way of doing =
it.
> > > > > Miklos, could you provide your input on this?
> >
> > Yes, it makes sense to refresh attributes only when necessary.
> >
>
> OK, I will add a 'compound flag' for optional operations and don't
> execute those, when the fuse server does not support compounds.
>
> This way we can always send the open+getattr, but if the fuse server
> does not process this as a compound (aka. it would be costly to do it),
> we only resend the FUSE_OPEN. Thus the current behavior does not change
> and we can profit from fuse servers that actually have the possibility to
> give us the attributes.

in my opinion, this adds additional complexity for no real benefit.  I
think we'll rarely hit a case where it'll be useful to speculatively
prefetch attributes that are already valid that is not already
accounted for by the attr_timeout the server set.

Thanks,
Joanne

>
> We can take a look at when to fetch the attributes in another context for
> the other cases.
>
> >
> > Thanks,
> > Miklos
> >
>
> Thanks,
> Horst

