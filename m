Return-Path: <linux-fsdevel+bounces-21046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8103E8FD11D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 16:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B541F231D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 14:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675E927701;
	Wed,  5 Jun 2024 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIg5KwI1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CDB19D88E
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jun 2024 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717598934; cv=none; b=HhyofpjAWf9VuTFoP0ovXua5yxtobf/qBoG4ycBjwZ+seLeKO6+cPeL1l3VmBI0sxCU/hbF/UuByD2MWCFfnf9rtSyuIKkBhJe4hYddNSQBhgUKlQfdrPPC/xmNKobCjrl4fmSVtlXeDPWrlrIhpX2z5zZvOD0shRwOZUykPQ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717598934; c=relaxed/simple;
	bh=/R/mk1vlKxhFynasRuNEZ3J3XUXwl2vs3LT41AUl6nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOX2/v+oVggUoUTD2fvmEYvcHsaFwsjeK/5ZyLef7OkPGHk3IWS5v919sqSemhTxDqTANx0804oA/ff+nEczp/FaPKhPE4C8FnzdJiaaLtpwPRoSmtTLPMZlkqKP4TwK+miygD0/BWcDoV/a6x3XrLt7Gv+VQVxsB4wSoO8Ex+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIg5KwI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FB1C2BD11;
	Wed,  5 Jun 2024 14:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717598934;
	bh=/R/mk1vlKxhFynasRuNEZ3J3XUXwl2vs3LT41AUl6nQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OIg5KwI1lgggVNTzDFrC6Tw89p1H6Pmw6/fgormSpEHKFzTP9swz6HfqTcatlzwES
	 2+UfsX4b8FcgddzeoaL0AXRAgcwNiWhYFVdxxBa9EM9ZmC281ctVchHqpPF/0UzWlH
	 4tgmvLJcS6agvlwCOBlVAR2VF5QmoBdMKik/rwcXLHCbuVGNiVbq7j6DVUI2MYcdg1
	 sEra8R06/D2RgfRUpYyw3uE2PSHps7CtpDs9ZXMfOIZ9Hn+4fxVQuI+S06MHIgzRrF
	 ian2ykUb9zL1Val/LOzkec63ovbczEMsKxqqQtt3gvzr76tsuBZshZXaQfbomRE5if
	 KGn5kRMghNXjw==
Date: Wed, 5 Jun 2024 16:48:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jemmy <jemmywong512@gmail.com>
Cc: longman@redhat.com, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, jemmy512@icloud.com
Subject: Re: [PATCH] Improving readability of copy_tree
Message-ID: <20240605-ereilen-sinnhaftigkeit-f088e83c39a3@brauner>
References: <20240604134347.9357-1-jemmywong512@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240604134347.9357-1-jemmywong512@gmail.com>

On Tue, Jun 04, 2024 at 09:43:47PM +0800, Jemmy wrote:
> Hello everyone,
> 
> I'm new to Linux kernel development
> and excited to make my first contribution.
> While working with the copy_tree function,
> I noticed some unclear variable names e.g., p, q, r.
> I've updated them to be more descriptive,
> aiming to make the code easier to understand.
> 
> Changes:
> 
> p       -> o_parent, old parent
> q       -> n_mnt, new mount
> r       -> o_mnt, old child
> s       -> o_child, old child
> parent  -> n_parent, new parent

Hey, seems worth to me but if so please spell out "old_*" and "new_*".

