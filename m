Return-Path: <linux-fsdevel+bounces-19711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581FB8C9096
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 13:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE28228276A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 11:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3CA38F86;
	Sat, 18 May 2024 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BygVJarO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B12D2E417;
	Sat, 18 May 2024 11:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716031324; cv=none; b=f7IL3nk8B58LaoxlFRCUixGopve8Tv5NAdBh+GoDoJKrMD+mdSL+Yyy4lcrundH04U5NivgeuSARqltJwdyuT88Ax8IUFtpljfGbX1LRN6xxiUQ62qJKG7VET0zBv1MbUzyvXvUeWxlIPLalsiC4Lc1N2fmAni5CE7ULsxew8uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716031324; c=relaxed/simple;
	bh=iELBELN+ItTNiOWOJCNO9fLBpmFwctgb5zTuPUdT+jE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=lEN2pEA7WdSCw0Pd0FXeMAcy2P+l5vMjK+YDfdPpQ3FNn2WBunUj3cCJsGqrpNNHnE0q74LXQAUMrAvvYZiZSYvQ6tmn9AYSUqfRPCqExdc+MfTBJDBqf7jq7GWyDVqCIeqjq5ao0tohUKDc85hknMQH1n/z5gBRKz3Z02ar/+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BygVJarO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84605C32782;
	Sat, 18 May 2024 11:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716031324;
	bh=iELBELN+ItTNiOWOJCNO9fLBpmFwctgb5zTuPUdT+jE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=BygVJarOdyxgxEoTi4Q6GFh1XwHgWTz+M5G0XqXv5+2vlOnao1Y+E1Obpug7VLlEp
	 N0JFh7oOJIuqcVVViPEX4LzdsUDS3+jd7lPmhGu91aSpf6Fev/X2sc5CO16Id9iWc9
	 dzB2n8WN9P+hA/PjNskR+wPNnGsdP3sqpZY7sXMbars+lMeppyofOLSo7LEcZx3lAC
	 LfTgVPWj/xQxrVhmik+397AUIU978Tw0YwpBbeK9YlUanbPCxAtnjAwstyO2lh3vRl
	 IPNdka9o22iFyZydhB9XDL/OFnEunFNjXay2z3kq9oSnl13VV0PgQekvT3IHiKKBAO
	 sG6I9kRV3MLNg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 May 2024 14:21:58 +0300
Message-Id: <D1CQC0PTK1G0.124QCO3S041Q@kernel.org>
Subject: Re: [PATCH 0/3] Introduce user namespace capabilities
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
In-Reply-To: <D1CQ8J60S7L4.1OVRIWBERNM5Y@kernel.org>

On Sat May 18, 2024 at 2:17 PM EEST, Jarkko Sakkinen wrote:
> On Sat May 18, 2024 at 2:08 PM EEST, Jarkko Sakkinen wrote:
> > On Fri May 17, 2024 at 10:11 PM EEST, Jonathan Calmels wrote:
> > > On Fri, May 17, 2024 at 10:53:24AM GMT, Casey Schaufler wrote:
> > > > Of course they do. I have been following the use of capabilities
> > > > in Linux since before they were implemented. The uptake has been
> > > > disappointing in all use cases.
> > >
> > > Why "Of course"?
> > > What if they should not get *all* privileges?
> >
> > They do the job given a real-world workload and stress test.
> >
> > Here the problem is based on a theory and an experiment.
> >
> > Even a formal model does not necessarily map all "unknown unknowns".
>
> So this was like the worst "sales pitch" ever:
>
> 1. The cover letter starts with the idea of having to argue about name
> spaces, and have fun while doing that ;-) We all have our own ways to
> entertain ourselves but "name space duels" are not my thing. Why not
> just start with why we all want this instead? Maybe we don't want it
> then. Maybe this is just useless spam given the angle presented?
> 2. There's shitloads of computer science and set theory but nothing
> that would make common sense. You need to build more understandable=20
> model. There's zero "gist" in this work.
>
> Maybe this does make sense but the story around it sucks so far.

One tip: I think this is wrong forum to present namespace ideas in the
first place. It would be probably better to talk about this with e.g.
systemd or podman developers, and similar groups. There's zero evidence
of the usefulness. Then when you go that route and come back with actual
users, things click much more easily. Now this is all in the void.

BR, Jarkko

