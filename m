Return-Path: <linux-fsdevel+bounces-31210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4222999306F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 17:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6998F1C22F81
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 15:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6F912E75;
	Mon,  7 Oct 2024 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GwDawbes"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057A31DDC9;
	Mon,  7 Oct 2024 15:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313322; cv=none; b=bnDkoEtuz77lBcqYjviwsGBiAmTbXfkAbKDJDLgSW6hvvlXKTAyP3eqTlqx/LF/Q+bWoIRPovhWcFp0U/h8o62/qa/qipwjD2PVGig2l1YMztmfBVa7Ysa7J5ToolIx4pHe0g/OEaea1V3EWPP8pFI3l03aOLoLeP+fZu8U8bp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313322; c=relaxed/simple;
	bh=ISgx3u7VkohK3GzKzVxEUysWOtvF+S43XZsVODcMCaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbxukfCs0u3oPbZ0BUu+WXRx5ngNWVM4aZ8plViLjbQRBYaKsV31aNB2TXl2/XZRlcD/JOlWhh32gjfMbMcE6iFHnW9c/rtSRiZiO+QSNNvCMuLy47DiWgkiYyIS+tZ80rorG2tm2ufX7QJ8I4IPRqvbvW4WMQJCVcbddjxUOVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=GwDawbes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FADC4CEC6;
	Mon,  7 Oct 2024 15:02:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GwDawbes"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1728313318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SRurEB5fyNJu1lqK2yd6H2x8EstEpdsUPSOtIBRW9Oo=;
	b=GwDawbes2LXqT2cAi9dSfgxpyCItpH4VW8unc+UcIeOZp7hSqhcfIuJglEB6RxTr4BFjcp
	EYG1Dxc3nz4kJCUFpxgpBqrrrMkKq0aR9gZ26RTI+f5DsnP1Egl5HSYKmrW+c7hWgJU0OF
	y6t5fLY4mnXZGc5764QYqKeVg6jsyTg=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id df8fd0b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 15:01:57 +0000 (UTC)
Date: Mon, 7 Oct 2024 17:01:55 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
Message-ID: <ZwP341bZ9eQ0Qyej@zx2c4.com>
References: <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com>
 <x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>
 <CAHk-=wi-nKcOEnvX3RX+ovpsC4GvsHz1f6iZ5ZeD-34wiWvPgA@mail.gmail.com>
 <e3qmolajxidrxkuizuheumydigvzi7qwplggpd2mm2cxwxxzvr@5nkt3ylphmtl>
 <CAHk-=wjns3i5bm++338SrfJhrDUt6wyzvUPMLrEvMZan5ezmxQ@mail.gmail.com>
 <2nyd5xfm765iklvzjxvn2nx3onhtdntqrnmvlg2panhtdbff7i@evgk5ecmkuoo>
 <20241006043002.GE158527@mit.edu>
 <jhvwp3wgm6avhzspf7l7nldkiy5lcdzne5lekpvxugbb5orcci@mkvn5n7z2qlr>
 <CAHk-=wh_oAnEY3if4fRC6sJsZxZm=OhULV_9hUDVFm5n7UZ3eA@mail.gmail.com>
 <dcfwznpfogbtbsiwbtj56fa3dxnba4aptkcq5a5buwnkma76nc@rjon67szaahh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dcfwznpfogbtbsiwbtj56fa3dxnba4aptkcq5a5buwnkma76nc@rjon67szaahh>

On Sun, Oct 06, 2024 at 03:29:51PM -0400, Kent Overstreet wrote:
> But - a big gap right now is endian /portability/, and that one is a
> pain to cover with automated tests because you either need access to
> both big and little endian hardware (at a minumm for creating test
> images), or you need to run qemu in full-emulation mode, which is pretty
> unbearably slow.

It's really not that bad, at least for my use cases:

    https://www.wireguard.com/build-status/

This thing sends pings to my cellphone too. You can poke around in
tools/testing/selftests/wireguard/qemu/ if you're curious. It's kinda
gnarly but has proven very very flexible to hack up for whatever
additional testing I need. For example, I've been using it for some of
my recent non-wireguard work here: https://git.zx2c4.com/linux-rng/commit/?h=jd/vdso-test-harness

Taking this straight-up probably won't fit for your filesystem work, but
maybe it can act as a bit of motivation that automated qemu'ing can
generally work. It has definitely caught a lot of silly bugs during
development time.

If for your cases, this winds up taking 3 days to run instead of the
minutes mine needs, so be it, that's a small workflow adjustment thing.
You might not get the same dopamine feedback loop of seeing your changes
in action and deployed to users _now_, but maybe delaying the
gratification a bit will be good anyway.

Jason

