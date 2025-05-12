Return-Path: <linux-fsdevel+bounces-48724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7022DAB33BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 11:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FABD189FF0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 09:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA4B26159A;
	Mon, 12 May 2025 09:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oX631XTM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B4F2609F3
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042201; cv=none; b=ZvrjCBzKGo8pIGlO3hrTFtd7clLg4huQyPzELq4DUpFj51HaWWZbhwekh0arbh+N2n4SP7Tn9rlOKA32c4SwPfI6YCvu29VMgL5oWd8nW/YCwVsTRYc+EqiNeK6clkz1EmOnrxCj8L8TRE6XYfFkznZxMkEarACaIlqzBEbxfLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042201; c=relaxed/simple;
	bh=QJEYwfDMXX05973P8ingwOhJPiPzEUPJkMRWAsXfOmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BT6cvddJ5IF49V8s1SvM1yc009Xh+vQBF1fEIXBdUzWJHwOyCnA8WdqbUXyh2pJa53f/98x8mFrMuinp8/9EzhRU8N9xEbgmFmwCCP4mqdsJZDFcukqhtDDZX4jMGrTU2OK6pZ7x2p9TmVljt9T645lEkjd3TxNIvo5dhqgtTtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oX631XTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C04C4CEE7;
	Mon, 12 May 2025 09:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747042201;
	bh=QJEYwfDMXX05973P8ingwOhJPiPzEUPJkMRWAsXfOmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oX631XTM8rel0zC6GV1skyJoyfoyEFJehcRgdTa6OAxg7eib/yKJVWRyTOT3JO5gL
	 z4RLMAd6aIWniM+H0KbQoqOouwqMzxw61YFbtRRX3Ll7h81MInfAPyV7Xpe1XB78oh
	 1VHUufj7x+iIliEa+vNTTF0jrnPhyzte7qF/gPcwY3YRYP8Ok+RumnIvOWSPkzU6dB
	 tafPmKKziBEtsPBbj+nvOXMYraISCg9UUtnT9HMwRRtcqLeW/dNRWi5swEjXLbDloJ
	 xZ5DJvtOXdnrstbAjdqynwVr8g7Y2mqsDVMrw8wu/IC/jLlu+bCxL2wzLrMx3OFH6a
	 YZZMPCirGmq5w==
Date: Mon, 12 May 2025 11:29:57 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] selftests/pidfd: move syscall definitions into
 wrappers.h
Message-ID: <20250512-spionieren-chauffieren-925accc6901f@brauner>
References: <20250509133240.529330-1-amir73il@gmail.com>
 <20250509133240.529330-4-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250509133240.529330-4-amir73il@gmail.com>

On Fri, May 09, 2025 at 03:32:35PM +0200, Amir Goldstein wrote:
> There was already duplicity in some of the defintions.
> 
> Remove syscall number defintions for __ia64__ that are
> both stale and incorrect.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

