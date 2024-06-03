Return-Path: <linux-fsdevel+bounces-20824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEBA8D8439
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 15:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B84B1C21DF5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 13:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1349612DDBA;
	Mon,  3 Jun 2024 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgVyBch2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C8112DD91
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422082; cv=none; b=AXhswrioC3s9JInsQbwLQ4HZsYPsDopWBr6nZhNuy0ug04fwixd4Y3/lNBEewNme6DEXrO2LOP0Eg3U8VQQe3cYVe+PbgqpzY3MEIoUNm1UXgAgqdA0FfmQr+D4QRGDOQUkc0/SZuOGh5MQ/TqSih2nXkfp9VOIsWXx8uRernwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422082; c=relaxed/simple;
	bh=DYeXFpwPqwnXwK9BqPRqhg89sgThdDjzQmxPvWtQ0vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsEUzPXgpT61bpiKi4r3rH0ahIqNdXb2r+C0ixP2TMMCdqL+NwtgYPVwrYnVPGRj0nvVjk8DxlhSfM2p/SW0buKtPQxgYn3XLL0dUlANtz1P/D/inaeap0wduLyeCn4p60K8mouNNInVwkrol6atSSHmg35RivTHEEOFECZ1WrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgVyBch2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33778C2BD10;
	Mon,  3 Jun 2024 13:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717422082;
	bh=DYeXFpwPqwnXwK9BqPRqhg89sgThdDjzQmxPvWtQ0vM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jgVyBch2I4eQTB09FZuFlur9VJtePprZmdPrawI1N5ZQOmHQTdkMJm3FN9y5DvHuV
	 R8UWk+6nHUmcdifeZfSZi9YpUG423ha92fHc5xYSOOtQpiXKMP1eAY8tDiO4ykbUYj
	 o3UiDS/X9mf2EnO3WPWqeU8VmcQodS+XAm74FpTAyYa24qTSmw9aqIXN79wLHPmhNI
	 nS5Iu4Me3VoMWhs92eCaZf9vTWhEgPyjX1Ed6kaSMfDiW6zVIHI50IYHuY1ezhTxx1
	 x20mtTonxHpneaoz4WSgLm05QUWNGygNZNNWloFtIb5t3ng8/MhDZumkI6bt6qG0Jn
	 miPsDVAvtKY4Q==
Date: Mon, 3 Jun 2024 15:41:18 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] remove pointless includes of <linux/fdtable.h>
Message-ID: <20240603-verzaubern-langgehegter-6c4ba9a0ef37@brauner>
References: <20240603035316.GJ1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240603035316.GJ1629371@ZenIV>

On Mon, Jun 03, 2024 at 04:53:16AM +0100, Al Viro wrote:
> [in viro/vfs.git#work.misc; will be in for-next if nobody yells]
> 
> some of those used to be needed, some had been cargo-culted for
> no reason...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

