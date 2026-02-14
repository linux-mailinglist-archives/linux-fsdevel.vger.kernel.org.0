Return-Path: <linux-fsdevel+bounces-77195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FccEHfRj2miTwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 02:35:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8675913AB55
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 02:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9BE2303FFCF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 01:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788A61B142D;
	Sat, 14 Feb 2026 01:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boTrQg0K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91C68F5B
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 01:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771032944; cv=pass; b=UINsif/a7TvC2PD2ORvRO/C2VbF1z+R+jC9PnsST14IaYgKjzLDXR+1AZw+VO/MxWvHZUM7xoYIhQpBg1tRDUavPvuc00hRzq/Tet+pFiFqimWeui1aUk3StHf10+hvweV2qfkYacwhjBPfqiISdjFqTTCZXbZZ50N1zOPaO5b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771032944; c=relaxed/simple;
	bh=GveYgWda2OPRLzU5QtwrxM3VvIOudslKQM5F0SP/++Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1av7bCrbjzO3cmhWa4yju16E1j+mncB7+v+FV+nIKoO/qSUJ99ybrKMzJIvqrZHh3bVDd0Vmor3Qa9t9OX5O0IXhpK3kuPSYuEgcYLYWXZilUozlGUlfbqTOyJs9M+8S13ZNgSHspnpUX4zg+M3HJx9z5+iSZNTZR6krDobChs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boTrQg0K; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-896ff127650so26266896d6.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 17:35:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771032942; cv=none;
        d=google.com; s=arc-20240605;
        b=C1cW31tjbFGLGH8i5cE30T46jT5koQVhjD3os/tV4vxfJBij/Kt7UV8Tf9kbfXxrcF
         MvR9lwwMFKPY4jqIRStrAMfAZnCaemO5MMtlzdRSwZq7moaNKW+J7FC9RNPmAEKd2/5M
         qZ3eubCRBrvMe7ASenwK7NoOY+yAjj/+ZBcWnLhYHUVnXzdZWuyyYZwzsAt034C5EpKb
         GPhEI4lfjvjYNFDCgEo0HXUqcAPMFieUmZqIKLocBvdN6Id+CpmSLd+OYeiJBQj6Dko5
         kTdeKtn0/NO8sJqX2ZwOZXh/vgp1z/yTYEF5Ly4nAy2zhRPyreSecVvPQ37ATV4tmG1F
         bygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9cPscnNVg18OGQOw4fEnZinXvci84JL8uZzmOk+Vve8=;
        fh=Uq0Ez+RLAvnCGETY3fQVSt/T+DjsyEfdGONLYt5PUzQ=;
        b=Koq3pm3e2hhk5Pg8uxFPIEkNWdCslx9eauYDuYd7BDTlrzyBJb73OWjjb5CxFuuB71
         h4Jez0nR0yTgSzJuFs7WH7IvLcyzbPEE7phalaK/IlJcQbn2AusB8XDGQtCW0LQlm5uR
         rmqdN4Ni4PWh6VgcI6b3udT6Q5LTAYdJ40VywyMRFXHGNWd1qFHR+4POQhkcmYwgOgYX
         F6gpvzjta8dH9rBKOVQJMMJU9TNM7CQ9AU5ERofBrukpqG+/mwVFnzHuJKsQziih/fst
         tV0ec6gBB1IJMxEmBIKTrBgDlBTOcVLfhzdAFjb1dq6whLTRKJqmoa4LJZ0jj3V/6wJL
         g+eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771032942; x=1771637742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cPscnNVg18OGQOw4fEnZinXvci84JL8uZzmOk+Vve8=;
        b=boTrQg0KDwSsV3BhNTRyKnRdAF7yYuQERXOD39LCOE32674r1+sVQ681gKz2hJ1JpU
         3Redkdw+Zw1mlevpk14WBtJVzs/EEHJUAe+fci2FT6NBLchs+7LCbL5d39mBTXHJNq6l
         028T7FhTM0m+HgPqivtb1NrZxRbfGr/SIJJ/vDUvfA+smagPXiDu2BiI8AGgVZyui9DR
         7qCVaTc5x/Vfiojzcx7NqPNs0DpJ8+cdlIttKrP1Jq4aS3Q87mtzwWy/GQHmUb9YmCew
         zbISEzuZb5z+FyoimGq1MpQjMRQxnzyiMLdbuEKyfWXJ1iUZt4BPVUn05wD4bvTKST8k
         PmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771032942; x=1771637742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9cPscnNVg18OGQOw4fEnZinXvci84JL8uZzmOk+Vve8=;
        b=rAALZlEcUepThOc0i7/trLHXAuQd+pG9MGfrSdRXNGFF7//GAgDHC2ohsFGWsnRLF9
         Dr7sABF/4vdKfTNXDK6Mkrm3zpBADrXCzvcOcaNyGTMPMnvyOCAeC+dQUMH5DQN8Hba6
         TqpyOUdBnAYF+OO1jlnkslkKScRh2KxJctGxrkgVQ6pFGik3N8lMrmX0frpYeuRTs6Wf
         6VqTRZgBvSwPu0hfw5nHHE1yDUYMNkR4UAL9eLIsIpXTDa2rA0zdmfyt1/pr0et6SVfu
         PJ4MLzBMILSWrmGokkuqwBFJwVQBMerGntpEQ12/9yCKB+O4UlPOoHnwL26ctEbCj7VP
         QpoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjroo3ZBQZz+ww4cs+ylxLy5eRA7IVTNGkFsCJaV56mHGbm9sA6yTmrSV/SLdQ3aydvIptcQZakpdo5b70@vger.kernel.org
X-Gm-Message-State: AOJu0YzAtpWmSJoWfJd9FIRxqZGit7JiOYpMj9HDgLwyIYNtJm+qyyd0
	vFDFC7Aise8CgUIu8IGgq/+bSvn/Df97zYbhIqCUycVzIrxY5peiDsMApFIKSPVsiPLK6Rd/5KR
	uxNA7wAMx2XpFFZlFW/VpiHbKjl1vZsg=
X-Gm-Gg: AZuq6aLUP8u0ezV3+OhoArwvsRzB3HdqBo12wISkYGjkZnCwVBUY3HwckqQR+fk/k4S
	YBWWPGlT0JBfQsXW7SESOyZLgJB/oouP6E7rn/d9qsPOgkHjPly3Gl13rZFV+Sc0vh3vr55HaC2
	Ev+NLjCvu8Y/vcls3NmVjUnUEY/G4qntVDWAfYn4uoClNkK0qlJ3TrYhwLuwIc90YJTuUVgD0og
	VsbSy3k/XbEISR1Ta1+mh65f6fxbHlYPLSwfWIWhG8kXsN+q/vmojU+BVmGa1HRjKQr1cx31g2x
	xVD6rA==
X-Received: by 2002:ad4:5941:0:b0:894:6a0b:2483 with SMTP id
 6a1803df08f44-8974049cad3mr24642266d6.53.1771032941679; Fri, 13 Feb 2026
 17:35:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com>
 <20260210-fuse-compounds-upstream-v5-1-ea0585f62daa@ddn.com>
 <CAJfpegvt0HwHOmOTzkCoOqdmvU6pf-wM228QQSauDsbcL+mmUA@mail.gmail.com>
 <f38cf69e-57b9-494b-a90a-ede72aa12a54@bsbernd.com> <CAJfpegscqhGikqZsaAKiujWyAy6wusdVCCQ1jirnKiGX9bE5oQ@mail.gmail.com>
 <bb5bf6c8-22b2-4ca8-808b-4a3c00ec72fd@bsbernd.com> <CAJfpegv4OvANQ-ZemENASyy=m-eWedx=yz85TL+1EFwCx+C9CQ@mail.gmail.com>
 <d37cca3f-217d-4303-becd-c82a3300b199@bsbernd.com> <aY25uu56irqfFVxG@fedora-2.fritz.box>
In-Reply-To: <aY25uu56irqfFVxG@fedora-2.fritz.box>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 13 Feb 2026 17:35:30 -0800
X-Gm-Features: AZwV_QgVflvdDFvt8-2tBmOYaCGz1HDFLAVJXoRs07jLdCCBfCx64ck3Oi9a9IY
Message-ID: <CAJnrk1bg+GG8RkDtrunHW-P-7o=wtVUvjbiwQa_5Te4aPkbw1g@mail.gmail.com>
Subject: Re: Re: [PATCH v5 1/3] fuse: add compound command to combine multiple requests
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Horst Birthelmer <horst@birthelmer.com>, Bernd Schubert <bschubert@ddn.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77195-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birthelmer.de:email]
X-Rspamd-Queue-Id: 8675913AB55
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 3:44=E2=80=AFAM Horst Birthelmer <horst@birthelmer.=
de> wrote:
>
> On Thu, Feb 12, 2026 at 11:43:12AM +0100, Bernd Schubert wrote:
> >
> >
> > On 2/12/26 11:16, Miklos Szeredi wrote:
> > > On Thu, 12 Feb 2026 at 10:48, Bernd Schubert <bernd@bsbernd.com> wrot=
e:
> > >> On 2/12/26 10:07, Miklos Szeredi wrote:
> > >>> On Wed, 11 Feb 2026 at 21:36, Bernd Schubert <bernd@bsbernd.com> wr=
ote:
> > >>>
> > >
> > >>> So as a first iteration can we just limit compounds to small in/out=
 sizes?
> > >>
> > >> Even without write payload, there is still FUSE_NAME_MAX, that can b=
e up
> > >> to PATH_MAX -1. Let's say there is LOOKUP, CREATE/OPEN, GETATTR. Loo=
kup
> > >> could take >4K, CREATE/OPEN another 4K. Copying that pro-actively ou=
t of
> > >> the buffer seems a bit overhead? Especially as libfuse needs to iter=
ate
> > >> over each compound first and figure out the exact size.
> > >
> > > Ah, huge filenames are a thing.  Probably not worth doing
> > > LOOKUP+CREATE as a compound since it duplicates the filename.  We
> > > already have LOOKUP_CREATE, which does both.  Am I missing something?
> >
> > I think you mean FUSE_CREATE? Which is create+getattr, but always
> > preceded by FUSE_LOOKUP is always sent first? Horst is currently workin=
g
> > on full atomic open based on compounds, i.e. a totally new patch set to
> > the earlier versions. With that LOOKUP
> >
> > Yes, we could use the same file name for the entire compound, but then
> > individual requests of the compound rely on an uber info. This info
> > needs to be created, it needs to be handled on the other side as part o=
f
> > the individual parts. Please correct me if I'm wrong, but this sounds
> > much more difficult than just adding an info how much space is needed t=
o
> > hold the result?
>
> I have a feeling we have different use cases in mind and misunderstand ea=
ch other.
>
> As I see it:
> From the discussion a while ago that actually started the whole thing I u=
nderstand
> that we have combinations of requests that we want to bunch together for =
a
> specific semantic effect. (see OPEN+GETATTR that started it all)
>
> If that is true, then bunching together more commands to create 'compound=
s' that
> semantically linked should not be a problem and we don't need any algorit=
hm for
> recosntructing the args. We know the semantics on both ends and craft the=
 compounds
> according to what is to be accomplished (the fuse server just provides th=
e 'how')
>
> From the newer discussion I have a feeling that there is the idea floatin=
g around
> that we should bunch together arbitrary requests to have some performance=
 advantage.
> This was not my initial intention.
> We could do that however if we can fill the args and the requests are not
> interdependent.

I have a series of (very unpolished) patches from last year that does
basically this. When libfuse does a read on /dev/fuse, the kernel
crams in as many requests off the fiq list as it can fit into the
buffer. On the libfuse side, when it iterates through that buffer it
offloads each request to a worker thread to process/execute that
request. It worked the same way on the dev uring side. I put those
changes aside to work on the zero copy stuff, but if there's interest
I can go back to those patches and clean them up and put them through
some testing. I don't think the work overlaps with your compound
requests stuff though. The compound requests would be a request inside
the larger batch.

>
> If we can signal to the fuse server what we expect as result
> (at least the allocated memory) I think we can do both, but I would like =
to have the
> emphasis more on the semantic grouping for the moment.
>
> Do you guys think that there will ever be a fuse server that doesn't supp=
ort compounds
> and all of them are handled by something like libfuse and the request han=
dlers are just
> called without having to handle not even one unseparatebale semantic 'gro=
up'?

If I'm understanding the question correctly, yes imo this is likely.
But I think that's fine. In my opinion, the main benefit from this is
saving on the context switching cost. I don't really see the problem
if libfuse has to issue the requests separately and sequentially if
the requests have dependency chains and  the server doesn't have a
special handler for that specific compound request combo (which imo I
don't think libfuse should even add, as I dont see what the purpose of
it is that can't be done by sending each request to each separate
handler sequentially).

Thanks,
Joanne

>
> >
> > Thanks,
> > Bernd

