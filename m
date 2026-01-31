Return-Path: <linux-fsdevel+bounces-75979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCwNMftVfWn9RQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 02:08:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F173BFDF9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 02:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B96FA30488CB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 01:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A079427AC48;
	Sat, 31 Jan 2026 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HllqAs+/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81BB3191DF
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jan 2026 01:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769821549; cv=pass; b=VqkCnv8QzUtTExq2iIbDT1V3CNq/CLLA4OPB4CYNoo4EYKd4s6JTBBCFTRgTLqXemo3AAVrmHdfBlPCyTGeChU9mvk6Kj/fJ0PgeZqrPAKo9Qw+R6vbGV8NioYenSSSgQG8h5lMEHwCpaICeY7+lx3EJ1x0KZLNbt6VhO0Txz3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769821549; c=relaxed/simple;
	bh=xauAVDrNEqxXuQQDfkuXjcLzA9iR5d/8KDCLj8SlAUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDltHPvMioGoQDdjwGqQvGWchvZkN/V8ydBjc7aNjWscTi97C5s3IpgsADXDD7Wns9A3KGgsOGGilDyaiDM22JepMNZ7jDkN4QyzjyO2R2qF7cZF8SyP5gvwWE5UfJ6PoxegRDIU6It4DKZ9Ne3Q14bfyRKsz+9tbe2o7I8Vzuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HllqAs+/; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b86ed375d37so377262866b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 17:05:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769821546; cv=none;
        d=google.com; s=arc-20240605;
        b=TkdWZrpljviQXtfUCX46uSU+ezIs06hetZE2tXt0N+H7Po9bTkGyc5Vnu0qzELAeCD
         xzw10w5tvrWRq0RrEKCnZr3GYKd1+uKA3SztUtfPBqS50iw852fvYWpjRAc0lLcMM6il
         GQ00yLzkSo86d3biSSBkmCPn2xHSBmuWNosLoC14WZl1hobRBf/kwIKrUipO1Cy5lnCQ
         V+B/3tIdR1cyLd8QVQSMEBKWkfmdWeMf4Gu9nW0+kNnDLys8Xfuqi28D06egCJj63Jvm
         QB5nxoUN0XATywuUHnakvn1D7vyk505ZM65a+cf69rXNoHZ99/WN2ji2G0sUvWysW7/q
         lelQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WR8rpY2KGV4n5Wdzx9LxUGbuZ8iHOgSWcj67TDHRUAg=;
        fh=XZguo7X6qS4aJMeI5lgvWoKqUBNuSGPo4i9Gv2dlJSg=;
        b=OCUqR0NMlbB/dJRjL55kKxMQnsoq3DFcTSR0E17r2akT/B5a7+0W+c+9t8rBdt1c6L
         3G0OcwlgOd0cuUBvvWC8azdBmebXBb+a5BF7lbaPD3gMZezOBt/ABJBdi2gJwqoXrLWW
         83nIC9RfkzN3iD3Td4Iz7tqk3+Sy8JghXZ3hFrSkZNIDfXeohDFACBRK5QpB5+9uPKsZ
         t0o1XbhcTbJtVPcCeCGw66FHLHjrM8PzNBROd1FC4j4kF34PNZeBnDAAEuzvzAKOo6dT
         RYlrQD2taxAXMcSVo/pCJvZFNqbMCz4zV4rtIXm0Re/WOZQLtsgwG0jpqG8XqY5t98C6
         xY8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769821546; x=1770426346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WR8rpY2KGV4n5Wdzx9LxUGbuZ8iHOgSWcj67TDHRUAg=;
        b=HllqAs+/IWHE2+kQ9ii8b5Gtko1h7Ik70Pwl45FY+prbj2XSVoNyELK+flYSa2NQo8
         EXfzD6mw0oX/ZlcIu3rfD3gSpUvxACQGYIH/Tl36lScTzSqGPf7KX8gtg3w/jdI+zaqh
         b70RFAKtyAAsDtS1eh60MRioJEW4g53yrxfS3kn8JvPA1T8gyDJ3TbalXssoUOVJkQbB
         jvGjJObfMMQbMdMBdGn+zwg4BMNPdymUx9VX9d4oC/MnBUwn5iYrXwM6DX/OcGYm3wZH
         /zCPYr3iPl0vH84xBlQRUFtR3PnsqszdSt7W3HzHNo81Di8s17L3tMFO2MgvOo+9Qs0Y
         at9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769821546; x=1770426346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WR8rpY2KGV4n5Wdzx9LxUGbuZ8iHOgSWcj67TDHRUAg=;
        b=mt4CtZNZ27ARqGu0/Uns8gxKSwWdYx5DzfHaPhRClODtvcqvFMPRgZj0pz6ddypmLx
         Pbu/tTKbPDs+wu61rysSXcxno3AaTYfBrxHGQpWIZU8B2+A7SxNrIrmpJF7cqOGNO4qx
         ZLPJKbUfvaJz8JMuw49pdQTJ6foFlflj+o3inlyBtW9mltUd9iko8n0NPcd3b2byyQsL
         Ky0GlpmPULfpWWIYzKuiYqgVVCgFUWHK62R1eq0aFH73e+rjbkLLckOtv/I9P9celC+i
         q5P89GyNrx8F1kON1zHn52rtEDR1Mlk9S2PAz7tXzR+9lf2Nyzhc3XFsukbZgqtI1l/o
         f0kw==
X-Forwarded-Encrypted: i=1; AJvYcCWR/LZ24PNKvGUlVWMr9w+xJ10Jtx69VMLY3BO8RIaWpf9vOEJUugafqpPhdYsbm4B/otVRFd85UXtb85Yh@vger.kernel.org
X-Gm-Message-State: AOJu0YzL1qXp3pEAh85ShLMPoS8iJOKJn2kKjADnzyWNhoBaF2AdW+i5
	2XTzLw1VF3QpNut3Q1wtHUh+2f2Nb/kFKfd6Y2WPVU72gSA8CYksCXpS8IpV0HaAiQD1UFkZX05
	TjR0RxpYoJFSZkBuaj4B5nQqFKvYSqaGssT4oCJN3BEq3Y0BDdqayK87XeLY=
X-Gm-Gg: AZuq6aKCiZySG6aVztKO3csqCt8q+cElt2b/HQeRrdpTQ5gS8il8CAr4RtD6Lvvsqng
	Bl+si4i6JQHicaZlHNw0peYSOFT0jcr8y9qZ0wqXVGd/FzU/bhn0mZ6luxbu+fMnuMF25forlA9
	W2fEXG4R0pRrPDIW3JTCLu0JFwoZkz57TiYq7e2y+vy5C3RPpJxEFmgfkTKTC4Q+z0zMjEk+HzV
	LKE0ItmLjuTZmehVcisewNxpodQKPMtbQUhXX4/s4VI5s1zfEgFzZt5ZPbjVvAvZyeCsvAl9b9T
	bZE=
X-Received: by 2002:a17:907:3e0d:b0:b87:322d:a8bc with SMTP id
 a640c23a62f3a-b8dff696c0fmr254282166b.31.1769821545900; Fri, 30 Jan 2026
 17:05:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh> <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV> <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV> <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
 <20260130070424.GV3183987@ZenIV> <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
 <20260130235743.GW3183987@ZenIV>
In-Reply-To: <20260130235743.GW3183987@ZenIV>
From: Samuel Wu <wusamuel@google.com>
Date: Fri, 30 Jan 2026 17:05:34 -0800
X-Gm-Features: AZwV_Qi-TVApb-UR_yhUuzDZcqy8acCYfKVdTsorIhJOL99wmGwpM0Som40uK5A
Message-ID: <CAG2KctotL+tpHQMWWAFOQEy=3NX-7fa9YroqsjnxKmTuunJ2AQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wusamuel@google.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.org.uk:email,mail.gmail.com:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75979-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 2F173BFDF9
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 3:55=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:

> So we have something that does O_NDELAY opens of ep0 *and* does not retry=
 on
> EAGAIN?
>
> How lovely...  Could you slap
>         WARN_ON(ret =3D=3D -EAGAIN);
> right before that
>         if (ret < 0)
>                 return ret;

Surprisingly ret =3D=3D 0 every time, so no difference in dmesg logs with
this addition.

> in there and see which process is doing that?  Regression is a regression=
,
> odd userland or not, but I would like to see what is that userland actual=
ly
> trying to do there.
>
> *grumble*
>
> IMO at that point we have two problems - one is how to avoid a revert of =
the
> tail of tree-in-dcache series, another is how to deal with quite real
> preexisting bugs in functionfs.
>
> Another thing to try (not as a suggestion of a fix, just an attempt to fi=
gure
> out how badly would the things break): in current mainline replace that
>         ffs_mutex_lock(&ffs->mutex, file->f_flags & O_NONBLOCK)
> in ffs_ep0_open() with
>         ffs_mutex_lock(&ffs->mutex, false)
> and see how badly do the things regress for userland.  Again, I'm not say=
ing
> that this is a fix - just trying to get some sense of what's the userland
> is doing.

Ergo this didn't make a difference either.

