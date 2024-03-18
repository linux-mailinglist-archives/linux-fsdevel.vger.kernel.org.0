Return-Path: <linux-fsdevel+bounces-14718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D52687E52D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 09:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D711F21148
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 08:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A052C19A;
	Mon, 18 Mar 2024 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzivUTTJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D1028E26;
	Mon, 18 Mar 2024 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710751670; cv=none; b=AQXh0E9T/HGOEVrCOkyi1uf4L/Uyy+Xl6LtmIpKB9O15neHq9Ib9TT5a6jQalMfjGC5S8w3Ip+x6u3dQNbiER4jdaVPlS1bRVzSSLOP8GHIwtdx9KIjEN0fupHwqbe1gv4zM0eGIZTxMQA/ca33r3ON+RMthUBHPtJCBjHqoI1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710751670; c=relaxed/simple;
	bh=Ew2uVxn7vsJK/JFcU9zZaMqRiK9DDlzk08Afo0ps6tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p93WRwniWv6hKPAUHh4ZTrZqQy9FBq1d97ZSfsvrUWhTrgJHKcqaicin6t9Sfm7hm+UDoMqMZCMF5Kqpx1xsco0gdnRL1zrTJhHECuFGerwBRD5AQHQBJM+MMeE+e0k/KoFp1nHog4vzrbniVb3TqeN2WIVH4f61sb5af+D/ACs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzivUTTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5EFC43390;
	Mon, 18 Mar 2024 08:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710751670;
	bh=Ew2uVxn7vsJK/JFcU9zZaMqRiK9DDlzk08Afo0ps6tI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EzivUTTJsOVwzxrrjAi8avkIKYnbjeM4XRGeAWhECQodhvZC8kmFJWqaTzdz0pxWC
	 P+u23knAXSnKZzwSijQvwcTp1Y6yj9Th6qF11ie0hubBxxB/lbWkBb8wG8INhF5gNt
	 SD/6DmhfAK68FbBlHwoFcGYdsPbAjZTJXaQyWLRyUrU+DDiNfEIrK2L+dTACporQO1
	 s0fBVumxqULEsAVUSP5Pg1kqLtxW7KR2VmNF4ZEemUk1fWUFSssa5XNq/GleRsKDdw
	 aKUJD8WTFNE0x9UTeLrBts8E4bqGm+jegR21ZVPowPivX1mVBWpcVQmkp0orvcL5Oa
	 eTYI7PqVNFLMw==
Date: Mon, 18 Mar 2024 09:47:45 +0100
From: Christian Brauner <brauner@kernel.org>
To: Cyril Hrubis <chrubis@suse.cz>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, lkp@intel.com, ltp@lists.linux.it, linux-kernel@vger.kernel.org
Subject: Re: [LTP] [linus:master] [pidfd]  cb12fd8e0d: ltp.readahead01.fail
Message-ID: <20240318-fegen-bezaubern-57b0a9c6f78b@brauner>
References: <202403151507.5540b773-oliver.sang@intel.com>
 <20240315-neufahrzeuge-kennt-317f2a903605@brauner>
 <ZfRf36u7CH7bIEZ7@yuki>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZfRf36u7CH7bIEZ7@yuki>

On Fri, Mar 15, 2024 at 03:49:03PM +0100, Cyril Hrubis wrote:
> Hi!
> > So I'd just remove that test. It's meaningless for pseudo fses.
> 
> Wouldn't it make more sense to actually return EINVAL instead of
> ignoring the request if readahead() is not implemented?

It would change the return value for a whole bunch of stuff. I'm not
sure that wouldn't cause regressions but is in any case a question for
the readahead maintainers. For now I'd just remove that test for pidfds
imho.

