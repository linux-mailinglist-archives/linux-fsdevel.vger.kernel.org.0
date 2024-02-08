Return-Path: <linux-fsdevel+bounces-10762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BE584DD41
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 10:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E3C283E57
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 09:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4965B6D1A6;
	Thu,  8 Feb 2024 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/Uo01K6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54BE6BFD2;
	Thu,  8 Feb 2024 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707385716; cv=none; b=SibgeQbVjlxjp/Hd0nCuwB9/12Wz/qgK+rxXkSWUH/16wtSdRIDx8wlg6GuAo4kMQ0skvk7jRxIebCcjLpRfGUlUOfhMyGdBEDiLWZjB22Db1etu3dqz6yGerS+1jXrTeOzFOx5x0Dk7bLFVezyftKa1biczs55gtKh2LN0x6NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707385716; c=relaxed/simple;
	bh=7H7GNu/FndQaMn2g8TwMEQyNtMFGHM2dszj2Rkj9RaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUO9r8VcEVJeZiUk6jDTfLe91kyqOvBx4p3aLdfJzsdeCTyXgxceIebcEViUZx+dWc86D8/XE77/Ttx8hTipQegqDuJNHCtEPZiSFfd9tQtiglc9lJb8qEYEL3cPE4rZc7fVfAvkR5im/FsKkGl8+TaqY8Hna0JjiLYpNc7sgYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/Uo01K6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897B5C43394;
	Thu,  8 Feb 2024 09:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707385716;
	bh=7H7GNu/FndQaMn2g8TwMEQyNtMFGHM2dszj2Rkj9RaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o/Uo01K6iEr6xftSaFmFg207Z+4/kWQP48f+lcUgJ5mwYjpGSACwYd1q/7brCvToZ
	 o6SGgziPPdQykEAQvUNy6axND4cmc5l3FN+GS2f6CEr3WD3wE3eibpV8Ex+yzW9MJZ
	 YgrVD5TVnzYdlplJGX2Eby0FJxdcJM+5BgkPBM0jtNrFSZfhHQrYFb1ePe6/tohaNy
	 GZkkIGBaP9pwMK9+GuCvHz7SdfGi0p0PfJuee2XtULYY6RIX5X4f7PTwKHu7HWkXHr
	 W37j0V1VwLU++0XEpccqS5ScW7tgoSUDBRol/nSLXSML8T9kJ8pz2lEY6RVY6nXaub
	 TuQXuNDhmoR1g==
Date: Thu, 8 Feb 2024 10:48:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] filesystem visibililty ioctls
Message-ID: <20240208-bachforelle-teilung-f5f2301e5acc@brauner>
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206201858.952303-1-kent.overstreet@linux.dev>

> Christain, if nothing else comes up, are you ready to take this?

I'm amazed how consistently you mistype my name. Sorry, I just read
that. Yep, I'm about to pick this up.

