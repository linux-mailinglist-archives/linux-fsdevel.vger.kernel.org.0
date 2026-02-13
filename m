Return-Path: <linux-fsdevel+bounces-77144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBxxJtoyj2k+MQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 15:19:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3C813704A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 15:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FBA1301993C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 14:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6671357710;
	Fri, 13 Feb 2026 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="HwCxI9eK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D84C1E376C
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770992334; cv=pass; b=H/FOqbcNlOFgs3JrjsIto9WJE4GAu9sX5iUBoUCqTryUkU1ayMQSERReaVo31QzbUlhWzAIBS3MaBXW4LcwxDyeEbt1IqOmFLaswW/7eVULq6uNV9u8DjjBU2TwaB7N2jsJK1HpYH494cMil+T464YD1jQGLGt9o/ejhQ+WH2y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770992334; c=relaxed/simple;
	bh=Ha0e4einRl3gVJ7lhbitIv1TiCEvi7y86FMnr1d+VD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjiF/DeWZMfK+xp4/7nb4fAqraxFXfusg3Fy0Wbeo+0o9lc6OoGkFpL6n5dE8x7kEmCrpfCnSMbcDHimRRFS3TTsQheL8G1X95+kg5esbKL0gGrd8K1blpGWqIVhPWrnva2kPvoEePa7akBx87KSXE/9XylEttnBeohS+H+F3JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=HwCxI9eK; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3878de20527so5908111fa.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 06:18:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770992331; cv=none;
        d=google.com; s=arc-20240605;
        b=ILmbkXJDkv5x5vxVY8yLJ0C7hDm9/zRlGORQQoOu5k29anVw+3BpUSVNtzjoiCFCaw
         JbG6QFn9AvkL+5IhqRShyLp6IdTDqL1pPcCmvuUusp+4dEwbMYl2nrGW4J5vWQbId7Ou
         vsiaeh8U93ijpmtkdzwK2R1sZukOIzPJILhAY2k01f7yWOR0SvnZZqzwCaW6GbqbY9cZ
         +bR3+IwkG6ibQMFr+kPD+XkZtK8aWCXzYn88roKVST40QioXZeRluDvRP+jz25tEZs9j
         kxqnnskSg4vABZfirpm/NLbqSl5UNOk9tf0TPIvDZgoALsVpRu3Cud1+kMk55GKZVHM4
         Ij6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PPZ5UjJXZiG/dIIj7T0/FHqJccKNEyOB/oHBxQ8dlL8=;
        fh=lOliubGtDRqmkwwwEdsrF8iIgNGqiRqsfHwqru62r/c=;
        b=cuRaz+USC0KOdikkffEqT15HZ2xbqxhFNOLfEKZ9xluvclgbF1bnFgaYJsXyoQOlWm
         piNKwcy+LQkckA2nF82saaeHE0XoFl1j9BTtYLGEhwox1NBdVEGUD5jufML0qG66rERH
         NH7X8IxjQNe6SrFW1G42b7YCT2WJKAoB2OQIVbOtcOw5CWqeEG8JXkZALJxps5PwVrit
         0iCie6EOIUUMyDmABR+vGnRY6CRpj9gCQdNDeeYjNB/7nJF0QFypVxYqLPFjz7fUfzgE
         2SEIgZrPovaivf5jH7wDPSpFJeg3+Q+ejhtvd46F4TZflng3oS8/GQu88Kz+b0GBICY8
         OD5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1770992331; x=1771597131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPZ5UjJXZiG/dIIj7T0/FHqJccKNEyOB/oHBxQ8dlL8=;
        b=HwCxI9eKLLHVxIfM5mr0TCpepOyc3HQMEeqhJj3ekauYTRhlSf+qm9qOEJmwpTLCCG
         Dp4q8eImGfN3tyj104lq8omX9sIEn1ic/AWo+2qme4IVMpnAUOwnAbuYrn3BTKNa288M
         cu4Ngx51+wo40DOMyAQr5UshLfo665ku642jd/dsOKrPWvrMpnYmPak6Gl0ESCS3rCca
         cR79y2ney5yvp41NmA9tAockBu77wQ1f0LgirGtgNredrXWqgCl6S6E4SJzhFIRGaf0V
         JJHs3G9pIbVHNd3ZwM4PtOP+pkGAonixNcNnfxiuRLDIeD2H+fSC7IuO4obH/3kQFaYm
         KfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770992331; x=1771597131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PPZ5UjJXZiG/dIIj7T0/FHqJccKNEyOB/oHBxQ8dlL8=;
        b=lUE1ZtG2GAoxjO7m5t7bOPYFjLdutnMukp2t8YZb005CXS5ibhunNN/cshwXAxq6qP
         xUXRLPfAbik2I0RgJveK/Kt7WBEhxRd3DrDLSM2655rFltZi4MRSZ1732lHkmsxh2C/9
         LHpXSx9+XPAEdvl3HpbwaztO8CIf0A3gah/ACa+h9yS21q1ARbF2QQ6WsfG7IBD1E7qs
         TcIXNZNPWyZYeCBKj07ijH7tHxceRvpee2wdS1abRp7d5yrPyKvLE/Ecwm+j/96Z+9Rn
         ja6QgiDsIyqL+kWpu4zeCzxuNrlLosHwgRx2hlAcsWjmSYX/hOHQFcinMTCIv5BbKhk1
         HByA==
X-Forwarded-Encrypted: i=1; AJvYcCW/DsIkXUdC2lj+6FXUMMYdUFuqzwfEpbULWo1Od5EC4urF70Ge2yCLTg2/mfB9ZVHL7uD2RQKq9pD6o33P@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/pkm8D3EdTcUtxnbHt4tvMpUWX2guERn9ZWo6d9W7jDta2ZlT
	8DCFpdoZBVVLTUN04Yg3NIQJSVs2UgVcWhN1dE/GLPi/XY0d+r6q/gKxWWCoscUrv8E4lGnEaX8
	ah1CNBUABXXMOTBs44JFLvFtsaXCWinJkSJ4zPcPwig==
X-Gm-Gg: AZuq6aIh4rDZ37msvkh0YiqsemH9GczRwsGeJ2FEC2sUMcb2cZdUuiXrCdN9G06Gu3L
	ymAVoLhg7ppM/PWOMG5jfNei3JFt3YJLLg28T6PyLdw2AEaLioxNuQ23BRmzOQeNmxnycBsckTn
	q1AhMRZqSv/wVB8e8FnV3REL4X3WpfKcXF8KghOzm/laDxiTjkb7ioxKcz6OuUtwFM6M/V6GcsT
	TfFPhXlIJCczlHoisojSAffGfOwXKhu2oX0b5x9SQf0Sg9PEBYuYR+lw02ovf1LPiMJlDnucKtG
	G2EtTQa95lwESUENATDYlR1cMzcmsPVSTCDoXtTHvVk4/qGKj0/hrqNmeaX6XLcjEGi5SQHRX5x
	fN2k=
X-Received: by 2002:a05:651c:f17:b0:387:1c06:f744 with SMTP id
 38308e7fff4ca-3881054c449mr6460791fa.23.1770992330706; Fri, 13 Feb 2026
 06:18:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <31a2a4c2-8c33-429a-a2b1-e1f3a0e90d72@nvidia.com>
 <459953fa-5330-4eb1-a1b4-7683b04e3d45@flourine.local> <aY77ogf5nATlJUg_@shinmob>
In-Reply-To: <aY77ogf5nATlJUg_@shinmob>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Fri, 13 Feb 2026 15:18:39 +0100
X-Gm-Features: AZwV_QiMQawRDF7MErqQBuWp-MuhZWG8Dupe7ZsjeFBjsuqumHNHXRrm7OHAk1I
Message-ID: <CAJpMwyi7-g0Oh2aJHQcrbf4zQN-2Z9oGBCDRdQbt4drQKqUN7Q@mail.gmail.com>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Daniel Wagner <dwagner@suse.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, Bart Van Assche <bvanassche@acm.org>, 
	Hannes Reinecke <hare@suse.de>, hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	"sagi@grimberg.me" <sagi@grimberg.me>, "tytso@mit.edu" <tytso@mit.edu>, 
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Christian Brauner <brauner@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
	"willy@infradead.org" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	"amir73il@gmail.com" <amir73il@gmail.com>, "vbabka@suse.cz" <vbabka@suse.cz>, Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77144-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,nvidia.com,vger.kernel.org,lists.infradead.org,lists.linux-foundation.org,acm.org,lst.de,kernel.dk,grimberg.me,mit.edu,wdc.com,kernel.org,oracle.com,javigon.com,infradead.org,suse.cz,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haris.iqbal@ionos.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ionos.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wdc.com:email,mail.gmail.com:mid,ionos.com:dkim]
X-Rspamd-Queue-Id: 3A3C813704A
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 12:25=E2=80=AFPM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Feb 12, 2026 / 08:52, Daniel Wagner wrote:
> > On Wed, Feb 11, 2026 at 08:35:30PM +0000, Chaitanya Kulkarni wrote:
> > >    For the storage track at LSFMMBPF2026, I propose a session dedicat=
ed to
> > >    blktests to discuss expansion plan and CI integration progress.

I am interested in this topic.

> >
> > Thanks for proposing this topic.
>
> Chaitanya, my thank also goes to you.
>
> > Just a few random topics which come to mind we could discuss:
> >
> > - blktests has gain a bit of traction and some folks run on regular
> >   basis these tests. Can we gather feedback from them, what is working
> >   good, what is not? Are there feature wishes?
>
> Good topic, I also would like to hear about it.
>
> FYI, from the past LSFMM sessions and hallway talks, major feedbacks I ha=
d
> received are these two:
>
>  1. blktests CI infra looks missing (other than CKI by Redhat)
>     -> Some activities are ongoing to start blktests CI service.
>        I hope the status are shared at the session.
>
>  2. blktests are rather difficult to start using for some new users
>     -> I think config example is demanded, so that new users can
>        just copy it to start the first run, and understand the
>        config options easily.

+1 to this.

>
> > - Do we need some sort of configuration tool which allows to setup a
> >   config? I'd still have a TODO to provide a config example with all
> >   knobs which influence blktests, but I wonder if we should go a step
> >   further here, e.g. something like kdevops has?
>
> Do you mean the "make menuconfig" style? Most of the blktests users are
> familiar with menuconfig, so that would be an idea. If users really want
> it, we can think of it. IMO, blktests still do not have so many options,
> then config.example would be simpler and more appropriate, probably.
>
> > - Which area do we lack tests? Should we just add an initial simple
> >   tests for the missing areas, so the basic infra is there and thus
> >   lowering the bar for adding new tests?
>
> To identify the uncovered area, I think code coverage will be useful. A f=
ew
> years ago, I measured it and shared in LSFMM, but that measurement was do=
ne for
> each source tree directory. The coverage ratio by source file will be mor=
e
> helpful to identify the missing area. I don't have time slot to measure i=
t,
> so if anyone can do it and share the result, it will be appreciated. Once=
 we
> know the missing areas, it sounds a good idea to add initial samples for =
each
> of the areas.
>
> > - The recent addition of kmemleak shows it's a great idea to enable mor=
e
> >   of the kernel test infrastructure when running the tests.
>
> Completely agreed.
>
> >   Are there more such things we could/should enable?
>
> I'm also interested in this question :)
>
> > - I would like to hear from Shin'ichiro if he is happy how things
> >   are going? :)
>
> More importantly, I would like to listen to voices from storage sub-syste=
m
> developers to see if they are happy or not, especially the maintainers.

I like the idea of blktests.
We have internal tests which we run for RNBD (and RTRS).
And I plan to port the RNBD ones to blktests.

>
> From my view, blktests keep on finding kernel bugs. I think it demonstrat=
es the
> value of this community effort, and I'm happy about it. Said that, I find=
 what
> blktests can improve more, of course. Here I share the list of improvemen=
t
> opportunities from my view point (I already mentioned the first three ite=
ms).
>
>  1. We can have more CI infra to make the most of blktests
>  2. We can add config examples to help new users
>  3. We can measure code coverage to identify missing test areas
>  4. Long standing failures make test result reports dirty
>     - I feel lockdep WARNs are tend to be left unfixed rather long period=
.
>       How can we gather effort to fix them?
>  5. We can refactor and clean up blktests framework for ease of maintaina=
nce
>       (e.g. trap handling)
>  6. Some users run blktests with built-in kernel modules, which makes a n=
umber
>     of test cases skipped. We can add more built-in kernel modules suppor=
t to
>     expand test coverage for such use case.

