Return-Path: <linux-fsdevel+bounces-75166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gENlMXascmkkogAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 00:02:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E986E5EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 00:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF476301BCCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 23:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DD53D905D;
	Thu, 22 Jan 2026 23:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxQt+22+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEA73D6492
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 23:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769122885; cv=none; b=RXN2w5Xv3cF7M8abrVKeYN6Vhx7QNptpoTohTp75mQVK98RUptUu3W5D+IXVltVBHuhuZBnAaybktgg0Q9twdgXw5pWShvT0yzz7YkKX4ik1uXQbaYhn4mFVL5x0pECUKs4r9JEpnpo0HMAYPZSpSE96dm+tgD65OVLML0xPxQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769122885; c=relaxed/simple;
	bh=JlakTW/ze/YnNgpvwbDGQ4KFotr/cPC9MgSPMwySzvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXAlQBOdiGrLk3sbwzUe8Rx6/wYYRyDSo6Uu5EamiUBdRsO0C+9VCdFndffpyGjNJ+e/DI49gce1t8KaDYAxxfO4Jkxco/dHUa0rLKQennrqCh1tJqZkueUYGTUGiH7dWmtr6w7tik43aJcXYNnyZIhUeXTbrPdfzVtaplVeb9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxQt+22+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6D2C19424
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 23:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769122885;
	bh=JlakTW/ze/YnNgpvwbDGQ4KFotr/cPC9MgSPMwySzvw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WxQt+22+zDa1XK9Y6XeRxhrrGVrAW2k/8mT/2kg0bT08mxhznEf1xt+kx98l4CE8B
	 IQNbATpf19sblYQS27w00iMB16fKTPE3MDxMVUz9TYuXjNS4lO8uMb9rt8SU4OxnbC
	 PChzmDG4tJ96egRJDo5JmKBZaFwa3AMqDComjRlROr+HwX/o3cu9yyhDyaGk3wKaC4
	 pJXn+O7GkRbLrJuS5zVpNXt/20RFJix6CtMuZ7YVny3083t3852v0qwmQzazl6i3j9
	 PpGh9OombBm/zhMmOl2+q2VPHND1kP5GIJuYXb6Nz5+zxDgsasTxv2SsFlUEAPUkN2
	 1gGyNpyqdMNGA==
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c5384ee23fso180389085a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 15:01:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbreajdvTmZYPYK5XAo+/HALBGZPoz3kFIl/oogC095AcX3MzUIYZC65Kl9KxFX+g91nsZ2yShURuLKOXG@vger.kernel.org
X-Gm-Message-State: AOJu0YxsNLMo5Cx2okDgxv7AYYG9ukA5CnpeV5TtYrtZbT6T+pB3Hm8/
	9n1bwp6Az8NbbkgIsn7Rx89BArCoMPt+l2Yw7B5nsRrCmjRH7RexxOYas5t+rBtavs1aJnfIGUr
	sQj30eCIPG/XSRTD3V65a9+vFbsON814=
X-Received: by 2002:a05:620a:2a0e:b0:8ba:3d82:de2d with SMTP id
 af79cd13be357-8c6e2e46e4dmr139790485a.67.1769122884014; Thu, 22 Jan 2026
 15:01:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW4=heDwYEkmRzSnLHDdW=da71qDd1KqUj9sYUOT5uOx3w@mail.gmail.com>
 <CAHC9VhRU_vtN4oXHVuT4Tt=WFP=4FrKc=i8t=xDz+bamUG7r6g@mail.gmail.com>
 <CAPhsuW6vCrN=k6xEuPf+tJr6ikH_RwfyaU_Q9DvGg2r2U9y+UA@mail.gmail.com> <94bf50cb-cea7-48c1-9f88-073c969eb211@schaufler-ca.com>
In-Reply-To: <94bf50cb-cea7-48c1-9f88-073c969eb211@schaufler-ca.com>
From: Song Liu <song@kernel.org>
Date: Thu, 22 Jan 2026 15:01:12 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7xi+PP9OnkpBoh96aQyf3C82S1cZY4NJro-FKp0i719Q@mail.gmail.com>
X-Gm-Features: AZwV_Qiqf6sZ_iabxA0mOK3Vfx-ioabvz7MRCMIvXr74zxqrJAA79152HUibatg
Message-ID: <CAPhsuW7xi+PP9OnkpBoh96aQyf3C82S1cZY4NJro-FKp0i719Q@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Refactor LSM hooks for VFS mount operations
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, lsf-pc@lists.linux-foundation.org, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75166-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[song@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 65E986E5EC
X-Rspamd-Action: no action

Hi Casey,

Thanks for your comments!

On Thu, Jan 22, 2026 at 9:16=E2=80=AFAM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 1/21/2026 7:00 PM, Song Liu wrote:
> > Hi Paul,
> >
> > On Wed, Jan 21, 2026 at 4:14=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> >> On Wed, Jan 21, 2026 at 4:18=E2=80=AFPM Song Liu <song@kernel.org> wro=
te:
> >>> Current LSM hooks do not have good coverage for VFS mount operations.
> >>> Specifically, there are the following issues (and maybe more..):
> >> I don't recall LSM folks normally being invited to LSFMMBPF so it
> >> seems like this would be a poor forum to discuss LSM hooks.
> > Agreed this might not be the best forum to discuss LSM hooks.
> > However, I am not aware of a better forum for in person discussions.
> >
> > AFAICT, in-tree LSMs have straightforward logics around mount
> > monitoring. As long as we get these logic translated properly, I
> > don't expect much controversy with in-tree LSMs.
>
> The existing mount hooks can't handle multiple LSMs that provide
> mount options. Fixing this has proven non-trivial.

Could you please share more information about this issue?

> Changes to LSM
> hooks have to be discussed on the LSM email list, regardless of how
> little impact it seems they might have.

I don't think we're gonna ship anything without thorough discussions in
the mailing list.

Thanks,
Song

