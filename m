Return-Path: <linux-fsdevel+bounces-19892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D249A8CB01B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 16:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE83285D44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 14:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2977FBB6;
	Tue, 21 May 2024 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrIGLAzs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0101535B7;
	Tue, 21 May 2024 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300741; cv=none; b=fHj0uaLMQMl2o4N53p1mO6+YyiEOpRux3snY/tdnNUwRr8M5/vtC/Ta0oRTC7k2UcrwdF80G537hvChQibTeQ2i0W1YuV3ZapZRyDc+fGn3bSuEvEKjY/o22QHttQ0ZyAIt8cgwjzBPfO1smtJKx5zEPYtOXTPoveOZx+zkhw6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300741; c=relaxed/simple;
	bh=wZtYXcGZzSQS0F0yeoqFidLr8irNWnwUfGi6pl/72k0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HKzj1dAdA+A05Da6DHMKKKZVa2IkuEOTbPegyHUP1pMHEKj0gBRdbaofDNineRcU5MgMRKGy5NT7qgeS5nlCOz9YgP5S2h/gDnZicdNDyHBlKEf9gs2ls5RfQQ6Qwgvijd0y+3ZJCDpQVRnBMPtzutvcimw5HgG8Z0uw4WP3edM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrIGLAzs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCC9C4AF13;
	Tue, 21 May 2024 14:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716300741;
	bh=wZtYXcGZzSQS0F0yeoqFidLr8irNWnwUfGi6pl/72k0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=JrIGLAzsfEwXHnF4TBlNEh/ojwF8O6M+gyeuZLu8pnogmhiVqczyd7u/A7hVRG3HL
	 9FDZ72VEm/uTsI8XttNZIju+adLcvpkyMfgClLZurMViRZSj+uvSzHljqQtjk5jLQh
	 amVhBSlxMZrElIq7BOOIPkur1EnDRbdpFPOB5woC/ssmfnV18pD1A0zc/N5krICMPi
	 fE9ad7Q4eGkZWX26254cX5t3pSPmuLWHmTpWOR4dFInouPY3VvanxNZNHR1EAmO7mU
	 YmT7N8bI7Xp0164viij+Sx42F9xeET58DuFwWTzzpppKKpNT9xxLC6Qhfrn/DYPFsf
	 PmbD5t4MPiJ3Q==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 May 2024 17:12:16 +0300
Message-Id: <D1FDU1C3W974.2BXBDS10OB8CB@kernel.org>
Cc: <brauner@kernel.org>, <ebiederm@xmission.com>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Kees Cook" <keescook@chromium.org>, "Joel Granados"
 <j.granados@samsung.com>, "Serge Hallyn" <serge@hallyn.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "David Howells"
 <dhowells@redhat.com>, <containers@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <keyrings@vger.kernel.org>
Subject: Re: [PATCH 0/3] Introduce user namespace capabilities
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "John Johansen" <john.johansen@canonical.com>, "Jonathan Calmels"
 <jcalmels@3xx0.net>, "Casey Schaufler" <casey@schaufler-ca.com>
X-Mailer: aerc 0.17.0
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <2804dd75-50fd-481c-8867-bc6cea7ab986@schaufler-ca.com>
 <D1BBFWKGIA94.JP53QNURY3J4@kernel.org>
 <D1BBI1LX2FMW.3MTQAHW0MA1IH@kernel.org>
 <D1BC3VWXKTNC.2DB9JIIDOFIOQ@kernel.org>
 <jvy3npdptyro3m2q2junvnokbq2fjlffljxeqitd55ff37cydc@b7mwtquys6im>
 <df3c9e5c-b0e7-4502-8c36-c5cb775152c0@schaufler-ca.com>
 <vhpmew3kyay3xq4h3di3euauo43an22josvvz6assex4op3gzw@xeq63mqb2lmh>
 <D1CQ1FZ72NIW.2U7ZH0GU6C5W5@kernel.org>
 <D1CQ8J60S7L4.1OVRIWBERNM5Y@kernel.org>
 <D1CQC0PTK1G0.124QCO3S041Q@kernel.org>
 <1b0d222a-b556-48b0-913f-cdd5c30f8d27@canonical.com>
In-Reply-To: <1b0d222a-b556-48b0-913f-cdd5c30f8d27@canonical.com>

On Tue May 21, 2024 at 4:57 PM EEST, John Johansen wrote:
> > One tip: I think this is wrong forum to present namespace ideas in the
> > first place. It would be probably better to talk about this with e.g.
> > systemd or podman developers, and similar groups. There's zero evidence
> > of the usefulness. Then when you go that route and come back with actua=
l
> > users, things click much more easily. Now this is all in the void.
> >=20
> > BR, Jarkko
>
> Jarkko,
>
> this is very much the right forum. User namespaces exist today. This
> is a discussion around trying to reduce the exposed kernel surface
> that is being used to attack the kernel.

Agreed, that was harsh way to put it. What I mean is that if this
feature was included, would it be enabled by distributions?

This user base part or potential user space part is not very well
described in the cover letter. I.e. "motivation" to put it short.

I mean the technical details are really in detail in this patch set but
it would help to digest them if there was some even rough description
how this would be deployed.

If the motivation should be obvious, then it is beyond me, and thus
would be nice if that obvious thing was stated that everyone else gets.

E.g. I like to sometimes just test quite alien patch sets for the sake
of learning and fun (or not so fun, depends) but this patch set does not
deliver enough information to do anything at all.

Hope this clears a bit where I stand. IMHO a good patch set should bring
the details to the specialists on the topic but also have some wider
audience motivational stuff in order to make clear where it fits in this
world :-)

BR, Jarkko

