Return-Path: <linux-fsdevel+bounces-19622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC838C7D41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 21:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19156285418
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 19:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69E9156F5F;
	Thu, 16 May 2024 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KraW8m6i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1B914533D;
	Thu, 16 May 2024 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715887752; cv=none; b=BhJj43Vdy1gd5lQ0sWtpfNz+nL92Et3PXmR0GnTgMADTlFbaOzndem5Cq3w7TMlt4pSR2JtQRCNEH8uMEs9fvT1EE54kXa+rhKNhl1/dH0qOlHQrQIxaZKIv+1Wy9Gre2IUPwLWQu2Tpl8VTF0LDt9oNHensmu0gYEPb0cM8ab4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715887752; c=relaxed/simple;
	bh=l+TnYWVF0KiB/EPfOg0XC54NqzGKjS+BW+46urjM8Wg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LHbgxEvA4JkdHTxlnnYZHNGrwxAsfCCsIb+UWUKtcJkss4nVsdBnfoYaUij4/Ckk5MhUUrqoL97fZAuXPKCf0IxGOtclm8b5XJv3BBUSLFZBSXGMGtjnVE9N0dNBL1V2YzeEVY/qyYwE04vkinJMjf2fjJ1eRZdN+a7OndE35Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KraW8m6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE5AC32782;
	Thu, 16 May 2024 19:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715887751;
	bh=l+TnYWVF0KiB/EPfOg0XC54NqzGKjS+BW+46urjM8Wg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=KraW8m6ii7OcHIdzBD3dYTIf9cBeWQXW9h5fyUKVWYwV+7WH1BA3Um8zu7uVVmrIH
	 m5djFd2CfRr6D/fV3miziNaYWvkcofGj3arGyCGLm+53p7TduIy+CLzUzkiLRJhnBE
	 38HcTCQleuRBN+lNKAIiEVLGYn5/GA+FYdtc3IpP559X5cp6RBC6u9V5OkpBQaWnfU
	 XBWg6vDPOMTrm38Hf4qmOaT0As/UGr3u5PopZN50+TnJjCBcGMapPse/T3jBaSyAkL
	 obJhh367vn1OPzNiaXBrcSp7j+tUVKF/VN2E0CYiQtmzIvR1hDsXxnAuygB42jrZ5m
	 g6SBQyDuNn4Ew==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 May 2024 22:29:06 +0300
Message-Id: <D1BBFWKGIA94.JP53QNURY3J4@kernel.org>
Cc: <containers@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <keyrings@vger.kernel.org>
Subject: Re: [PATCH 0/3] Introduce user namespace capabilities
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Casey Schaufler" <casey@schaufler-ca.com>, "Jonathan Calmels"
 <jcalmels@3xx0.net>, <brauner@kernel.org>, <ebiederm@xmission.com>, "Luis
 Chamberlain" <mcgrof@kernel.org>, "Kees Cook" <keescook@chromium.org>,
 "Joel Granados" <j.granados@samsung.com>, "Serge Hallyn"
 <serge@hallyn.com>, "Paul Moore" <paul@paul-moore.com>, "James Morris"
 <jmorris@namei.org>, "David Howells" <dhowells@redhat.com>
X-Mailer: aerc 0.17.0
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <2804dd75-50fd-481c-8867-bc6cea7ab986@schaufler-ca.com>
In-Reply-To: <2804dd75-50fd-481c-8867-bc6cea7ab986@schaufler-ca.com>

On Thu May 16, 2024 at 10:07 PM EEST, Casey Schaufler wrote:
> I suggest that adding a capability set for user namespaces is a bad idea:
> 	- It is in no way obvious what problem it solves
> 	- It is not obvious how it solves any problem
> 	- The capability mechanism has not been popular, and relying on a
> 	  community (e.g. container developers) to embrace it based on this
> 	  enhancement is a recipe for failure
> 	- Capabilities are already more complicated than modern developers
> 	  want to deal with. Adding another, special purpose set, is going
> 	  to make them even more difficult to use.

What Inh, Prm, Eff, Bnd and Amb is not dead obvious to you? ;-)
One UNs cannot hurt...

I'm not following containers that much but didn't seccomp profiles
supposed to be the silver bullet?

BR, Jarkko

