Return-Path: <linux-fsdevel+bounces-75776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGNAJvRFemkp5AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 18:23:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FCAA6C64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 18:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 813E03161565
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DCA314A77;
	Wed, 28 Jan 2026 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3KYvRU7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5427E30C626
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619445; cv=pass; b=MFsbv4fQEVWV6Q92/BpEEINoEUhIuNc2HzRsZS4bSRAJmW9RzM+SSFwQ5TzYQ7ZorU1xerZCsGdC7SxJ0zCOH6pekKxQnkBHgGsvWbbkWw7ykrKIK4tqn8E+R2Zy5IybHwnIFG5ymZQEHJ/HqUukVr4Yb2i0hqSh/a8UicFPEVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619445; c=relaxed/simple;
	bh=aQmjSshpFgYK9TiBI5W5jdIFo/kiblZE6CPdhJiatlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aF/H6PpOOA7Vq0NIGzpC9J1po1DAg6QiGde9foWk5WbqjE5xk7CTqdFXEJB1GJ0eWFiR2pHgubhE0xiGMHk1wCLyjsbOrd7VU682NguR/oR+2JjRl9ayuo0216FjG6mcUnObbfzxW9vo1Up65KvW/hYaPA3rhVavXAQH9Y997IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3KYvRU7; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-944168e8c5fso42537241.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 08:57:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769619443; cv=none;
        d=google.com; s=arc-20240605;
        b=VNMq7UDBs+0DwD4KnAlqmwO681K2LE2aJAbXeDzxGRXvysHWpLLfs3RdHA/3CF/XxC
         1bZc+RnlNEKBRzdO27caTxy6u8dVr/1q+GMr1Rs2QAeF4zzxnryRtT7+swlyDKXVrzFo
         HjJF+/oFkmcnE90KHN/45KlhVxh5qvSXesEIkNIEArUk8KxUmBWY12G84uK+mSgWzDhk
         OZThlhWFAnIqagwPYkUdGm8W79aK9liXBHSsqug4q2ZNoMiLMmA02q6XlZUvwIPpRJJJ
         ghZ+bKNKv/aY4nbNfXz0ntpfuWDT+/vv7cplubDQOK8C0OqRar3NUN9cVdxwC4IA2EIw
         7sSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cWU6jdpATzspJVVhGCx/pcC4aGNiM2QqTMvjgdpwQ90=;
        fh=Lj32Hn4MUNen6mJeqKnnxeQ7Iwvkjh12FwQY/9R2joM=;
        b=evVxGpPi1NCc1OFqmaWPq4hgjFMugceUmyX8j4IZ5jsZAtQAkyXmkt3M+iZF2V/zI9
         KhS3zZOAD2/Y8Cyixp2WeAYoUQ0pukTqiu6tGtRYZH6OXeFKODQfa3yV9AO6YTwgqUFt
         V0L1Jo7vc25WBzbqf70wr5eCTA7dHdU3EURA6vqskz1/3w9v7t2IGjeyhn9hCDfqevmJ
         mLIYo/NmHK3l0wzgl4zOslFuDm8DN9FucuRyYeHvGnXeVk/T7Y+/RFoDAT3s2WiAi3DD
         iRtf8tvKypjMHayNOB+ANttAP5DCI7YjWhmtR2LyKC2ybyIKFLvyWNUy5DCk5S4CqeT8
         vs6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769619443; x=1770224243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWU6jdpATzspJVVhGCx/pcC4aGNiM2QqTMvjgdpwQ90=;
        b=Q3KYvRU7K5nRhrZ5f0j9uFDbKXWdXesqfotyc+INow9zyOXUBJ/PWAnXFVtMqMA7eJ
         /cRDsgvSJOxCtp2mzkONy01559vkWpIRlfTJyZxurjCs1Fy/TmdybLpR97PP11EgbJdX
         NlWq7bs65LjHQGBPJsHiDxF1kejVoF2yp1ugDP0qksz5RIGWT7erHlAJBVbFLIHOXLUY
         3W0gzwe2P/IKEZ9o8OVi/b669Wd1dpBEMh/IbMic54HsE/hkBux34hpAQHu6R7psoYTQ
         EsDMH2xj1al6XXzFXsfSBkRj7iQq9WkDVwcES+aG8eEarToIzctqNb+yf2KULrQxuRtl
         SPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769619443; x=1770224243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cWU6jdpATzspJVVhGCx/pcC4aGNiM2QqTMvjgdpwQ90=;
        b=AKMDLcTuEhfKryA2cjb1C90kutIYOrmc1cGa2g/o1XdMFdWqu/nU8CEMcnF3kV+NDz
         G/uBZi1/t1vNFMqruHBpeFQB8DWeAxu2x8Wh3SFk/2++S7SBjxoORzg5CvhTCsTZhQYr
         MAOJiwrInXXymLanomF9PHSrz5qOA59+GV3xSo6ljPVBKxNAHpWkrXncn+6gQu++IaHT
         M/kfb8otECCY2tPzci6Ll+pmIeS7ivpQwrl86IfkWPF7LPAJmlSyV0A8NRJNIkh/Hhk4
         mUPYL5KJg+IglO2I7K45BR02OVuLKdZRsyjTeYuhaJfTybJfwzxJuYFGFG4WAk9iq77w
         EvZg==
X-Gm-Message-State: AOJu0YzfXPw2f8uJzskOanfRFPXfmQJ6q06jqVamVcOYopEx92qTCfCl
	MDifjF86On5P3udYYWDfWMCk7VNp06oRnj0OdXgpp1Slr8Rv5sVkBrDN++ADZ2olKxmM90bGPjh
	dgOXcHtOJV0VKulfuR4S7eN1aiqEx6Mk=
X-Gm-Gg: AZuq6aKePVhmETdC2I5I+C+7No0oX0ZW4lCGZzqG3X0E4zQTphcYXj5Hao5VUy3BH41
	QKb2IeXFRptZDQOh20pZwVM3rOVlLl/oJ/cI0uj/9+6/+Cq/SCDIe5oRIrqdeR9DqkV8gJH2lkH
	m0uKxWeXhf28WzqhB7iHuGZjrVr13KSBc0CuHw0aDlz1rNXPev3ydWuGVXxFc3ZUZiwU5DwMTUj
	N4rw1f2uyFzfuCVwlnoqY3j/P2k3MCmhWH0t7EffuISGsVO3THy9z2gtw7S1nNQJLvHAOIX1wtL
	Rm2+lQP2h4TuHO5+AV9RlIE4lf9tXe8=
X-Received: by 2002:a05:6102:6ca:b0:5ef:a6bd:c8af with SMTP id
 ada2fe7eead31-5f7237ea477mr2124540137.39.1769619442901; Wed, 28 Jan 2026
 08:57:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127180109.66691-1-dorjoychy111@gmail.com>
 <20260127180109.66691-2-dorjoychy111@gmail.com> <2026-01-27-awake-stony-flair-patrol-g4abX8@cyphar.com>
 <vhq3osjqs3nn764wrp2lxp66b4dxpb3n5x3dijhe2yr53qfgy3@tfswbjskc3y6>
In-Reply-To: <vhq3osjqs3nn764wrp2lxp66b4dxpb3n5x3dijhe2yr53qfgy3@tfswbjskc3y6>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Wed, 28 Jan 2026 22:57:12 +0600
X-Gm-Features: AZwV_QhWFJnL7OO1h9keBmN5V-0iCnAafCkxrpYSeXoP3q-PshnUa55o0MuJdZI
Message-ID: <CAFfO_h7thTNV2fXkStdD-HH=kOy1uPL8=iJf0tkvYr8VvosoGQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] open: new O_REGULAR flag support
To: Mateusz Guzik <mjguzik@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, jlayton@kernel.org, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75776-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cyphar.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44FCAA6C64
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 1:12=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Wed, Jan 28, 2026 at 12:23:45AM +0100, Aleksa Sarai wrote:
> > In my view, this should be an openat2(2)-only API.
>
> fwiw +1 from me, the O_ flag situation is already terrible even without
> the validation woes.
>
> I find it most unfortunate the openat2 syscall reuses the O_ namespace.
> For my taste it would be best closed for business, with all new flag
> additions using a different space.
>
> I can easily see people passing O_WHATEVER to open and openat by blindly
> assuming they are supported just based on the name.
>
> that's a side mini-rant, too late to do anything here now
>
> > In addition, I would
> > propose that (instead of burning another O_* flag bit for this as a
> > special-purpose API just for regular files) you could have a mask of
> > which S_IFMT bits should be rejected as a new field in "struct
> > open_how". This would let you reject sockets or device inodes but permi=
t
> > FIFOs and regular files or directories, for instance. This could even b=
e
> > done without a new O_* flag at all (the zero-value how->sfmt_mask would
> > allow everything and so would work well with extensible structs), but w=
e
> > could add an O2_* flag anyway.
>
> I don't think this works because the vars have overlapping bits:
>   #define S_IFBLK  0060000
>   #define S_IFDIR  0040000
>
> So you very much can't select what you want off of a bitmask.
>
> At best the field could be used to select the one type you are fine with.
>
> If one was to pursue the idea, some other defines with unique bits would
> need to be provided. But even then, semantics should be to only *allow*
> the bits you are fine with and reject the rest.
>
> But I'm not at all confident this is worth any effort -- with
> O_DIRECTORY already being there and O_REGULAR proposed, is there a use
> case which wants something else?
>

Good discussion. So should I just rename the O_REGULAR to O2_REGULAR
and create a VALID_OPENAT2_FLAGS and no need to do how->sfmt_mask
stuff?

> >
> > > +#define ENOTREG            134     /* Not a regular file */
> > > +
> >
> [..]
> > Then to be fair, the existence of ENOTBLK, ENOTDIR, ENOTSOCK, etc. kind
> > of justify the existence of ENOTREG too. Unfortunately, you won't be
> > able to use ENOTREG if you go with my idea of having mask bits in
> > open_how... (And what errno should we use then...? Hm.)
> >
>
> The most useful behavior would indicate what was found (e.g., a pipe).
>
> The easiest way to do it would create errnos for all types (EISDIR
> already exists for one), but I can't seriously propose that.
>
> Going the other way, EBADTYPE or something else reusable would be my
> idea.

Good point. Maybe ENOTREG is acceptable too?

Regards,
Dorjoy

