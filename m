Return-Path: <linux-fsdevel+bounces-69055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 164AFC6D818
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 09:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B47C3352884
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 08:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0492FD69B;
	Wed, 19 Nov 2025 08:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1pT7hJO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B06D307ADA
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 08:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763541952; cv=none; b=ourfmCJSW2b7V4E52uBWs7ImK3p+V6MENB/q9BbIg3enWgtlKXw0AAVoisB/RSA1afVuUiKSr426nFHQq9jPwzHGC2tPd2tJTPxGQfSdH+0viWYZosPSBPXxNFN3/Pd6gEurhWs4IVtBHdJNHNuAsyGZbBrFi7vfHpOVJ32+uV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763541952; c=relaxed/simple;
	bh=w4xwkKVpoaVrg2jXzvPhwTDzCqeAgrxF+VGrZxku6tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SymVGdZIC8f77efGnFXfvxwMGX7hnDMzyWogUyEXa2YJZti2IXFFfpb2HEvcACgP6cS81SlUuBi3AkQ2ohPD1OhNl1pop5gRuAICRpMlTj9I/Ev0h7VFJuThGXiIv4dSD9ghsrmcTTe3j3TQbZk51eUUBe/koVOP5lUQYYVo6uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1pT7hJO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFA5C2BCB0;
	Wed, 19 Nov 2025 08:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763541951;
	bh=w4xwkKVpoaVrg2jXzvPhwTDzCqeAgrxF+VGrZxku6tQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N1pT7hJOzLkvDN7nFrioT4Y8RF9c6LA3bQQb00k3IvuNVKQQVGjKw/rrM3s3MAs65
	 hhI5IlTLSojMZL+sv+FVqwSAkmM1KS9mjjc0IxYFyCY5wUqQpiIauaTZhy8oKhzeAl
	 GuDiTBQVPHYJAJSrgXRUz/1RiRZWCPWJaExLP2vZb1Amm1zbcXBtXSgZ5+dhj/3mdl
	 Xyls5U1vAnTs3jEXeSUNXYfdbmEG7+DET1msEKd64wbscyo+ysJFUu3TC+eVzge8pV
	 psOypSiruW6BfDvJn1hL3PxrTas9S8RbGfkv/njrQ4ZnAL1k5aUUeAs5GuIyuebt7d
	 cq/tc204dnP9A==
Date: Wed, 19 Nov 2025 09:45:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: unexport ioctl_getflags
Message-ID: <20251119-frist-vertragen-22e1d099b118@brauner>
References: <20251118070941.2368011-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251118070941.2368011-1-hch@lst.de>

On Tue, Nov 18, 2025 at 08:09:41AM +0100, Christoph Hellwig wrote:
> No modular users, nor should there be any for a dispatcher like this.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Ideally we'd be able to catch unnecessary exports automatically.
Which would also be nice because it would mean that we could enforce
automatic removal of unused exports. I'm pretty sure we have a bunch of
them without realizing it.

