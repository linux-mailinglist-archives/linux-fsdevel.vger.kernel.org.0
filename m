Return-Path: <linux-fsdevel+bounces-19843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A478CA460
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 00:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908C128235C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 22:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1363139D1A;
	Mon, 20 May 2024 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jv+Yqjwe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1891CD3B;
	Mon, 20 May 2024 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716243183; cv=none; b=qXHoj6ujtHrjTKaqWp2TQFFdanDdL49QX2etbyd1CoD7NpIJ9JKCHroSB0wLwYLXuxHn75P+UWHtGDo7PhgWVxeh4qfNQINeHidJkAd0PGPX0Tt5BOrfTsep4GZUZ3QgLYiUP5uPGIWeVS/bVUBsJQHZ/MELJInnHv3gXSrAAXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716243183; c=relaxed/simple;
	bh=g67Au3Gl3mqSp0DalxfSQ7ydt1TQGOl6Vi8oRqoOvyE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=IfSGOjk8znDm4ZX9aDMqdZx8t3pKgqWga28Z/D3mq2NesX72w4EEcjOjpe5Z3axkgbTpyeViREAhx58khXaCjsb0Fg0PfFGMBKWXKGhBzlQ2LgHsSdz4er2RBwui2dKGguCVlxIrNCrh/QNMs9XydF5A09icmuVInY8pvoqZz7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jv+Yqjwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D6AC2BD10;
	Mon, 20 May 2024 22:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716243182;
	bh=g67Au3Gl3mqSp0DalxfSQ7ydt1TQGOl6Vi8oRqoOvyE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=jv+YqjweWfOJ58Q3rWlPlQFpRXdnf0erK6kTjwm69gsovWdMmwxN9rknV5ZxWSN6B
	 Fqs8WiDOHc9qevF1/3ks8cLHz5bTvsGWiabm9jjGikcvnZZG1qt/aDXy8jxdg4uG4c
	 z1WKhAGZceld4lkmUZbrOQKQJqV+ed++z5zKsq63KAs98UAwUtpJ5ALf4kCvQnVLuH
	 iFAoYHnk66FrFIo3UhnKZKeGaFUfJvXUnMuZH2soK+u2t7rJxRqxV2iqQEemdJT6BQ
	 uLCZIxjwrjwVmECgZ02bXTlOH/TcfCevAYf2khb2XBVuWXd0po3UYUMOSBHAy6kQ9L
	 aWJlEPVroniqQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 May 2024 01:12:57 +0300
Message-Id: <D1ETFJFE9Y48.1T8I7SIPGFMQ2@kernel.org>
Cc: <brauner@kernel.org>, <ebiederm@xmission.com>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Kees Cook" <keescook@chromium.org>, "Joel Granados"
 <j.granados@samsung.com>, "Serge Hallyn" <serge@hallyn.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "David Howells"
 <dhowells@redhat.com>, <containers@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <keyrings@vger.kernel.org>
Subject: Re: [PATCH 3/3] capabilities: add cap userns sysctl mask
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Tycho Andersen" <tycho@tycho.pizza>, "Jonathan Calmels"
 <jcalmels@3xx0.net>
X-Mailer: aerc 0.17.0
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <20240516092213.6799-4-jcalmels@3xx0.net> <ZktQZi5iCwxcU0qs@tycho.pizza>
 <ptixqmplbovxmqy3obybwphsie2xaybfj46xyafdnol7bme4z4@4kwdljmrkdpn>
 <Zku8839xgFRAEcl+@tycho.pizza>
In-Reply-To: <Zku8839xgFRAEcl+@tycho.pizza>

On Tue May 21, 2024 at 12:13 AM EEST, Tycho Andersen wrote:
> On Mon, May 20, 2024 at 12:25:27PM -0700, Jonathan Calmels wrote:
> > On Mon, May 20, 2024 at 07:30:14AM GMT, Tycho Andersen wrote:
> > > there is an ongoing effort (started at [0]) to constify the first arg
> > > here, since you're not supposed to write to it. Your usage looks
> > > correct to me, so I think all it needs is a literal "const" here.
> >=20
> > Will do, along with the suggestions from Jarkko
> >=20
> > > > +	struct ctl_table t;
> > > > +	unsigned long mask_array[2];
> > > > +	kernel_cap_t new_mask, *mask;
> > > > +	int err;
> > > > +
> > > > +	if (write && (!capable(CAP_SETPCAP) ||
> > > > +		      !capable(CAP_SYS_ADMIN)))
> > > > +		return -EPERM;
> > >=20
> > > ...why CAP_SYS_ADMIN? You mention it in the changelog, but don't
> > > explain why.
> >=20
> > No reason really, I was hoping we could decide what we want here.
> > UMH uses CAP_SYS_MODULE, Serge mentioned adding a new cap maybe.
>
> I don't have a strong preference between SETPCAP and a new capability,
> but I do think it should be just one. SYS_ADMIN is already god mode
> enough, IMO.

Sometimes I think would it make more sense to invent something
completely new like capabilities but more modern and robust, instead of
increasing complexity of a broken mechanism (especially thanks to
CAP_MAC_ADMIN).

I kind of liked the idea of privilege tokens both in Symbian and Maemo
(have been involved professionally in both). Emphasis on the idea not
necessarily on implementation.

Not an LSM but like something that you could use in the place of POSIX
caps. Probably quite tedious effort tho because you would need to pull
the whole industry with the new thing...

BR, Jarkko

