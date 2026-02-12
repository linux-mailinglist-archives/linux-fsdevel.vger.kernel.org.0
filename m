Return-Path: <linux-fsdevel+bounces-77045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEbfEEIkjmlCAAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 20:04:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86058130867
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 20:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EF47309C1BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 19:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA6629B8E6;
	Thu, 12 Feb 2026 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="h0x6kfwc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A448F2877ED
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770922997; cv=pass; b=OcdiOtvScNp4MzXkjY8joqbAQcv4SJzOU8SiBlW5yOqElCnsg3V88FABaWtvttImLZwdImzhcOIVckuPm7+DXynLmAfW3vVRSStgIL1FBWIjpFgfeDDt+jJ+AyEpnSVkHEdZ8Qr9SwRcbSCRNvGC2mnzvwI7Sd/PprPj3jpuBZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770922997; c=relaxed/simple;
	bh=LKHGwO3hiqD6NIFE+Y2UcEe/Q+HBxOmCECIIjIgGCE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=spTqk2DvRFFlGWsoZnjyu6D4fnY3V8mhfErvi2OcHkeFkH8g7RVhMzCD6CX2sarRw6Rq2Owkx91Tg+QXhOXn6FPXAhPmisLTpU9Q/VVdqU1/6Le3J11IjyTYEyNjrX8vY9YTnR0nUgs0YSw/fGbscGPjbGjmGFDb07cux6hgYAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=h0x6kfwc; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2baa6ec5638so89977eec.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 11:03:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770922995; cv=none;
        d=google.com; s=arc-20240605;
        b=daLeOSAKvtjM3NZW9E/5fKSSK8sN0RlrZ2doGnnUBqN1+54rlVscxw07fOwIQjt2cO
         j3e1qkuPt1e8QZNKnF55hC320yWGNqHqPKx37LCa1yKL21BUxDocBboMP6qCzHxRbBy5
         +X1MYx8idwE7wnONQMpck/KDl1GvhKsquV0swLC62GQAPEHy05JHaVJnR2ksONfzxnCz
         qZsI722qyctS8q27TH0j4jDiBFSAhsH2nsLQI0XJGKciv70Se1m5/9xDdmKE21b9NP0f
         /AapBE1GGz2D53W0wdByrtDljV1y8wweYijlN10wLJwa/sg5BpqMB2vb1iZjRslNfW3p
         JK/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c2xAC1tj2xjd8aU8DIQH6w8DdKo91ahT5oRcVfyBoFo=;
        fh=+MjZ8oMid4DCJnzH3ve4U/0YkiDLdw2QWvoR21qEva8=;
        b=imGTfSkdaJc0uC2l0lDnJm2T/XId0ZaPCIQI5B4cpM8/2KiaTigVLQSXSI0RBGYQgC
         LtqsvTSLMfL0fCnRPHS6ianqXjuX0cjdQDMfuxJXE6sEOQpixaUbXDxI2vJtQLvBOmv8
         mJ9hJh+3tqMM5P5GqSLgMFVJAm1cga3QgXsrksHquzFV9ZcLI5bmHeV5e6InFjkxQiGy
         +Q2IhijAAU5wbjVTpVJ0KuVWNAqQzQOCLvuMjRldvwhXuTK1ktiEWV7J6AEKYIypc2TP
         vSlbOeT41C0TYjVRuWkTOuEsJHDRsxxm9jtpds9bGFRP9m2qxvrjefszePdaJYslmqJ/
         VdMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1770922995; x=1771527795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2xAC1tj2xjd8aU8DIQH6w8DdKo91ahT5oRcVfyBoFo=;
        b=h0x6kfwcBiFSaRNPZwfO3LYypBDSr1jwxe3P6TXwfsrqFdzop2vPUmOZWxYUaMGz6/
         Qrisa30Umm9b55Y2+WAXLSGpJ2bg1rLXbmSvXXC2RKRD/GKBjPwosfribIqgdY4kskr3
         c9W0BwNwTaCWgSmSXYJLoYWTT5JusfWjMNNhlfg6pXg0/UNa5hDjAyda8G1R30tK5Mc3
         3q61tSPotSrNPNrGRF31iIVXexkKqBiU26jgZCv4KMzaGDf+1iI/cS2pbm2wWo8rLD/n
         lxQt7OCBO5yBiwkr/uwC8qsRoPQsQuklXH1Rsg4MgoAilJ0hpN2BBF3OweDPqMimh8Vr
         zy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770922995; x=1771527795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c2xAC1tj2xjd8aU8DIQH6w8DdKo91ahT5oRcVfyBoFo=;
        b=DGTKwzQ3ZJ+eowO2/YBPLnb6k5I7zWdXuq6ocy8Yic1jl/AcU5x4x/4Y6O5OzVhucV
         9hYKMxEufGJZWKZZqX2miFxTD48UsRS59ZgnGSolS/vVuYZSXBuV1Fs0YKmw0BhGu2Rl
         dIzkNGyTyDRNpPsXHmTFB2y5vKrhqOY9gU693OgRUgUMicE4HYMSrOmityMCV2I87J2r
         lCJcN3vPfcTb35I1OixJOWv0nCPNUSkwZfyrDFH1ej7yLOaz2r0gXCeuylETg94ypOXz
         QRYwUDWvfAJjVJdntcntpHUa1Qxqy2wb6opt8gOWCH2fOukEb1MvLtOcCBREO6bFnuxb
         JAOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUucqsJPaezerYiVjyEG9P+IrpZwRGtQTdoLGGaioFpl+jICoCpjeRxjN1+0WM/3QtvF8CwWExEDX69imIP@vger.kernel.org
X-Gm-Message-State: AOJu0YyFCSPe6DCEdYLy37WHAi6t7icSbAkw+WOzKRtCi2KPGw1ZSJ36
	GegLqTpxCPZIKywjSwUnueUTaA/pXCaQtd3Oly6cFqrvA4ArqIk1edRx4lyA2v+QPmdNVPqxRnk
	hs60cFLRVNe13FlAj1ILS1HmqY/AX+GFBn+/mVvHcqQ==
X-Gm-Gg: AZuq6aLa+gm+yIHCnfKX7lTFeBq5lDRypkH8YEktSzQudFNqjghyO4c3UihqewlFxbx
	DDQkTtUUYozIzSCdTIkknIGOt4JZ4S/9QIioverYTPH9+V+G+283mY+FU8XsWc0BnulUeIAyQl2
	9jAKEhx04aVwIsPXoZIzPQVSuzDOjuXZSFfBAGLIP3w4fs6KW0GgRp0Rlu67xqQhVMS2XCdD2Rx
	VfEfGWhzBR5jYsnPg1r/Ng7YuMlUyqmyVNJay7Q7xKgx0REbxwlf/pCUPBIiOviE5VouPy7BLFE
	XMclBqS/ww4zel0LbyMySZjWTmHncO6sthMXJc0N
X-Received: by 2002:a05:7300:2151:b0:2a4:3593:ccba with SMTP id
 5a478bee46e88-2baab6c2b7emr1516209eec.1.1770922994353; Thu, 12 Feb 2026
 11:03:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b9f6cd20-8f0f-48d6-9819-e0c915206a3f@wdc.com> <bcedbc03-c307-4de5-9973-94237f05cd85@wdc.com>
 <CAEzrpqd_-V691dQzVF1WmrvLNXnDR0THuxGCieDMZcWdRN5WEQ@mail.gmail.com> <CAOQ4uxia_BDVOLLnuN=OzhpUYBdFkd10T+079h7+PjHXkt208w@mail.gmail.com>
In-Reply-To: <CAOQ4uxia_BDVOLLnuN=OzhpUYBdFkd10T+079h7+PjHXkt208w@mail.gmail.com>
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 12 Feb 2026 14:03:01 -0500
X-Gm-Features: AZwV_QgvO_gsTKhHjuMmKSzjsWOj0vyvIH_lTufAppH72nTrqwmbg5LZndeaUSU
Message-ID: <CAEzrpqdOmT_U=+7wrD+x-ZS9JH9TM-j=ASW=xP2zvmVu0+wnHg@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] A common project for file system
 performance testing
To: Amir Goldstein <amir73il@gmail.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Hans Holmberg <Hans.Holmberg@wdc.com>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, hch <hch@lst.de>, 
	Naohiro Aota <Naohiro.Aota@wdc.com>, "jack@suse.com" <jack@suse.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[toxicpanda.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[toxicpanda.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77045-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josef@toxicpanda.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[toxicpanda.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,wdc.com:email]
X-Rspamd-Queue-Id: 86058130867
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 12:37=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Thu, Feb 12, 2026 at 7:32=E2=80=AFPM Josef Bacik <josef@toxicpanda.com=
> wrote:
> >
> > On Thu, Feb 12, 2026 at 11:42=E2=80=AFAM Johannes Thumshirn
> > <Johannes.Thumshirn@wdc.com> wrote:
> > >
> > > On 2/12/26 2:42 PM, Hans Holmberg wrote:
> > > > Hi all,
> > > >
> > > > I'd like to propose a topic on file system benchmarking:
> > > >
> > > > Can we establish a common project(like xfstests, blktests) for
> > > > measuring file system performance? The idea is to share a common ba=
se
> > > > containing peer-reviewed workloads and scripts to run these, collec=
t and
> > > > store results.
> > > >
> > > > Benchmarking is hard hard hard, let's share the burden!
> > >
> > > Definitely I'm all in!
> > >
> > > > A shared project would remove the need for everyone to cook up thei=
r
> > > > own frameworks and help define a set of workloads that the communit=
y
> > > > cares about.
> > > >
> > > > Myself, I want to ensure that any optimizations I work on:
> > > >
> > > > 1) Do not introduce regressions in performance elsewhere before I
> > > >     submit patches
> > > > 2) Can be reliably reproduced, verified, and regression=E2=80=91tes=
ted by the
> > > >     community
> > > >
> > > > The focus, I think, would first be on synthetic workloads (e.g. fio=
)
> > > > but it could expanded to running application and database workloads
> > > > (e.g. RocksDB).
> > > >
> > > > The fsperf[1] project is a python-based implementation for file sys=
tem
> > > > benchmarking that we can use as a base for the discussion.
> > > > There are probably others out there as well.
> > > >
> > > > [1] https://github.com/josefbacik/fsperf
> > >
> > > I was about to mention Josef's fsperf project. We also used to have s=
ome
> > > sort of a dashboard for fsperf results for BTRFS, but that vanished
> > > together with Josef.
> > >
> > > A common dashboard with per workload statistics for different
> > > filesystems would be a great thing to have, but for that to work, we'=
d
> > > need different hardware and probably the vendors of said hardware to =
buy
> > > in into it.
> > >
> > > For developers it would be a benefit to see eventual regressions and
> > > overall weak points, for users it would be a nice tool to see what FS=
 to
> > > pick for what workload.
> > >
> > > BUT someone has to do the job setting everything up and maintaining i=
t.
> > >
> >
> > I'm still here, the dashboard disappeared because the drives died, and
> > although the history is interesting it didn't seem like we were using
> > it much. The A/B testing part of fsperf still is being used regularly
> > as far as I can tell.
> >
> > But yeah maintaining a dashboard is always the hardest part, because
> > it means setting up a website somewhere and a way to sync the pages.
> > What I had for fsperf was quite janky, basically I'd run it every
> > night, generate the new report pages, and scp them to the VPS I had.
> > With Claude we could probably come up with a better way to do this
> > quickly, since I'm clearly not a web developer. That being said we
> > still have to have someplace to put it, and have some sort of hardware
> > that runs stuff consistently.
> >
>
> That's the main point IMO.
>
> Perf regression tests must rely on consistent hardware setups.
> If we do not have organizations to fund/donate this hardware and put in
> the engineering effort to drive it, talking about WHAT to run in LSFMM
> is useless IMO.
>
> The fact that there is still a single test in fstests/tests/perf since 20=
17
> says it all - it's not about lack of tests to run, it is about lack of re=
sources
> and this is not the sort of thing that gets resolved in LSFMM discussion =
IMO.
>

Well that's because getting code into fstests is miserable, so we just
worked on fsperf outside of fstests. We've added a fair number of
tests, a good bit of infrastructure to do different things and collect
different metrics, even run bpf scripts to get additional metrics.

Hardware is always a problem, that's why I think it's better to just
use this stuff as A/B testing. Making it easy to run means we can have
a consistent tool to run on different machines that may have different
characteristics. I can validate my fix works good on my NVME drive,
but then Johannes can run on their ZNS drives and see it regresses,
and then we have a consistent test to go back and forth and work with
to get to a fix.  Thanks,

Josef

