Return-Path: <linux-fsdevel+bounces-56996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CB1B1D9FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 16:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B911898289
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 14:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3597264617;
	Thu,  7 Aug 2025 14:35:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.lichtvoll.de (lichtvoll.de [37.120.160.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ED3262FE4;
	Thu,  7 Aug 2025 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.160.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754577317; cv=none; b=PZzbY4e1alwUVpEjhR4ORlrtw4yHXU+gU+75oNLwnSPl5+7viQdcZbzvbRUaujfzGrSW3z0OqWKfhDdxhLu3S5e5+NeV5thqniHxfq0xFPfG6Z02a36CWxE+oOPIMBYxyx2FVbUtfjU1YnhmYi+i7ePYcwU3vXnxCCURK2itJAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754577317; c=relaxed/simple;
	bh=nWXqu19Z2b9S0qTX4q0JcitlMU/BmuH+gBHAjGFV9x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qItKLa+I6/dnov/cCTU3F8cd8GEGqCMuhYpipUgaDJURdCNUKopnefP1bL0dqB2UHQ8vPHro5CN4GwCBHNPvS6EMReF34H8c05qKYgso5VlKPnzpC9ea3jxAs8BY173opdxTaxj+6k4AkKR6S3tMGfGQUeOX/HTZQFNM02FoQ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=37.120.160.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id 8ECED12CA1C;
	Thu, 07 Aug 2025 14:27:35 +0000 (UTC)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin@lichtvoll.de smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Malte =?UTF-8?B?U2NocsO2ZGVy?= <malte.schroeder@tnxip.de>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Date: Thu, 07 Aug 2025 16:27:32 +0200
Message-ID: <2235744.irdbgypaU6@lichtvoll.de>
In-Reply-To: <f4be82e7-d98c-44d1-a65b-8c4302574fff@tnxip.de>
References:
 <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
 <f4be82e7-d98c-44d1-a65b-8c4302574fff@tnxip.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi.

Malte Schr=C3=B6der - 05.08.25, 23:19:21 CEST:
> So, no merge yet? That really is a bummer. I was really hoping to
> finally be able to run mainline Linux again on my boxes (yes, I
> converted all of them to bcachefs early this year), now that pretty much
> all issues I was hitting are fixed by this merge request.

Thanks, that is great to know.

> I mean, at the rate Kent's tree is stabilizing right now I am actually
> considering moving some productive systems over there. But those will
> need to run distro kernels. So, please merge, I don't want to jump
> through the hoops to run OpenZFS ...

I did not agree to some of your behavior before, Kent. But actually at=20
least from your description I had the feeling this pull request is about=20
stabilizing BCacheFS in order to remove the experimental tag. The pull=20
request looked quite reasonable to me.

And frankly I am using BCacheFS in production meanwhile, even with=20
encryption: On a 4 TB XS-2000 external SSD and I am quite sure I am not=20
willing to copy over all that data to a different filesystem again. And on=
=20
a scratch filesystem on my laptop, but that one is easily replaceable.

Sure I can switch to a different kernel source tree, having compiled=20
BCacheFS tools myself as well. And I am fine to do so.

But on the other hand, Linus, on a past rc1 pull request that does not=20
only contain bug fixes, there is still the option to simply not pull it.=20
After the discussion that has been had, even not pulling it without=20
explaining it sounds absolutely fair enough to me. It is not that someone=20
could force you to accept a pull request as far as I understand.

Well, maybe that is the strategy here: Just pull this at the last day of=20
the 2-week window to make sure everything else after that can only contain=
=20
bug fixes anymore. :)

So my two cents=E2=80=A6 I'd appreciate BCacheFS to stay in kernel. I bet t=
he=20
churn to remove it and later again reintroduce it would be actually more=20
work than to simply ignore a pull request every now and then.

And I think I may not be the only BCacheFS user who prefers to use=20
mainline kernels.

Maybe at one conference you could come together in a room and sort this=20
all out face to face. But until then maybe the approach I outlined above=20
can be an option?

Best,
=2D-=20
Martin



