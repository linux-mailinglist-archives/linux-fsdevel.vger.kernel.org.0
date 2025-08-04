Return-Path: <linux-fsdevel+bounces-56645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C5EB1A3E3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 15:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3C0B17D676
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 13:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E53E26B77D;
	Mon,  4 Aug 2025 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZsqodiv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0781DD9AC;
	Mon,  4 Aug 2025 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754315585; cv=none; b=iJfY8bdWhOdvbCdj5lqdyt4Ru42/l1BxbI5j9qk4m1EAm77ico97zFuoAEHidXgNpgIGw2je7F77HERiiqs4lYtR14gXXDymy66bzg441n00qvNJQg1emA8ifKRJMhwLtHFbjBCaqwlekvSOmq+c2VZTLRbospsn+Qguj9J8ARU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754315585; c=relaxed/simple;
	bh=5rc6chq3h2xmwl7+CIBxfykl13rJlNajYi69c8oWQf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaDHxzxa62o5CjaG+xCM9wq8qAbaAYPQh4etX84ooUDy7ZHJYm0kZriXKJ0yOXxxRhb1S/B4d22bPx9jXFTwZ5NhA7up+npRZTss/ARybDf9ynRLzYtV8nfT4V4rAtsdNmqDBWBZQjr+Bbs9/eC4UuiY4GXEpJ9E6hYkA9g/BYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZsqodiv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C793C4CEE7;
	Mon,  4 Aug 2025 13:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754315585;
	bh=5rc6chq3h2xmwl7+CIBxfykl13rJlNajYi69c8oWQf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pZsqodivm+P4sALfbGHhv+MPQEBsR1hk8+XFGlspkAXYyQ/dxJ08h9OG5w1fYmy61
	 1seqaQMHVVEIwEPLoopGPeIP2v7gWH9Hz6w4/NnagGerYa81JNT0nH/qSS+mLpef0F
	 NjWH/uW4eWOpZuJYu7RQ5eLz/M41QFcN5YbPI0YDyiplXZ0Aody6HagKCUsbEJsKdf
	 BggRkcRSRDnpnOs9Zuj4PIUl5iPqVRDsyxsfOcsj8YCwnlBtfto6l87b9kRAKgrG/c
	 tf/EWKz1g7u1hgNING7W6MR+8jtwsvfZ7zb/dH7F56MNHcVnhST3zeQa+hW82y//YK
	 V3nZLY/9JfntA==
Date: Mon, 4 Aug 2025 15:53:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Beibei Yang <13738176232@163.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH trivial] init: Fix comment typo in do_mounts_initrd.c
Message-ID: <20250804-raben-einwickeln-b778686442a7@brauner>
References: <1754231358-3544-1-git-send-email-13738176232@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1754231358-3544-1-git-send-email-13738176232@163.com>

On Sun, Aug 03, 2025 at 07:29:18AM -0700, Beibei Yang wrote:
> From: root <root@192.168.220.227>
> 
> The original comment incorrectly used "cwd" (current working directory)
> when referring to the root change operation. The correct term should be
> "pwd" (present working directory) as per process context semantics.
> 
> This is a pure comment correction with no functional impact.
> 
> Signed-off-by: Beibei Yang <13738176232@163.com>
> ---

Didn't I reply to the same thing just a few weeks ago?
Not worth it imho. cwd is equally well understood as pwd.

