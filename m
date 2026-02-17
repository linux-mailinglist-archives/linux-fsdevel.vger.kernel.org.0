Return-Path: <linux-fsdevel+bounces-77353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CM/6AA9FlGmcBwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 11:38:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C0914AEB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 11:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3744F303A5D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 10:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5816326959;
	Tue, 17 Feb 2026 10:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dmYLmGrQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E18326955
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771324655; cv=pass; b=ojwV3ndX6394DYecVaWbJTECxOyo0WOqNypGxv1afO57iYracv9BFqB9yIkplXsqnvOGrulXdEmSISt3cK0eCYIUyo9OSAA1tfECHvRw+ItKxmZTsFVOemguXp8U+daHpPP4euv13osb62voJAADrRNS4eYbj6g2gLZYG3a1Yl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771324655; c=relaxed/simple;
	bh=dPjtly+ZxqrcgnTcKSIFDHsF1hA5MWE73lwPbiR8+3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C0fsjCO/bTjm3LZvTGfvj3RKqYnrmk93+fOmtDoV5chHdOxDkU0OzIlBKc9pwtC+wzDgIEuxSxqXZ/zGT6iKpoorpe+1hm+VLco9LHFNwYSmclbKavNRccoZy1GQo63mW7fyRyb/n/Qq/1QUjbNMIYSeR//Q2nT41Ua1KYfAmGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dmYLmGrQ; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38706b10b3bso36851011fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 02:37:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771324652; cv=none;
        d=google.com; s=arc-20240605;
        b=EUHTbuBfhioqEXDKV46ushxIMPS1SHPrF6CJxouAM6V/GQER3wG/RynVSXlf987OS1
         rP6uC0mxW3ZEqxDcdK/qvn8KI1Pv4DI8bWi3LmhAtok4jalH+ITRmq1aK0spyUm6pJ5r
         y8d0GBDBJtDWYWebW2qAbq7VQ/XjXAAovNFUzD+bXT8J3qsm3iotMYN8xJRV8+VcON7y
         +0hpc6A4ug3TbO6zRPCoSPPWcURARIub0s2rWFZy3gR78J6NUeOFsPIx/mi7uZiU4HIe
         TD/QxuKuTE5ltuCs2TBf3hsfQwAhSac9s2piECVZly8kteeFu28E8LdOFS3VLfBE8Q/b
         nr4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NZMo/PtOIzSJeD+bvKh62aH9xtqgsP4XaPk4C2v4d9E=;
        fh=RlfBG/kK5r5QAwzwhpP1WsLh3foVFx1KIHgd47EKWIo=;
        b=hZt1smmSaPiTVE1cwqgpH0C21u1Azzlp/HV6AoYgQXQR/LNWyGzE2XZ2grTZX3gGyJ
         43x2Njyl1RyIC71myu0MMLggB6YLJaOwQqR9dIfHUquxrti2OldwqEjyU/q0XvoGZxvD
         bqDUw53J09RleUq4hwjw57fUTJAu2Bvn9fs3yqmrPvh3H8K+1fx9KSnX7jV1ODrnVg8/
         pp0MkKERqB3q/8Qv0/Z2u2cmVyOzFQu1Hv+MVHzY5VZJNsKL+1l1gaDcca5P2vHsuFr2
         ASdGSAufvj6AhOmFivbpXT3KlpdU5eJoxuQtM1cOK+TYb2ADMtziCX3VfY1wCAuV4Rl7
         DW7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1771324652; x=1771929452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZMo/PtOIzSJeD+bvKh62aH9xtqgsP4XaPk4C2v4d9E=;
        b=dmYLmGrQL6EpWGinGmazJYZO2mJYS/9YAtjKAkQYVsYcu67/5AA8mkj764LmfULiGy
         Bq1tyIlasq5pw9UoS4Sr+XCwvWTBbwX8s+hIVYntsZPYoiwNa3nVU4Db6qMzN0KObR5u
         +szP0cw+XNRlcTzTNf4B5GXh2CK1xmRAFYDmrGhbKeZ1DNZbm24/fY6wlyVWhzNOgLOX
         /tZInKxJH3v+wzSCU2v2Mk1DEhlRMMh0/0h0X+K4aDFEi0cYkMFereA5+SHXhdwt9Ejn
         m9++REQio3HlLCp4R4ZiLcPl3WV10drQ7hxCz+iw3pxBnEx/RC6cNykCWYgpsliYzvIg
         1YKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771324652; x=1771929452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZMo/PtOIzSJeD+bvKh62aH9xtqgsP4XaPk4C2v4d9E=;
        b=W/fK0dvVWEcTwpKgw16LiF0wcaVNdadPQmcYEk2yeRHDCS1Ko4LaWilUTFZ0fV3EcN
         bWqwKfucyA16kHJ5+vrtIphDUGfz0T63EeiFoii4RKhn/7sX77yJX3WWGx2cdLvuqiva
         XsGWPx4ORIve1rNphrR1w+bkJizIXrpAnSdsWSVfK74VjMZ60EYP8hXNqCllZlFzLleT
         FXBImfQK7lj66R141g14tS32XrOqgDyBD3z+dHSwrFAK9VhTdTCNIEhpHYTYtqtJV9Xk
         F8Ffxb5eBm/Nhl8Bp+qv0SnxMI9cg3C80vzJZvJ3K9Pf5bkL2vi1XnIhMcD/XvD36u+J
         BVCA==
X-Gm-Message-State: AOJu0YxNRJ9bd091I1Qpvys7KWoYqzSsZ8Srn/cl7wRuGCbstwh0RTKc
	02fBz13DrR4bsB95AbIJlNLuDyNDG3x74l2aZNd8EWIecuBjl4QFezvMfp7R+3gQ87b68OQaITF
	JhQRJ04mllskx36GII+8GvivcKDUcIb++q0Bici/I1A==
X-Gm-Gg: AZuq6aLVT94TYosV1jhEcjPN0LtxUbyCi1cUBP2O/eOG6rMPKcE4xB1c5wNULscfiwJ
	iGIajRjOGATpl1tIJ4aAUzft48ZTl6WfyTrlt/Gcqh8CjNKAXoZIBk1n/kdvOgyktyOACOTDmiZ
	Vc2HyyAQIGvg2FbYgYt7uTDehWbnCnxvVaGa0Am4WbjzUoiIp3VhWHjiQWYxFPA1QMpXrkShQCb
	NhyH23dAujDBt9EU6C4EIerEoiALgOlLMPtL3qxx/P3z95AUrkJ0Di58p+8Swl+RHSIYCCEve4N
	6aZPUg3M2gBo+doghsqd/UCWrBmORFKV3FqB5ofoYT16os0Z9vrKRQXHEqgB0udqrKBw
X-Received: by 2002:a05:651c:1ca:b0:386:ec21:c87f with SMTP id
 38308e7fff4ca-3881b99cc9cmr30135731fa.42.1771324651832; Tue, 17 Feb 2026
 02:37:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner> <20260119-bagger-desaster-e11c27458c49@brauner>
 <20260129-beidseitig-unwohl-9ae543e9f9f5@brauner> <20260216-ruhelosigkeit-umlegen-548e2a107686@brauner>
In-Reply-To: <20260216-ruhelosigkeit-umlegen-548e2a107686@brauner>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Tue, 17 Feb 2026 11:37:19 +0100
X-Gm-Features: AaiRm52ye33PKO28CcExseV6coNOG-rZ2nBeMP78z80h8Dwp-N455yQLK7UlhmY
Message-ID: <CAJpMwyg-3-Z=ZDC60Vn0s-8Z78VOPKYmvX9s=Nnvcoao4T5zbg@mail.gmail.com>
Subject: Re: LSF/MM/BPF: 2026: Call for Proposals
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org, 
	bpf@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haris.iqbal@ionos.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-77353-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,ionos.com:dkim,forms.gle:url];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ionos.com:+]
X-Rspamd-Queue-Id: 93C0914AEB2
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 3:28=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Jan 29, 2026 at 05:13:52PM +0100, Christian Brauner wrote:
> > On Mon, Jan 19, 2026 at 03:26:39PM +0100, Christian Brauner wrote:
> > > > (1) Fill out the following Google form to request attendance and
> > > >     suggest any topics for discussion:
> > > >
> > > >           https://forms.gle/hUgiEksr8CA1migCA
> > > >
> > > >     If advance notice is required for visa applications, please poi=
nt
> > > >     that out in your proposal or request to attend, and submit the =
topic
> > > >     as soon as possible.
>
> This is (likely) the final reminder to put in your invitation request!
> The invitation request form closes this Friday, 20th February.

Hello,

What is the announcement date for accepted topics and invitations?

>
> Fever has struck me down so all you get is a bad limerick:
>
> There's a conference called LSFMM,
> Where maintainers debate and condemn,
> They argue till dawn
> What's merged or withdrawn,
> Then next year do it over again!
>
> Don't forget to pester^wask^wremind your respective organizations to
> sponsor LSF/MM/BPF 2026! If it helps, you can tell them that we're
> considering renaming it LSF/MM/BPF/AI.
>
> Thanks!
> Christian
>

