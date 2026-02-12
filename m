Return-Path: <linux-fsdevel+bounces-77038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEQgHeMPjmkM/AAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 18:37:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1789712FFA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 18:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 581793012859
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 17:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99329257452;
	Thu, 12 Feb 2026 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNFsL5AL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF99D223DFF
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917856; cv=pass; b=XBeKX/Mzx91Xc4/mKWJz3sNy4NVT3VDJNQYGCIkjG+EPoIvTjfFdmwJ6u/cMevVD+f3cXTvta5QtXilUt3tXc6Vzo0FTVD2cnv0vLPJuS6846aGYTF9xPHpchEzXQb0mqcyeuQcnKYGYFh+jEnYFjlRa0f3ZAzKsZYIjQVBAwtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917856; c=relaxed/simple;
	bh=1J62dzopx3s7zpkoemPVHQMmONEnLM1LMrEddvK/lQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssqN2qsqDsC3HkPgiW8GqgqWTmqXSLpgV6R4Rk0F6taMLhqMGYzkWA7ql6GYfjBjxhE9wR5Ge/6oC3Exc2lqCGrVDkGyOUPs85iYxmpz/WQNNnQl/4VFkaKDMjpZFx6ttnaUl1V4ASP3IjS0fnNoK/EXdhs7C26FIS1V++FT4Gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNFsL5AL; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65807298140so24403a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 09:37:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770917853; cv=none;
        d=google.com; s=arc-20240605;
        b=kgjkfszE3dtSB+OOgPt5HGjNAAyzqId+E3fZxEX9daX8I/Fxx5ZS+RZgmQtzLBEfzj
         frMA1c9/GyCaiNeRzXZzJeK81G+XSuFEzb4YMVKB5fFFkiHz4cGceXJNcUaJ1U3cQhs0
         yDQ7bOox8s5Us/thxEJQSPA5mcvCxse3pzM2pmRcpc1z4wluMQpmUrTOvOi/iJbGs+Pz
         gnOKOZWu4zef9OUj0FvpgbYqkKmYAggUIC3Hlys0h51/hXBxFZp3cUGx+eEThQQI8XAF
         Pt8EwvsxcyRXF/nC7nvd8BDWYAniAmysgbNwCOJZy0TL4DBsscDRkKCHoBqnp622alh6
         NCyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eR3uVwr49U3mjJR+lcSgOE98ucO0kx4fm3wGdcwm/2s=;
        fh=1HTypA/CLGKGej6g8sIhvrHcy9DryAMzE6JqCuM4hvI=;
        b=Y+mxg570/NWTyId35x9dLXIVxOptjp3XpsZ4yl8dsnsl5UtS5hrWEzS07/L9E/IJ3K
         UBLDkXts051xFAerabVdbiRuW06PWuzFPooNJmXp9vuaKxIqK8jV4DJYTehZ2v1Nyt/8
         mU1BlaFjwoDdQGSjm79+sfTZ5vwE16QBKrjAtzOX7PuL+JIENodywCOX7/SWGWSLqGyQ
         UUHtkWUI0OMw3AfKaFifSwHNZ2yJ9hiWcbmTTWZmBWCc+c00cxQojpJ9jSH34Kl+GJ21
         j7RGJTANqMDrTimfxw8sipMJ/BII8kk1j11mvLT1htUxrrEpkTkHMQ0M2zz8xlWdS6Or
         pWoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770917853; x=1771522653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eR3uVwr49U3mjJR+lcSgOE98ucO0kx4fm3wGdcwm/2s=;
        b=iNFsL5ALRkFH1iyQwGVpXranfp7Eu94Xw2y3EOtSx3DWAsd07O+ICxlEB+ODXDrEwp
         RLgN1xXNUoziIfTCTCvZGxCm1DcjsEWqqBXYpzdfG15TEz6jQjMo770K5QvoFjjrWygp
         ZVlgvLinBtGFZPz849XmcBrBdfWVXTCQXI8zf9FICqc+nnUebxcSaZHE9VhAljC3WIY4
         UCjV5ds2O6cqAXlXgRbV7hezKoGHvw++z1VzDBgtk2OFqR4fTm8xURiATFTo0JuEgYoq
         UxyjnA7PS6sNahdMzdL7esqkDqdjVNWB3YT4ll4jgIMqUohn8vF+zDJcvIkfyKxeoKd5
         ONaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770917853; x=1771522653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eR3uVwr49U3mjJR+lcSgOE98ucO0kx4fm3wGdcwm/2s=;
        b=BZEi4luufjzh9XYuBXNSUz0m8RQDgLCNZnJ+1/RTbkjF9rK4cj8YAdu7xCKa+5bvgJ
         O0mmLR6+1AJSf3xGLT4x+WJW+2Hq5qQxzqp9SY0np2EEjrNL/4rQgfajdKt/Xtg/OR/u
         Uqed70pRN2XEKS4Zca8kaPCkrgykE0du6NKrPENWOHt505klKiZnRcqHVQ5HvGb/ZA3p
         O6u76cf2J2kC5uzlPKVafZhoPRLfRkjKkhWPNx4rQUniGIEpaxzNkq7bMzN7VL5KXeZD
         jyKvbT+BCu+tAJds6lwNTVnZpZZZYrUYC9QzjrJNow+gIEDgQFW8VxfgkyIl3eq6WZZS
         jEmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRHrQY4UiDrXAQyDn+CitpPST6JH/79z7jGZAxZhgbrdZpefQITzykalsj8MN9PYVDZN5G2CMrH1NFaXTh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy08qvVLIZRSGf37PxKJQ7D9+iyxIi0C5W0V/BGJrTiEDkH7Bdj
	ovubDhs2MLKd6pd8U06ypH3HPiqqmkot/PrVQChyo1+I3V/aXHUPIa7E8UPT/ZfalDVdR/aCzHK
	04sThB/Iovv9SOAv85t0S0pl+U5WPHY4=
X-Gm-Gg: AZuq6aKkLp+kPrWDJxc08Fk1M1Zeeb+8wsQsnv4xGaCARXOH0l7ld3UZG3C1t6Jyrpm
	3l2lxr4VktMB7YiiMuRKWEX8yB+c/iUj/mbhZMumwJAaa3I2XA16TZh+jsPdfgrGA8tq7Rk9PSo
	5pzZ/EHah7K7UIqUYp6GXhMPmddMq5kV7KqLaKEpb0rd1twzQM63O1yRGtXUI+GwEC/XwOvxyNc
	ylOKbZFhtUOgq9lK19+w5Vgf7ININN2+RhPNgfbj3u+2CitsTko45JRNm1kYoif4gCJHnN3vXsV
	5IglBN092NapA1QMNNcWTFzoxHWVh60AhT77luWCgQ==
X-Received: by 2002:a05:6402:35d2:b0:658:c3c1:2b84 with SMTP id
 4fb4d7f45d1cf-65b9dad7574mr1731590a12.13.1770917852988; Thu, 12 Feb 2026
 09:37:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b9f6cd20-8f0f-48d6-9819-e0c915206a3f@wdc.com> <bcedbc03-c307-4de5-9973-94237f05cd85@wdc.com>
 <CAEzrpqd_-V691dQzVF1WmrvLNXnDR0THuxGCieDMZcWdRN5WEQ@mail.gmail.com>
In-Reply-To: <CAEzrpqd_-V691dQzVF1WmrvLNXnDR0THuxGCieDMZcWdRN5WEQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 12 Feb 2026 18:37:22 +0100
X-Gm-Features: AZwV_QjF5KbEAUKRfPj5l9Ijwa3V7I7QDxVGjivSrnvFgTrtcGLGYPvaK2NhI1A
Message-ID: <CAOQ4uxia_BDVOLLnuN=OzhpUYBdFkd10T+079h7+PjHXkt208w@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] A common project for file system
 performance testing
To: Josef Bacik <josef@toxicpanda.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Hans Holmberg <Hans.Holmberg@wdc.com>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, hch <hch@lst.de>, 
	Naohiro Aota <Naohiro.Aota@wdc.com>, "jack@suse.com" <jack@suse.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77038-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1789712FFA6
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 7:32=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Thu, Feb 12, 2026 at 11:42=E2=80=AFAM Johannes Thumshirn
> <Johannes.Thumshirn@wdc.com> wrote:
> >
> > On 2/12/26 2:42 PM, Hans Holmberg wrote:
> > > Hi all,
> > >
> > > I'd like to propose a topic on file system benchmarking:
> > >
> > > Can we establish a common project(like xfstests, blktests) for
> > > measuring file system performance? The idea is to share a common base
> > > containing peer-reviewed workloads and scripts to run these, collect =
and
> > > store results.
> > >
> > > Benchmarking is hard hard hard, let's share the burden!
> >
> > Definitely I'm all in!
> >
> > > A shared project would remove the need for everyone to cook up their
> > > own frameworks and help define a set of workloads that the community
> > > cares about.
> > >
> > > Myself, I want to ensure that any optimizations I work on:
> > >
> > > 1) Do not introduce regressions in performance elsewhere before I
> > >     submit patches
> > > 2) Can be reliably reproduced, verified, and regression=E2=80=91teste=
d by the
> > >     community
> > >
> > > The focus, I think, would first be on synthetic workloads (e.g. fio)
> > > but it could expanded to running application and database workloads
> > > (e.g. RocksDB).
> > >
> > > The fsperf[1] project is a python-based implementation for file syste=
m
> > > benchmarking that we can use as a base for the discussion.
> > > There are probably others out there as well.
> > >
> > > [1] https://github.com/josefbacik/fsperf
> >
> > I was about to mention Josef's fsperf project. We also used to have som=
e
> > sort of a dashboard for fsperf results for BTRFS, but that vanished
> > together with Josef.
> >
> > A common dashboard with per workload statistics for different
> > filesystems would be a great thing to have, but for that to work, we'd
> > need different hardware and probably the vendors of said hardware to bu=
y
> > in into it.
> >
> > For developers it would be a benefit to see eventual regressions and
> > overall weak points, for users it would be a nice tool to see what FS t=
o
> > pick for what workload.
> >
> > BUT someone has to do the job setting everything up and maintaining it.
> >
>
> I'm still here, the dashboard disappeared because the drives died, and
> although the history is interesting it didn't seem like we were using
> it much. The A/B testing part of fsperf still is being used regularly
> as far as I can tell.
>
> But yeah maintaining a dashboard is always the hardest part, because
> it means setting up a website somewhere and a way to sync the pages.
> What I had for fsperf was quite janky, basically I'd run it every
> night, generate the new report pages, and scp them to the VPS I had.
> With Claude we could probably come up with a better way to do this
> quickly, since I'm clearly not a web developer. That being said we
> still have to have someplace to put it, and have some sort of hardware
> that runs stuff consistently.
>

That's the main point IMO.

Perf regression tests must rely on consistent hardware setups.
If we do not have organizations to fund/donate this hardware and put in
the engineering effort to drive it, talking about WHAT to run in LSFMM
is useless IMO.

The fact that there is still a single test in fstests/tests/perf since 2017
says it all - it's not about lack of tests to run, it is about lack of reso=
urces
and this is not the sort of thing that gets resolved in LSFMM discussion IM=
O.

Thanks,
Amir.

