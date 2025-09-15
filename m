Return-Path: <linux-fsdevel+bounces-61371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE05B57B0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBFBC4E2191
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F95302CC8;
	Mon, 15 Sep 2025 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uR+aPf8n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F1D1E531;
	Mon, 15 Sep 2025 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939486; cv=none; b=BDgTSE/PbR3JUX1/JHer5GL7zErY/ZhWhUaR2UvX0XCoSjBpys+bnvMVok24dFXf4x8FMn+VKwMADpD93Qx83GZisl979AIYsP5cfGkc5RbOqz6g6IEfTk8oXyRuAa2uSVOfoXludu2S56HZowKuIb8ykxwSY+YGMr//p2zBALE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939486; c=relaxed/simple;
	bh=lzwABRgZlSdwnl7k7yKgiBhr8uuK7qrcgPTw+IFn9RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeGYPbDCaMGMCfemqdRi8wU51z7yNkgLkvkddsnIDZhlzlk7qWmsZCzCNx1t6If5kagdF+9IjIhOcLyerJ5gbrwJgMDNgUd4u7ywI0SLt0SMjCChrDZyi1qHWK4k/bQpiks4WmweL/st2QuuP1xqsIC3ntljbsa0lyvwQu8hRJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uR+aPf8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA48C4CEF1;
	Mon, 15 Sep 2025 12:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757939485;
	bh=lzwABRgZlSdwnl7k7yKgiBhr8uuK7qrcgPTw+IFn9RA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uR+aPf8nHkiO/3U9u4WH/ptFa9iZ0nZefh+WDiLfYKaVdXLqUoVKbKBPVR8XJGVca
	 y32Wzpau0Ho4D3frZyaIsVpHs6Gzp3swO05191t1j1qGkM8dbZoIimITxGRJ/cJjEH
	 x+0KuNB7UgqtvdNHL4U84ZJAzzwyckPF2usoEVVC54V42igcWJXwGv9G1k0CYwmq0Y
	 UexDxEWSnUCdF++SJdydTE2cVxrlgcaXsHceP00aehllBYQYFSi+XD+2ZpVyVVAnu7
	 hn2qO53vJxHXdxZIN0IxENLfmChAso+2/sdyVOBVMmBed0Gmx7PV3k+HfpLFevEd+5
	 8/ZXR0/hqtr6A==
Date: Mon, 15 Sep 2025 14:31:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	david@fromorbit.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: expand dump_inode()
Message-ID: <20250915-besten-demonstrieren-b664a5700250@brauner>
References: <20250911065641.1564625-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250911065641.1564625-1-mjguzik@gmail.com>

On Thu, Sep 11, 2025 at 08:56:41AM +0200, Mateusz Guzik wrote:
> This adds fs name and few fields from struct inode: i_mode, i_opflags,
> i_flags, i_state and i_count.
> 
> All values printed raw, no attempt to pretty-print anything.
> 
> Compile tested on i386 and runtime tested on amd64.
> 
> Sample output:
> [   23.121281] VFS_WARN_ON_INODE("crap") encountered for inode ffff9a1a83ce3660
>                fs pipefs mode 10600 opflags 0x4 flags 0x0 state 0x38 count 0
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> v2:

Applied.

