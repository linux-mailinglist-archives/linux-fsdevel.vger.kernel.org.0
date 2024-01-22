Return-Path: <linux-fsdevel+bounces-8450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 283B2836BCD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 17:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5F31C23ECB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C835BAC6;
	Mon, 22 Jan 2024 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgcnszHe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE193D967;
	Mon, 22 Jan 2024 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937155; cv=none; b=uIaebfcqVnUqgNyzZWUVz+kJE7veAlC+TNTx7vaH/OCJDasKSRUokXfUc67/Z6HDy5j8vSjAOTnzR0z9CAC0k+oSManKYP8DORzogAlUn4gBZ9EYNtTdUzgDmDzfdItE9T+Dcc4T8WOc9tDJb78nQEiQ+7voURuli5pgtg+4B44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937155; c=relaxed/simple;
	bh=C8wjqeeCf8FT+5eE7w6W/zlZBQKoCYKXMmOWmrJ3NT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Za5U2UMA0Ft0K2VvppoSxpa2er4YX6weGiuEifgskX0LZkRK1ND2ajmEsDMVPF91c/C0jdrwsX9fz/7QEtsDE7ZQN6zkIFHVcu/Q6ZcTiA1AeZP6738CLIadvRxDscN+EedOxd+9EyU9kI7TNYgqPt/ah3sXPLP/GMWaqqKTcBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgcnszHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EA2C43394;
	Mon, 22 Jan 2024 15:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705937155;
	bh=C8wjqeeCf8FT+5eE7w6W/zlZBQKoCYKXMmOWmrJ3NT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WgcnszHeIqZfVOkJTdGhrZ7/tCMb25qdwQFCYDCEa/sEgaws0v8FTqKz2nKPQOUd6
	 PGORtsH0d/ZsIzYx7vSzFBeSEdrfDinh2l7txWv3km6m3y0iYtSpVy2vSAAIBKxUvU
	 4pD0IdNdk6HiiJqt98eu4rTmBoHUkFrA+4274wjBGjdbDtXg7O6VW4pWjYs6qnEgT0
	 qfZikyI4j59EMdJU07N86K2DfF6zXXAp7X+9XXDsAumJEi2akp6B/WeeDykW2KsIhP
	 HjXwiBLG2cxwgneXwJQYrlUHJzOHEqSu95AODncSvsmza5XCBkjTYmXyq93ELvHzpu
	 GPgZ3I06bCMYw==
Date: Mon, 22 Jan 2024 16:25:50 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, paul@paul-moore.com, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Subject: Re: [GIT PULL] BPF token for v6.8
Message-ID: <20240122-scheu-amtlich-2ecfb8501f84@brauner>
References: <20240119050000.3362312-1-andrii@kernel.org>
 <CAHk-=wg3BUNT1nmisracRWni9LzRYxeanj8sePCjya0HTEnCCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg3BUNT1nmisracRWni9LzRYxeanj8sePCjya0HTEnCCQ@mail.gmail.com>

> I think Christian's concerns were sorted out too, but in case I'm
> mistaken, just holler.

Yes, I think everything is covered. Thanks for checking!

