Return-Path: <linux-fsdevel+bounces-72549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E51CFB29B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 22:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71B8F304868A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 21:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823752C0282;
	Tue,  6 Jan 2026 21:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6EzTg6J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE2228CF5F;
	Tue,  6 Jan 2026 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767736241; cv=none; b=ngSwbopXooc0s2VLHxMvU12xNxxN9mvcPGDJy2cu9pZ1dVQ57dS4FYAiRPZyIYLlnJnIkGgDfsioRLMFd36jHUyKhFiZo2xlKD1LULdS7ApSV4VKAQYv7+4+K4kureU5HxEQjJlvYYmK7YIp08XhhrwfB5NWR/ypmIiQJAe7Lmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767736241; c=relaxed/simple;
	bh=DRme/nOLuBlH3mUJW2KO+MveKRAX1UVEPievDqcvjX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMLFK8tLzD7bBOw+QuMHbhyxg6Wr+Pd/15udRmEBZONR5WlWchpgQYTh1J3Y7urIkkyrD1iqPO/1J3MP3zPm2ZQjWbnreajfWqEwzL3sHC4X/vOpgMYhbbMTBbqFWEYxCf8Q/PPPGNLH2OAc/UGipNXQr2Q1Ohy1qSuEw59G21w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6EzTg6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5892C116C6;
	Tue,  6 Jan 2026 21:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767736240;
	bh=DRme/nOLuBlH3mUJW2KO+MveKRAX1UVEPievDqcvjX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H6EzTg6Jd8XzzxBffE8KgEobfztEyikz/fjzDrSiwFUl5hX9oRPkyRmLQWPMnKWts
	 X1m0bfxPNYqq7FQ5HXewfQlKbGGodfAdwnFk4RRYhhsO1y22jgtkz8sbETykj+AOJX
	 qASSNEXUlR4/iUxOYKq0eCvI6+RW5+oSlLgdAKFuNhm+FNX0NqWao/wd8gFeISJh4D
	 ZuWZQ/LEMT/RQ3tUT1b66/AhBmu58EbI8Q90gQm1XbIMDQoD2QUaqNbJgx9qN2NtCM
	 q5ysPTI/YJ+1v3iOhF9SH5NFg7NgtoE6Ew8392uPhr4LV7kCrwCmolu7UbIWaaZwAP
	 UMETvP2ZEC5BA==
Date: Tue, 6 Jan 2026 22:50:36 +0100
From: Christian Brauner <brauner@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, 
	Jonathan Corbet <corbet@lwn.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] docs: filesystems: add fs/open.c to api-summary
Message-ID: <20260106-hypnose-exakt-e30c53f1d6bc@brauner>
References: <20260104204530.518206-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260104204530.518206-1-rdunlap@infradead.org>

On Sun, Jan 04, 2026 at 12:45:30PM -0800, Randy Dunlap wrote:
> Include fs/open.c in filesystems/api-summary.rst to provide its
> exported APIs.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

