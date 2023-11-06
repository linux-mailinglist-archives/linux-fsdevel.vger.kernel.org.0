Return-Path: <linux-fsdevel+bounces-2102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C807E27A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 15:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146C72813E0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 14:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4119C28DB0;
	Mon,  6 Nov 2023 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rE7oATpe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D16128DAD
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 14:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B28C433C7;
	Mon,  6 Nov 2023 14:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699282256;
	bh=PrPL5yxS0XHR88fAG6CPc6WPfIQAznLRMTKPqNE0Xjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rE7oATpe1ZgWfXcIoEEYTKuDO2oyjiZolXVeLIPumiw25dIWXVc3fhdbRCYyTsa1+
	 a3qHcvLQ3yPKfm9y4yFqhEYVmpUZMBlBgG8DrbKm/+JkGfs+eG+EClGCKFCl+bY0gt
	 2LSz4dlsQrVCCzaQBJXNcxW402GnJMy2GHaJNQX4+Xph7yOyHBVIa3yDcBlCiWhMf0
	 ajGM/77GJy0kUF3VP1S068yabBhLX0AG1XWKxx1UHBGLcEVMFEOMZ8DAVrEzb7zKWr
	 67LMJ6vwibIagt+HyiOeI+IJh6XgyCkX+emCBddz3rWw/43wTWtOz97ccPJgs19jFV
	 wl4j8poomrivA==
Date: Mon, 6 Nov 2023 15:50:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: David Howells <dhowells@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bill O'Donnell <bodonnel@redhat.com>
Subject: Re: [GIT PULL for v6.7] autofs updates
Message-ID: <20231106-aufleben-umfeld-25a2cd86e521@brauner>
References: <20231027-vfs-autofs-018bbf11ed67@brauner>
 <43ea4439-8cb9-8b0d-5e04-3bd5e85530f4@themaw.net>
 <ZT+9kixqhgsRKlav@redhat.com>
 <61f26d16-36e9-9a3c-ad08-9ed2c8baa748@themaw.net>
 <83a889bd-3f9e-edce-78ff-0afa01990197@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <83a889bd-3f9e-edce-78ff-0afa01990197@themaw.net>

> Christian, David's original conversion patch for devpts looks like it's
> 
> still relevant, it also looks fairly small to the point that I'm wondering
> 
> if it's worth breaking it down into smaller patches.

I vaguely remember that patch and no, for simple fses like devpts
breaking this into smaller chunks is probably not worth it.

These conversions patches often aren't easy to split nicely anyway.

> Would you be ok with me just doing a straight patch apply, detailed review
> 
> and some testing before posting it?

Sure.

