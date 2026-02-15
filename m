Return-Path: <linux-fsdevel+bounces-77255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UETQDkM4kmmTsAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 22:18:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D5D13FBEE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 22:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C5DD3038515
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 21:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B08F3043B2;
	Sun, 15 Feb 2026 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="P0N2Rfgi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD7F1EBFE0
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Feb 2026 21:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771190323; cv=pass; b=PVrXgNEg7NJNEZd0SFZCW7Z+Aj6mrVhp+QqpddYAz12M0BofX/+tHFTiG5wMv/a6VwMlcm/corGKtpWraHZeBIvqf+aSCxpP55BDfbhow5rgHD7i1wn85EFmfyz32vcNsf7w6ySHm6PKAXuuK8p1MOpRR2BuHevV3BWt5dZfkDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771190323; c=relaxed/simple;
	bh=kHKJYV8nnw8Z8vztJHTpu6iFGyZWzK74DCx4AAtkr30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJvj4BGH7/5JBTyf1FvU4q0U17NZn4EZ31dAjRSlbwtDM78OLob6ok/PaBS3R/Kr/u+844C3aoAxU+O7J+SOaHiWMBdXUuTqCzWqczkNjTLdxe1eCqkIKff+m3w1X4sU/O4dry0OY5Y1pkEO+cRBk3fk0ogfNZbPVmWVhALGZqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=P0N2Rfgi; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-388126f79bcso15551301fa.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Feb 2026 13:18:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771190320; cv=none;
        d=google.com; s=arc-20240605;
        b=Z8e+PjzK/U3YXDq0ao3NtaWlDt+J+DddW/O4sp9SJc9emVG9fBH57hrv/tq1WlowvP
         ckYX7GcZ10uQcDXaAfB4uIUKMdUdpC0OjYq5M0wMiUJG5gq7AUN3hHSuyQbMiQ7w+Wlo
         52m7sjPKTKoStINaSImc+kfD/uU3jNDW9ia2UIZv0evVo4O9/NnganyNNagxTbN1fRu3
         sRfu7tbAhFkNVVnvPzbMFkI/+HkckYEwgUAJCy9wy+40L/rF+LC74JKonXdmgg00PdRk
         ECaZjQAvg0/gZoX0kR1CK9FIs4Kc9iVVMzUislUp77Gnd386AsXzUCJRx86VwlBlvFO8
         31rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nh5TnaSI7rZPj2uhgnsZBl8QSuJdZuhEOKvh+vqqOKs=;
        fh=w+l6sTUnRo+CF4K+cus3WFPEO2FlHVfQ+m4uyEkQ2BU=;
        b=gi/hEG/LKyFO0Rmyg+N7oebNUw0aE5hA44DDVsEMB52PKZ1sJ5kuBo8wr+2NmnbcLF
         FPNry3ZsW5U99e/f5cktGMM/kcBSzeSHIjqVT3na6MwYbZXKb225NIB2O68oJnOy4AsZ
         RcsQmk8nbXtz/8PFboSsUjrS43kHx3C+7QrcPrLgoMd6c/MhwMwQkmZ7um3yMf2c8rXY
         n65CUdUcyKW9NAt4gsI4RFRvPg461iHTzR7rfCuwvGsJELcGwVpurBhV2fFwYCtN2e8y
         M8ih41ebl3fIsbYleHx7eAG0Yx+NzjJhP6VA1mkDXNGj88aOvalMYZRbdAwh3h2y/DvN
         6Npg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1771190320; x=1771795120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nh5TnaSI7rZPj2uhgnsZBl8QSuJdZuhEOKvh+vqqOKs=;
        b=P0N2RfgiPzN4CIynQyVmn8d3n6n9uuP7CBn0ef4S3xG/F8oQzqUWj7JSo/bP9gaBPD
         uAmxfKcp7OB+r2tiEgGjYd1Kx3Uq+4z7FSTQqXyUKyF9EJK7XD2qZvRBIq5O/i0pPYGv
         p3B2P5uzhbrqeCa1PaY/o+TSf+VQF77SEzikQSc+PcelJVFYsAPqlqzZvT7y9Ke1mu18
         fQDMuWHWBP1T/G0+Cx8xgVsvHUGipS8av/Rbk2j07mRtgB0/RYA+n559ngBRZ+uZIDrH
         Mqh9LRqmYu/QwVbgexFaC4gnD9YdIara2f+ZUb+ZOYiwfNq4QieLLnNf7m5wrUHc23HX
         o7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771190320; x=1771795120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nh5TnaSI7rZPj2uhgnsZBl8QSuJdZuhEOKvh+vqqOKs=;
        b=JYkiV5o4iU5pxsUY8B7elTRb7VCPG0rK6nKGJXjr+ccIdnMcXAxsF0ZlsuHaAM1kEF
         LWTaRBVYrJvQSwGxY3zr4HA+F7yfvplUJBTpq1m6OIAKofHoo4zTz5lYO4WyASrR9q5s
         kN2z0uUvkHvCowWhPRbvtpdYbrvUx5TKbJXCO8zj/0BTkcoC7mXFBsDOg78jw1TrzTxF
         IktXb7Teyx/fViz0/NOXganHLDVaQg8BFQqDqYt1us7A849mU63iuhg4tP/deDzHjOb6
         wRAFNE+LUyamlkb2HeZtkmeblWisL8KmUoMzaS3BVqVfDO+VIFRcYuwRNE5sGhSFd21d
         4SSw==
X-Forwarded-Encrypted: i=1; AJvYcCVpF3bT3C/G7Nkxe1B1ZTDUlmht6eCSBOH4aFTyls9yPOj036joYJckGWhXzQililyvQnuO/01SWWZv0yw5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6bF24fPjetvbMwB3HEWfNraBM29eswebG3HCoDNW+IHZADwFn
	QS3ytHUSJv5kGGoAbIevtKQM/wPxy4b8UetDOF8BV18F05g/dcC499kdLSkHmwu3/vVT4FYEOFq
	egS5w/RIb+EEpe01X9ytrNiGkYd8/kFQALlz5VMk4jA==
X-Gm-Gg: AZuq6aJVg5RPs9T8JJh+zlPCZ/fTxb1Fy4LgsEBG4UYhn+9PNJNfJHo4m9sObqbGLnM
	ebq7j1s39IuGPpLmdKLbzOvK7nurCxuZ95I9HHLHyzgYof5iRsgW5flIySHBo176LaW+RoiDDuZ
	tx91xK1lDHw5oHKOjA+uS1GyJS8f7D8ZPTJNOqRObvYtSy7L+JzNF0Q414QZk+lBJgWV3aCyzw3
	ZmuLOogg5id+tlTp1lKPjWwDcqe2IrLd7EUMN49OLqKHTNi2bnSRe5L4LYoeiq596efx4VReNyG
	YvKsT/GDXMRn2K8FCnssAJ9h7tkqAwfbLNHyDWkdUvf88z6+0Zg7zOIoxjrBmEYSQzf5oKa6jR7
	tbaT1NH4Sitm7MQXKGcugmDc=
X-Received: by 2002:a2e:a781:0:b0:383:1d89:8d0c with SMTP id
 38308e7fff4ca-38810525294mr24772281fa.15.1771190319860; Sun, 15 Feb 2026
 13:18:39 -0800 (PST)
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
Date: Sun, 15 Feb 2026 22:18:28 +0100
X-Gm-Features: AaiRm50UiUfxjs0q7nnu2kE7OqfPsAIU6uDVz4YX8OUdHbhFYRNnEhFTdkEJv9w
Message-ID: <CAJpMwyis1iZB2dQMC4VC8stVhRhOg0mfauCWQd_Nv8Ojb+X-Yw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77255-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wdc.com:email]
X-Rspamd-Queue-Id: A6D5D13FBEE
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 12:25=E2=80=AFPM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Feb 12, 2026 / 08:52, Daniel Wagner wrote:
> > On Wed, Feb 11, 2026 at 08:35:30PM +0000, Chaitanya Kulkarni wrote:
> > >    For the storage track at LSFMMBPF2026, I propose a session dedicat=
ed to
> > >    blktests to discuss expansion plan and CI integration progress.
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
>
> From my view, blktests keep on finding kernel bugs. I think it demonstrat=
es the
> value of this community effort, and I'm happy about it. Said that, I find=
 what
> blktests can improve more, of course. Here I share the list of improvemen=
t
> opportunities from my view point (I already mentioned the first three ite=
ms).

A possible feature for blktest could be integration with something
like virtme-ng.
Running on VM can be versatile and fast. The run can be made parallel
too, by spawning multiple VMs simultaneously.

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

