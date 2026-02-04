Return-Path: <linux-fsdevel+bounces-76290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHzpNLgQg2kPhQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 10:26:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 470D7E3CED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 10:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED2AC3096768
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 09:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A57C3A4F2D;
	Wed,  4 Feb 2026 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYQt7SSY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42893A4F39
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196935; cv=pass; b=N2rkYIIWVfXLtT/UahhTiOBsNJHfOEuKR1oV/N2oVymjVsmRgIc54phFsZesORURzTh37rgz/BtNXeWAqqRopWW6ic6vIJFPSUd3oUNZyS/xEmuGiddpq5jOaChvlHEDw6wzS0bYPErx9uKvXdaNmD3jlthCm4bP6/Tt3BTmOrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196935; c=relaxed/simple;
	bh=0hDRXwPzW3/6ToHHwEWkP753GuOUrTA7RZhhIa8f9bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLa+4/LJtAtdwmIvQliS6x20gQxm2kv4gJwe7UKdgswSmFCVh/LCv+9+GxfKiosJ1RDvBD3QbkujMgkFvNaIx41GkD9HmhJMHb6LUYgq1IirK8YWd+nWjui5kDGqDuvSagQPJKSVdFDaMwofNuUZ6IXUvtyn/F6kNs2HnqLqL6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYQt7SSY; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506251815a3so610831cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Feb 2026 01:22:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770196934; cv=none;
        d=google.com; s=arc-20240605;
        b=kl9mobbfofBPmEm6QqLCHucZVY5ZanZw14aV8+ZwlokRtYLeh/nVjlEruQ4gLWb/Ju
         4Jn0J9TaqBJR4C6s0efjved7V05aZLbV1dstQxXp5S59E+O2JtNNttu/l9HMMpK3e7Xi
         ECQcnWCR5cpfPM9fYqQ5uT5p+yEG0NNM2EIDPe0rIY+VnznbM8VH9EXznlSQtP3Wn7NI
         o7vombbTSS7NSeGQhS9kO0ZIIGGotklZXeXMF6Umem9nauccfeMu4+jWIlKX5eX8Ar2A
         IG30d9gQmJkW0FEkuP2q3Os23UkJo+GH0qI/u1GVC4o78tZuvhUu77Qm7NJMoaMhnRJb
         fgzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U6Bno4P/hxe4/YKlevFXjeDly7/hifMQNx7lG2pEsLM=;
        fh=07GT3Cd74pla2Y9Mvt3HUFodHTNaBEjBiG4DpCtUSHQ=;
        b=bZqmGNcst+7Ty0+fQZF4V2JvGQyBusYPDQ2bJxTb6q/vxse3ugUqID57A3oeL+Pneg
         JRC8HMft9o3hFFX4XRXAQfmmN6YTuOu3Wv/cLAZxkFE4JH0lU925RnnRcaMo4l2rYNuE
         Cldc9Vas7GxHuqUWt5INcJFMztdcEMpUNyaaUznO7NeRGjLvIntxYVVij5hxMSwOJN4s
         RR20lRgXyGaoUIgMlWdHNVVPlqJSVhEfjiLytP7iv68/MvCkQGMjOejTyQO7tKrrd1hW
         L167HV5A1WNhe3Sg8bM1A6WiF6LyN1BTHa//PAr5bzAfZCQ/nWwvt30Tn3FN/LF7dWik
         /3bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770196934; x=1770801734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6Bno4P/hxe4/YKlevFXjeDly7/hifMQNx7lG2pEsLM=;
        b=jYQt7SSY62HDYCT1UMR5IkwiVNnW0ebaKtMEUauKKBO6vRQLQN8Och4Oyz2vAv5r2l
         eFY5oTQSrPFvnKgnmC/pbATiei5JD2PSewM8cJdqG06jFYyEg1E26Y6RxPaXdkCgLfjt
         YBu4fUovoTGrZhewTVRo8ZCTVZGV5LDUIRaNIeM8wqggXNBP++yysAfgjijRybsqMWgW
         MWQWF91Nwv5CU1i6As2k2cLgYujgQrHo+9AuSYlv5zm9uFUPfLJs7hWRKPfUEz+ueMMd
         6nH8G5A7mubytgzVkYAjllBiPUoU38aUXbKwF0v+TcS2D8S7OYob8CIoSGtvT7suOxc6
         brYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770196934; x=1770801734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U6Bno4P/hxe4/YKlevFXjeDly7/hifMQNx7lG2pEsLM=;
        b=IuA0pXFQuSmEe073Es1cExdo45SllbXvMoFfQg2pYdGf5f1+h5PjwyGcrqQbv/augK
         5wqDI1HrtntRR9wkyCfDH2IT/mXtRO6rHkpPIvOvQmABSy/RapSKmdpXNdVBNeviHYHv
         ohgJNilDbJztBccvFzxGGbUCBcDCUbmaqaER7Px0lE7DLpisjNy8+nD89JLvhYQK8KTX
         uKohqGIQGIFb8sxzI8f/+ukH8jJI3flanqzH+ZticWloReDml3FCVxaNYtXIbifNZo/a
         Ksq2gbDXX6wyfGkduSrteyfuYlBM0JG2iCquiTW+FNBweW/l9Z+gFrvq6hfFCGZtClBZ
         7LYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXLAfJvKyF4VO7wtzzEeM1GZ08Xj0zTswruGP5mfSTpEAD9Rl8xrvHXkfDgQvAklKxCAbf0Kq5u6h07d9j@vger.kernel.org
X-Gm-Message-State: AOJu0YwMjPDn531Xq3Qvg90H9GKLVws7Xppi8VbgG41RAFIda6pC1Yk4
	hhB/bsKrNo1bl3kXfiLni6V+rPGoi0gLkah5rNF8Rv+/NDigCH/sn5ZXcxjIgOH9kDRqQRUjNaS
	cmP1kNC3sbGQV23Z/Qysmb7MRqciqP1E=
X-Gm-Gg: AZuq6aLNsTcAA4VtGNghQV1hcbZ9CWqV4nOmIjIALPkwU8Do/k+6c6SX1LKPwdZS74E
	omPJB9PyKb9IgnBW+EOGonNBU0dfPE2Oo1MJXJgRkdFEvHSYfVQ/TgwCVnn/AC0/b5z6iqOQkc1
	GWnp5m7aaOxP7rFFRxOqlsrIiWxI2wEWxdqXlJaFhqEIaGxl9Pzdj1eIDqtHj8JVSeipISiNYHJ
	QZGFJ4mVL/vVAm8ES5bCdfIMfyVAI6nx2bq07t7qhiXd7YUlSufZLV4jkUnU2ir+wbf3648
X-Received: by 2002:ac8:57c8:0:b0:4ee:1aab:fd6 with SMTP id
 d75a77b69052e-5061c0c6ea3mr27920441cf.3.1770196933745; Wed, 04 Feb 2026
 01:22:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <CAOQ4uxjEdJHjbfCFM364V=tBrEyczYvzo-b-Xo0UPOCA2cnPGQ@mail.gmail.com> <CAJfpegvg=hqM1vMCyrb61VT6uA+4gdGwvqHe5Djg2RF+DTUMiw@mail.gmail.com>
In-Reply-To: <CAJfpegvg=hqM1vMCyrb61VT6uA+4gdGwvqHe5Djg2RF+DTUMiw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 4 Feb 2026 01:22:02 -0800
X-Gm-Features: AZwV_QjeeJRQON12mJBtppy7xpfNEkUsEy7Fy6TbCY_PjP477zE5Qvhi4S_TV8Y
Message-ID: <CAJnrk1YKDi9e-eTQyGBD-rFScxGTcsfz3tnmnE_EshPd18aMrw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	"Darrick J . Wong" <djwong@kernel.org>, John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>, 
	Luis Henriques <luis@igalia.com>, Horst Birthelmer <horst@birthelmer.de>, 
	lsf-pc <lsf-pc@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,groves.net,bsbernd.com,igalia.com,birthelmer.de,lists.linux-foundation.org];
	TAGGED_FROM(0.00)[bounces-76290-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 470D7E3CED
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 11:55=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Mon, 2 Feb 2026 at 17:14, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > All important topics which I am sure will be discussed on a FUSE BoF.

Two other items I'd like to add to the potential discussion list are:

* leveraging io-uring multishot for batching fuse writeback and
readahead requests, ie maximizing the throughput per roundtrip context
switch [1]

* settling how load distribution should be done for configurable
queues. We came to a bit of a standstill on Bernd's patchset [2] and
it would be great to finally get this resolved and the feature landed.
imo configurable queues and incremental buffer consumption are the two
main features needed to make fuse-over-io-uring more feasible on
large-scale systems.

>
> I see your point.   Maybe the BPF one could be useful as a cross track
> discussion, though I'm not sure the fuse side of the design is mature
> enough for that.  Joanne, you did some experiments with that, no?

The discussion on this was started in response [3] to Darrick's iomap
containerization patchset. I have a prototype based on [4] I can get
into reviewable shape this month or next, if there's interest in
getting something concrete before May. I did a quick check with the
bpf team a few days ago and confirmed with them that struct ops is the
way to go for adding the hook point for fuse. For attaching the bpf
progs to the fuse connection, going through the bpf link interface is
the modern/preferred way of doing this. Discussion wise, imo on the
fuse side what would be most useful to discuss in May would be what
other interception points do we think would be the most useful in fuse
and what should the API interfaces that we expose for those look like
(eg should these just take the in/out request structs already defined
in the uapi? or expose more state information?). imo, we should take
an incremental approach and add interception points more
conservatively than liberally, on a per-need basis as use cases
actually come up.

>
> > I think that at least one question of interest to the wider fs audience=
 is
> >
> > Can any of the above improvements be used to help phase out some
> > of the old under maintained fs and reduce the burden on vfs maintainers=
?

I think it might be helpful to know ahead of time where the main
hesitation lies. Is it performance? Maybe it'd be helpful if before
May there was a prototype converting a simpler filesystem (Darrick and
I were musing about fat maybe being a good one) and getting a sense of
what the delta is between the native kernel implementation and a
fuse-based version? In the past year fuse added a lot of new
capabilities that improved performance by quite a bit so I'm curious
to see where the delta now lies. Or maybe the hesitation is something
else entirely, in which case that's probably a conversation better
left for May.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1Z3mTdZdfe5rTukKOnU0y5dpM8a=
FTCqbctBWsa-S301TQ@mail.gmail.com/

[2] https://lore.kernel.org/linux-fsdevel/20251013-reduced-nr-ring-queues_3=
-v3-4-6d87c8aa31ae@ddn.com/t/#u

[3] https://lore.kernel.org/linux-fsdevel/CAJnrk1Z05QZmos90qmWtnWGF+Kb7rVzi=
J51UpuJ0O=3DA+6N1vrg@mail.gmail.com/t/#u

[4] https://lore.kernel.org/linux-fsdevel/176169810144.1424854.114393554000=
09006946.stgit@frogsfrogsfrogs/T/#m4998d92f6210d50d0bf6760490689c029bda9231

>
> I think the major show stopper is that nobody is going to put a major
> effort into porting unmaintained kernel filesystems to a different
> framework.
>
> Alternatively someone could implement a "VFS emulator" library.  But
> keeping that in sync with the kernel, together with all the old fs
> would be an even greater burden...
>
> Thanks,
> Miklos

