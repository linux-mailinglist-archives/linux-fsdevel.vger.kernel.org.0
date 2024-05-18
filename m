Return-Path: <linux-fsdevel+bounces-19710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3FC8C9090
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 13:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC5B1C20DC3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 11:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033972C87C;
	Sat, 18 May 2024 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrSggykd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4DD2629C;
	Sat, 18 May 2024 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716031051; cv=none; b=ToTwbE60Hr4wV/AWMUxAohA4Mz5oQ4zS4VK9/BZSv4BR5M5rjW0ltJwJ+wVk7wUyUXmJc50HRIiR9nQDC6IAizyApTzjI+k7r/pmjo+1xt4B9/kNq9nsPgw5XP4gcQmbuEL1fXeSlOnVQiue8SrGpZTBY6uqQYOoqL32QQK1wvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716031051; c=relaxed/simple;
	bh=OuTyIJpw4THU83E4QH0la6A+4g8vZoMGoOnXcdCfLz0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ChkRcuI3Hs9F/H/TJerNq6/07Zf44A0HxOUT/4hW+r7jGi9jPjE/lHSJ3UvfVzMKmPjtXVMxV3pHXJiUFJ2KeTj8RvJxlPIXFDXPhKWGD5e6+wMW6ItgNxHeedO+y2Cy16rBNMRxzoKXZ/aJFCZbgCftjL+SRVZiQVMCGikGAFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrSggykd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC73C113CC;
	Sat, 18 May 2024 11:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716031050;
	bh=OuTyIJpw4THU83E4QH0la6A+4g8vZoMGoOnXcdCfLz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MrSggykduGNaK1WHlBAqu1gRo5NDPTpguUIm/nvYFva/R4PLIWrUJKTikX1Kz5jjM
	 83PCQ/1fqFkA5tewjFBQLQc5q9p0QCc2+jrDPGm7SthMHCpDSf+4PHFs/IFw03bJff
	 AsGE15028kPZxixPEHEHigzQVGUkyHs8E+Gl2F99dEALBIHB4+j9tSoO5TSGT0h7lC
	 iaQGKKGIjm9rHbzdaZ+vdEwWA+3vaRioJ2ui9CPANyiSs2h7o6C9ECjQd6Jr0q4EpY
	 W1NBgvbfj4cEuJYQetVmmo9wMfgV0eSnNco9sd1VINcwB0cbY5sBQH3ELug6J1zFJS
	 uxBWlLwNqIjEg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 May 2024 14:17:25 +0300
Message-Id: <D1CQ8J60S7L4.1OVRIWBERNM5Y@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Jonathan Calmels"
 <jcalmels@3xx0.net>, "Casey Schaufler" <casey@schaufler-ca.com>
Cc: <brauner@kernel.org>, <ebiederm@xmission.com>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Kees Cook" <keescook@chromium.org>, "Joel Granados"
 <j.granados@samsung.com>, "Serge Hallyn" <serge@hallyn.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "David Howells"
 <dhowells@redhat.com>, <containers@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <keyrings@vger.kernel.org>
Subject: Re: [PATCH 0/3] Introduce user namespace capabilities
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
In-Reply-To: <D1CQ1FZ72NIW.2U7ZH0GU6C5W5@kernel.org>

On Sat May 18, 2024 at 2:08 PM EEST, Jarkko Sakkinen wrote:
> On Fri May 17, 2024 at 10:11 PM EEST, Jonathan Calmels wrote:
> > On Fri, May 17, 2024 at 10:53:24AM GMT, Casey Schaufler wrote:
> > > Of course they do. I have been following the use of capabilities
> > > in Linux since before they were implemented. The uptake has been
> > > disappointing in all use cases.
> >
> > Why "Of course"?
> > What if they should not get *all* privileges?
>
> They do the job given a real-world workload and stress test.
>
> Here the problem is based on a theory and an experiment.
>
> Even a formal model does not necessarily map all "unknown unknowns".

So this was like the worst "sales pitch" ever:

1. The cover letter starts with the idea of having to argue about name
spaces, and have fun while doing that ;-) We all have our own ways to
entertain ourselves but "name space duels" are not my thing. Why not
just start with why we all want this instead? Maybe we don't want it
then. Maybe this is just useless spam given the angle presented?
2. There's shitloads of computer science and set theory but nothing
that would make common sense. You need to build more understandable=20
model. There's zero "gist" in this work.

Maybe this does make sense but the story around it sucks so far.

BR, Jarkko

