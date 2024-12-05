Return-Path: <linux-fsdevel+bounces-36577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFA29E60E4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 23:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0EC2849C2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 22:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BD91CDFC1;
	Thu,  5 Dec 2024 22:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBEA6llR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2741C3C15;
	Thu,  5 Dec 2024 22:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733439144; cv=none; b=SO6xfKFgFCBd/da/KzbFS7MJJePQOE33MEFAqe4Dozdp3D8KaaPKmnXPRJW/x6eBuv6ZYI9YYyOO2bApymh8FyAknk5NGhuv9GWo2wq+Q7WWnAAyutQy4H7bKmrHDRHPaJbLm1wZaU7f7IhuNGV1tqAMiHjEagoI9QJB6noCPRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733439144; c=relaxed/simple;
	bh=kp+HkUg4Alkp2qK1e7PK2s7s1oCpo8kcFE7HeVQMBnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXDLSezs9oGeqkhkJBQwFD5SERuyR/RbofYxR4ZTpK2w6gmeY/o5y9rRB33RJtHMddercwkMbWLzf7QdUS0/Ro6uZhtGVySD4x2q115840+nz8SsC//a12GLCVbbBf5bbySsK/GhjzNXnfexjwcRVzTyblCT7uyTWU3vBN1Fkng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBEA6llR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D53C4CED1;
	Thu,  5 Dec 2024 22:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733439144;
	bh=kp+HkUg4Alkp2qK1e7PK2s7s1oCpo8kcFE7HeVQMBnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MBEA6llROBng98tD+yowL70u10OoQ/zqb725FOk31UwBzkE6H3Ut03gcmZEwZOHVW
	 Wfvv9fXZJCI+j0rbgN5ZO1IoZCt4LFp9LxbHr8wULnKAjfjauxx0pSoE2zQCKKo2Dl
	 xnYPTo0QYuxCO8FQrEtQ2/lgGtQvDzuiwLUzskcxpKqL94oru2mIaKYH4eMbHBiMq8
	 dKl+cPb8wpLsngsV0Th3m8nHEaWY8V7Z7NgBOx+APoPD8xxwFemheoe5u993ShSzSt
	 moAxlTXI0VxeS1dMOhWoLw/uYsAPBMBPOqSQCn4JKPqoAvilYE4N1Aq4hXJTM2HpWx
	 yNVElaaQVA0Cg==
Date: Thu, 5 Dec 2024 14:52:22 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: patches@lists.linux.dev, fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH] common/config: use modprobe -w when supported
Message-ID: <Z1IuphUjdnnRUWCg@bombadil.infradead.org>
References: <20241205002624.3420504-1-mcgrof@kernel.org>
 <0272e083-8915-407a-9d7f-0c1a253c32d7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0272e083-8915-407a-9d7f-0c1a253c32d7@redhat.com>

On Wed, Dec 04, 2024 at 10:35:45PM -0600, Eric Sandeen wrote:
> but that probably has more to do with the test not realizing
> /before it starts/ that the module cannot be removed and it
> should not even try.

Right.

> Darrick fixed that with:
> 
> [PATCH 2/2] xfs/43[4-6]: implement impatient module reloading

Looks good to me.

> but it's starting to feel like a bit of a complex house of cards
> by now. We might need a more robust framework for determining whether
> a module is removable /at all/ before we decide to wait patiently
> for a thing that cannot ever happen?

I think the above is a good example of knowing userspace and knowing
that userspace may be doing something else and we're ok to fail.
Essentially, module removal is non-deterministic due to how finicky
and easy it is to bump the refcnt for arbitrary reasons which are
subsystem specific. The URLs in the commit log I added provide good
examples of this. It is up to each subsystem to ensure a proper
quiesce makes sense to ensure userspace won't do something stupid
later.

If one can control the test environment to quiesce first, then it
makes sense to patiently remove the module. Otherwise the optional
impatient removal makes sense.

  Luis

