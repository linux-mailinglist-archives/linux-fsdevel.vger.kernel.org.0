Return-Path: <linux-fsdevel+bounces-19623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F5E8C7D46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 21:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DD94B2335D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 19:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AB9156F5F;
	Thu, 16 May 2024 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/EThQr8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19D114533D;
	Thu, 16 May 2024 19:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715887920; cv=none; b=eR4XPBQtKZmuVT6f032YcHeOcMLQy0c8EEHRYWiAEw9u4EBKWXF53ElDNpWp6Yw/2SR2tgqhisO/RkAQRhUoggdBZqNQ4LEp9HplXkIlRRVCEXVSjMUc6PQ3O0Z7JsAel64DJXb/4A3VC8p4iqWAcs0T3lFmkGHxA9UVqGd5SbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715887920; c=relaxed/simple;
	bh=QS3rWyqiNz1bMHqpo1/6vgSRC+6QfSN7Fb8rIEEX/L8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OWUknunKcxcU3Jm5dY0/lNQjhiSAkU7PYzqAHhH/Y01oVO8RK9xyl0UI+m6NHOs3skIyGjlpsm5EQbPcGdRr2Ygc86Yp16hH3lFoDgU14o2P54IX1qHnMVEqdDzQPS0gzPGJGICqikBpX+wn0kQavkoIOPzJngoPYPcox3jgZpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/EThQr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3619CC32786;
	Thu, 16 May 2024 19:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715887919;
	bh=QS3rWyqiNz1bMHqpo1/6vgSRC+6QfSN7Fb8rIEEX/L8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=d/EThQr8Yjxxs6XG21fXUmzllZqq+V5qpW0ltah9r9oooBwamLANJ9O7FYU6/vfyI
	 CbiKZgNlxPOjAcapN/LASyE+XWI6rQmQhZplX9/6r4JN28JbNaNTfTEbxK8QHPA1a8
	 WGYmvTTnmtAg3SYWP7O+Cv+Qn7I5rJt50i9ml+1CGpNFRc1tqHFctsm3q6SRWZQOHN
	 /xPuFP2CuHOL6aIdWq4s9ALjGYe5/EgXBGGloPZ+2oylJexbmMSZNTp6q+4Pfmtpd/
	 NT9E2YjUiJjAmlk1IweAoWmL+WNG/itEZ5D9AYTNby9ZoJSjccInht8h8uztjJ/862
	 fqMMIL/cWAX+Q==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 May 2024 22:31:54 +0300
Message-Id: <D1BBI1LX2FMW.3MTQAHW0MA1IH@kernel.org>
Cc: <containers@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <keyrings@vger.kernel.org>
Subject: Re: [PATCH 0/3] Introduce user namespace capabilities
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Casey Schaufler"
 <casey@schaufler-ca.com>, "Jonathan Calmels" <jcalmels@3xx0.net>,
 <brauner@kernel.org>, <ebiederm@xmission.com>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Kees Cook" <keescook@chromium.org>, "Joel Granados"
 <j.granados@samsung.com>, "Serge Hallyn" <serge@hallyn.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "David Howells"
 <dhowells@redhat.com>
X-Mailer: aerc 0.17.0
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <2804dd75-50fd-481c-8867-bc6cea7ab986@schaufler-ca.com>
 <D1BBFWKGIA94.JP53QNURY3J4@kernel.org>
In-Reply-To: <D1BBFWKGIA94.JP53QNURY3J4@kernel.org>

On Thu May 16, 2024 at 10:29 PM EEST, Jarkko Sakkinen wrote:
> On Thu May 16, 2024 at 10:07 PM EEST, Casey Schaufler wrote:
> > I suggest that adding a capability set for user namespaces is a bad ide=
a:
> > 	- It is in no way obvious what problem it solves
> > 	- It is not obvious how it solves any problem
> > 	- The capability mechanism has not been popular, and relying on a
> > 	  community (e.g. container developers) to embrace it based on this
> > 	  enhancement is a recipe for failure
> > 	- Capabilities are already more complicated than modern developers
> > 	  want to deal with. Adding another, special purpose set, is going
> > 	  to make them even more difficult to use.
>
> What Inh, Prm, Eff, Bnd and Amb is not dead obvious to you? ;-)
> One UNs cannot hurt...
>
> I'm not following containers that much but didn't seccomp profiles
> supposed to be the silver bullet?

Also, I think Kata Containers style way of doing containers is pretty
solid. I've heard that some video streaming service at least in recent
past did launch VM per stream so it's not like VM's cannot be made to
scale I guess.

BR, Jarkko

