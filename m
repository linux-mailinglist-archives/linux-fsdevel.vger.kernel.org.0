Return-Path: <linux-fsdevel+bounces-45606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 889DDA79D98
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 10:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56FBC1897CE9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 08:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243E92417D3;
	Thu,  3 Apr 2025 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIKAD9Pc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADAF1862;
	Thu,  3 Apr 2025 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743667294; cv=none; b=rVmFmd6D49PE0cevMJ3lNwxKKFdf8rKbxSJnwBjyJJreZRy4o2hEFauBYEUZkTf5+lqXMzgSZvi9J7p5mw7l4XkCEqiBc0AV8Azy0b2pTSsecxuS8tveOh75kJqcWZL0xESH1NGKeQc48Qfbf1ToTU804pTJzrVxATcKOfGXoac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743667294; c=relaxed/simple;
	bh=gt0gwpYLEu58But4Hx9yEVm8tlCQ7IHQfp5bOUm/cT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHAwl5GxqXxaH7BBRuZDFfR4Jirwbw0auXoDz9X5wwbZGOG7FgiJcpPdpmV9WCBbz1bK7JlyxUv1p8ee8E6kIaoG2mVVO7NqD3AnMvIwate8UB00ZOUjb2E0vBaMt7m7lPOe+XF+e6cCK2DOMEWgUqEaVhme7tp7mbXhAGykDvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIKAD9Pc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923A5C4CEE3;
	Thu,  3 Apr 2025 08:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743667294;
	bh=gt0gwpYLEu58But4Hx9yEVm8tlCQ7IHQfp5bOUm/cT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YIKAD9Pc95ZjEponSUVJ2epEvKS2IicaA9MS5fnaxsjNSG8Lw1dIR2t4/Mr1XikYl
	 YQ+SmV4bQXzSKKPkLi5ZIcy2Z05GoDy91xHGPzEo/ctUPN77O94V/mOTWTrX8+pJ3v
	 bg/SW7y7BklX/6/3EHMe/d/Wp8YbxSdbCYnU3AdC/t1Px7M7m5Ksq461k5RiVzQJpz
	 8OTy0S4qazhSPfQpW6N0mWtq2FDaS0KZcUNvdy+UOKZQVaO0oXjndyql8jA5hcMvPb
	 rvhpX5nAtr+hBaKYYPQcswHn8yY5SAnbYHS+rercDROyXVWdCFbKfMgnOMlBF28CrG
	 HKBHG9Ofv8LmA==
Date: Thu, 3 Apr 2025 10:01:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Xiaole He <hexiaole1994@126.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] fs/super.c: Add NULL check for type in
 iterate_supers_type
Message-ID: <20250403-inkognito-museen-4a78cc088344@brauner>
References: <20250402034529.12642-1-hexiaole1994@126.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250402034529.12642-1-hexiaole1994@126.com>

On Wed, Apr 02, 2025 at 11:45:29AM +0800, Xiaole He wrote:
> The first several lines of iterate_supers_type are below:
> 
> 1 void iterate_supers_type(struct file_system_type *type,
> 2 	void (*f)(struct super_block *, void *), void *arg)
> 3 {
> 4 	struct super_block *sb, *p = NULL;
> 5
> 6 	spin_lock(&sb_lock);
> 7 	hlist_for_each_entry(sb, &type->fs_supers, s_instances) {
> 8 	...
> 9 }
> 
> The iterate_super_type is a exported symbol, and if iterate_supers_type
> is called with type of NULL, then there will be a NULL pointer
> dereference of argument type in line 7.
> 
> This patch fix above problem by adding NULL pointer check for argument
> type.
> 
> Signed-off-by: Xiaole He <hexiaole1994@126.com>
> ---

Both Al and James already pointed out that this check is unnecessary and
ultimately misleading. So we're not going to accept this patch.

