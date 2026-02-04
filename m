Return-Path: <linux-fsdevel+bounces-76301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1oqxG5Ihg2ltiAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 11:38:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D96E5E4A43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 11:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88AC830160DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 10:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6FB3E8C47;
	Wed,  4 Feb 2026 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXom1Kp5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022C63D7D6F
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770201487; cv=pass; b=GuxyWViX9bs+/KLMF3pmaq0yg8qA+Mg10/2MeCXcutFVDTFbqHyOYEzhhS3tcp9uPHzCOOpoby8chTK22wMjWKlrcc1CH0zLlu+ncGuOA8DhrKlPHAOAILO8oGeNlXP3JsR+jAitC5LoQHH3ARyNLIJRava2IdzIrbW6l0R6ofg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770201487; c=relaxed/simple;
	bh=MaE5dSzTw4DCLdgZdi5pt+oCKr0X5iGDoLGe4GzAEE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/gbCXMsa5hLiSRJ2Xf2928JYxGnjVED4ZmRQ4l5rjbTeFhFJc5w5Ikas9p2TwbZ9PtFjWdXdI6GSrPW8g+VSJp+cVohmoqbYEX3AS9vPMS0O5/GcJsasCMvOp7GNwDQGXQ8X3V/ZXbmTSPe9jaYEGy8xUYW2PrRBJaVmQdOCMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXom1Kp5; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-658b7d13f09so11975264a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Feb 2026 02:38:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770201485; cv=none;
        d=google.com; s=arc-20240605;
        b=Vdi1DkA+0Iv3qkrUCVF/xEyw5BMUZKh8ex5GwrLE7FeGo15enl9YeD/MGFcaRT7rIm
         ksHTzdRDj0UKxAg/JAs7d2UgcY1PKUsqGT8aCrcUOLOXfctkmLRnZJ0hU9RozSO1yPl7
         LLJSrmANslhH/4pxwFsBpG0XK+deT5yvde788He8gXkHjFo6Fu9BE2J1GSFusN4d7giI
         wB7TgnRAHMsLg2N1ZXLeJESaZGNBK9FkmMA+bu6H7wzwUrpMx9BD9ndowmCpP9sOXEV2
         wX1GmOBXt/2w+x8s/RtUZkGXoUYwJ2irxgi8t8dw1cz9eUn4O6IiBbumLRphbZWeDFoU
         C5Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uM5J7dTDigCNS3rvenYhKNR04fvnGYc9H0nw2tC2+nA=;
        fh=m9Thrjb9lQDm7cV88G7gPaGWnk+oFqVonwi0J+Wday0=;
        b=jRTr5UqQkk+UQnNp1ZuQLU5MpFwuevll1jQLWlQDF92/GpLN0cMpWxeAzgEWe0SgCe
         k4hEj8o9GV5SPNjA03O0e+utVVVqF1pbQs20Xm+PssDmk/4pQKz4rzb7oKIrIDl2LiVK
         Fo0ySonPto1jsYqHeb6phTtrNOKgwIx/WQFN5KpBHBYIr0micBnmHxVNKfT2IsEhw8OQ
         UwsmMYfcYXuezJExuUB3SEKmaj+TDqj8n0NBNZEWMJD8GGHVdv0a/VYNWpcTCAUA9WcW
         8MUfdC1ZzOOIQLmHSmID0ffKYxeIUePtCjXjruHiFtZbJyEiNy/3Ds2IfyfhHFYCgJtv
         +upQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770201485; x=1770806285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uM5J7dTDigCNS3rvenYhKNR04fvnGYc9H0nw2tC2+nA=;
        b=RXom1Kp5SN3L4/kkeL0u62MPk2xpyBsi7gLavXyak9fb+TI6/8H374J55SEZ5c7vSy
         p4ZTPsjlywqjXHExEzV9+6JQjFNhB4t/0ppwQPBlUl9DHVpr4IpMWzsD9xnj1YBI6jP7
         md2dIOfpOybVFc2LVBqMwBvdP+6ZxvVugalhxb0hAHxX4YhZ+jgzN6Aas8e5ViXoqKe2
         jPsZ3cTSoL11aL5p4npTm32PHMVsNXC4eByQORM6XqQ5g5h/XyjY8c3qsKmRnakOVsa9
         oxuuJuLpKusaG4w+3S4oens0FDdsF8p32tXZry1LbWQCtXeTTLZwCRI71AIxqAc+jUm+
         GI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770201485; x=1770806285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uM5J7dTDigCNS3rvenYhKNR04fvnGYc9H0nw2tC2+nA=;
        b=KZ28ykKdplP0HJj1cTBapNUyg8PeXK7pf4nXwW2aQpxet8EwtdHAqZa4LHBBwH0cst
         EblQ5TU3UKygvZDWCNrSOmeblC+q6oqd5VMSnqyqw5VOVmmqrvkKqI/xrfRtM+j+nyyH
         Md1pU12E+vFAyQSAkERvOltS5xdMmGkUIaZdDmtMDEaYSVEhSp6zlzhiIffsoakuDw1V
         A7yaG+fl7vAStavKXbCb1pQa4736ZPiFduraSipoDOL+yKO36TqF+N9f1ELiXCl8+nxF
         wjoHHM4X/PK8pY6+tDQVKAkyA/y0aR2Y6yYT4LbfFptIKRUiMpN6DcioDZwtTmllAkJD
         hwiA==
X-Forwarded-Encrypted: i=1; AJvYcCX8eCpPafAoXzE+8MSJZ5UuPUYVj9eu+rZkksw7jQPZ2bi+SGdIko3rDbNrM2A/Gin1HqKqCvoyONVWDauv@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcn7hzLQqjUjeS/9n2xri2VgFfO+4NpxTE5OGFPicfK2w078sP
	cj5SeTq4EEiUZ6pSZsAky49yqGBz1N7zU2AkHni4O1BqNFPkKnlHIkt2HUciQA07ISwg1R1ssXh
	HR7thkj9ZEFh46Mc/1f9tkDAkeK1xJok=
X-Gm-Gg: AZuq6aLRwzKc5DxSv0mq0zxXu30fix6v4q1qHqSpwHyoQgkRffw/7sDtoZrhno+L3+F
	578y2jpLuCk36CIaL61mT1g8BHvp1k9pnIcyFKUXDu5iUxlZ17Y5nyhO1qg4z+XCp9ryoElTisq
	iFOI5Tu8ElJQOHiEoZ8wG6w97Jx7n+eCSqiT7Tyg02crDAn5EzaI8SyKyVgSJrjdF43N3iRY1hv
	FE9GU80ui9O6qPww+1Gmvo3WNKZ9OOegLBPageO4ifL9o2+eUlSHF9bVPIjGL8RGjQbsNIR14WW
	GOsSTcUtkcd3gsv/YcOxlsSu9X7AyA==
X-Received: by 2002:a05:6402:210f:b0:658:b4df:ce33 with SMTP id
 4fb4d7f45d1cf-65949dc8b48mr1770738a12.22.1770201485023; Wed, 04 Feb 2026
 02:38:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <CAOQ4uxjEdJHjbfCFM364V=tBrEyczYvzo-b-Xo0UPOCA2cnPGQ@mail.gmail.com>
 <CAJfpegvg=hqM1vMCyrb61VT6uA+4gdGwvqHe5Djg2RF+DTUMiw@mail.gmail.com> <CAJnrk1YKDi9e-eTQyGBD-rFScxGTcsfz3tnmnE_EshPd18aMrw@mail.gmail.com>
In-Reply-To: <CAJnrk1YKDi9e-eTQyGBD-rFScxGTcsfz3tnmnE_EshPd18aMrw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 4 Feb 2026 11:37:52 +0100
X-Gm-Features: AZwV_Qi7v-YwWsTymMCdPlzbQppywgqCmiUirl2ruLXz9Ug7bEABjiL-Iqj5V_8
Message-ID: <CAOQ4uxiUyO-fNG5o_3sH94BJWsYos0+wAe2Zs_7WKy1wUbhnew@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	"Darrick J . Wong" <djwong@kernel.org>, John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>, 
	Luis Henriques <luis@igalia.com>, Horst Birthelmer <horst@birthelmer.de>, 
	lsf-pc <lsf-pc@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76301-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,szeredi.hu:email];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: D96E5E4A43
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 10:22=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Mon, Feb 2, 2026 at 11:55=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu=
> wrote:
> >
> > On Mon, 2 Feb 2026 at 17:14, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > > All important topics which I am sure will be discussed on a FUSE BoF.
>
> Two other items I'd like to add to the potential discussion list are:
>
> * leveraging io-uring multishot for batching fuse writeback and
> readahead requests, ie maximizing the throughput per roundtrip context
> switch [1]
>
> * settling how load distribution should be done for configurable
> queues. We came to a bit of a standstill on Bernd's patchset [2] and
> it would be great to finally get this resolved and the feature landed.
> imo configurable queues and incremental buffer consumption are the two
> main features needed to make fuse-over-io-uring more feasible on
> large-scale systems.
>
> >
> > I see your point.   Maybe the BPF one could be useful as a cross track
> > discussion, though I'm not sure the fuse side of the design is mature
> > enough for that.  Joanne, you did some experiments with that, no?
>
> The discussion on this was started in response [3] to Darrick's iomap
> containerization patchset. I have a prototype based on [4] I can get
> into reviewable shape this month or next, if there's interest in
> getting something concrete before May. I did a quick check with the
> bpf team a few days ago and confirmed with them that struct ops is the
> way to go for adding the hook point for fuse. For attaching the bpf
> progs to the fuse connection, going through the bpf link interface is
> the modern/preferred way of doing this. Discussion wise, imo on the
> fuse side what would be most useful to discuss in May would be what
> other interception points do we think would be the most useful in fuse
> and what should the API interfaces that we expose for those look like
> (eg should these just take the in/out request structs already defined
> in the uapi? or expose more state information?). imo, we should take
> an incremental approach and add interception points more
> conservatively than liberally, on a per-need basis as use cases
> actually come up.
>
> >
> > > I think that at least one question of interest to the wider fs audien=
ce is
> > >
> > > Can any of the above improvements be used to help phase out some
> > > of the old under maintained fs and reduce the burden on vfs maintaine=
rs?
>
> I think it might be helpful to know ahead of time where the main
> hesitation lies. Is it performance?

I think that for phasing out unmaintained filesystems performance
is really the last concern if a concern at all (call it a nudge).

> Maybe it'd be helpful if before
> May there was a prototype converting a simpler filesystem (Darrick and
> I were musing about fat maybe being a good one) and getting a sense of
> what the delta is between the native kernel implementation and a
> fuse-based version? In the past year fuse added a lot of new
> capabilities that improved performance by quite a bit so I'm curious
> to see where the delta now lies.

Yeh, this is a fun exercise. fat could be a good candidate.
I'd do it myself if I find the time.
If anyone starts doing that maybe post a message here or in FUSE thread
so we can avoid working on the same fs.

> Or maybe the hesitation is something
> else entirely, in which case that's probably a conversation better
> left for May.
>

Besides testing and maintenance which I already mentioned and
functionality (e.g. nfs export), there could be other concerns
fuse has some unique behaviors, but maybe those could be
fixes for the sake of this sort of project.

I guess we will know better once we start experimenting and
let actual users try the conversion.
Finding those users could be a challenge in itself.

Thanks,
Amir.

