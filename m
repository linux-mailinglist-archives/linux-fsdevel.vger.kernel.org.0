Return-Path: <linux-fsdevel+bounces-25542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D33794D34B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 17:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BB9285829
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 15:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC76198A05;
	Fri,  9 Aug 2024 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eg+wWz5A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36E4198842
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216879; cv=none; b=GQJ2R+BXZEIwBz7yOVoCo6oFoSpuTfQfrYWbXNGyr09xFNobJuusp7mQy6siFxaBNZlM4UXgcw0J2Y3BKPS+wkStV8/Km2CboQchULX4+zbRX71E/yGFotYMjLGk/WXMRlWPinmnQtHrxXSVtezrpFCeS7EioZj+ds6mIPS3ld8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216879; c=relaxed/simple;
	bh=lnr5dcjyBjby8ex3m/UJYpPzxc5dBQs8GJfI5dgXRw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McB+1pXVqTtccUwIG1lKq9M2F4yco89rc9lj+vYBQppw0V7oUttPnVmQUMvR52+J5KGOZdo85uxiugxExJyz7s5pX9pqSlYZnKG19UYjLGo0Rz8/i0Gr5pHC70dTG9fIIl9HKc5IHg4RbrBsBTN+yORoeSOlEX17EkbUWK47mm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eg+wWz5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE835C32782;
	Fri,  9 Aug 2024 15:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723216879;
	bh=lnr5dcjyBjby8ex3m/UJYpPzxc5dBQs8GJfI5dgXRw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eg+wWz5AShZGzeHi3Aae7En8nyFfZ7KUTIOVVCsRD+7DVfw0hzFnKHRlIWHEo3mn8
	 J/la8qoUt+Bx/XCwNQ0vuDASn6IVfIOjDrArb3gQT8t3aZ96IPcHcT40QS6PRCCWP+
	 WfwDvy18MIir6IlGwSax4Z2GExcL7lD67zBN3yY2sSnRrkTSfEUPb2Vm9X2/aRSzz+
	 KjHmZ9eqnw8+A3c4qltoco2b4gYKaJZdHcWrMUub+4xfzaB6Zteqel7QtjVviTx5JE
	 1OZiMeCnR/UOUtu154hqzdTFbP0bwdPeUS2VVfQ4KgQV58rviwAmt36PnwK36CrbKI
	 I3M/aAurTTz5g==
Date: Fri, 9 Aug 2024 17:21:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mathias Krause <minipli@grsecurity.net>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] file: fix typo in take_fd() comment
Message-ID: <20240809-sprechen-golfball-3feddb38031a@brauner>
References: <20240809135035.748109-1-minipli@grsecurity.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240809135035.748109-1-minipli@grsecurity.net>

> Btw, include/linux/file.h could get an entry in MAINTAINERS, maybe, as
> could a few others matching the include/linux/fs*.h pattern?

Yeah, sure that sounds useful.

