Return-Path: <linux-fsdevel+bounces-276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC987C8983
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 18:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F117282EC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 16:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3F11C684;
	Fri, 13 Oct 2023 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrF9MdWF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D6E1C289
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 16:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE306C433C8;
	Fri, 13 Oct 2023 16:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697213006;
	bh=mcv6vZBKM2c2x3X7SAMdPBiYtPn9l0sRcjbP8ZSJ5z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MrF9MdWF4vAESJ/XDsEGBcBpXrsoKIgrVVO76N7PlbkbgEUGDha7Xm94oXOGXe2Ns
	 uWd9TE+aXkxYmIBlXFaafRP2d5mVEkIYhXYAIgygSaUMtXmD1Xkqlr3sILI16n16Ts
	 o6j7GxZjNekad8tKLy2idhnP8Yka1MEOWSiLb4vIzwTChKb4fgALRBgTlyN/nsoawS
	 t/rEtQPo4av2FBphw+EBSMW/96CvbJ8k87y+kDXM08mIWAX0EtxaF6IHDmIoeFJTUf
	 K0Lf5BQz75FTczg6LP2ihMG7AuayOqPgq6qE+cuQv18hDNC0Hn7Y2cu/WOr3sjmEe/
	 tRfAX80bPHYbw==
Date: Fri, 13 Oct 2023 18:03:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Dan Clash <daclash@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
	dan.clash@microsoft.com, audit@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [PATCH] audit,io_uring: io_uring openat triggers audit reference
 count underflow
Message-ID: <20231013-keilen-erdkruste-7a1154fb0da0@brauner>
References: <20231012215518.GA4048@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20231013-karierte-mehrzahl-6a938035609e@brauner>
 <f1a37128-004b-4605-81a5-11f778cd5498@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f1a37128-004b-4605-81a5-11f778cd5498@kernel.dk>

> > Picking this up as is. Let me know if this needs another tree.
> 
> Since it's really vfs related, your tree is fine.
> 
> > Applied to the vfs.misc branch of the vfs/vfs.git tree.
> > Patches in the vfs.misc branch should appear in linux-next soon.
> 
> You'll send it in for 6.6, right?

Given that it fixes a bug, yeah. I'll let it sit until Monday so other's
have a moment to speak up though.

